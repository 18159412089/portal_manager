package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import com.fjzxdz.ams.util.WaterSeriesUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 水环境小时数据
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:25:58
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtCityHourDataServiceImpl implements WtCityHourDataService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getPageList</p>
     * <p>Description:  数据服务-水环境自建站点数据列表 </p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtCityHourDataParam param, Page<Map<String, Object>> page) {

        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "', 'yyyy-mm-dd hh24:mi:ss')";
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            } else {
                where = "";
            }
        }
        String sql = "SELECT a.DATATIME, a.POINT_CODE, a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', DATAVALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', DATAVALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', DATAVALUE, 0 )) W01009,"
                + "sum(DECODE( CODE_POLLUTE, 'W01014', DATAVALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', DATAVALUE, 0 )) W01003,"
                + "sum(DECODE( CODE_POLLUTE, 'W01019', DATAVALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', DATAVALUE, 0 )) W21003,"
                + "sum(DECODE( CODE_POLLUTE, 'W21011', DATAVALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', DATAVALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_HOUR_REPORT b ON a.DATATIME=b.DATATIME AND a.POINT_CODE=b.POINT_CODE "
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE AND c.CATEGORY=3 " + where
                + " GROUP BY a.DATATIME,a.POINT_CODE,a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY a.DATATIME DESC";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> result = byPage.getResult();
        for (int i = 0; i < result.size(); i++) {
            JSONArray polluteName = new JSONArray();
            JSONArray polluteCodes = new JSONArray();
            Map<String, Object> map = result.get(i);
            map.put("targetQuality", WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("targetQuality"))).getKey());
            map.put("resultQuality", WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("resultQuality"))).getKey());
            JSONArray parseArray = JSONArray.parseArray(map.get("excessfactorstr").toString());
            map.remove("excessfactorstr");
            for (int j = 0; j < parseArray.size(); j++) {
                JSONObject jsonObject = parseArray.getJSONObject(j);
                if (!jsonObject.containsKey("isExcess")) {
                    polluteName.add(jsonObject.get("polluteName"));
                    polluteCodes.add(jsonObject.get("codePollute").toString().toLowerCase());
                } else if (jsonObject.get("isExcess").equals(true)) {
                    polluteName.add(jsonObject.get("polluteName"));
                    polluteCodes.add(jsonObject.get("codePollute").toString().toLowerCase());
                }
            }
            map.put("polluteNames", polluteName);
            map.put("polluteCodes", polluteCodes);
            result.set(i, map);
        }
        byPage.setResult(result);
        return byPage;
    }

    /**
     * <p>Title: getPointsDateByHour</p>
     * <p>Description: 数据服务-水环境自建站点数据分析  </p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService#getPointsDateByHour(com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getPointsDateByHour(WtCityHourDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        List<String> pollutes = strToList(param.getParamname());
        Map<String, Object> timeMap = null;
        Map<String, Integer> indexmap = null;
        List<String> xAxis = null;
        List<Object[]> list = null;
        String sql = "";
        for (String str : pollutes) {
            Map<String, Object> map = new HashMap<>();
            Map<String, Object[]> series = new HashMap<String, Object[]>();
            sql = "SELECT a.POINT_NAME,PARAMNAME,DATAVALUE,to_char(DATATIME,'yyyy-mm-dd hh24'),b.UNIT,b.RATE FROM WT_CITY_HOUR_DATA a "
                    + "INNER JOIN WT_CITY_FACTOR b ON a.POINT_CODE=b.POINT_CODE AND a.CODE_POLLUTE=b.CODE_POLLUTE "
                    + "WHERE a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ") and DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') "
                    + "and DATATIME <= TO_DATE('" + param.getEndTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.CODE_POLLUTE='" + str + "' "
                    + "GROUP BY a.POINT_NAME,DATATIME,PARAMNAME,DATAVALUE,b.UNIT,b.RATE ORDER BY a.POINT_NAME,DATATIME ASC";
            list = simpleDao.createNativeQuery(sql).getResultList();
            if (ToolUtil.isNotEmpty(list)) {
                int rate = Integer.parseInt(list.get(0)[5].toString());
                timeMap = DateUtil.getBetweenHour(param.getStartTime(), param.getEndTime(), rate);
                indexmap = (Map<String, Integer>) timeMap.get("indexmap");
                xAxis = (List<String>) timeMap.get("xList");
                for (Object[] obj : list) {
                    if (obj[0] != null) {
                        if (series.containsKey(obj[0])) {
                            if (obj[2] != null && indexmap.containsKey(obj[3])) {
                                series.get(obj[0].toString())[indexmap.get(obj[3])] = new BigDecimal(obj[2].toString());
                            }
                        } else {
                            Object[] tempList = new Object[indexmap.size()];
                            if (obj[2] != null && indexmap.containsKey(obj[3])) {
                                tempList[indexmap.get(obj[3])] = new BigDecimal(obj[2].toString());
                            }
                            series.put(obj[0].toString(), tempList);
                        }
                    }
                }
            }
            List<String> legendList = new ArrayList<String>();
            JSONArray xArray = new JSONArray();
            map.put("xAxis", xAxis);
            for (Object key : series.keySet()) {
                legendList.add(key.toString());
                JSONObject xObject = new JSONObject();
                xObject.put("data", series.get(key));
                xObject.put("type", "line");
                xObject.put("name", key);
                xArray.add(xObject);
            }
            map.put("legend", legendList);
            String unit = list.size() > 0 ? StringUtils.nullToString(list.get(0)[4]) : "";
            unit = "".equals(unit) ? "" : "（" + unit + "）";
            map.put("title", list.size() > 0 ? StringUtils.nullToString(list.get(0)[1]) + unit : "暂无数据");
            map.put("formatter", "{value}");
            map.putAll(WaterSeriesUtil.getSeriesData(xArray, str));
            result.add(map);
        }
        return result;
    }

    public String toSqlStr(String str) {
        String sqlStr = null;
        if (ToolUtil.isNotEmpty(str)) {
            String[] strs = str.split(",");
            sqlStr = "'" + StringUtils.join(strs, "','") + "'";
        }
        return sqlStr;
    }

    public List<String> strToList(String str) {
        if (ToolUtil.isNotEmpty(str)) {
            return Arrays.asList(str.split(","));
        }
        return new ArrayList<String>();
    }

    /**
     * <p>Title: getYearDataQuality</p>
     * <p>Description: 数据服务-国家水质年监测结果数据   </p>
     *
     * @param queryYear
     * @param flag      为1,2水环境大屏展示
     * @return
     * @see WtCityHourDataService#getYearDataQuality(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getYearDataQuality(String queryYear, String flag) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        String gkSkSql = "";
        if ("1".equals(flag)) {
            gkSkSql = " and b.category=1 ";
        }
        if ("2".equals(flag)) {
            gkSkSql = " and b.category=2 ";
        }
        if ("3".equals(flag)) {
            gkSkSql = " and b.category=3 ";
        }
        String sql1 = "SELECT TO_CHAR(DATATIME,'yyyy-mm') AS yearmonth,a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 " + gkSkSql + " AND DATAVALUE IS NOT NULL "
                + "AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE('" + queryYear + "-01-01','yyyy-mm-dd') "
                + "AND DATATIME<=TO_DATE('" + queryYear + "-12-31','yyyy-mm-dd') GROUP BY TO_CHAR(DATATIME,'yyyy-mm'),a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                + "ORDER BY yearmonth DESC,a.POINT_CODE,CODE_POLLUTE ASC";
        String sql2 = "SELECT TO_CHAR(DATATIME,'yyyy') AS yearmonth,a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 " + gkSkSql + " AND DATAVALUE IS NOT NULL "
                + "AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE('" + queryYear + "-01-01','yyyy-mm-dd') "
                + "AND DATATIME<=TO_DATE('" + queryYear + "-12-31','yyyy-mm-dd') GROUP BY TO_CHAR(DATATIME,'yyyy'),a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                + "ORDER BY yearmonth DESC,a.POINT_CODE,CODE_POLLUTE ASC";
        Map<String, Map<String, Object>> mapForMonth = getQuality(simpleDao.createNativeQuery(sql1).getResultList());
        Map<String, Map<String, Object>> mapForYear = getQuality(simpleDao.createNativeQuery(sql2).getResultList());
        for (String key1 : mapForMonth.keySet()) {
            Map<String, Object> result1 = new HashMap<String, Object>();
            WaterQualityEnum targetQuality = WaterQualityEnum.valueOf(mapForMonth.get(key1).get("pointQuality").toString());
            String pointType = mapForMonth.get(key1).get("pointType").toString();
            result1.put("pointName", mapForMonth.get(key1).get("pointName").toString());
            result1.put("pointQuality", targetQuality.getKey());
            result1.put("pointCode", key1);
            Map<String, cn.hutool.json.JSONArray> object1 = (Map<String, cn.hutool.json.JSONArray>) mapForYear.get(key1).get("monthData");
            cn.hutool.json.JSONArray jsonArray1 = object1.get(queryYear);
            cn.hutool.json.JSONObject waterQuality1 = WaterQualityUtil.getWaterQuality(jsonArray1, pointType, targetQuality);
            result1.put("1-12mm", WaterQualityEnum.valueOf(waterQuality1.get("resultQuality").toString()).getKey());

            cn.hutool.json.JSONArray excessFactor = (cn.hutool.json.JSONArray) waterQuality1.get("excessFactor");
            JSONArray polluteName = new JSONArray();
            for (int j = 0; j < excessFactor.size(); j++) {
                cn.hutool.json.JSONObject jsonObject = excessFactor.getJSONObject(j);
                if (!jsonObject.containsKey("isExcess")) {
                    polluteName.add(jsonObject.get("polluteName"));
                } else if (jsonObject.get("isExcess").equals(true)) {
                    polluteName.add(jsonObject.get("polluteName"));
                }
            }
            result1.put("polluteName", polluteName);
            Map<String, cn.hutool.json.JSONArray> object2 = (Map<String, cn.hutool.json.JSONArray>) mapForMonth.get(key1).get("monthData");
            for (String yearMonth : object2.keySet()) {
                cn.hutool.json.JSONArray jsonArray2 = object2.get(yearMonth);
                cn.hutool.json.JSONObject waterQuality2 = WaterQualityUtil.getWaterQuality(jsonArray2, pointType, targetQuality);

                String quality = WaterQualityEnum.valueOf(waterQuality2.get("resultQuality").toString()).getKey();
                result1.put(yearMonth.split("-")[1] + "mm", quality);
            }
            result.add(result1);
        }
        return result;
    }

    /**
     * <p>Title: getRankingQualityDataForPollutant</p>
     * <p>Description: 数据服务-均值比较   </p>
     *
     * @param
     * @param :         category    1为国控，2为省控，3为自建
     * @param :         type hour,day,month,day
     * @return
     * @see WtCityHourDataService#getYearDataQuality(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getRankingQualityDataForPollutant(String regionCode, String startTime, String endTime, String category, String type, String pollutantCode, int flag) {
        if (type == null) {
            return null;
        }
        List<Map<String, Object>> result = null;
        String gkSkSql = "";
        String timestr = "";
        if ("1".equals(category)) {
            gkSkSql = " and b.category=1 ";
        }
        if ("2".equals(category)) {
            gkSkSql = " and b.category=2 ";
        }
        if ("3".equals(category)) {
            gkSkSql = " and b.category=3 ";
        }

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        switch (type) {
            case "date":
                timestr = "AND DATATIME>=TO_DATE('" + startTime + "','yyyy-mm-dd HH24:mi:ss') "
                        + " AND DATATIME<=TO_DATE('" + endTime + "','yyyy-mm-dd HH24:mi:ss')";
                break;
            case "month":
                String firstDayOfMonth = df.format(DateUtil.getFisrtDayOfMonth(startTime)).toString();
                String lastDayOfMonth = df.format(DateUtil.getLastDayOfMonth(endTime)).toString();
                timestr = "AND DATATIME>=TO_DATE('" + firstDayOfMonth + "','yyyy-mm-dd HH24:mi:ss') "
                        + " AND DATATIME<=TO_DATE('" + lastDayOfMonth + "','yyyy-mm-dd HH24:mi:ss')";
                break;
            case "year":
                String firstDayOfYear = df.format(DateUtil.getFirstDayOfYear(startTime)).toString();
                String lastDayOfYear = endTime.split("-")[0].toString() + "-12-31";
                timestr = "AND DATATIME>=TO_DATE('" + firstDayOfYear + "','yyyy-mm-dd') "
                        + " AND DATATIME<=TO_DATE('" + lastDayOfYear + "','yyyy-mm-dd')";
                break;

            default:
                break;
        }
        if (flag == 1) {
            result = getWTAvgDataByPoint(regionCode, timestr, gkSkSql, pollutantCode);
        } else {
            result = getWTAvgDataByCity(regionCode, timestr, gkSkSql, pollutantCode);
        }
        return result;
    }

    //获取各个站点均值数据
    private List<Map<String, Object>> getWTAvgDataByPoint(String regionCode, String timestr,
                                                          String gkSkSql, String pollutantCode) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        String sql = "SELECT  a.POINT_CODE,a.POINT_NAME,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.CODE_REGION in(" + regionCode + ") " + gkSkSql + " AND DATAVALUE IS NOT NULL "
                + timestr
                + " AND a.CODE_POLLUTE ='" + pollutantCode + "'"
                + " GROUP BY  a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                + " ORDER BY  a.POINT_CODE  desc";
        List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
        for (Object[] objects : resultList) {
            Map<String, Object> mapObj = new HashMap<>();
            mapObj.put("pointCode", objects[0]);
            mapObj.put("pointName", objects[1]);
            mapObj.put("codePollute", objects[2]);
            mapObj.put("pollutantName", objects[3]);
            mapObj.put("avgValue", Float.valueOf(objects[4].toString()));
            result.add(mapObj);
        }
        return result;
    }

    //获取各个城市均值数据
    private List<Map<String, Object>> getWTAvgDataByCity(String regionCode, String timestr,
                                                         String gkSkSql, String pollutantCode) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        String sql = "SELECT  b.CODE_REGION,b.REGION_NAME,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.CODE_REGION in(" + regionCode + ") " + gkSkSql + " AND DATAVALUE IS NOT NULL "
                + timestr
                + " AND a.CODE_POLLUTE ='" + pollutantCode + "'"
                + " GROUP BY  b.CODE_REGION,b.REGION_NAME,CODE_POLLUTE,PARAMNAME "
                + " ORDER BY  b.CODE_REGION  desc";
        List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
        for (Object[] objects : resultList) {
            Map<String, Object> mapObj = new HashMap<>();
            mapObj.put("pointCode", objects[0]);
            mapObj.put("pointName", objects[1]);
            mapObj.put("codePollute", objects[2]);
            mapObj.put("pollutantName", objects[3]);
            mapObj.put("avgValue", Float.valueOf(objects[4].toString()));
            result.add(mapObj);
        }
        return result;
    }


    /**
     * <p>Title: getYearDataQuality</p>
     * <p>Description: 数据服务-水质分析   </p>
     *
     * @param
     * @param :         category    1为国控，2为省控，3为自建
     * @param :         type hour,day,month,day
     * @return
     * @see WtCityHourDataService#getYearDataQuality(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getRankingQualityDataByTime(String regionCode, String startTime, String endTime, String category, String type) {
        if (type == null) {
            return null;
        }
        List<Map<String, Object>> result = null;
        String gkSkSql = "";
        if ("1".equals(category)) {
            gkSkSql = " and b.category=1 ";
        }
        if ("2".equals(category)) {
            gkSkSql = " and b.category=2 ";
        }
        if ("3".equals(category)) {
            gkSkSql = " and b.category=3 ";
        }
        result = getWTHourData(regionCode, startTime, endTime, gkSkSql);
        return result;
    }

    /**
     * 获取小时数据
     *
     * @param regionCode 区域编码
     * @param startTime  开始时间
     * @param endTime    结束时间
     * @param gkSkSql    国控省控sql
     * @return
     */
    private List<Map<String, Object>> getWTHourData(String regionCode, String startTime, String endTime, String gkSkSql) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        String regionStr ="";
        if(StringUtils.isNotBlank(regionCode)){
            regionStr =" and b.CODE_REGION =" + regionCode + " ";
        }

        String sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3) "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE  1=1  " + regionStr + " " + gkSkSql + " AND DATAVALUE IS NOT NULL "
                + "AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE('" + startTime + "','yyyy-mm-dd HH24:mi:ss') "
                + "AND DATATIME<=TO_DATE('" + endTime + "','yyyy-mm-dd HH24:mi:ss') GROUP BY  a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                + "ORDER BY  a.POINT_CODE,CODE_POLLUTE  desc";
        Map<String, Map<String, Object>> mapForHour = getHourQuality(simpleDao.createNativeQuery(sql).getResultList());
        for (String key1 : mapForHour.keySet()) {
            Map<String, Object> result1 = new HashMap<String, Object>();
            WaterQualityEnum targetQuality = WaterQualityEnum.valueOf(mapForHour.get(key1).get("pointQuality").toString());
            String pointType = mapForHour.get(key1).get("pointType").toString();
            result1.put("pointName", mapForHour.get(key1).get("pointName").toString());
            result1.put("pointQuality", targetQuality.getKey());
            result1.put("pointCode", key1);
            cn.hutool.json.JSONArray jsonArray1 = (cn.hutool.json.JSONArray) mapForHour.get(key1).get("pollutantDatas");
            cn.hutool.json.JSONObject waterQuality1 = WaterQualityUtil.getWaterQuality(jsonArray1, pointType, targetQuality);
            result1.put("reslutQuality", WaterQualityEnum.valueOf(waterQuality1.get("resultQuality").toString()).getKey());
            result1.put("overPollutant", getOverPollutant((cn.hutool.json.JSONArray) waterQuality1.get("excessFactor")));
            result1.put("reslutQualityNum", getWaterLevelNum(waterQuality1.get("resultQuality").toString()));
            result.add(result1);
        }
        return result;
    }

    private List<Map<String, Object>> getWTDayData(String queryYear, String gkSkSql) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        return result;

    }

    //获取超标物
    private String getOverPollutant(cn.hutool.json.JSONArray jsonArray) {
        String string = "";
        for (int i = 0; i < jsonArray.size(); i++) {
            cn.hutool.json.JSONObject pollutantJsonObject = (cn.hutool.json.JSONObject) jsonArray.get(i);
            if (pollutantJsonObject.getStr("isExcess").equals("true")) {
                string = pollutantJsonObject.getStr("polluteName") + "," + string;
            }
        }
        if (string.length() > 0) {
            string = string.substring(0, string.length() - 1);
        } else {
            string = "无";
        }
        return string;

    }

    //获取小时数据
    private Map<String, Map<String, Object>> getHourQuality(List<Object[]> resultList) {
        Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
        for (Object[] objects : resultList) {
            if (!map.containsKey(objects[0].toString())) {
                Map<String, Object> map1 = new HashMap<String, Object>();
                cn.hutool.json.JSONArray hourDataArr = new cn.hutool.json.JSONArray();
                map1.put("pointQuality", objects[3]);
                map1.put("pointType", objects[2]);
                map1.put("pointName", objects[1]);
                map1.put("pollutantDatas", hourDataArr);
                map.put(objects[0].toString(), map1);
            } else {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("codePollute", objects[4]);
                jsonObject.put("polluteName", objects[5]);
                jsonObject.put("polluteValue", objects[6]);
                ((cn.hutool.json.JSONArray) map.get(objects[0]).get("pollutantDatas")).add(jsonObject);

            }
        }
        return map;
    }

    /**
     * 同比 监测站因子比较
     */
    @SuppressWarnings("unchecked")
    @Override
    public cn.hutool.json.JSONObject getWtYearToYearDataByTime(String pointCodes, String codePollute, String startTime, String endTime, String type) {
        if (type == null) {
            return null;
        }
        String sql = null;
        switch (type) {
            case "DAY":
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,  to_char(DATATIME, 'yyyy-mm-dd hh') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in(" + pointCodes + ")  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE ='" + codePollute + "' AND (TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy-mm-dd')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy-mm-dd hh') , b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                        + "ORDER BY  a.POINT_CODE,CODE_POLLUTE,DATATIME  asc";
                break;
            case "MONTH":
                startTime = startTime.split("-")[0] + "-" + startTime.split("-")[1];
                endTime = endTime.split("-")[0] + "-" + endTime.split("-")[1];
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,  to_char(DATATIME, 'yyyy-mm-dd') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in(" + pointCodes + ")  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE ='" + codePollute + "' AND (TO_CHAR (DATATIME, 'yyyy-mm') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy-mm')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy-mm-dd') , b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                        + "ORDER BY  a.POINT_CODE,CODE_POLLUTE,DATATIME  asc";
                break;
            case "YEAR":
                startTime = startTime.split("-")[0];
                endTime = endTime.split("-")[0];
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,  to_char(DATATIME, 'yyyy-mm') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in(" + pointCodes + ")  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE ='" + codePollute + "' AND (TO_CHAR (DATATIME, 'yyyy') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy-mm') , b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME "
                        + "ORDER BY  a.POINT_CODE,CODE_POLLUTE,DATATIME  asc";
                break;
            default:
                break;
        }
        cn.hutool.json.JSONObject record = getWTPointData(sql, startTime, endTime);
        return record;
    }

    //同比   wtPointData 站点数据
    public cn.hutool.json.JSONObject getWTPointData(String sql, String startTime, String endTime) {

        List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
        cn.hutool.json.JSONObject pointMonitorDataArr = new cn.hutool.json.JSONObject();
        for (Object[] objects : resultList) {
            if (!pointMonitorDataArr.containsKey(objects[0].toString())) {
                JSONObject allObject = new JSONObject();
                JSONObject pollutantObject = new JSONObject();
                JSONArray dataArr = new JSONArray();
                JSONArray monitorTimeArr = new JSONArray();
                allObject.put("pointCode", objects[0]);
                allObject.put("pointName", objects[1]);
                allObject.put("pointQuality", objects[2]);
                pollutantObject.put("codePollute", objects[3]);
                pollutantObject.put("polluteName", objects[4]);
                monitorTimeArr.add(objects[5]);
                pollutantObject.put("monitorTimes", monitorTimeArr);
                dataArr.add(objects[6]);
                pollutantObject.put("pollutantDatas", dataArr);
                allObject.put(objects[3].toString(), pollutantObject);
                pointMonitorDataArr.put(objects[0].toString(), allObject);
            } else {
                cn.hutool.json.JSONObject allObject = pointMonitorDataArr.getJSONObject(objects[0].toString());
                if (allObject.containsKey(objects[3].toString())) {
                    allObject.getJSONObject(objects[3].toString()).getJSONArray("pollutantDatas").add(objects[6]);
                    allObject.getJSONObject(objects[3].toString()).getJSONArray("monitorTimes").add(objects[5]);
                } else {
                    JSONObject pollutantObject = new JSONObject();
                    JSONArray dataArr = new JSONArray();
                    JSONArray monitorTimeArr = new JSONArray();
                    pollutantObject.put("codePollute", objects[3]);
                    pollutantObject.put("polluteName", objects[4]);
                    monitorTimeArr.add(objects[5]);
                    pollutantObject.put("monitorTimes", monitorTimeArr);
                    dataArr.add(objects[6]);
                    pollutantObject.put("pollutantDatas", dataArr);
                    allObject.put(objects[3].toString(), pollutantObject);
                }
            }
        }
        return pointMonitorDataArr;
    }


    /**
     * 同比 监测站因子结论
     * pointCodes  站点集合
     * startTime   开始时间
     * endTime     结束时间
     * type        类型  天 月 年
     */
    @SuppressWarnings("unchecked")
    @Override
    public cn.hutool.json.JSONObject getWtYearToYearDataResultByTime(String pointCodes, String startTime, String endTime, String type) {
        if (type == null) {
            return null;
        }
        String sql = null;
        switch (type) {
            case "DAY":
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,  to_char(DATATIME, 'yyyy-mm-dd') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in('" + pointCodes + "')  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE in( 'W01001','W01009','W01019','W01018','W01017','W21003','W21011') "
                        + "AND (TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy-mm-dd')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy-mm-dd') , b.POINT_QUALITY,CODE_POLLUTE "
                        + "ORDER BY  a.POINT_CODE,DATATIME  asc";
                break;
            case "MONTH":
                startTime = startTime.split("-")[0] + "-" + startTime.split("-")[1];
                endTime = endTime.split("-")[0] + "-" + endTime.split("-")[1];
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,  to_char(DATATIME, 'yyyy-mm') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in('" + pointCodes + "')  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE in( 'W01001','W01009','W01019','W01018','W01017','W21003','W21011') "
                        + "AND (TO_CHAR (DATATIME, 'yyyy-mm') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy-mm')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy-mm') , b.POINT_QUALITY,CODE_POLLUTE "
                        + "ORDER BY  a.POINT_CODE,DATATIME  asc";
                break;
            case "YEAR":
                startTime = startTime.split("-")[0];
                endTime = endTime.split("-")[0];
                sql = "SELECT  a.POINT_CODE,a.POINT_NAME,b.POINT_QUALITY,CODE_POLLUTE,  to_char(DATATIME, 'yyyy') as DATATIME, ROUND (AVG(DATAVALUE), 3) as avgVal "
                        + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.POINT_CODE in('" + pointCodes + "')  AND DATAVALUE IS NOT NULL "
                        + "AND CODE_POLLUTE in( 'W01001','W01009','W01019','W01018','W01017','W21003','W21011') "
                        + "AND (TO_CHAR (DATATIME, 'yyyy') = '" + startTime + "' "
                        + "or 	TO_CHAR (DATATIME, 'yyyy')= '" + endTime + "') GROUP BY A .POINT_CODE,A.POINT_NAME,TO_CHAR (DATATIME, 'yyyy') , b.POINT_QUALITY,CODE_POLLUTE "
                        + "ORDER BY  a.POINT_CODE,DATATIME  asc";
                break;
            default:
                break;
        }
        cn.hutool.json.JSONObject record = getWTPointResultData(sql, startTime, endTime);
        return record;
    }


    //同比   wtPointData 站点结论数据
    public cn.hutool.json.JSONObject getWTPointResultData(String sql, String startTime, String endTime) {

        List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
        cn.hutool.json.JSONObject pointMonitorDataArr = new cn.hutool.json.JSONObject();
        for (Object[] objects : resultList) {
            if (!pointMonitorDataArr.containsKey(objects[0].toString())) {
                cn.hutool.json.JSONObject pollutantObject = new cn.hutool.json.JSONObject();
                cn.hutool.json.JSONObject monitorObject = new cn.hutool.json.JSONObject();
                if (startTime.contains(objects[4].toString())) {
                    monitorObject.put("currentItem", objects[5]);
                } else {
                    monitorObject.put("lastItem", objects[5]);
                }
                pollutantObject.put(objects[3].toString(), monitorObject);

                pointMonitorDataArr.put(objects[0].toString(), pollutantObject);
            } else {
                cn.hutool.json.JSONObject pollutantObject = pointMonitorDataArr.getJSONObject(objects[0].toString());
                cn.hutool.json.JSONObject monitorObject = null;
                if (pollutantObject.containsKey(objects[3].toString())) {
                    monitorObject = pollutantObject.getJSONObject(objects[3].toString());
                    if (startTime.contains(objects[4].toString())) {
                        monitorObject.put("currentItem", objects[5]);
                    } else {
                        monitorObject.put("lastItem", objects[5]);
                    }
                } else {
                    monitorObject = new cn.hutool.json.JSONObject();
                    if (startTime.contains(objects[4].toString())) {
                        monitorObject.put("currentItem", objects[5]);
                    } else {
                        monitorObject.put("lastItem", objects[5]);
                    }
                    pollutantObject.put(objects[3].toString(), monitorObject);
                    pointMonitorDataArr.put(objects[0].toString(), pollutantObject);
                }


            }
        }
        return pointMonitorDataArr;
    }


    /**
     * 获取水质等级Num 数值
     *
     * @param name
     */
    private int getWaterLevelNum(String name) {
        int num = 0;
        switch (name) {
            case "FIRSR":
                num = 1;
                break;
            case "SECOND":
                num = 2;
                break;
            case "THIRD":
                num = 3;
                break;
            case "FOURTH":
                num = 4;
                break;
            case "FIFTH":
                num = 5;
                break;
            case "OTHER":
                num = 6;
                break;
            default:
                break;
        }
        return num;
    }


    /**
     * @param resultList
     * @return Map<String, Map < String, Object>>
     * @throws
     * @Title: getQuality
     * @Description: 计算水质类别前数据封装
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午5:28:52
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午5:28:52
     */
    @SuppressWarnings("unchecked")
    public Map<String, Map<String, Object>> getQuality(List<Object[]> resultList) {
        Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
        for (Object[] objects : resultList) {
            if (!map.containsKey(objects[1].toString())) {
                Map<String, Object> map1 = new HashMap<String, Object>();
                Map<String, cn.hutool.json.JSONArray> map2 = new HashMap<String, cn.hutool.json.JSONArray>();
                map1.put("pointQuality", objects[4]);
                map1.put("pointType", objects[3]);
                map1.put("pointName", objects[2]);
                map2.put(objects[0].toString(), new cn.hutool.json.JSONArray());
                map1.put("monthData", map2);
                map.put(objects[1].toString(), map1);
            } else {
                Map<String, cn.hutool.json.JSONArray> object = (Map<String, cn.hutool.json.JSONArray>) map.get(objects[1]).get("monthData");
                if (!object.containsKey(objects[0].toString())) {
                    object.put(objects[0].toString(), new cn.hutool.json.JSONArray());
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("codePollute", objects[5]);
            jsonObject.put("polluteName", objects[6]);
            jsonObject.put("polluteValue", objects[7]);
            Map<String, cn.hutool.json.JSONArray> object = (Map<String, cn.hutool.json.JSONArray>) map.get(objects[1]).get("monthData");
            object.get(objects[0]).add(jsonObject);
        }
        return map;
    }

    /**
     * <p>Title: getMonthDataQuality</p>
     * <p>Description: 数据服务-地表水断面采测分离水质评        </p>
     *
     * @param yearMonth
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService#getMonthDataQuality(java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getMonthDataQuality(String yearMonth) {
        String pattern = "yyyy-MM";
        Date date = DateUtil.parse(yearMonth, pattern);
        String thisMonth1 = DateUtil.getLastDayOfMonth(date, pattern);
        String thisMonth2 = thisMonth1.substring(0, 7) + "-01";
        String lastMonth1 = DateUtil.getLastDayOfMonth(DateUtil.addMonth(date, -1), pattern);
        String lastMonth2 = lastMonth1.substring(0, 7) + "-01";
        String lastYear1 = DateUtil.getLastDayOfMonth(DateUtil.addYear(date, -1), pattern);
        String lastYear2 = lastYear1.substring(0, 7) + "-01";

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        String sql = "SELECT TO_CHAR(a.DATATIME,'yyyy-mm') yearmonth,a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,a.CODE_POLLUTE,a.PARAMNAME,"
                + "ROUND(AVG(a.DATAVALUE), 3) FROM (SELECT DATATIME,POINT_CODE,POINT_NAME,CODE_POLLUTE,PARAMNAME,DATAVALUE FROM WT_CITY_HOUR_DATA WHERE "
                + "DATATIME>=TO_DATE('" + thisMonth2 + "', 'yyyy-mm-dd') AND DATATIME<=TO_DATE('" + thisMonth1 + "', 'yyyy-mm-dd') UNION ALL SELECT DATATIME,POINT_CODE,"
                + "POINT_NAME,CODE_POLLUTE,PARAMNAME,DATAVALUE FROM WT_CITY_HOUR_DATA WHERE DATATIME>=TO_DATE('" + lastMonth2 + "', 'yyyy-mm-dd') AND "
                + "DATATIME<=TO_DATE('" + lastMonth1 + "', 'yyyy-mm-dd') UNION ALL SELECT DATATIME,POINT_CODE,POINT_NAME,CODE_POLLUTE,PARAMNAME,DATAVALUE "
                + "FROM WT_CITY_HOUR_DATA WHERE DATATIME>=TO_DATE('" + lastYear2 + "', 'yyyy-mm-dd') AND DATATIME<=TO_DATE('" + lastYear1 + "', 'yyyy-mm-dd')) a INNER JOIN "
                + "WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') "
                + "GROUP BY TO_CHAR(a.DATATIME,'yyyy-mm'),a.POINT_CODE,a.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,a.CODE_POLLUTE,a.PARAMNAME ORDER BY yearmonth DESC,"
                + "a.POINT_CODE,a.CODE_POLLUTE ASC";
        List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
        Map<String, Map<String, Object>> qualityMap = getQuality(resultList);
        for (String key : qualityMap.keySet()) {
            Map<String, Object> result1 = new HashMap<String, Object>();
            WaterQualityEnum targetQuality = WaterQualityEnum.valueOf(qualityMap.get(key).get("pointQuality").toString());
            String pointType = qualityMap.get(key).get("pointType").toString();
            result1.put("pointName", qualityMap.get(key).get("pointName").toString());
            result1.put("pointQuality", targetQuality.getKey());
            Map<String, cn.hutool.json.JSONArray> object2 = (Map<String, cn.hutool.json.JSONArray>) qualityMap.get(key).get("monthData");
            for (String key1 : object2.keySet()) {
                cn.hutool.json.JSONArray jsonArray2 = object2.get(key1);
                cn.hutool.json.JSONObject waterQuality2 = WaterQualityUtil.getWaterQuality(jsonArray2, pointType, targetQuality);
                String quality = WaterQualityEnum.valueOf(waterQuality2.get("resultQuality").toString()).getKey();
                cn.hutool.json.JSONArray excessFactor = (cn.hutool.json.JSONArray) waterQuality2.get("excessFactor");
                if (yearMonth.indexOf(key1) != -1) {
                    result1.put("thisMonth", quality);
                    JSONArray polluteName = new JSONArray();//国水十条考核目标超标项目
                    JSONArray polluteName1 = new JSONArray();//III类超标项目
                    for (int j = 0; j < excessFactor.size(); j++) {
                        cn.hutool.json.JSONObject jsonObject = excessFactor.getJSONObject(j);
                        if (!jsonObject.containsKey("isExcess")) {
                            polluteName.add(jsonObject.get("polluteName"));
                            String temp = WaterQualityEnum.valueOf(jsonObject.get("resultQuality").toString()).getKey();
                            polluteName1.add("Ⅳ,Ⅴ,劣Ⅴ".indexOf(temp) != -1 ? jsonObject.get("polluteName") : "");
                        } else if (jsonObject.get("isExcess").equals(true)) {
                            polluteName.add(jsonObject.get("polluteName"));
                            String temp = WaterQualityEnum.valueOf(jsonObject.get("resultQuality").toString()).getKey();
                            polluteName1.add("Ⅳ,Ⅴ,劣Ⅴ".indexOf(temp) != -1 ? jsonObject.get("polluteName") : "");
                        }
                    }
                    result1.put("polluteName", polluteName);
                    result1.put("polluteName1", polluteName1);
                } else if (lastMonth1.indexOf(key1) != -1) {
                    result1.put("lastMonth", quality);
                } else if (lastYear1.indexOf(key1) != -1) {
                    result1.put("lastYear", quality);
                }

            }
            result.add(result1);
        }
        return result;
    }

    /**
     * <p>Title: findList</p>
     * <p>Description: 省手工-水基础资料
     *
     * @param param
     * @param page
     * @param response
     * @return
     */
    @Override
    public Page<Map<String, Object>> findList(WtCityHourDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {

        String sql = "select * from ( SELECT\n" +
                "\ta.POINT_CODE,\n" +
                "\ta.POINT_NAME,\n" +
                "\ta.DATATIME,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01001', a.DATAVALUE, 0 )) val1,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01009', a.DATAVALUE, 0 )) val2,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01019', a.DATAVALUE, 0 )) val3,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01018', a.DATAVALUE, 0 )) val4,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01017', a.DATAVALUE, 0 )) val5,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21003', a.DATAVALUE, 0 )) val6,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21011', a.DATAVALUE, 0 )) val7,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '铜', a.DATAVALUE, 0 )) val8,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '锌', a.DATAVALUE, 0 )) val9,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21017', a.DATAVALUE, 0 )) val10,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '硒', a.DATAVALUE, 0 )) val11,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '砷', a.DATAVALUE, 0 )) val12,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '汞', a.DATAVALUE, 0 )) val13,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '镉', a.DATAVALUE, 0 )) val14,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '六价铬', a.DATAVALUE, 0 )) val15,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W20120', a.DATAVALUE, 0 )) val16,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '氰化物', a.DATAVALUE, 0 )) val17,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '阴离子表面活性剂', a.DATAVALUE, 0 )) val18,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '硫化物', a.DATAVALUE, 0 )) val19\n" +
                "FROM\n" +
                "wt_city_hour_data a LEFT JOIN WT_CITY_POINT b on a.POINT_CODE=b.POINT_CODE" +
                " WHERE\n" +
                "\ta.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24' ) \n" +
                "\tAND a.DATATIME <= TO_DATE( '" + param.getEndTime() + "', 'yyyy-mm-dd hh24' ) \n";
        if (StringUtils.isNotEmpty(param.getRegionName())) {
            String[] n = param.getRegionName().split(",");
            sql += "AND (a.point_code='" + n[0] + "'";
            for (int i = 1; i < n.length; i++) {
                sql += "or a.point_code='" + n[i] + "'";
            }
            sql += ")";
        }
        if (param.getType() == 0) {
            sql += " AND a.type is null";
        } else if (param.getType() == 1) {
            sql += " AND a.type='1'";
        } else if (param.getType() == 2) {
            sql += " AND a.type is null";
        }
        if (param.getCategory() == 1) {
            sql += " AND b.CATEGORY='1'";
        } else if (param.getCategory() == 2) {
            sql += " AND b.CATEGORY='2'";
        } else if (param.getCategory() == 3) {
            sql += " AND b.CATEGORY='3'";
        }
        sql += " AND b.STATUS='1'  " +
                " GROUP BY\n" +
                "\ta.POINT_CODE,\n" +
                "\ta.POINT_NAME,\n" +
                "\ta.DATATIME\n" +
                "ORDER BY\n" +
                "\ta.DATATIME DESC )";

        return simpleDao.listNativeByPage(sql, page);
    }

    /**
     * <p>Title: findList</p>
     * <p>Description: 省手工-水基础资料（数据导出）
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> exportData(WtCityHourDataParam param) {
        String sql = "select * from ( SELECT\n" +
                "\ta.POINT_CODE,\n" +
                "\ta.POINT_NAME,\n" +
                "\ta.DATATIME,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01001', a.DATAVALUE, 0 )) val1,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01009', a.DATAVALUE, 0 )) val2,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01019', a.DATAVALUE, 0 )) val3,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01018', a.DATAVALUE, 0 )) val4,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W01017', a.DATAVALUE, 0 )) val5,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21003', a.DATAVALUE, 0 )) val6,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21011', a.DATAVALUE, 0 )) val7,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '铜', a.DATAVALUE, 0 )) val8,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '锌', a.DATAVALUE, 0 )) val9,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W21017', a.DATAVALUE, 0 )) val10,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '硒', a.DATAVALUE, 0 )) val11,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '砷', a.DATAVALUE, 0 )) val12,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '汞', a.DATAVALUE, 0 )) val13,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '镉', a.DATAVALUE, 0 )) val14,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '六价铬', a.DATAVALUE, 0 )) val15,\n" +
                "\tsum(\n" +
                "\tDECODE( a.CODE_POLLUTE, 'W20120', a.DATAVALUE, 0 )) val16,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '氰化物', a.DATAVALUE, 0 )) val17,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '阴离子表面活性剂', a.DATAVALUE, 0 )) val18,\n" +
                "\tsum(\n" +
                "\tDECODE( a.PARAMNAME, '硫化物', a.DATAVALUE, 0 )) val19\n" +
                "FROM\n" +
                "wt_city_hour_data a LEFT JOIN WT_CITY_POINT b on a.POINT_CODE=b.POINT_CODE" +
                " WHERE\n" +
                "\ta.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24' ) \n" +
                "\tAND a.DATATIME <= TO_DATE( '" + param.getEndTime() + "', 'yyyy-mm-dd hh24' ) \n";
        if (StringUtils.isNotEmpty(param.getRegionName())) {
            String[] n = param.getRegionName().split(",");
            sql += "AND (a.point_code='" + n[0] + "'";
            for (int i = 1; i < n.length; i++) {
                sql += "or a.point_code='" + n[i] + "'";
            }
            sql += ")";
        }
        if (param.getType() == 0) {
            sql += " AND a.type is null";
        } else if (param.getType() == 1) {
            sql += " AND a.type='1'";
        } else if (param.getType() == 2) {
            sql += " AND a.type is null";
        }
        if (param.getCategory() == 1) {
            sql += " AND b.CATEGORY='1'";
        } else if (param.getCategory() == 2) {
            sql += " AND b.CATEGORY='2'";
        } else if (param.getCategory() == 3) {
            sql += " AND b.CATEGORY='3'";
        }
        sql += " AND b.STATUS='1'  " +
                " GROUP BY\n" +
                "\ta.POINT_CODE,\n" +
                "\ta.POINT_NAME,\n" +
                "\ta.DATATIME\n" +
                "ORDER BY\n" +
                "\ta.DATATIME DESC )";
        return simpleDao.getNativeQueryList(sql);
    }

    @Override
    public List<Map<String, Object>> getDataByCode(WtCityHourData wtCityHourData) {
        String sql =
                "SELECT * from WT_CITY_HOUR_DATA a \n" +
                        "where point_code='" + wtCityHourData.getPointCode() + "'\n";
        if (StringUtils.isNotEmpty(wtCityHourData.getCodePollute())) {
            sql += "and CODE_POLLUTE='" + wtCityHourData.getCodePollute() + "'\n";

        }
        sql += "and DATATIME =to_date('" + wtCityHourData.getDatatime() + "','yyyy-mm-dd hh24:mi:ss') \n";
        return simpleDao.getNativeQueryList(sql);
    }

    @Override
    public List<Map<String, Object>> getDataByName(WtCityHourData wtCityHourData) {
        String sql =
                "SELECT * from WT_CITY_HOUR_DATA a \n" +
                        "where point_code='" + wtCityHourData.getPointCode() + "'\n";
        if (StringUtils.isNotEmpty(wtCityHourData.getParamname())) {
            sql += "and PARAMNAME='" + wtCityHourData.getParamname() + "'\n";
        }
        sql += "and DATATIME =to_date('" + wtCityHourData.getDatatime() + "','yyyy-mm-dd hh24:mi:ss') \n";
        return simpleDao.getNativeQueryList(sql);
    }

    @Override
    public void insertData(WtCityHourData wtCityHourData) {
        simpleDao.add(wtCityHourData);
    }

    @Override
    public void updateData(WtCityHourData wtCityHourData) {
        simpleDao.update(wtCityHourData);
    }
}
