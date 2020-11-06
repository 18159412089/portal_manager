package com.fjzxdz.ams.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.hugedata.HugeDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.util.MapUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;

/**
 * 关于大气数据服务模块的污染物分析的实现
 *
 * @Author lianhuinan
 * @Version 1.0
 * @CreateTime 2019年6月25日 下午3:51:52
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class AirPolluteServiceImpl implements AirPolluteService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private HugeDataService hugeDataService;

    /**
     * 污染物分析图表
     * <p>Title: analysisCharts</p>
     * <p>Description: </p>
     *
     * @param regionName
     * @param factory
     * @param start
     * @param end
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService#analysisCharts(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
     */
    @Override
    public Map<String, Object> analysisCharts(String regionName, String factory,
                                              String start, String end, String pointType, String type) {
        String clause = "";
        String title = "";
        if (StringUtils.equals(pointType, "point")) {
            regionName = regionName.replace(",", "','");
            clause = " AND p.parent IN ( '" + regionName + "' )  ";
            title = "污染物分析";
        } else {
            clause = " AND p.POINT_TYPE = '1'  ";
            title = "污染物分析（城市）";
        }
        String table = "AIR_DAY_DATA";
        if(StringUtils.equals(type, "2")){
            table = "AIR_HOUR_DATA";
            clause = "AND p.POINT_CODE IN ('" + regionName + "') ";
        }
        String sql = "SELECT " +
                "   TO_CHAR(d.MONITOR_TIME, 'yyyy-mm-dd') MONITOR_TIME, d.AQI, " +
                "	sum( DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                "	sum( DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, " +
                "	sum( DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                "	sum( DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                "	sum( DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, " +
                "	sum( DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, " +
                "	p.POINT_CODE POINTCODE, p.POINT_NAME POINTNAME " +
                "FROM " + table +" d " +
                "	LEFT JOIN AIR_MONITOR_POINT p ON d.POINT_CODE =p.POINT_CODE " +
                "WHERE " +
                "	 d.MONITOR_TIME >= TO_DATE( '" + start + "', 'yyyy-mm-dd' )  " +
                "	AND d.MONITOR_TIME <= TO_DATE( '" + end + "', 'yyyy-mm-dd' )  " + clause +
                "GROUP BY " +
                "	d.MONITOR_TIME, d.AQI, p.POINT_CODE, p.POINT_NAME";
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql);
        if (ToolUtil.isNotEmpty(list)) {
            //存放返回值
            Map<String, Object> result = new HashMap<>();
            //存放关于图表信息
            Map<String, Object> charts = new HashMap<>();

            Set<String> temp_xAxis = new HashSet<>();
            for (Map<String, Object> map : list) {
                temp_xAxis.add(map.get("pointname").toString());
            }

            Map<String, Integer> seriesMap = new HashMap<>();
            for (String key : temp_xAxis) {
                int count = 0;
                for (Map<String, Object> map : list) {
                    if (StringUtils.equals(map.get("pointname").toString(), key)) {
                        if (new BigDecimal(map.get("aqi").toString()).compareTo(new BigDecimal(50)) == 1) {
                            double no2 = new BigDecimal(map.get("no2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                            double o3 = new BigDecimal(map.get("o3").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                            int pm10 = new BigDecimal(map.get("pm10").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                            int pm25 = new BigDecimal(map.get("pm25").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                            double so2 = new BigDecimal(map.get("so2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                            double co = new BigDecimal(map.get("co").toString()).setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
                            Aqi aqi = AqiUtil.CountAqi(pm25, pm10, co, no2, o3, so2);
                            if (StringUtils.equals(aqi.getName(), factory)) {
                                count++;
                            }
                        }
                    }
                }
                seriesMap.put(key, count);
            }
            seriesMap = MapUtil.sortByValueDescending(seriesMap);
            charts.put("title", title);
            charts.put("xAxis", seriesMap.keySet());
            charts.put("series", seriesMap.values());
            result.put("charts", charts);

            //文字说明部分
            result.put("words", getTop3AndBottom3(seriesMap));

            return result;
        }

        return new HashMap<>(0);
    }

    /**
     * 污染物分析列表
     * <p>Title: analysisWords</p>
     * <p>Description: </p>
     *
     * @param regionName
     * @param dateType
     * @param start
     * @param end
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService#analysisWords(java.lang.String, java.lang.String, java.lang.String, java.lang.String, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> analysisWords(String regionName, String dateType,
                                                   String start, String end, Page<Map<String, Object>> page, String pointType, String type) {
        String format = "";
        if (StringUtils.equals(dateType, "年")) {
            format = "yyyy";
        } else {
            format = "yyyy-mm";
        }
        String clause = "";
        if (StringUtils.equals(pointType, "point")) {
            regionName = regionName.replace(",", "','");
            clause = " AND p.parent IN ( '" + regionName + "' )  ";
        } else {
            clause = " AND p.POINT_TYPE = '1'  ";
        }
        String table = "AIR_DAY_DATA";
        if(StringUtils.equals(type, "2")){
            table = "AIR_HOUR_DATA";
            clause = "AND p.POINT_CODE IN ('" + regionName + "') ";
        }
        String sql = "SELECT TIME, AVG(AQI) aqi, AVG(NO2) no2, AVG(O3) o3," +
                "       AVG(PM10) pm10, AVG(PM25) pm25, AVG(SO2) so2," +
                "       AVG(CO) co, POINT_CODE  ponitcode," +
                "       POINT_NAME  pointname, REGION_NAME regionname " +
                "   FROM (SELECT TO_CHAR(d.MONITOR_TIME, '" + format + "') TIME," +
                "             AVG(d.AQI)                                             AQI," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A21004', d.AVERVALUE, 0))  NO2," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A050248', d.AVERVALUE, 0)) O3," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A34002', d.AVERVALUE, 0))  PM10," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A34004', d.AVERVALUE, 0))  PM25," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A21026', d.AVERVALUE, 0))  SO2," +
                "             sum(DECODE(d.CODE_POLLUTE, 'A21005', d.AVERVALUE, 0))  CO," +
                "             p.POINT_CODE POINT_CODE," +
                "             p.POINT_NAME POINT_NAME," +
                "             d.REGION_NAME REGION_NAME " +
                "      FROM "+ table +" d LEFT JOIN AIR_MONITOR_POINT p ON d.POINT_CODE = p.POINT_CODE" +
                "      WHERE d.MONITOR_TIME >= TO_DATE('" + start + "', 'yyyy-mm-dd')" +
                "        AND d.MONITOR_TIME <= TO_DATE('" + end + "', 'yyyy-mm-dd')" + clause +
                "      GROUP BY d.MONITOR_TIME, p.POINT_CODE, p.POINT_NAME, d.REGION_NAME)" +
                "WHERE NO2 <> '1' AND PM10 <> '1' AND PM25 <> '1' AND SO2 <> '1' AND O3 <> '1'" +
                "GROUP BY TIME, POINT_CODE, POINT_NAME, REGION_NAME ORDER BY TIME DESC";
        Page<Map<String, Object>> mapPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> list = mapPage.getResult();
        if (ToolUtil.isNotEmpty(list)) {
            for (Map<String, Object> map : list) {
                String startTime = "";
                String endTime = "";
                String currentTime = DateUtil.getCurYearMonthDay();
                if (StringUtils.equals(dateType, "月")) {
                    startTime = map.get("time") + "-01";
                    endTime = DateUtil.getLastDayOfMonth2(map.get("time").toString());
                } else {
                    startTime = map.get("time") + "-01-01";
                    endTime = map.get("time") + "-12-31";
                }
                if (StringUtils.contains(currentTime, map.get("time").toString())) {
                    endTime = currentTime;
                }
                double no2 = new BigDecimal(map.get("no2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int pm10 = new BigDecimal(map.get("pm10").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                int pm25 = new BigDecimal(map.get("pm25").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                double so2 = new BigDecimal(map.get("so2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                Map<String, BigDecimal> o_co = new HashMap<>();
                if(StringUtils.equals(type, "2")){
                    o_co = hugeDataService.getCoAndO3(startTime, endTime, map.get("ponitcode").toString(), table);
                }else{
                    o_co = hugeDataService.getCoAndO3(startTime, endTime, map.get("ponitcode").toString());
                }
                double co = o_co.get("CO").doubleValue();
                int o3 = o_co.get("O3").intValue();
                Aqi aqi = AqiUtil.CountAqi(pm25, pm10, co, no2, o3, so2);
                if (aqi.getAqi() > 50) {
                    map.put("pollute", aqi.getName());
                } else {
                    map.put("pollute", "-");
                }
                map.put("monitortime", map.get("time"));
                map.put("dayCount", DateUtil.getDaySub(startTime, endTime) + 1);
                map.put("monitorCount", o_co.get("COUNT"));
            }
            return mapPage;
        }
        return new Page<Map<String, Object>>();
    }

    /**
     * 分析污染物-同比-监测站污染物
     * <p>Title: analysisPointCharts</p>
     * <p>Description: </p>
     *
     * @param pointName
     * @param start
     * @param end
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService#analysisPointCharts(java.lang.String, java.lang.String, java.lang.String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> analysisPointCharts(String pointName, String start, String end,
                                                         String dateType, String queryType) throws ParseException {
        String format = "";
        Map<String, Object> timeMap;
        if (StringUtils.equals(dateType, "日")) {
            format = "yyyy-mm-dd";
            timeMap = DateUtil.getBetweenDay(start, end);
        } else if (StringUtils.equals(dateType, "月")) {
            format = "yyyy-mm";
            timeMap = DateUtil.getBetweenMonth(start, end);
        } else {
            format = "yyyy";
            timeMap = DateUtil.getBetweenYear(start, end);
        }
        List<Map<String, Object>> result = new ArrayList<>();
        String[] pointNames = StringUtils.split(pointName, ",");
        String startTime = (String) timeMap.get("startTime");
        String endTime = (String) timeMap.get("endTime");

        List<String> xAxis = (List<String>) timeMap.get("xList");
        Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");

        for (String point : pointNames) {
            Map<String, Object> map = new HashMap<>();

            String sql = "SELECT TIME, POINT_NAME POINTNAME, POINT_CODE POINTCODE, " +
                    "	ROUND( AVG( PM25 ), 0 ) PM25, ROUND( AVG( PM10 ), 0 ) PM10, " +
                    "	ROUND( AVG( CO ), 1 ) CO, ROUND( AVG( NO2 ), 0 ) NO2, " +
                    "	ROUND( AVG( O3 ), 0 ) O3, ROUND( AVG( SO2 ), 0 ) SO2  " +
                    "FROM ( SELECT " +
                    "		TO_CHAR( MONITOR_TIME, '" + format + "' ) TIME, " +
                    "		POINT_CODE POINT_CODE, POINT_NAME POINT_NAME, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, " +
                    "		sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO  " +
                    "	FROM AIR_DAY_DATA  " +
                    "	WHERE " +
                    "		MONITOR_TIME >= TO_DATE( '" + startTime + "', 'yyyy-MM-dd' )  " +
                    "		AND MONITOR_TIME <= TO_DATE( '" + endTime + "', 'yyyy-MM-dd' )  " +
                    "		AND POINT_CODE = '" + point + "' " +
                    "	GROUP BY " +
                    "		MONITOR_TIME, " +
                    "		POINT_CODE, " +
                    "		POINT_NAME )  " +
                    "GROUP BY TIME, POINT_NAME, POINT_CODE " +
                    "ORDER BY TIME";
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql);

            if (ToolUtil.isNotEmpty(list)) {
                String[] a = new String[indexmap.size()];
                String[] b = new String[indexmap.size()];
                String[] c = new String[indexmap.size()];
                String[] d = new String[indexmap.size()];
                String[] e = new String[indexmap.size()];
                String[] f = new String[indexmap.size()];
                for (Map<String, Object> map2 : list) {
                    int pm25 = Integer.parseInt(map2.get("pm25").toString());
                    int o3 = Integer.parseInt(map2.get("o3").toString());
                    if (pm25 < 5 || o3 < 10) {
                        a[indexmap.get(map2.get("time"))] = null;
                        b[indexmap.get(map2.get("time"))] = null;
                        c[indexmap.get(map2.get("time"))] = null;
                        d[indexmap.get(map2.get("time"))] = null;
                        e[indexmap.get(map2.get("time"))] = null;
                        f[indexmap.get(map2.get("time"))] = null;
                    } else {
                        a[indexmap.get(map2.get("time"))] = map2.get("pm25").toString();
                        b[indexmap.get(map2.get("time"))] = map2.get("pm10").toString();
                        c[indexmap.get(map2.get("time"))] = map2.get("so2").toString();
                        d[indexmap.get(map2.get("time"))] = map2.get("no2").toString();
                        e[indexmap.get(map2.get("time"))] = map2.get("co").toString();
                        f[indexmap.get(map2.get("time"))] = map2.get("o3").toString();
                    }
                    map.put("title", map2.get("pointname").toString());
                }
                JSONArray series = new JSONArray();
                JSONObject pm25Json = new JSONObject();
                pm25Json.put("name", "PM2.5");
                pm25Json.put("type", "line");
                pm25Json.put("symbol:", "circle");
                pm25Json.put("yAxisIndex", "0");
                pm25Json.put("itemStyle", JSONObject.parse("{normal:{color:'#51a1fa'}}"));
                pm25Json.put("data", a);
                series.add(pm25Json);
                JSONObject pm10Json = new JSONObject();
                pm10Json.put("name", "PM10");
                pm10Json.put("type", "line");
                pm25Json.put("symbol:", "triangle");
                pm10Json.put("yAxisIndex", "0");
                pm10Json.put("itemStyle", JSONObject.parse("{normal:{color:'#65b149'}}"));
                pm10Json.put("data", b);
                series.add(pm10Json);
                JSONObject so2Json = new JSONObject();
                so2Json.put("name", "SO2");
                so2Json.put("type", "line");
                pm25Json.put("symbol:", "star");
                so2Json.put("yAxisIndex", "0");
                so2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ffbf26'}}"));
                so2Json.put("data", c);
                series.add(so2Json);
                JSONObject no2Json = new JSONObject();
                no2Json.put("name", "NO2");
                no2Json.put("type", "line");
                pm25Json.put("symbol:", "star");
                no2Json.put("yAxisIndex", "0");
                no2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ff5400'}}"));
                no2Json.put("data", d);
                series.add(no2Json);
                JSONObject coJson = new JSONObject();
                coJson.put("name", "CO");
                coJson.put("type", "line");
                pm25Json.put("symbol:", "diamond");
                coJson.put("yAxisIndex", "1");
                coJson.put("itemStyle", JSONObject.parse("{normal:{color:'#d13430'}}"));
                coJson.put("data", e);
                series.add(coJson);
                JSONObject o3Json = new JSONObject();
                o3Json.put("name", "O3-8h");
                o3Json.put("type", "line");
                pm25Json.put("symbol:", "circle");
                o3Json.put("yAxisIndex", "0");
                o3Json.put("itemStyle", JSONObject.parse("{normal:{color:'#5d30d1'}}"));
                o3Json.put("data", f);
                series.add(o3Json);
                map.put("xAxis", xAxis);
                map.put("series", series);
                map.put("pollute", getPollute(start, end, point, queryType));

                result.add(map);
            }
        }


        return result;
    }

    /**
     * @param seriesMap
     * @return JSONArray
     * @throws
     * @Title: getTopAndBottom
     * @Description: TODO(获取排名前三后三)
     * @CreateBy: lianhuinan
     * @CreateTime: 2019年6月28日 上午9:50:21
     * @UpdateBy: lianhuinan
     * @UpdateTime: 2019年6月28日 上午9:50:21
     */
    public Map<String, JSONArray> getTop3AndBottom3(Map<String, Integer> seriesMap) {
        if (ToolUtil.isNotEmpty(seriesMap)) {
            JSONArray top = new JSONArray(3);
            JSONArray bottom = new JSONArray(3);
            List<String> points = new ArrayList<>(seriesMap.size());
            for (String key : seriesMap.keySet()) {
                points.add(key);
            }
            if (points.size() >= 6) {
                for (int i = points.size() - 1; i >= points.size() - 3; i--) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", points.get(i));
                    temp.put("value", seriesMap.get(points.get(i)));
                    top.add(temp);
                }
                for (int i = 0; i <= 2; i++) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", points.get(i));
                    temp.put("value", seriesMap.get(points.get(i)));
                    bottom.add(temp);
                }
            } else if (points.size() > 3) {
                for (int i = 0; i <= 2; i++) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", points.get(i));
                    temp.put("value", seriesMap.get(points.get(i)));
                    bottom.add(temp);
                }
                for (int i = points.size() - 1; i > 2; i--) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", points.get(i));
                    temp.put("value", seriesMap.get(points.get(i)));
                    top.add(temp);
                }
            } else {
                for (int i = 0; i > points.size(); i++) {
                    JSONObject temp = new JSONObject();
                    temp.put("name", points.get(i));
                    temp.put("value", seriesMap.get(points.get(i)));
                    top.add(temp);
                }
            }
            Map<String, JSONArray> words = new HashMap<>(2);
            if (ToolUtil.isNotEmpty(top)) {
                words.put("top", top);
            }
            if (ToolUtil.isNotEmpty(bottom)) {
                words.put("bottom", bottom);
            }
            return words;
        }
        return new HashMap<String, JSONArray>(0);
    }

    /**
     * @param start
     * @param end
     * @param point
     * @return Map<String, String>
     * @throws
     * @Title: getPollute
     * @Description: TODO(获取今 、 去年同比的污染物)
     * @CreateBy: lianhuinan
     * @CreateTime: 2019年7月10日 上午10:38:08
     * @UpdateBy: lianhuinan
     * @UpdateTime: 2019年7月10日 上午10:38:08
     */
    public Map<String, String> getPollute(String start, String end, String point, String type) {
        Map<String, String> pollute = new HashMap<>();
        String lastStart = "";
        String lastEnd = "";
        if(StringUtils.equals(type, "环比")) {
            lastStart = DateUtil.getLastMonthSameDay(start);
            lastEnd = DateUtil.getLastMonthSameDay(end);
        }else {
	        lastStart = DateUtil.getLastYearSameDay(start);
	        lastEnd = DateUtil.getLastYearSameDay(end);
        }
        String polluteSql = "select " +
                "	TIME, " +
                "	ROUND(AVG(NO2),0) NO2, " +
                "	ROUND(AVG(O3),0) O3, " +
                "	ROUND(AVG(PM10),0) PM10, " +
                "	ROUND(AVG(PM25),0) PM25, " +
                "	ROUND(AVG(SO2),0) SO2, " +
                "	ROUND(AVG(CO),1) CO " +
                "FROM (	 " +
                "	SELECT " +
                "		TO_CHAR( MONITOR_TIME, 'yyyy' ) TIME, " +
                "		POINT_CODE, " +
                "		POINT_NAME, " +
                "		sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                "		sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, " +
                "		sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                "		sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                "		sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, " +
                "		sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO  " +
                "	FROM AIR_DAY_DATA  " +
                "	WHERE ((MONITOR_TIME >= TO_DATE( '" + start + "', 'yyyy-mm-dd' )  " +
                "		AND MONITOR_TIME <= TO_DATE( '" + end + "', 'yyyy-mm-dd' )) " +
                "		OR (MONITOR_TIME >= TO_DATE( '" + lastStart + "', 'yyyy-mm-dd' )  " +
                "		AND MONITOR_TIME <= TO_DATE( '" + lastEnd + "', 'yyyy-mm-dd' ))) " +
                "		AND POINT_CODE = '" + point + "'  " +
                "	GROUP BY MONITOR_TIME, POINT_CODE, POINT_NAME ) " +
                "WHERE PM10>10 and O3>10 " +
                "GROUP BY TIME";
        List<Map<String, Object>> polluteList = simpleDao.getNativeQueryList(polluteSql);
        if (ToolUtil.isNotEmpty(polluteList)) {
            int lastYear = Integer.parseInt(lastStart.substring(0, 4));
            for (Map<String, Object> map3 : polluteList) {
                Map<String, String> temp = new HashMap<>(6);
                int time = Integer.parseInt(map3.get("time").toString());
                double no2 = Double.parseDouble(map3.get("no2").toString());
                int pm10 = Integer.parseInt(map3.get("pm10").toString());
                int pm25 = Integer.parseInt(map3.get("pm25").toString());
                double so2 = Double.parseDouble(map3.get("so2").toString());
                double o3;
                double co;
                if (lastYear == time) {
                    Map<String, BigDecimal> co_o3 = hugeDataService.getCoAndO3(lastStart, lastEnd, point);
                    o3 = co_o3.get("O3").doubleValue();
                    co = co_o3.get("CO").doubleValue();
                } else {
                    Map<String, BigDecimal> co_o3 = hugeDataService.getCoAndO3(start, end, point);
                    o3 = co_o3.get("O3").doubleValue();
                    co = co_o3.get("CO").doubleValue();
                }
                temp.put("PM2.5", pm25 + "");
                temp.put("PM10", pm10 + "");
                temp.put("NO2", no2 + "");
                temp.put("SO2", so2 + "");
                temp.put("CO", co + "");
                temp.put("O3", o3 + "");
                Aqi aqi = AqiUtil.CountAqi(pm25, pm10, co, no2, o3, so2);
                if (aqi.getAqi() < 50) {
                    pollute.put(lastYear == time ? "last" : "now", "-");
                    pollute.put(lastYear == time ? "lastVal" : "nowVal", "-");
                } else {
                    pollute.put(lastYear == time ? "last" : "now", aqi.getName());
                    pollute.put(lastYear == time ? "lastVal" : "nowVal", temp.get(aqi.getName()));
                }
                if (!pollute.containsKey("last")) {
                    pollute.put("last", "-");
                    pollute.put("lastVal", "-");
                }
                if (!pollute.containsKey("now")) {
                    pollute.put("now", "-");
                    pollute.put("nowVal", "-");
                }
            }
            pollute.put("nowTime", end);
            pollute.put("lastTime", lastEnd);
        }
        return pollute;
    }
}
