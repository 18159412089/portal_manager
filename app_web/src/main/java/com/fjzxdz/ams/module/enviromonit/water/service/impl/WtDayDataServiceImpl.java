package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtDayDataDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService;
import com.fjzxdz.ams.util.WaterSeriesUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 在线水天数据服务
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:33:04
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtDayDataServiceImpl implements WtDayDataService {

    @Autowired
    private WtDayDataDao wtDayDataDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    public Page<WtDayData> listByPage(WtDayDataParam param, Page<WtDayData> page) {
        return wtDayDataDao.listByPage(param, page);
    }

    /**
     * <p>Title: getPageList</p>
     * <p>Description:  在线水天数据列表</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtDayDataParam param, Page<Map<String, Object>> page) {

        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.MONITOR_TIME >= '" + param.getStartTime() + "' and a.MONITOR_TIME <= '" + param.getEndTime() + "'";
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            } else {
                where = "";
            }
        }
        String sql = "SELECT a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', POLLUTE_VALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', POLLUTE_VALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', POLLUTE_VALUE, 0 )) W01009,"
                + "sum(DECODE( CODE_POLLUTE, 'W01014', POLLUTE_VALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', POLLUTE_VALUE, 0 )) W01003,"
                + "sum(DECODE( CODE_POLLUTE, 'W01019', POLLUTE_VALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', POLLUTE_VALUE, 0 )) W21003,"
                + "sum(DECODE( CODE_POLLUTE, 'W21011', POLLUTE_VALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', POLLUTE_VALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR FROM WT_DAY_DATA a INNER JOIN WT_DAY_REPORT b "
                + "ON a.MONITOR_TIME=b.MONITOR_TIME and a.POINT_CODE=b.POINT_CODE " + where
                + "GROUP BY a.MONITOR_TIME, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) "
                + "ORDER BY a.MONITOR_TIME DESC";
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
     * <p>Title: getPointsDateByDay</p>
     * <p>Description: 获取天数据分析   </p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService#getPointsDateByDay(com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getPointsDateByDay(WtDayDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        List<String> pollutes = strToList(param.getPollutes());
        Map<String, Object> timeMap;
        Map<String, Integer> indexmap;
        List<String> xAxis;
        List<Object[]> list = null;
        String sql = "";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        for (String str : pollutes) {
            Map<String, Object> map = new HashMap<>();
            sql = "SELECT POINT_NAME,POLLUTE_NAME,POLLUTE_VALUE,MONITOR_TIME "
                    + "FROM WT_DAY_DATA WHERE POINT_CODE in (" + toSqlStr(param.getPointName()) + ") "
                    + "AND MONITOR_TIME >= '" + param.getStartTime() + "' AND MONITOR_TIME <= '" + param.getEndTime() + "' "
                    + "and CODE_POLLUTE='" + str + "' GROUP BY POINT_NAME,MONITOR_TIME,POLLUTE_NAME,POLLUTE_VALUE "
                    + "ORDER BY POINT_NAME,MONITOR_TIME ASC";
            timeMap = DateUtil.getBetweenDay(param.getStartTime(), param.getEndTime());

            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            xAxis = (List<String>) timeMap.get("xList");
            list = simpleDao.createNativeQuery(sql).getResultList();
            Map<String, Object[]> series = new HashMap<String, Object[]>();
            for (Object[] obj : list) {
                if (obj[0] != null) {
                    Date parse = df.parse(obj[3].toString());
                    String date = df.format(parse);
                    if (series.containsKey(obj[0])) {
                        if (obj[2] != null && indexmap.containsKey(date)) {
                            series.get(obj[0].toString())[indexmap.get(date)] = obj[2];
                        }
                    } else {
                        Object[] tempList = new Object[indexmap.size()];
                        if (obj[2] != null && indexmap.containsKey(date)) {

                            tempList[indexmap.get(date)] = obj[2];
                        }
                        series.put(obj[0].toString(), tempList);
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
            map.put("title", list.size() > 0 ? list.get(0)[1].toString() : "暂无数据");
            map.put("formatter", "{value}");
            map.putAll(WaterSeriesUtil.getSeriesData(xArray, str));
            result.add(map);
        }

        return result;
    }

    /**
     * <p>Title: getPassMonthAnalysis</p>
     * <p>Description: 往月环比数据分析  </p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService#getPassMonthAnalysis(com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassMonthAnalysis(WtDayDataParam param) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis;
        String sql;

        Map<String, Integer> indexmap;
        Map<String, Object> timeMap = DateUtil.getMonthDays(param.getStartTime(), param.getEndTime());
        String startTime1 = timeMap.get("startTime1").toString();
        String endTime1 = timeMap.get("endTime1").toString();
        String startTime2 = timeMap.get("startTime2").toString();
        String endTime2 = timeMap.get("endTime2").toString();
        xAxis = (List<String>) timeMap.get("xList");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        sql = "SELECT MONITOR_TIME,POLLUTE_VALUE,POINT_NAME FROM WT_DAY_DATA WHERE POINT_CODE = ? AND CODE_POLLUTE = ? AND "
                + "(MONITOR_TIME>=? AND MONITOR_TIME <=? OR MONITOR_TIME>=? AND MONITOR_TIME <=?)";
        list = simpleDao.createNativeQuery(sql, param.getPointCode(), param.getPollutes(), startTime1, endTime1, startTime2, endTime2).getResultList();


        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                String yearMonth = obj[0].toString().substring(0, 7);
                String date = obj[0].toString().substring(8, 10);
                if (series.containsKey(yearMonth)) {
                    if (obj[1] != null) {
                        series.get(yearMonth)[indexmap.get(date)] = obj[1];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null) {
                        tempList[indexmap.get(date)] = obj[1];
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
     * <p>Title: getPassYearAnalysis</p>
     * <p>Description: 往年同比数据分析</p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService#getPassYearAnalysis(com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassYearAnalysis(WtDayDataParam param) throws ParseException {
        List<Object[]> list;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis;
        String sql;

        Map<String, Integer> indexmap;
        Map<String, Object> timeMap = DateUtil.getYearDay(Integer.parseInt(param.getStartTime()));
        String startTime1 = timeMap.get("year1") + "-01-01";
        String endTime1 = timeMap.get("year1") + "-12-31";
        String startTime2 = timeMap.get("year2") + "-01-01";
        String endTime2 = timeMap.get("year2") + "-12-31";
        xAxis = (List<String>) timeMap.get("xList");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        sql = "SELECT MONITOR_TIME,POLLUTE_VALUE,POINT_NAME FROM WT_DAY_DATA WHERE POINT_CODE = ? AND CODE_POLLUTE = ? AND "
                + "(MONITOR_TIME>=? AND MONITOR_TIME <=? OR MONITOR_TIME>=? AND MONITOR_TIME <=?)";
        list = simpleDao.createNativeQuery(sql, param.getPointCode(), param.getPollutes(), startTime1, endTime1, startTime2, endTime2).getResultList();


        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                String year = obj[0].toString().substring(0, 4);
                String monthDate = obj[0].toString().substring(5, 10);
                if (series.containsKey(year)) {
                    if (obj[1] != null) {
                        series.get(year)[indexmap.get(monthDate)] = obj[1];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null) {
                        tempList[indexmap.get(monthDate)] = obj[1];
                    }
                    series.put(year, tempList);
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
     * <p>Title: getPageList</p>
     * <p>Description:  在线水天数据列表</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam, cn.fjzxdz.frame.common.Page)
     */


    /**
     * 获取华安县填数据
     * @param param
     * @param page
     * @return
     */
    @Override
    public Page<Map<String, Object>> getPageAllList(WtDayDataParam param, Page<Map<String, Object>> page) {

        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            param.setStartTime( param.getStartTime().substring(0,10));
            param.setEndTime( param.getEndTime().substring(0,10));
            where = where + "a.MONITOR_TIME >= '" + param.getStartTime() + "' and a.MONITOR_TIME <= '" + param.getEndTime() + "'";
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            }
        } else {
            String currentStartTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1")) ;
            String currentEndTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"));
            where = where + "a.MONITOR_TIME >= '" + currentStartTime + "' and a.MONITOR_TIME <= '" + currentEndTime + "'";

            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + "and  a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            }
        }
        String sql = "SELECT    a.MONITOR_TIME  as DATATIME , a.POINT_CODE, a.POINT_NAME,a.CODE_POLLUTE ,a.POLLUTE_VALUE ,a.POLLUTE_NAME FROM WT_DAY_DATA a "
                 +  where
                 + " ORDER BY a.MONITOR_TIME DESC";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> result = byPage.getResult();

        byPage.setResult(result);
        return byPage;
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

}
