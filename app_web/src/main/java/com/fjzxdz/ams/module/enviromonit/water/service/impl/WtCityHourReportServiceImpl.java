package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.NumUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourReportService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class WtCityHourReportServiceImpl implements WtCityHourReportService {

    public static final String SK = "2";
    public static final String GK = "1";
    public static final String ZJ = "3";
    List<WtSectionMonthReport> listGk;
    List<WtSectionMonthReport> listSk;
    List<Map<String, Object>> yearDataQualityGk;
    List<Map<String, Object>> yearDataQualitySk;
    List<Map<String, Object>> yearDataQualityZJ;
    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private WtCityHourDataService wtCityHourDataService;

    /**
     * 监控情况统计 【污水处理厂】【常规口】【污普废水企业】【微型水质自动站】【小流域】
     *
     * @return
     */
    @Override
    public JSONArray countMonitorSituation() {
        StringBuilder sql = new StringBuilder();
        //==污水处理厂==
        sql.append(" SELECT COUNT(DISTINCT E.PE_ID) TOTAL FROM PE_MONITOR_POINT P ");
        sql.append(" INNER JOIN PE_ENTERPRISE_DATA E ON P.PE_ID = E.PE_ID ");
        sql.append(" WHERE P.OUTFALL_TYPE = 1 AND E.LONG_VALUE IS NOT NULL ");
        sql.append("  AND E.LAT_VALUE IS NOT NULL AND E.PE_TYPE = 'peType1' ");
        //==常规口==
        sql.append(" UNION ALL ");
        sql.append(" SELECT COUNT(DISTINCT E.PE_ID) AS SGK FROM PE_MONITOR_POINT P ");
        sql.append(" INNER JOIN PE_ENTERPRISE_DATA E ON P.PE_ID = E.PE_ID ");
        sql.append(" WHERE P.OUTFALL_TYPE = 1 AND E.LONG_VALUE IS NOT NULL ");
        sql.append(" AND E.LAT_VALUE IS NOT NULL AND E.PE_TYPE <> 'peType1' ");
        //===污普废水企业==
        sql.append(" UNION ALL ");
        sql.append(" SELECT COUNT(DISTINCT QYMC) FROM POLLUTION_WATER_DATA ");
        //===微型水质自动站==
        sql.append(" UNION ALL ");
        sql.append(" SELECT COUNT(1) FROM WT_CITY_POINT P ");
        sql.append("  LEFT JOIN WT_CITY_HOUR_REPORT R ON P.POINT_CODE = R.POINT_CODE ");
        sql.append(" AND R.DATATIME >= SYSDATE - 2 AND R.DATATIME <= SYSDATE AND ");
        sql.append(" (R.POINT_CODE, R.DATATIME) IN (SELECT WP.POINT_CODE, MAX(WD.DATATIME) ");
        sql.append(" FROM WT_CITY_POINT WP ");
        sql.append(" INNER JOIN WT_CITY_HOUR_REPORT WD ON WP.POINT_CODE = WD.POINT_CODE ");
        sql.append(" WHERE WD.DATATIME >= SYSDATE - 2 AND WD.DATATIME <= SYSDATE ");
        sql.append(" GROUP BY WP.POINT_CODE) ");
        sql.append(" WHERE P.STATUS = 1 AND P.CATEGORY = 3 ");
        //==小流域==
        sql.append(" UNION ALL ");
        sql.append(" SELECT COUNT(1) FROM WT_BASIN_MONITOR A where ischeck=1 ");
        List<Object[]> list = simpleDao.createNativeQuery(sql.toString()).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            JSONObject temp = new JSONObject();
            JSONArray array = new JSONArray();
            for (int i = 0; i < list.size(); i++) {
                temp.put(i + "", list.get(i));
            }
            array.add(temp);
            return array;
        }
        return new JSONArray();
    }

    /**
     * 考核目标 【国考断面】【省考断面】
     *
     * @param date
     */
    @Override
    public Map wtData(String date) {
        date = DateUtil.getCurFullYear();
        Map resultMap = new HashMap();
        //国考断面国考断面Ⅰ～Ⅲ类水质达到比例
        Double gKPercent = 0.875;
        //省考断面Ⅰ～Ⅲ类水质比例达以上
        Double sKPercent = 0.9545;
        int one2ThreeGk = 0;
        int one2ThreeSk = 0;
        //未达标断面
        listGk = getWdbList(date, GK, "RESULT_QUALITY", new HashMap());
        List<Object[]> pointCodeGk = getRglList(date, GK);
        int talGk = pointCodeGk.size();
        List<Map> listDbDmxqGk = new ArrayList<>();//断面详情国考达标
        List<Map> listWdbDmxqGk = new ArrayList<>();//断面详情国考未达标
        String averageQualityGk = "";
        for (Object[] monthReport : pointCodeGk) {
            Map map = new HashMap();
            for (WtSectionMonthReport o : listGk) {
                if (monthReport[0].equals(o.getSectionName())) {
                    map.put("resultQuality" + o.getMonthNumber(), o.getResultQuality());
                    map.put("targetQuality", o.getTargetQuality());
                    map.put("sectionName", o.getSectionName());
                    map.put("averageQuality" + o.getMonthNumber(), o.getAverageQuality());
                }
            }
            //年均值 到达哪个月就算到那个月的均值
            averageQualityGk = MapUtils.getString(map, "averageQuality" + monthReport[4], "");
            map.put("averageQuality", averageQualityGk);
            if (WaterQualityUtil.formatVal(map.get("targetQuality").toString()) >= WaterQualityUtil.formatVal(averageQualityGk)) {
                listDbDmxqGk.add(map);
            } else {
                listWdbDmxqGk.add(map);
            }
            //国考达标断面统计
            if (WaterQualityUtil.formatVal(monthReport[2].toString()) <= 3) {
                one2ThreeGk++;
            }
        }
        //省考数据有多少
        listSk = getWdbList(date, SK, "RESULT_QUALITY", new HashMap());
        List<Object[]> pointCodeSk = getRglList(date, SK);
        int talSk = pointCodeSk.size();

        List<Map> listDbDmxqSkGk = new ArrayList<>();//断面详情达标省考=国考+省考
        List<Map> listWdbDmxqSkGk = new ArrayList<>();//断面详情未达标省考=国考+省考
        List<Map> listDbDmxqSk = new ArrayList<>();//断面详情省考达标
        List<Map> listWdbDmxqSk = new ArrayList<>();//断面详情省考未达标
        String averageQualitySk = "";
        for (Object[] monthReport : pointCodeSk) {
            Map map = new HashMap();
            for (WtSectionMonthReport o : listSk) {
                if (monthReport[0].equals(o.getSectionName())) {
                    map.put("resultQuality" + o.getMonthNumber(), o.getResultQuality());
                    map.put("targetQuality", o.getTargetQuality());
                    map.put("sectionName", o.getSectionName());
                    map.put("averageQuality" + o.getMonthNumber(), o.getAverageQuality());
                }
            }
            averageQualitySk = MapUtils.getString(map, "averageQuality" + monthReport[4], "");//最大的月数
            map.put("averageQuality", averageQualitySk);
            if (WaterQualityUtil.formatVal(map.get("targetQuality").toString()) >= WaterQualityUtil.formatVal(averageQualitySk)) {
                listDbDmxqSk.add(map);
            } else {
                listWdbDmxqSk.add(map);
            }
            //省考达标断面统计
            if (WaterQualityUtil.formatVal(monthReport[2].toString()) <= 3) {
                one2ThreeSk++;
            }
        }
        //按照目标未达到等级 4-》3-》2级显示
        Collections.sort(listDbDmxqGk, new Comparator<Map>() {
            @Override
            public int compare(Map o1, Map o2) {
                return WaterQualityUtil.formatVal(MapUtils.getString(o2, "averageQuality", "")) - WaterQualityUtil.formatVal(MapUtils.getString(o1, "averageQuality", ""));
            }
        });
        //按照目标未达到等级 4-》3-》2级显示
        Collections.sort(listDbDmxqSk, new Comparator<Map>() {
            @Override
            public int compare(Map o1, Map o2) {
                return WaterQualityUtil.formatVal(MapUtils.getString(o2, "averageQuality", "")) - WaterQualityUtil.formatVal(MapUtils.getString(o1, "averageQuality", ""));
            }
        });
        //按照目标未达到等级 4-》3-》2级显示
        Collections.sort(listWdbDmxqGk, new Comparator<Map>() {
            @Override
            public int compare(Map o1, Map o2) {
                return WaterQualityUtil.formatVal(MapUtils.getString(o2, "averageQuality", "")) - WaterQualityUtil.formatVal(MapUtils.getString(o1, "averageQuality", ""));
            }
        });
        //按照目标未达到等级 4-》3-》2级显示
        Collections.sort(listWdbDmxqSk, new Comparator<Map>() {
            @Override
            public int compare(Map o1, Map o2) {
                return WaterQualityUtil.formatVal(MapUtils.getString(o2, "averageQuality", "")) - WaterQualityUtil.formatVal(MapUtils.getString(o1, "averageQuality", ""));
            }
        });

        listDbDmxqSkGk.addAll(listDbDmxqGk);
        listDbDmxqSkGk.addAll(listDbDmxqSk);
        listWdbDmxqSkGk.addAll(listWdbDmxqGk);
        listWdbDmxqSkGk.addAll(listWdbDmxqSk);
        //日管理国考
        List rglListGk = getRglList(date, GK);
        //日管理省考
        List rglListSk = getRglList(date, SK);
        //日管理国考
        List rglListZj = getRglList(date, ZJ);
        //最差的排在前面
        Collections.sort(rglListGk, new Comparator<Object[]>() {
            @Override
            public int compare(Object[] o1, Object[] o2) {
                return WaterQualityUtil.formatVal(o2[6].toString()) - WaterQualityUtil.formatVal(o1[6].toString());
            }

        });
        Collections.sort(rglListZj, new Comparator<Object[]>() {
            @Override
            public int compare(Object[] o1, Object[] o2) {
                return WaterQualityUtil.formatVal(o2[6].toString()) - WaterQualityUtil.formatVal(o1[6].toString());
            }

        });
        Collections.sort(rglListSk, new Comparator<Object[]>() {
            @Override
            public int compare(Object[] o1, Object[] o2) {
                return WaterQualityUtil.formatVal(o2[6].toString()) - WaterQualityUtil.formatVal(o1[6].toString());
            }

        });

        //按照目标未达到等级 4-》3-》2级显示


        //完成情况：国考断面Ⅰ～Ⅲ类水质达到比例
        Double gkWc = NumUtil.divide(one2ThreeGk, talGk, 4);
        //省考断面Ⅰ～Ⅲ类水质比例达以上
        Double sKWc = NumUtil.divide(one2ThreeSk + one2ThreeGk, talSk + talGk, 4);

        resultMap.put("mbgkbl", gKPercent);//国考Ⅰ～Ⅲ类水质目标比例
        resultMap.put("mbskbl", sKPercent);//省考Ⅰ～Ⅲ类水质目标比例
        resultMap.put("wcgkbl", gkWc);//国考Ⅰ～Ⅲ类水质完成情况比例
        resultMap.put("wcskbl", sKWc);//省考Ⅰ～Ⅲ类水质完成情况比例
        resultMap.put("gkStatus", gkWc >= gKPercent ? "已达到考核目标" : "未达考核目标");
        resultMap.put("skStatus", sKWc >= sKPercent ? "已达到考核目标" : "未达考核目标");
        resultMap.put("wdbdmGk", listWdbDmxqGk);
        resultMap.put("wdbdmSk", listWdbDmxqSkGk);

        resultMap.put("dmxqdbGk", listDbDmxqGk);//断面详情达标国考
        resultMap.put("dmxqwdbGk", listWdbDmxqGk);//断面详情未达标国考
        resultMap.put("dmxqdbSk", listDbDmxqSkGk);//断面详情达标省考
        resultMap.put("dmxqwdbSk", listWdbDmxqSkGk);//断面详情未达标省考
        resultMap.put("yearDataQualityGk", rglListGk);//日管理国考
        resultMap.put("yearDataQualitySk", rglListSk);//日管理省考
        resultMap.put("yearDataQualityZJ", rglListZj);//日管理自建
        return resultMap;
    }

    /**
     * 国控，省考所有站点 [手工录入]
     *
     * @param date
     * @param s
     * @return
     */
    List<Object[]> countDistinctPointCode(String date, String s) {
        StringBuilder countPointSql = new StringBuilder();
        countPointSql.append(" SELECT DISTINCT SECTION_NAME, SECTION_CODE FROM WT_SECTION_MONTH_REPORT t   WHERE T.STATUS=1   ");
        if (GK.equals(s)) {
            countPointSql.append(" AND T.CATEGORY=1    ");
        } else {
            countPointSql.append(" AND T.CATEGORY=2    ");
        }
        countPointSql.append(" AND t.YEAR_NUMBER = ? ");
        countPointSql.append("  ORDER BY T.SECTION_NAME ");
        List resultList = simpleDao.createNativeQuery(countPointSql.toString(), date).getResultList();
        return resultList;

    }

    /**
     * 日管理 国控、声控、自建断面 [手工录入]
     *
     * @param date
     * @param s
     * @return
     */
    List getRglList(String date, String s) {
        StringBuilder countPointSql = new StringBuilder("　SELECT * FROM (　");
        countPointSql.append(" SELECT T.SECTION_NAME,T.SECTION_CODE,T.AVERAGE_QUALITY,T.TARGET_QUALITY,T.MONTH_NUMBER, t.YEAR_NUMBER,t.RESULT_QUALITY,  ");
        countPointSql.append(" RANK() OVER(PARTITION BY T.SECTION_NAME ORDER BY T.MONTH_NUMBER DESC) AS RANK ");
        countPointSql.append(" FROM WT_SECTION_MONTH_REPORT t WHERE T.STATUS=1 ");
        if (GK.equals(s)) {
            countPointSql.append(" AND T.CATEGORY=1    ");
        }
        if (SK.equals(s)) {
            countPointSql.append(" AND T.CATEGORY=2    ");
        }
        if (ZJ.equals(s)) {
            countPointSql.append(" AND T.CATEGORY=3    ");
        }
        countPointSql.append(" AND t.YEAR_NUMBER =  ").append(Integer.parseInt(date));
        countPointSql.append("  ) A WHERE A.rank =1 ");
        List resultList = simpleDao.createNativeQuery(countPointSql.toString()).getResultList();
        return resultList;

    }


    /**
     * 查询国控断面 省考断面 目标、完成情况 【手工录入】
     *
     * @param date        时间
     * @param flag        标志 省考  国考  自建
     * @param countColumn 按什么统计 目标水质 测试水质
     * @return
     */
    private int getGoalTotals(String date, String flag, String countColumn) {
        StringBuilder sql = new StringBuilder(" SELECT count(1) FROM WT_SECTION_MONTH_REPORT t ");
        sql.append("  WHERE T.STATUS=1 AND T.").append(countColumn).append(" IS NOT NULL");
        if (GK.equals(flag)) {
            sql.append("  AND T.CATEGORY=1 AND T.").append(countColumn).append(" IN ('FIRSR','SECOND','THIRD')");
        }
        if (SK.equals(flag)) {
            sql.append("  AND T.CATEGORY=2 AND T.").append(countColumn).append(" IN ('FIRSR','SECOND','THIRD')");
        }
        if (ZJ.equals(flag)) {
            sql.append("  AND T.CATEGORY=3 AND T.").append(countColumn).append(" IN ('FIRSR','SECOND','THIRD')");
        }
        sql.append(" and t.YEAR_NUMBER=").append(Integer.parseInt(date));
        return Integer.parseInt(simpleDao.createNativeQuery(sql.toString()).getResultList().get(0).toString());
    }

    /**
     * 查询国控断面 省考断面 自建断面有多少条数据 【手工录入】
     *
     * @param date        时间
     * @param flag        标志 省考  国考  自建
     * @param countColumn 按什么统计 目标水质 测试水质
     * @return
     */
    private List<WtSectionMonthReport> getWdbList(String date, String flag, String countColumn, Map paramMap) {

        StringBuilder sql = new StringBuilder(" SELECT * FROM WT_SECTION_MONTH_REPORT t ");
        sql.append("  WHERE T.STATUS=1 AND T.").append(countColumn).append(" IS NOT NULL");
        if (GK.equals(flag)) {
            sql.append("  AND T.CATEGORY=1 ");
        }
        if (SK.equals(flag)) {
            sql.append("  AND T.CATEGORY=2 ");
        }
        if (ZJ.equals(flag)) {
            sql.append("  AND T.CATEGORY=3 ");
        }
        sql.append(" and t.YEAR_NUMBER=").append(Integer.parseInt(date));
        String pointCode = MapUtils.getString(paramMap, "pointCode", "");
        if (StringUtils.isNotEmpty(pointCode)) {
            sql.append(" AND T.SECTION_NAME=").append(SqlUtil.toSqlStr(pointCode));
        }
        sql.append(" order by t.SECTION_NAME,MONTH_NUMBER ");
        return simpleDao.createNativeQuery(sql.toString(), WtSectionMonthReport.class);
    }


    /**
     * 断面详情点击弹窗 XXX详情 【手工录入】
     *
     * @param flag 国考省考标志
     * @param map  参数集合
     * @return
     */
    public List<Object> getDetailList4Months(String flag, Map map) {
        String curFullYear = DateUtil.getCurFullYear();
        cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
        JSONObject temp1 = new JSONObject();
        //断面的月数据
        List<Object[]> monthData = getMonthData(curFullYear, "", map);
        //断面的月份
        List<WtSectionMonthReport> result_quality = getWdbList(curFullYear, "", "RESULT_QUALITY", map);
        //查找测试水质
        for (WtSectionMonthReport monthReport : result_quality) {
            for (Object[] o : monthData) {
                if (o[4].toString().equals(monthReport.getYearNumber().toString())
                        && o[5].toString().equals(monthReport.getMonthNumber().toString())
                        && o[2].toString().equals(monthReport.getSectionName())) {
                    temp1.put("jcsz", monthReport.getResultQuality().getKey());//测试水质
                    temp1.put("yearMonth", monthReport.getYearNumber() + "-" + monthReport.getMonthNumber());
                    temp1.put("pointCode", monthReport.getSectionCode());
                    temp1.put("pointName", monthReport.getSectionName());
                    temp1.put("pointQuality", monthReport.getTargetQuality().getKey());
                    if ("W01001".equals(o[6])) temp1.put("W01001", o[8]);//ph
                    if ("W01009".equals(o[6])) temp1.put("W01009", o[8]);//溶解氧
                    if ("W01019".equals(o[6])) temp1.put("W01019", o[8]);//高锰酸盐指数
                    if ("W21003".equals(o[6])) temp1.put("W21003", o[8]);//氨氮
                    if ("W21011".equals(o[6])) temp1.put("W21011", o[8]);//总磷
                }
            }

            if (ToolUtil.isNotEmpty(temp1)) dataArray.add(temp1);
            temp1 = new JSONObject();
        }
        return dataArray;
    }

    /**
     * 获取断面的月详情数据 【手工录入】
     * 监测时间
     * 监测站点
     * 目标水质
     * 检测水质
     * PH
     * 溶解氧
     * 高锰酸盐指数
     * 氨氮
     * 总磷
     *
     * @param date 查询的时间
     * @param flag 国考还是省考标志  1国考  2省考
     * @param map  参数集合
     * @return
     */
    List<Object[]> getMonthData(String date, String flag, Map map) {
        String pointCode = MapUtils.getString(map, "pointCode", "");
        StringBuilder sql = new StringBuilder();
        sql.append(" SELECT  *  FROM WT_SECTION_MONTH_DATA t where t.STATUS=0 ");
        if (GK.equals(flag)) {
            sql.append(" AND t.CATEGORY = 1");
        }
        if (SK.equals(flag)) {
            sql.append(" AND t.CATEGORY = 2");
        }
        sql.append(" AND t.YEAR_NUMBER =  ").append(Integer.parseInt(date));
        sql.append(" AND t.SECTION_NAME = ").append(SqlUtil.toSqlStr(pointCode));
        return simpleDao.createNativeQuery(sql.toString()).getResultList();


    }

    /**
     * 获取断面的月详情数据 【暂时没用到】
     *
     * @param flag 国考省考标志
     * @param map  参数集合
     * @return
     */
    @Override
    public List<Object> getDetailList4Month(String flag, Map map) {
        map.put("groupByMonth", "yes");
        List<Object[]> list = nationalExaminationCompletion(flag, map);
        Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH);
        List<Map<String, Object>> targetList = new ArrayList<>();//取测试水质
        if (GK.equals(flag)) {
            targetList.addAll(yearDataQualityGk);
        } else {
            targetList.addAll(yearDataQualitySk);
        }
        cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
        int a = 0;
        JSONObject temp1 = new JSONObject();
        WaterQualityEnum targetQuality = null;
        String jcsz = "";
        for (Object[] objects : list) {
            temp1.put((String) objects[5], objects[7]);
            if (a % 5 == 0) {
                //获取测试水质
                for (int i = 0; i < targetList.size(); i++) {
                    Map<String, Object> targetMap = targetList.get(i);
                    String code = MapUtils.getString(targetMap, "pointCode", "");
                    if (objects[1].toString().equals(code)) {
                        jcsz = MapUtils.getString(targetMap, month < 10 ? "0" + month + "mm" : month + "mm", "");
                        temp1.put("jcsz", jcsz);
                        month--;
                        break;
                    }
                }
                temp1.put("yearMonth", objects[0]);
                temp1.put("pointCode", objects[1]);
                temp1.put("pointName", objects[2]);
                temp1.put("pointQuality", objects[4]);
                dataArray.add(temp1);
                temp1 = new JSONObject();
            }
            a++;
        }
        return dataArray;
    }

    /**
     * 查询国控断面 省考断面 【暂时没用到】
     *
     * @param sql
     * @param flag
     * @return
     */
    private int getGoalTotal(StringBuilder sql, String flag) {
        sql.append("  WHERE T.POINT_QUALITY IN ('FIRSR','SECOND','THIRD') ");
        if (GK.equals(flag)) {
            sql.append(" and T.STATUS=1 AND T.CATEGORY=1 ");
        }
        if (SK.equals(flag)) {
            sql.append(" and T.STATUS=1 AND T.CATEGORY=2 ");
        }
        if ("3".equals(flag)) {
            sql.append(" and T.STATUS=1 AND T.CATEGORY=3 ");
        }
        return Integer.parseInt(simpleDao.createNativeQuery(sql.toString()).getResultList().get(0).toString());
    }


    /**
     * 国控，省考完成情况
     *
     * @param s “1”：国控   “2”：省考
     * @return
     */
    private List nationalExaminationCompletion(String s, Map map) {
        String pointCode = MapUtils.getString(map, "pointCode");
        String groupByMonth = MapUtils.getString(map, "groupByMonth");
        StringBuilder finishSql = new StringBuilder(" SELECT ");
        if (StringUtils.isNotEmpty(groupByMonth)) {
            finishSql.append(" TO_CHAR(DATATIME, 'yyyy-mm') AS yearmonth, ");
        }
        finishSql.append(" a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) FROM WT_CITY_HOUR_DATA a ");
        finishSql.append(" INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 AND DATAVALUE IS NOT NULL ");
        if (GK.equals(s)) {
            finishSql.append(" AND b.CATEGORY=1  ");
        } else {
            finishSql.append(" AND b.CATEGORY=2  ");
        }
        if (StringUtils.isNotEmpty(pointCode)) {
            finishSql.append(" and a.point_code =").append(SqlUtil.toSqlStr(pointCode));
        }
        finishSql.append(" AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE('").append(DateUtil.getFirstOfCurYear_Str()).append("','yyyy-mm-dd') ");
        finishSql.append(" AND DATATIME<=TO_DATE('").append(DateUtil.getCurYearMonthDay()).append("','yyyy-mm-dd')   ");
        finishSql.append(" GROUP BY  ");
        if (StringUtils.isNotEmpty(groupByMonth)) {
            finishSql.append(" TO_CHAR(DATATIME, 'yyyy-mm'),  ");
        }
        finishSql.append(" a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,  ");
        finishSql.append(" CODE_POLLUTE,PARAMNAME ORDER BY   ");
        if (StringUtils.isNotEmpty(groupByMonth)) {
            finishSql.append(" yearmonth DESC,");
        }
        finishSql.append(" a.POINT_CODE,CODE_POLLUTE ASC  ");
        List resultList = simpleDao.createNativeQuery(finishSql.toString()).getResultList();
        return resultList;
    }


    /**
     * 考核目标 【国考断面】【省考断面】 暂时不使用此方法
     *
     * @param date
     */
    @Override
    public Map assessmentTarget(String date) {
        wtData("2019");
        Map resultMap = new HashMap();
        //所有
        StringBuilder sql = new StringBuilder(" SELECT count(1) FROM WT_CITY_POINT t ");
        StringBuilder sql2 = new StringBuilder(" SELECT count(1) FROM WT_CITY_POINT t ");
        int total = Integer.parseInt(simpleDao.createNativeQuery(sql.toString()).getResultList().get(0).toString());
        String flag = "";
        //目标
        int totalGk = getGoalTotal(sql, GK);
        int totalSk = getGoalTotal(sql2, SK);
        //国考断面国考断面Ⅰ～Ⅲ类水质达到比例
        Double gKPercent = NumUtil.divide(totalGk, total, 4);
        //省考断面Ⅰ～Ⅲ类水质比例达以上
        Double sKPercent = NumUtil.divide(totalSk, total, 4);
        //国考完成情况
        List<Object[]> listGk = nationalExaminationCompletion(GK, new HashMap<>());
        //省考完成情况
        List<Object[]> listSk = nationalExaminationCompletion(SK, new HashMap<>());

        List<Object[]> pointCodeGk = countPointCode(GK);
        WaterQualityEnum targetQuality = null;
        int one2ThreeGk = 0;
        int tal = pointCodeGk.size();
        //未达标断面
        List<Object> wdbListGk = new ArrayList();
        List<Object> wdbListSk = new ArrayList();
        String tarQual = "";
        //获取个站点的信息
        for (Object[] objects : pointCodeGk) {
            cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
            for (Object[] o : listGk) {
                if (objects[0].equals(o[0])) {
                    JSONObject temp1 = new JSONObject();
                    temp1.put("codePollute", o[4]);
                    temp1.put("polluteValue", new BigDecimal(String.valueOf(o[6])));
                    temp1.put("polluteName", o[5]);
                    targetQuality = WaterQualityEnum.valueOf(o[3].toString());
                    tarQual = o[3].toString();
                    dataArray.add(temp1);
                }
            }
            JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, "0", targetQuality);

            Object resultQuality1 = resultQuality.get("resultQuality");
            if (WaterQualityUtil.formatVal(resultQuality1.toString()) > WaterQualityUtil.formatVal(tarQual)) {
                wdbListGk.add(objects);
            }

            if (resultQuality1.toString().equals("FIRSR") || resultQuality1.toString().equals("SECOND") || resultQuality1.toString().equals("THIRD")) {
                one2ThreeGk++;
            }
        }

        List<Object[]> pointCodeSk = countPointCode(SK);
        int one2ThreeSk = 0;
        tarQual = "";
        //获取个站点的信息
        for (Object[] objects : pointCodeSk) {
            cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
            for (Object[] o : listSk) {
                if (objects[0].equals(o[0])) {
                    JSONObject temp1 = new JSONObject();
                    temp1.put("codePollute", o[4]);
                    temp1.put("polluteValue", new BigDecimal(String.valueOf(o[6])));
                    temp1.put("polluteName", o[5]);
                    targetQuality = WaterQualityEnum.valueOf(o[3].toString());
                    tarQual = o[3].toString();
                    dataArray.add(temp1);
                }
            }
            JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, "0", targetQuality);
            Object resultQuality1 = resultQuality.get("resultQuality");
            if (WaterQualityUtil.formatVal(resultQuality1.toString()) > WaterQualityUtil.formatVal(tarQual)) {
                wdbListSk.add(objects);
            }
            if (resultQuality1.toString().equals("FIRSR") || resultQuality1.toString().equals("SECOND") || resultQuality1.toString().equals("THIRD")) {
                one2ThreeSk++;
            }
        }
        //完成情况：国考断面Ⅰ～Ⅲ类水质达到比例
        Double gkWc = NumUtil.divide(one2ThreeGk, tal, 4);
        //省考断面Ⅰ～Ⅲ类水质比例达以上
        Double sKWc = NumUtil.divide(one2ThreeSk, tal, 4);

        resultMap.put("mbgkbl", gKPercent);
        resultMap.put("mbskbl", sKPercent);
        resultMap.put("wcgkbl", gkWc);
        resultMap.put("wcskbl", sKWc);
        resultMap.put("gkStatus", gkWc >= gKPercent ? "达标" : "未达标");
        resultMap.put("skStatus", sKWc >= sKPercent ? "达标" : "未达标");
        resultMap.put("wdbdmGk", gkWc >= gKPercent ? wdbListGk : new ArrayList<>());
        resultMap.put("wdbdmSk", sKWc >= sKPercent ? wdbListSk : new ArrayList<>());
        String curYear = DateUtil.getCurFullYear();
        yearDataQualityGk = wtCityHourDataService.getYearDataQuality(curYear, GK);//国考
        yearDataQualitySk = wtCityHourDataService.getYearDataQuality(curYear, SK);//省考
        yearDataQualityZJ = wtCityHourDataService.getYearDataQuality(curYear, ZJ);//自建

        Map<String, List<Map<String, Object>>> wdbGkMap = new HashMap<>();
        Map<String, List<Map<String, Object>>> dbGkMap = new HashMap<>();
        Map<String, List<Map<String, Object>>> wdbSkMap = new HashMap<>();
        Map<String, List<Map<String, Object>>> dbSkMap = new HashMap<>();

        //国考
        for (int i = 0; i < yearDataQualityGk.size(); i++) {
            Map<String, Object> stringObjectMap = yearDataQualityGk.get(i);
            //国控达标未达标分开
            List<Map<String, Object>> wdbList = new ArrayList<>();
            List<Map<String, Object>> dbList = new ArrayList<>();
            if (WaterQualityUtil.formatVal2((String) stringObjectMap.get("pointQuality")) < WaterQualityUtil.formatVal2((String) stringObjectMap.get("1-12mm"))) {
                wdbList.add(stringObjectMap);
            } else {
                dbList.add(stringObjectMap);
            }
            if (!wdbList.isEmpty()) wdbGkMap.put(stringObjectMap.get("pointCode").toString(), wdbList);
            if (!dbList.isEmpty()) dbGkMap.put(stringObjectMap.get("pointCode").toString(), dbList);
        }
        //省考
        for (int i = 0; i < yearDataQualitySk.size(); i++) {
            Map<String, Object> stringObjectMap = yearDataQualitySk.get(i);
            //国控达标未达标分开
            List<Map<String, Object>> wdbList = new ArrayList<>();
            List<Map<String, Object>> dbList = new ArrayList<>();
            if (WaterQualityUtil.formatVal2((String) stringObjectMap.get("pointQuality")) < WaterQualityUtil.formatVal2((String) stringObjectMap.get("1-12mm"))) {
                wdbList.add(stringObjectMap);
            } else {
                dbList.add(stringObjectMap);
            }
            if (!wdbList.isEmpty()) wdbSkMap.put(stringObjectMap.get("pointCode").toString(), wdbList);
            if (!dbList.isEmpty()) dbSkMap.put(stringObjectMap.get("pointCode").toString(), dbList);
        }

        resultMap.put("dmxqdbGk", dbGkMap);//断面详情达标国考
        resultMap.put("dmxqwdbGk", wdbGkMap);//断面详情未达标国考
        resultMap.put("dmxqdbSk", dbSkMap);//断面详情达标省考
        resultMap.put("dmxqwdbSk", wdbSkMap);//断面详情未达标省考
        resultMap.put("yearDataQualityGk", yearDataQualityGk);//断面详情未达标省考
        resultMap.put("yearDataQualitySk", yearDataQualityGk);//断面详情未达标省考
        resultMap.put("yearDataQualityZJ", yearDataQualityZJ);//断面详情未达标省考
        //resultMap.put("getDetailList4Month", getDetailList4Month(GK,new HashMap()));//断面详情未达标省考
        return resultMap;
    }

    /**
     * 国控，省考所有站点
     *
     * @param s “1”：国控   “2”：省考
     * @return
     */
    private List countPointCode(String s) {
        StringBuilder countPointSql = new StringBuilder();
        countPointSql.append(" SELECT distinct b.POINT_CODE,b.POINT_NAME,b.POINT_QUALITY FROM WT_CITY_HOUR_DATA a");
        countPointSql.append(" INNER JOIN WT_CITY_POINT b ON a.POINT_CODE = b.POINT_CODE");
        countPointSql.append(" WHERE b.STATUS = 1 AND DATAVALUE IS NOT NULL");
        if (GK.equals(s)) {
            countPointSql.append(" AND b.CATEGORY=1  ");
        } else {
            countPointSql.append(" AND b.CATEGORY=2  ");
        }
        countPointSql.append(" AND CODE_POLLUTE IN ('W01001', 'W01009', 'W01019', 'W01018', 'W01017', 'W21003', 'W21011')");
        countPointSql.append(" AND DATATIME >= TO_DATE('").append(DateUtil.getFirstOfCurYear_Str()).append("', 'yyyy-mm-dd')");
        countPointSql.append(" AND DATATIME <= TO_DATE('").append(DateUtil.getCurYearMonthDay()).append("', 'yyyy-mm-dd')");
        countPointSql.append("  order by b.POINT_CODE ");
        List resultList = simpleDao.createNativeQuery(countPointSql.toString()).getResultList();
        return resultList;
    }


}
