package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirDayDataDao;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDataParam;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDataService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirDataService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class ZpAirDataServiceImpl implements ZpAirDataService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private AirDayDataDao airDayDataDao;

    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getMonthPollutionConAnalysis(AirDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> list = null;
        Map<String, Object> timeMap = DateUtil.getYearMonths(param.getStartTime());
        String startTime = (String) timeMap.get("startTime");
        String endTime = (String) timeMap.get("endTime");
        String sql;

        List<String> xAxis = (List<String>) timeMap.get("xList");
        Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        for (String point : param.getPointList()) {
            Map<String, Object> map = new HashMap<>();

            sql = "select TIME,POINT_NAME,ROUND(AVG(PM25),2),ROUND(AVG(PM10),2),ROUND(AVG(CO),2),ROUND(AVG(NO2),2),ROUND(AVG(O3),2),ROUND(AVG(SO2),2) "
                    + "FROM (SELECT TO_CHAR(MONITOR_TIME,'yyyy-mm') TIME, POINT_CODE, POINT_NAME, sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, "
                    + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, "
                    + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, "
                    + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO FROM AIR_DAY_DATA WHERE MONITOR_TIME>=TO_DATE(?,'yyyy-mm-dd') "
                    + "and MONITOR_TIME<=TO_DATE(?,'yyyy-mm-dd') AND POINT_CODE=? GROUP BY MONITOR_TIME, POINT_CODE, POINT_NAME ORDER BY MONITOR_TIME ASC) "
                    + "GROUP BY TIME,POINT_NAME ORDER BY TIME";
            list = simpleDao.createNativeQuery(sql, startTime, endTime, point).getResultList();

            List<Object> a = new ArrayList<>();
            List<Object> b = new ArrayList<>();
            List<Object> c = new ArrayList<>();
            List<Object> d = new ArrayList<>();
            List<Object> e = new ArrayList<>();
            List<Object> f = new ArrayList<>();
            for (Object[] obj : list) {
                a.add(indexmap.get(obj[0]), obj[2]);
                b.add(indexmap.get(obj[0]), obj[3]);
                c.add(indexmap.get(obj[0]), obj[4]);
                d.add(indexmap.get(obj[0]), obj[5]);
                e.add(indexmap.get(obj[0]), obj[6]);
                f.add(indexmap.get(obj[0]), obj[7]);
                map.put("title", obj[1].toString());
            }
            JSONArray series = new JSONArray();
            JSONObject pm25Json = new JSONObject();
            pm25Json.put("name", "PM2.5");
            pm25Json.put("type", "line");
            pm25Json.put("yAxisIndex", "0");
            pm25Json.put("itemStyle", JSONObject.parse("{normal:{color:'#51a1fa'}}"));
            pm25Json.put("data", a);
            series.add(pm25Json);
            JSONObject pm10Json = new JSONObject();
            pm10Json.put("name", "PM10");
            pm10Json.put("type", "line");
            pm10Json.put("yAxisIndex", "0");
            pm10Json.put("itemStyle", JSONObject.parse("{normal:{color:'#65b149'}}"));
            pm10Json.put("data", b);
            series.add(pm10Json);
            JSONObject so2Json = new JSONObject();
            so2Json.put("name", "SO2");
            so2Json.put("type", "line");
            so2Json.put("yAxisIndex", "0");
            so2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ffbf26'}}"));
            so2Json.put("data", f);
            series.add(so2Json);
            JSONObject no2Json = new JSONObject();
            no2Json.put("name", "NO2");
            no2Json.put("type", "line");
            no2Json.put("yAxisIndex", "0");
            no2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ff5400'}}"));
            no2Json.put("data", d);
            series.add(no2Json);
            JSONObject coJson = new JSONObject();
            coJson.put("name", "CO");
            coJson.put("type", "line");
            coJson.put("yAxisIndex", "1");
            coJson.put("itemStyle", JSONObject.parse("{normal:{color:'#d13430'}}"));
            coJson.put("data", c);
            series.add(coJson);
            JSONObject o3Json = new JSONObject();
            o3Json.put("name", "O3-8h");
            o3Json.put("type", "line");
            o3Json.put("yAxisIndex", "0");
            o3Json.put("itemStyle", JSONObject.parse("{normal:{color:'#5d30d1'}}"));
            o3Json.put("data", e);
            series.add(o3Json);
            map.put("xAxis", xAxis);
            map.put("series", series);

            result.add(map);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getMonthPollutionAnalysis(AirDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> list = null;
        Map<String, Object> timeMap = DateUtil.getYearMonths(param.getStartTime());
        String startTime = (String) timeMap.get("startTime");
        String endTime = (String) timeMap.get("endTime");
        String sql;

        List<String> xAxis = (List<String>) timeMap.get("xList");
        Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        for (String point : param.getPointList()) {
            sql = "select TIME,POINT_NAME,COUNT(case when POLLUTION='PM2.5' THEN 'PM2.5' END) result1,"
                    + "COUNT(case when POLLUTION='PM10' THEN 'PM10' END) result2,COUNT(case when POLLUTION='CO' THEN 'CO' END) result3,"
                    + "COUNT(case when POLLUTION='SO2' THEN 'SO2' END) result4,COUNT(case when POLLUTION='NO2' THEN 'NO2' END) result5,"
                    + "COUNT(case when POLLUTION='O3' THEN 'O3' END) result6 from (select TO_CHAR(MONITOR_TIME,'yyyy-mm') TIME,POINT_NAME, "
                    + "COUNT_POLLUTION(sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )), sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )), "
                    + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )), sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )), "
                    + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )), sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 ))) POLLUTION  "
                    + "from AIR_DAY_DATA where MONITOR_TIME>=TO_DATE(?,'yyyy-mm-dd') and MONITOR_TIME<=TO_DATE(?,'yyyy-mm-dd') "
                    + "and POINT_CODE =? GROUP BY MONITOR_TIME,POINT_NAME) GROUP BY TIME,POINT_NAME ORDER BY TIME";
            list = simpleDao.createNativeQuery(sql, startTime, endTime, point).getResultList();

            Map<String, Object> map = new HashMap<>();

            List<String> a = new ArrayList<>();
            List<String> b = new ArrayList<>();
            List<String> c = new ArrayList<>();
            List<String> d = new ArrayList<>();
            List<String> e = new ArrayList<>();
            List<String> f = new ArrayList<>();
            for (Object[] obj : list) {
                a.add(indexmap.get(obj[0]), obj[2].toString());
                b.add(indexmap.get(obj[0]), obj[3].toString());
                c.add(indexmap.get(obj[0]), obj[4].toString());
                d.add(indexmap.get(obj[0]), obj[5].toString());
                e.add(indexmap.get(obj[0]), obj[6].toString());
                f.add(indexmap.get(obj[0]), obj[7].toString());
                map.put("title", obj[1].toString());
            }

            map.put("xAxis", xAxis);
            JSONArray xArray = new JSONArray();
            JSONObject aJson = new JSONObject();
            aJson.put("data", a);
            aJson.put("type", "bar");
            aJson.put("stack", "首要污染物");
            aJson.put("itemStyle", JSONObject.parse("{normal:{color:'#00E400'}}"));
            aJson.put("name", "PM2.5");
            xArray.add(aJson);
            JSONObject bJson = new JSONObject();
            bJson.put("data", b);
            bJson.put("type", "bar");
            bJson.put("stack", "首要污染物");
            bJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FFFF00'}}"));
            bJson.put("name", "PM10");
            xArray.add(bJson);
            JSONObject cJson = new JSONObject();
            cJson.put("data", c);
            cJson.put("type", "bar");
            cJson.put("stack", "首要污染物");
            cJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FF7E00'}}"));
            cJson.put("name", "CO");
            xArray.add(cJson);
            JSONObject dJson = new JSONObject();
            dJson.put("data", d);
            dJson.put("type", "bar");
            dJson.put("stack", "首要污染物");
            dJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FF0000'}}"));
            dJson.put("name", "SO2");
            xArray.add(dJson);
            JSONObject eJson = new JSONObject();
            eJson.put("data", e);
            eJson.put("type", "bar");
            eJson.put("stack", "首要污染物");
            eJson.put("itemStyle", JSONObject.parse("{normal:{color:'#99004C'}}"));
            eJson.put("name", "NO2");
            xArray.add(eJson);
            JSONObject fJson = new JSONObject();
            fJson.put("data", f);
            fJson.put("type", "bar");
            fJson.put("stack", "首要污染物");
            fJson.put("itemStyle", JSONObject.parse("{normal:{color:'#7E0023'}}"));
            fJson.put("name", "O3");
            xArray.add(fJson);
            map.put("series", xArray);
            result.add(map);
        }

        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getMonthQualityAnalysis(AirDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> list = null;
        Map<String, Object> timeMap = DateUtil.getYearMonths(param.getStartTime());
        String startTime = (String) timeMap.get("startTime");
        String endTime = (String) timeMap.get("endTime");
        String sql;

        List<String> xAxis = (List<String>) timeMap.get("xList");
        Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        for (String point : param.getPointList()) {
            sql = "select Time,POINT_NAME,count(case when aqi>0 and aqi<=50 then '优' end) result1,count(case when aqi>50 and aqi<=100 then '良' end) result2,"
                    + "count(case when aqi>100 and aqi<=200 then '轻度' end) result3,count(case when aqi>200 and aqi<=300 then '中度' end) result4,"
                    + "count(case when aqi>300 and aqi<=400 then '重度' end) result5,count(case when aqi>400 then '严重' end) result6 "
                    + "from (select TO_CHAR(MONITOR_TIME,'yyyy-mm') Time,POINT_NAME,AQI  from AIR_DAY_DATA where MONITOR_TIME>=TO_DATE(?,'yyyy-mm-dd') "
                    + "and MONITOR_TIME<=TO_DATE(?,'yyyy-mm-dd') and POINT_CODE =? GROUP BY AQI,MONITOR_TIME,POINT_NAME ORDER BY MONITOR_TIME asc) "
                    + "GROUP BY Time,POINT_NAME ORDER BY Time";
            list = simpleDao.createNativeQuery(sql, startTime, endTime, point).getResultList();

            Map<String, Object> map = new HashMap<>();
            List<String> a = new ArrayList<>();
            List<String> b = new ArrayList<>();
            List<String> c = new ArrayList<>();
            List<String> d = new ArrayList<>();
            List<String> e = new ArrayList<>();
            List<String> f = new ArrayList<>();
            for (Object[] obj : list) {
                a.add(indexmap.get(obj[0]), obj[2].toString());
                b.add(indexmap.get(obj[0]), obj[3].toString());
                c.add(indexmap.get(obj[0]), obj[4].toString());
                d.add(indexmap.get(obj[0]), obj[5].toString());
                e.add(indexmap.get(obj[0]), obj[6].toString());
                f.add(indexmap.get(obj[0]), obj[7].toString());
                map.put("title", obj[1].toString());
            }

            map.put("xAxis", xAxis);
            JSONArray xArray = new JSONArray();
            JSONObject aJson = new JSONObject();
            aJson.put("data", a);
            aJson.put("type", "bar");
            aJson.put("stack", "搜索引擎");
            aJson.put("itemStyle", JSONObject.parse("{normal:{color:'#00E400'}}"));
            aJson.put("name", "优");
            xArray.add(aJson);
            JSONObject bJson = new JSONObject();
            bJson.put("data", b);
            bJson.put("type", "bar");
            bJson.put("stack", "搜索引擎");
            bJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FFFF00'}}"));
            bJson.put("name", "良");
            xArray.add(bJson);
            JSONObject cJson = new JSONObject();
            cJson.put("data", c);
            cJson.put("type", "bar");
            cJson.put("stack", "搜索引擎");
            cJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FF7E00'}}"));
            cJson.put("name", "轻度");
            xArray.add(cJson);
            JSONObject dJson = new JSONObject();
            dJson.put("data", d);
            dJson.put("type", "bar");
            dJson.put("stack", "搜索引擎");
            dJson.put("itemStyle", JSONObject.parse("{normal:{color:'#FF0000'}}"));
            dJson.put("name", "中度");
            xArray.add(dJson);
            JSONObject eJson = new JSONObject();
            eJson.put("data", e);
            eJson.put("type", "bar");
            eJson.put("stack", "搜索引擎");
            eJson.put("itemStyle", JSONObject.parse("{normal:{color:'#99004C'}}"));
            eJson.put("name", "重度");
            xArray.add(eJson);
            JSONObject fJson = new JSONObject();
            fJson.put("data", f);
            fJson.put("type", "bar");
            fJson.put("stack", "搜索引擎");
            fJson.put("itemStyle", JSONObject.parse("{normal:{color:'#7E0023'}}"));
            fJson.put("name", "严重");
            xArray.add(fJson);
            map.put("series", xArray);
            result.add(map);
        }

        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getPointDateByHourOrDay(AirDataParam param) {
        List<Map<String, Object>> list = new ArrayList<>();
        for (String str : param.getPointList()) {
            String sql = "";
            if ("hour".equals(param.getType())) {
                sql = "SELECT a.MONITOR_TIME, a.POLLUTE_NAME, a.POINT_NAME, avg(AVERVALUE), avg(AQI) "
                        + "FROM AIR_HOUR_DATA a LEFT JOIN AIR_MONITOR_POINT b ON a.POINT_CODE = b.POINT_CODE "
                        + "WHERE a.MONITOR_TIME >= TO_DATE( '" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss' ) "
                        + "AND a.MONITOR_TIME <= TO_DATE( '" + param.getEndTime() + "', 'yyyy-mm-dd hh24:mi:ss' ) "
                        + "AND b.POINT_CODE = '" + str + "' GROUP BY a.MONITOR_TIME, a.POLLUTE_NAME, a.POINT_NAME ORDER BY MONITOR_TIME ASC";
            } else if ("day".equals(param.getType())) {
                sql = "SELECT a.MONITOR_TIME, a.POLLUTE_NAME, a.POINT_NAME, avg(AVERVALUE), avg(AQI) "
                        + "FROM AIR_DAY_DATA a LEFT JOIN AIR_MONITOR_POINT b ON a.POINT_CODE = b.POINT_CODE "
                        + "WHERE a.MONITOR_TIME >= TO_DATE( '" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss' ) "
                        + "AND a.MONITOR_TIME <= TO_DATE( '" + param.getEndTime() + "', 'yyyy-mm-dd hh24:mi:ss' ) "
                        + "AND b.POINT_CODE = '" + str + "' GROUP BY a.MONITOR_TIME, a.POLLUTE_NAME, a.POINT_NAME ORDER BY MONITOR_TIME ASC";
            }
            Map<String, Object> map = new HashMap<>();
            List<Object[]> tempList = simpleDao.createNativeQuery(sql).getResultList();
            if (ToolUtil.isNotEmpty(tempList)) {
                Map<String, String> xAxisMap = new LinkedHashMap<>();
                List<Double> pm10 = new ArrayList<>();
                List<Double> pm25 = new ArrayList<>();
                List<Double> so2 = new ArrayList<>();
                List<Double> no2 = new ArrayList<>();
                List<Double> co = new ArrayList<>();
                List<Double> o3 = new ArrayList<>();
                for (Object[] obj : tempList) {
                    if ("day".equals(param.getType())) {
                        xAxisMap.put(formatDate((Date) obj[0], "yyyy-MM-dd"), formatDate((Date) obj[0], "yyyy-MM-dd"));
                    } else if ("hour".equals(param.getType())) {
                        xAxisMap.put(formatDate((Date) obj[0], "yyyy-MM-dd HH"), formatDate((Date) obj[0], "yyyy-MM-dd HH"));
                    }
                    if ("一氧化碳".equals(obj[1].toString())) {
                        co.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    } else if ("二氧化氮".equals(obj[1].toString())) {
                        no2.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    } else if ("臭氧(8h)".equals(obj[1].toString())) {
                        o3.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    } else if ("PM10".equals(obj[1].toString())) {
                        pm10.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    } else if ("PM2.5".equals(obj[1].toString())) {
                        pm25.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    } else if ("二氧化硫".equals(obj[1].toString())) {
                        so2.add(Double.parseDouble(formatDouble("0.00", obj[3])));
                    }
                }
                List<String> xAxis = new ArrayList<>();
                for (Map.Entry<String, String> entry : xAxisMap.entrySet()) {
                    xAxis.add(entry.getValue());
                }
                map.put("co", co);
                map.put("no2", no2);
                map.put("o3", o3);
                map.put("pm10", pm10);
                map.put("pm25", pm25);
                map.put("so2", so2);
                map.put("xAxis", xAxis);
                map.put("county", tempList.get(0)[2].toString());
                list.add(map);
            }
        }
        return list;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getPointsDateByHourOrDay(AirDataParam param) throws ParseException {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "";
        List<Object[]> list = null;
        Map<String, Object> timeMap = new HashMap<>();
        Map<String, Integer> indexmap;
        List<String> xAxis;
        for (String str : param.getFactorList()) {
            Map<String, Object> map = new HashMap<>();
            if ("hour".equals(param.getType())) {
                sql = "SELECT POINT_NAME,POLLUTE_NAME,AVERVALUE,to_char(MONITOR_TIME,'yyyy-mm-dd hh24') "
                        + "FROM AIR_HOUR_DATA WHERE POINT_CODE in (" + List2Sqlin(param.getPointList()) + ") "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm-dd hh24') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd hh24') "
                        + "and CODE_POLLUTE=? GROUP BY POINT_NAME,MONITOR_TIME,POLLUTE_NAME,AVERVALUE "
                        + "ORDER BY POINT_NAME,MONITOR_TIME ASC";
                timeMap = DateUtil.getBetweenHour(param.getStartTime(), param.getEndTime(), 1);
            } else if ("day".equals(param.getType())) {
                sql = "SELECT POINT_NAME,POLLUTE_NAME,AVERVALUE,to_char(MONITOR_TIME,'yyyy-mm-dd') "
                        + "FROM AIR_DAY_DATA WHERE POINT_CODE in (" + List2Sqlin(param.getPointList()) + ") "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') "
                        + "and CODE_POLLUTE=? GROUP BY POINT_NAME,MONITOR_TIME,POLLUTE_NAME,AVERVALUE "
                        + "ORDER BY POINT_NAME,MONITOR_TIME ASC";
                timeMap = DateUtil.getBetweenDay(param.getStartTime(), param.getEndTime());
            }
            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            xAxis = (List<String>) timeMap.get("xList");
            list = simpleDao.createNativeQuery(sql, param.getStartTime(), param.getEndTime(), str).getResultList();
            if (ToolUtil.isNotEmpty(list)) {
                Map<String, Object[]> series = new HashMap<String, Object[]>();
                for (Object[] obj : list) {
                    if (obj[0] != null) {
                        if (series.containsKey(obj[0])) {
                            if (obj[2] != null) {
                                series.get(obj[0].toString())[indexmap.get(obj[3])] = obj[2];
                            }
                        } else {
                            Object[] tempList = new Object[indexmap.size()];
                            if (obj[2] != null) {
                                tempList[indexmap.get(obj[3])] = obj[2];
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
                map.put("series", xArray);
                map.put("title", list.get(0)[1].toString());
                if ("A21005".equals(str)) {
                    map.put("formatter", "{value}(mg/m3)");
                } else {
                    map.put("formatter", "{value}(μg/m3)");
                }
                result.add(map);
            }

        }

        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassMonthAnalysis(AirDataParam param) throws ParseException {
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
        if (param.getType() != null && "aqi".equals(param.getType())) {
            sql = "SELECT to_char(MONITOR_TIME,'yyyy-MM'),AQI,to_char(MONITOR_TIME,'dd'),POINT_NAME FROM AIR_DAY_DATA "
                    + "WHERE POINT_CODE = ? AND (MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') "
                    + "OR MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd')) "
                    + "GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC";
            list = simpleDao.createNativeQuery(sql, param.getPoints(), startTime1, endTime1, startTime2, endTime2).getResultList();
            result.put("formatter", "{value}");
        } else {
            sql = "SELECT to_char(MONITOR_TIME,'yyyy-MM'),AVERVALUE,to_char(MONITOR_TIME,'dd'),POINT_NAME FROM AIR_DAY_DATA "
                    + "WHERE POINT_CODE =? AND (MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') "
                    + "OR MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd')) AND CODE_POLLUTE= ? "
                    + "GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME ASC";
            list = simpleDao.createNativeQuery(sql, param.getPoints(), startTime1, endTime1, startTime2, endTime2, param.getType()).getResultList();
            if ("A21005".equals(param.getType())) {
                result.put("formatter", "{value}(mg/m3)");
            } else {
                result.put("formatter", "{value}(μg/m3)");
            }
        }

        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                if (series.containsKey(obj[0])) {
                    if (obj[1] != null) {
                        series.get(obj[0].toString())[indexmap.get(obj[2])] = obj[1];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null) {
                        tempList[indexmap.get(obj[2])] = obj[1];
                    }
                    series.put(obj[0].toString(), tempList);
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
        result.put("title", list.size() == 0 ? "" : list.get(0)[3].toString());

        return result;
    }

    /**
     * 往年同比
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassYearAnalysisWithPoint(String polluteName, String pointCode, String time, int year) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis = new ArrayList<String>();
        String sql;

        Map<String, Integer> indexmap = new HashMap<String, Integer>();
        if (time != null && time.equals("YearDay")) {
            Map<String, Object> timeMap = DateUtil.getYearDay(Integer.valueOf(year));
            String startTime1 = timeMap.get("year1") + "-01-01";
            String endTime1 = timeMap.get("year1") + "-12-31";
            String startTime2 = timeMap.get("year2") + "-01-01";
            String endTime2 = timeMap.get("year2") + "-12-31";
            xAxis = (List<String>) timeMap.get("xList");
            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            if (polluteName != null && polluteName.equals("aqi")) {
                sql = "SELECT to_char(MONITOR_TIME,'yyyy'),AQI,to_char(MONITOR_TIME,'mm-dd'),POINT_NAME FROM AIR_DAY_DATA "
                        + "WHERE POINT_CODE = ? AND (MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') "
                        + "OR MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd')) "
                        + "GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, pointCode, startTime1, endTime1, startTime2, endTime2).getResultList();
                result.put("formatter", "{value}");
            } else {
                sql = "SELECT to_char(MONITOR_TIME,'yyyy'),AVERVALUE,to_char(MONITOR_TIME,'mm-dd'),POINT_NAME FROM AIR_DAY_DATA "
                        + "WHERE POINT_CODE =? AND (MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') "
                        + "OR MONITOR_TIME >= to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd')) AND CODE_POLLUTE= ? "
                        + "GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, pointCode, startTime1, endTime1, startTime2, endTime2, polluteName).getResultList();
                if ("A21005".equals(polluteName)) {
                    result.put("formatter", "{value}(mg/m3)");
                } else {
                    result.put("formatter", "{value}(μg/m3)");
                }
            }
        }
        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                if (series.containsKey(obj[0])) {
                    if (obj[1] != null) {
                        series.get(obj[0].toString())[indexmap.get(obj[2])] = obj[1];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null) {
                        tempList[indexmap.get(obj[2])] = obj[1];
                    }
                    series.put(obj[0].toString(), tempList);
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
        result.put("title", list.size() == 0 ? "" : list.get(0)[3].toString());

        return result;
    }

    /**
     * 数字转换
     *
     * @param step
     * @param num
     * @return
     */
    public String formatDouble(String step, Object num) {
        DecimalFormat df = new DecimalFormat(step);
        return df.format(num);
    }

    /**
     * 时间格式转换
     *
     * @param date
     * @return
     */
    public String formatDate(Date date, String format) {
        Format sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }

    /**
     * 数组转sql in条件语句
     *
     * @param str
     * @return
     */
    public static String List2Sqlin(List<String> str) {
        StringBuilder sb = new StringBuilder();
        for (String s : str) {
            sb.append("'").append(s).append("'").append(",");
        }
        return sb.toString().substring(0, sb.length() - 1);
    }


    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCurAirQuality(String pointCode, String time) {
        String sql = "SELECT TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ),POINT_NAME,AQI, " +
                "	sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                "	sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                "	sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co, " +
                "	sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                "	sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,sum( " +
                "	DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2  " +
                "FROM AIR_DAY_DATA WHERE POINT_CODE = ?  " +
                "	AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd')=? " +
                "GROUP BY MONITOR_TIME,POINT_NAME,AQI";
        return simpleDao.createNativeQuery(sql, pointCode, time).getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAirQualityChart(AirDayDataParam param) {

        String sql = "SELECT DISTINCT MONITOR_TIME,AQI " +
                "FROM AIR_DAY_DATA WHERE  " +
                "TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ?  " +
                "AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ?  " +
                "AND POINT_CODE = ? ORDER BY MONITOR_TIME ASC";

        List<Object[]> list = simpleDao.createNativeQuery(sql, param.getStartTime(), param.getEndTime(), param.getPointCode()).getResultList();
        return list;
    }

    /**
     * 往年同比/环比 大气 多站点对比 按天展示
     *
     * @param polluteName 因子
     * @param pointCode   站点
     * @param time
     * @param year        对比年份
     * @return
     * @throws ParseException
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getPassYearAnalysisAirMorePoint(String polluteName, String pointCode, String time, String year) throws ParseException {
        List<String> points = Arrays.asList(pointCode.split(","));
        List<Map<String, Object>> resultList = new ArrayList<>();
        List<Object[]> list = null;
        Map<String, Object> result = null;
        List<String> xAxis = null;
        StringBuilder sql = null;
        Map<String, Integer> indexmap = null;
        String title = "";
        Map<String, Object> timeMap = null;
        String startTime1 = "";
        String endTime1 = "";
        String startTime2 = "";
        String endTime2 = "";
        if (StringUtils.isEmpty(time)) {
            timeMap = DateUtil.getYearMonth42(year);
            startTime1 = DateUtil.getCurFullYear() + "-01";
            endTime1 = DateUtil.getCurFullYear() + "-12";
            startTime2 = year + "-01";
            endTime2 = year + "-12";
        } else {
            if (year.indexOf('-') > -1) {
                timeMap = DateUtil.getMonthDays(year);
                startTime1 = year + "-01";
                endTime1 = year + "-31";
                startTime2 = DateUtil.getCurYearMonth() + "-01";
                endTime2 = DateUtil.getCurYearMonth() + "-31";
            } else {
                timeMap = DateUtil.getYearDay(Integer.parseInt(year));
                startTime1 = timeMap.get("year1") + "-01-01";
                endTime1 = timeMap.get("year1") + "-12-31";
                startTime2 = timeMap.get("year2") + "-01-01";
                endTime2 = timeMap.get("year2") + "-12-31";
            }
        }
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        int idx = 0;
        for (String pcode : points) {
            sql = new StringBuilder();
            result = new HashMap<>();
            xAxis = (List<String>) timeMap.get("xList");
            if (time != null && time.equals("YearDay")) {
                sql.append(" SELECT to_char(MONITOR_TIME,'yyyy'),AVERVALUE,to_char(MONITOR_TIME,'mm-dd'),POINT_NAME,point_code FROM AIR_DAY_DATA ");
                sql.append(" WHERE POINT_CODE =").append(SqlUtil.toSqlStr(pcode));
                sql.append(" AND (MONITOR_TIME >= to_date(").append(SqlUtil.toSqlStr(startTime1)).append(",'yyyy-mm-dd') ");
                sql.append(" AND MONITOR_TIME <= to_date(").append(SqlUtil.toSqlStr(endTime1)).append(",'yyyy-mm-dd') ");
                sql.append(" OR MONITOR_TIME >= to_date(").append(SqlUtil.toSqlStr(startTime2)).append(",'yyyy-mm-dd') ");
                sql.append(" AND MONITOR_TIME <= to_date(").append(SqlUtil.toSqlStr(endTime2)).append(",'yyyy-mm-dd') ");
                sql.append(" )AND CODE_POLLUTE=  ").append(SqlUtil.toSqlStr(polluteName));
                sql.append(" GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME,point_code ORDER BY POINT_NAME,MONITOR_TIME ASC ");
                list = simpleDao.createNativeQuery(sql.toString()).getResultList();
            } else {
                sql.append("		select year, round(avg(AVERVALUE)) ,month,POINT_NAME,point_code ");
                sql.append("		from ( ");
                sql.append("		SELECT to_char(MONITOR_TIME, 'yyyy') year, AVERVALUE, to_char(MONITOR_TIME, 'mm-dd') day,to_char(MONITOR_TIME, 'mm') month, POINT_NAME,point_code ");
                sql.append("		FROM AIR_DAY_DATA ");
                sql.append("	WHERE POINT_CODE =  ").append(SqlUtil.toSqlStr(pcode));
                sql.append(" AND (MONITOR_TIME >= to_date(").append(SqlUtil.toSqlStr(startTime1)).append(",'yyyy-mm') ");
                sql.append(" AND MONITOR_TIME <= to_date(").append(SqlUtil.toSqlStr(endTime1)).append(",'yyyy-mm') ");
                sql.append(" OR MONITOR_TIME >= to_date(").append(SqlUtil.toSqlStr(startTime2)).append(",'yyyy-mm') ");
                sql.append(" AND MONITOR_TIME <= to_date(").append(SqlUtil.toSqlStr(endTime2)).append(",'yyyy-mm') ");
                sql.append(" )AND CODE_POLLUTE=  ").append(SqlUtil.toSqlStr(polluteName));
                sql.append("		GROUP BY POINT_NAME, AVERVALUE, MONITOR_TIME,point_code ");
                sql.append("		ORDER BY POINT_NAME, MONITOR_TIME ASC ");
                sql.append("		) a ");
                sql.append("		 ");
                sql.append("		group by a.year,a.month,a.POINT_NAME,point_code ");
                sql.append("		order by a.year,a.month ");
                list = simpleDao.createNativeQuery(sql.toString()).getResultList();
            }
            if ("A21005".equals(polluteName)) {
                result.put("formatter", "{value}(mg/m3)");
            } else {
                result.put("formatter", "{value}(μg/m3)");
            }
            Map<String, Object[]> series = new HashMap<String, Object[]>();
            String code = "";
            for (Object[] obj : list) {
                title = (String) obj[3];
                code = (String) obj[4];

                if (obj[0] != null) {
                    if (series.containsKey((year.indexOf('-') > -1 ? obj[0].toString() + obj[2].toString().split("-")[0] : obj[0]))) {
                        if (obj[1] != null) {
                            if (year.indexOf('-') > -1) {
                                series.get(obj[0].toString() + obj[2].toString().split("-")[0])[indexmap.get(obj[2])] = obj[1];
                            } else {
                                series.get(obj[0].toString())[indexmap.get(obj[2])] = obj[1];
                            }

                        }
                    } else {
                        Object[] tempList = new Object[indexmap.size()];
                        if (obj[1] != null) {
                            tempList[indexmap.get(obj[2])] = obj[1];
                        }
                        if (year.indexOf('-') > -1) {
                            series.put(obj[0].toString() + obj[2].toString().split("-")[0], tempList);
                        } else {
                            series.put(obj[0].toString(), tempList);
                        }
                    }
                }
            }
            List<String> legendList = new ArrayList<String>();
            JSONArray xArray = new JSONArray();
            result.put("xAxis", xAxis);
            for (Object key : series.keySet()) {
                legendList.add(key.toString() + "," + code + "," + idx);
                JSONObject xObject = new JSONObject();
                xObject.put("data", series.get(key));
                xObject.put("type", "line");
                xObject.put("name", key + "," + code + "," + idx);
                xObject.put("code", code);
                xArray.add(xObject);
            }
            result.put("legend", legendList);
            result.put("series", xArray);
            result.put("title", list.size() == 0 ? "" : title);
            resultList.add(result);
            idx++;
        }
        return resultList;
    }


    /**
     * 获取比较数据 因子-同比-监测站因子
     *
     * @param pointCode 站点
     * @param year      对比年度
     * @param rq        比较日期 日 月
     * @return
     */
    @Override
    public Map<String, Object> getCompareData(String pointCode, String year, String rq) {

        StringBuilder sql = new StringBuilder();
        String curFullYear = DateUtil.getCurFullYear();
        List<Map> curYearList = null;
        List<Map> pastYearList = null;
        //日
        if (rq.indexOf('-') > -1) {
            if (year.indexOf('-') > -1) {
                curYearList = getMaps(pointCode, DateUtil.getCurYearMonthDay().substring(5), sql, curFullYear);
                year = year.substring(0, 4);
            } else {
                curYearList = getMaps(pointCode, rq, sql, curFullYear);
            }
            sql = new StringBuilder();
            pastYearList = getMaps(pointCode, rq, sql, year);
        } else {
            curYearList = getMapsForMonth(pointCode, rq, sql, curFullYear);
            sql = new StringBuilder();
            pastYearList = getMapsForMonth(pointCode, rq, sql, year);
        }
        Map curMap = new HashMap();
        if (ToolUtil.isNotEmpty(curYearList)) {
            Map map = curYearList.get(0);
            curMap.put("curNo2", MapUtils.getString(map, "no2"));
            curMap.put("curO3", MapUtils.getString(map, "o3"));
            curMap.put("curPM10", MapUtils.getString(map, "pm10"));
            curMap.put("curPM25", MapUtils.getString(map, "pm25"));
            curMap.put("curSO2", MapUtils.getString(map, "so2"));
            curMap.put("curCO", MapUtils.getString(map, "co"));
        }
        if (ToolUtil.isNotEmpty(pastYearList)) {
            Map map = pastYearList.get(0);
            curMap.put("pastNo2", MapUtils.getString(map, "no2"));
            curMap.put("pastO3", MapUtils.getString(map, "o3"));
            curMap.put("pastPM10", MapUtils.getString(map, "pm10"));
            curMap.put("pastPM25", MapUtils.getString(map, "pm25"));
            curMap.put("pastSO2", MapUtils.getString(map, "so2"));
            curMap.put("pastCO", MapUtils.getString(map, "co"));
        }
        int i = Integer.parseInt(MapUtils.getString(curMap, "curNo2", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastNo2", "0"));
        int i1 = Integer.parseInt(MapUtils.getString(curMap, "curO3", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastO3", "0"));
        int i2 = Integer.parseInt(MapUtils.getString(curMap, "curPM10", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastPM10", "0"));
        int i3 = Integer.parseInt(MapUtils.getString(curMap, "curPM25", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastPM25", "0"));
        int i4 = Integer.parseInt(MapUtils.getString(curMap, "curSO2", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastSO2", "0"));
        double i5 = Double.parseDouble(MapUtils.getString(curMap, "curCO", "0.0")) - Double.parseDouble(MapUtils.getString(curMap, "pastCO", "0.0"));
        curMap.put("No2", i);
        curMap.put("O3", i1);
        curMap.put("PM10", i2);
        curMap.put("PM25", i3);
        curMap.put("SO2", i4);
        curMap.put("CO", i5);
        return curMap;
    }

    /**
     * 获取比较数据 因子-同比-监测站因子
     *
     * @param pointCode   站点编码
     * @param rq          日期
     * @param sql         日
     * @param curFullYear 比对年度
     * @return
     */
    private List<Map> getMaps(String pointCode, String rq, StringBuilder sql, String curFullYear) {
        sql.append(" 	SELECT sum(DECODE(a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0))  NO2, ");
        sql.append(" 	sum(DECODE(a.CODE_POLLUTE, 'A050248', a.AVERVALUE, 0)) O3, ");
        sql.append(" 	sum(DECODE(a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0))  PM10, ");
        sql.append(" 	sum(DECODE(a.CODE_POLLUTE, 'A34004', a.AVERVALUE, 0))  PM25, ");
        sql.append(" 	sum(DECODE(a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0))  SO2, ");
        sql.append(" 	sum(DECODE(a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0))  CO, ");
        sql.append(" 	a.MONITOR_TIME ");
        sql.append(" 	FROM AIR_DAY_DATA a ");
        sql.append(" WHERE POINT_CODE =  ").append(SqlUtil.toSqlStr(pointCode));
        sql.append(" 	AND to_char(MONITOR_TIME, 'yyyy-mm-dd') =  ").append(SqlUtil.toSqlStr(curFullYear + "-" + rq));
        sql.append(" 	GROUP BY  a.MONITOR_TIME ");
        return simpleDao.getNativeQueryList(sql.toString());
    }

    /**
     * 获取比较数据 因子-同比-监测站因子
     *
     * @param pointCode   站点编码
     * @param rq          日期
     * @param sql         月
     * @param curFullYear 比对年度
     * @return
     */
    private List<Map> getMapsForMonth(String pointCode, String rq, StringBuilder sql, String curFullYear) {

        sql.append(" 	SELECT  ROUND(AVG(B.NO2)) NO2, ROUND(AVG(O3)) O3, ROUND(AVG(B.PM10)) PM10, ROUND(AVG(B.PM25)) PM25, ROUND(AVG(SO2)) SO2, ROUND(AVG(B.CO),1) CO, B.MONITOR_TIME ");
        sql.append(" 	FROM ( ");
        sql.append(" 	SELECT SUM(DECODE(A.CODE_POLLUTE, 'A21004', A.AVERVALUE, 0))  NO2, ");
        sql.append(" 	SUM(DECODE(A.CODE_POLLUTE, 'A050248', A.AVERVALUE, 0)) O3, ");
        sql.append(" 	SUM(DECODE(A.CODE_POLLUTE, 'A34002', A.AVERVALUE, 0))  PM10, ");
        sql.append(" 	SUM(DECODE(A.CODE_POLLUTE, 'A34004', A.AVERVALUE, 0))  PM25, ");
        sql.append(" 	SUM(DECODE(A.CODE_POLLUTE, 'A21026', A.AVERVALUE, 0))  SO2, ");
        sql.append(" 	SUM(DECODE(A.CODE_POLLUTE, 'A21005', A.AVERVALUE, 0))  CO, ");
        sql.append(" 	TO_CHAR(A.MONITOR_TIME, 'YYYY-MM')                     MONITOR_TIME ");
        sql.append(" 	FROM AIR_DAY_DATA A ");
        sql.append(" WHERE POINT_CODE =  ").append(SqlUtil.toSqlStr(pointCode));
        sql.append(" AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') =  ").append(SqlUtil.toSqlStr(curFullYear + "-" + rq));
        sql.append(" 	GROUP BY MONITOR_TIME ");
        sql.append(" 	) B ");
        sql.append(" 	GROUP BY B.MONITOR_TIME ");
        return simpleDao.getNativeQueryList(sql.toString());
    }


}
