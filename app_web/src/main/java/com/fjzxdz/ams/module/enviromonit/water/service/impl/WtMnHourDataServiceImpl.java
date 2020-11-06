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
import com.fjzxdz.ams.module.enviromonit.water.dao.WtMnHourDataDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.PollutionWaterData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtMnHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtMnHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 水环境服务
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午4:50:56
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtMnHourDataServiceImpl implements WtMnHourDataService {

    @Autowired
    private WtMnHourDataDao wtMnHourDataDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    public WtMnHourData getById(String uuid) {
        return wtMnHourDataDao.getById(uuid);
    }

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 水数据服务，国家水表格数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtMnHourDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtMnHourDataParam param, Page<Map<String, Object>> page) {

        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime()
                    + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime()
                    + "', 'yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getMm())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getMm()) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getMm())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getMm()) + ")";
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
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE AND c.CATEGORY=1 " + where
                + "GROUP BY a.DATATIME,a.POINT_CODE,a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY a.DATATIME DESC";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> result = byPage.getResult();
        for (int i = 0; i < result.size(); i++) {
            JSONArray polluteName = new JSONArray();
            JSONArray polluteCodes = new JSONArray();
            Map<String, Object> map = result.get(i);
            map.put("targetQuality",
                    WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("targetQuality"))).getKey());
            map.put("resultQuality",
                    WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("resultQuality"))).getKey());
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
     * <p>Title: getPassYearAnalysis</p>
     * <p>Description:  国家水质环比</p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService#getPassYearAnalysis(com.fjzxdz.ams.module.enviromonit.water.param.WtMnHourDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassYearAnalysis(WtMnHourDataParam param) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis;
        String sql;
        Map<String, Object> timeMap = null;
        Map<String, Integer> indexmap;
        if ("W01019".equals(param.getParamnames()) || "W21003".equals(param.getParamnames())
                || "W21011".equals(param.getParamnames()) || "W21001".equals(param.getParamnames())) {
            timeMap = DateUtil.getDayHours(param.getStartTime(), 4);
        } else {
            timeMap = DateUtil.getDayHours(param.getStartTime(), 1);
        }
        String startTime1 = timeMap.get("startTime1").toString();
        String endTime1 = timeMap.get("endTime1").toString();
        String startTime2 = timeMap.get("startTime2").toString();
        String endTime2 = timeMap.get("endTime2").toString();
        xAxis = (List<String>) timeMap.get("xList");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        sql = "SELECT DATATIME,DATAVALUE,POINT_NAME FROM WT_CITY_HOUR_DATA WHERE POINT_CODE = ? AND CODE_POLLUTE = ? AND "
                + "(DATATIME>=to_date(?,'yyyy-mm-dd hh24') AND DATATIME <=to_date(?,'yyyy-mm-dd hh24') OR DATATIME>=to_date(?,'yyyy-mm-dd hh24') AND DATATIME <=to_date(?,'yyyy-mm-dd hh24'))";
        list = simpleDao.createNativeQuery(sql, param.getMm(), param.getParamnames(), startTime1, endTime1, startTime2,
                endTime2).getResultList();

        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                String yearMonth = obj[0].toString().substring(0, 10);
                String dateTime = obj[0].toString().substring(11, 13);
                if (series.containsKey(yearMonth)) {
                    if (obj[1] != null && indexmap.containsKey(dateTime)) {
                        series.get(yearMonth)[indexmap.get(dateTime)] = new BigDecimal(obj[1].toString());
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null && indexmap.containsKey(dateTime)) {
                        tempList[indexmap.get(dateTime)] = new BigDecimal(obj[1].toString());
                    }
                    series.put(yearMonth, tempList);
                }
            }
        }
        List<String> legendList = new ArrayList<String>();
        JSONArray xArray = new JSONArray();
        result.put("xAxis", xAxis);
        for (Object key : series.keySet()) {
            legendList.add(key.toString());
            JSONObject xObject = new JSONObject();
            xObject.put("data", series.get(key));
            xObject.put("type", "line");
            xObject.put("name", key);
            xArray.add(xObject);
        }
        result.put("legend", legendList);
        result.put("series", xArray);
        result.put("title", list.size() > 0 ? list.get(0)[2].toString() : "暂无数据");
        result.put("formatter", "{value}");
        return result;
    }

    /**
     * @param str
     * @return String
     * @throws
     * @Title: toSqlStr
     * @Description: 拼接sql片段
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:07:12
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:07:12
     */
    public String toSqlStr(String str) {
        String sqlStr = null;
        if (ToolUtil.isNotEmpty(str)) {
            String[] strs = str.split(",");
            sqlStr = "'" + StringUtils.join(strs, "','") + "'";
        }
        return sqlStr;
    }

    /**
     * @param str
     * @return List<String>
     * @throws
     * @Title: strToList
     * @Description: list转换成数组
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:07:51
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:07:51
     */
    public List<String> strToList(String str) {
        if (ToolUtil.isNotEmpty(str)) {
            return Arrays.asList(str.split(","));
        }
        return new ArrayList<String>();
    }

    /**
     * <p>Title: getBasinYearAnalysis</p>
     * <p>Description: 小流域环比分析</p>
     *
     * @param name
     * @param polluteCode
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService#getBasinYearAnalysis(java.lang.String, java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getBasinYearAnalysis(String name, String polluteCode) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        String sql;
        sql = "SELECT YEAR_NUMBER,MONTH_NUMBER,BASIN_NAME,REPLACE(" + polluteCode
                + ", 'L', '') FROM WT_BASIN_MONTH_DATA WHERE BASIN_NAME=? and MONTH_NUMBER is not null ORDER BY YEAR_NUMBER DESC,MONTH_NUMBER DESC";
        list = simpleDao.createNativeQuery(sql, name).getResultList();
        List<String> legendList = new ArrayList<String>();
        JSONArray seriesData = new JSONArray();
        int i = 0;
        for (Object[] obj : list) {
            if (i < 2) {
                seriesData.add(obj[3].toString());
                legendList.add(obj[0].toString() + "年" + obj[1].toString() + "月");
                i++;
            }
        }
        // xObject.put("name", obj[0].toString()+obj[1].toString());
        result.put("title", name);
        result.put("xAxis", legendList);
        result.put("seriesData", seriesData);
        return result;
    }

    /**
     * <p>Title: getBasinYearAnalysisTb</p>
     * <p>Description: 小流域同比分析 </p>
     *
     * @param name
     * @param polluteCode
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService#getBasinYearAnalysisTb(java.lang.String, java.lang.String)
     */
    @SuppressWarnings({"unchecked"})
    @Override
    public Map<String, Object> getBasinYearAnalysisTb(String name, String polluteCode) {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        String sql;
        Date date = new Date();
        int year = Integer.parseInt(DateUtil.getYear(date)) - 1;
        sql = " SELECT YEAR_NUMBER,BASIN_NAME,VALUE,MONTH_NUMBER FROM(SELECT YEAR_NUMBER,BASIN_NAME,REPLACE("
                + polluteCode + ", 'L', '') AS VALUE,MONTH_NUMBER FROM WT_BASIN_MONTH_DATA "
                + "WHERE BASIN_NAME=? and MONTH_NUMBER is not null ORDER BY YEAR_NUMBER DESC,MONTH_NUMBER DESC) WHERE ROWNUM=1"
                + " UNION ALL " + "SELECT YEAR_NUMBER,BASIN_NAME,TO_CHAR(ROUND(AVG(REPLACE(" + polluteCode
                + ", 'L', '')), 2)) AS VALUE,YEAR_NUMBER FROM WT_BASIN_MONTH_DATA "
                + "WHERE BASIN_NAME=? and YEAR_NUMBER=? and MONTH_NUMBER is not null GROUP BY YEAR_NUMBER,BASIN_NAME ";
        list = simpleDao.createNativeQuery(sql, name, name, year).getResultList();
        List<String> legendList = new ArrayList<String>();
        JSONArray seriesData = new JSONArray();
        for (Object[] obj : list) {
            seriesData.add(obj[2].toString());
            if (obj[3].equals(obj[0])) {
                legendList.add(obj[0].toString() + "年");
            } else {
                legendList.add(obj[0].toString() + "年" + obj[3].toString() + "月");
            }

        }
        // xObject.put("name", obj[0].toString()+obj[1].toString());
        result.put("title", name);
        result.put("xAxis", legendList);
        result.put("seriesData", seriesData);
        return result;
    }

    /**
     * <p>Title: getBasinYearAnalysisNjdb</p>
     * <p>Description: 小流域年均对比</p>
     *
     * @param name
     * @param thisYear
     * @param lastYear
     * @param polluteCode
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMnHourDataService#getBasinYearAnalysisNjdb(java.lang.String, int, int, java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getBasinYearAnalysisNjdb(String name, int thisYear, int lastYear, String polluteCode) {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        String sql;

        sql = "SELECT YEAR_NUMBER,BASIN_NAME,ROUND(AVG(REPLACE(" + polluteCode
                + ", 'L', '')), 2) FROM WT_BASIN_MONTH_DATA"
                + " WHERE BASIN_NAME=? AND (YEAR_NUMBER=? OR YEAR_NUMBER=?) and MONTH_NUMBER is not null"
                + " GROUP BY YEAR_NUMBER,BASIN_NAME ORDER BY YEAR_NUMBER desc";
        list = simpleDao.createNativeQuery(sql, name, thisYear, lastYear).getResultList();
        List<String> legendList = new ArrayList<String>();
        JSONArray seriesData = new JSONArray();
        int i = 0;
        for (Object[] obj : list) {
            if (i < 2) {
                legendList.add(obj[0].toString() + "年");
                seriesData.add(obj[2].toString());
                i++;
            }
        }
        result.put("title", name);
        result.put("xAxis", legendList);
        result.put("seriesData", seriesData);
        return result;
    }

    /**
     * @param thisYear
     * @param lastYear
     * @return
     * @throws ParseException Map<String,Object>
     * @throws
     * @Title: getYearMonth
     * @Description: 或取一年内的月的横坐标数据
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:09:10
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:09:10
     */
    public static Map<String, Object> getYearMonth(int thisYear, int lastYear) throws ParseException {
        int leapYear;
        boolean flag1 = thisYear % 4 == 0 && thisYear % 100 != 0 || thisYear % 400 == 0;
        boolean flag2 = lastYear % 4 == 0 && lastYear % 100 != 0 || lastYear % 400 == 0;
        if (flag1) {
            leapYear = thisYear;
        } else if (flag2) {
            leapYear = lastYear;
        } else {
            leapYear = thisYear;
        }
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> indexmap = new HashMap<>();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
        SimpleDateFormat df1 = new SimpleDateFormat("M");
        String startTime = leapYear + "-01";
        String endTime = leapYear + "-12";
        Date start = df.parse(startTime);
        Date end = df.parse(endTime);
        List<String> xList = new ArrayList<String>();
        int i = 0;
        while (start.compareTo(end) <= 0) {
            xList.add(df1.format(start));
            indexmap.put(df1.format(start), i++);
            start = DateUtil.addMonth(start, 2);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        map.put("thisYear", thisYear);
        map.put("lastYear", lastYear);
        return map;
    }

    /**
     * 新增修改废水企业信息
     *
     * @param pollutionWaterData 污水企业对象
     * @return
     */
    @Override
    public void addWasteCompanyInfo(PollutionWaterData pollutionWaterData) {
        BigDecimal longitude = pollutionWaterData.getLongitude();
        BigDecimal latitude = pollutionWaterData.getLatitude();
        StringBuilder sql = new StringBuilder("INSERT INTO POLLUTION_WATER_DATA  ");
        sql.append(" values( ");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getLxr())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getQx())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getQymc())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getWrwname())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getDs())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getLxdh())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getAddress())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getYear())).append(",");
        sql.append(SqlUtil.toSqlStr(pollutionWaterData.getPfl())).append(",");
        sql.append( longitude == null ? "" : longitude).append(",");
        sql.append( latitude == null ? "" : latitude);
        sql.append(" ) ");
        simpleDao.createNativeQuery(sql.toString()).executeUpdate();
    }

    /**
     * 修改废水企业信息
     *
     * @param pollutionWaterData
     * @return
     */
    @Override
    public void updateWastCompanyInfo(PollutionWaterData pollutionWaterData) {
        StringBuilder sql = new StringBuilder("update POLLUTION_WATER_DATA  ");
        sql.append(" set lxr=?,qx=?,ds=?,lxdh=?,address=?, LONGITUDE=?,LATITUDE=? ");
        sql.append(" WHERE QYMC = ? AND  WRWNAME=? AND YEAR = ? AND PFL = ? ");
        BigDecimal longitude = pollutionWaterData.getLongitude();
        BigDecimal latitude = pollutionWaterData.getLatitude();
        simpleDao.createNativeQuery(sql.toString(), pollutionWaterData.getLxr(), pollutionWaterData.getQx(),
                pollutionWaterData.getDs(), pollutionWaterData.getLxdh(), pollutionWaterData.getAddress()
                , longitude == null ? "" : longitude, latitude == null ? "" : latitude, pollutionWaterData.getQymc(),
                pollutionWaterData.getWrwname(), pollutionWaterData.getYear(), pollutionWaterData.getPfl()).executeUpdate();
    }

    /**
     * 删除废水企业信息
     *
     * @param qymc    企业名称
     * @param wrwname 污染物名称
     * @param year    年度
     * @param pfl     排放量
     * @return
     */
    @Override
    public void deleteWasteCompanyInfo(String qymc, String wrwname, String year, String pfl) {
        StringBuilder sql = new StringBuilder(" DELETE FROM POLLUTION_WATER_DATA  ");
        sql.append(" WHERE QYMC = ? AND  WRWNAME=? AND YEAR = ? AND PFL = ? ");
        simpleDao.createNativeQuery(sql.toString(), qymc, wrwname, year, pfl).executeUpdate();
    }
}
