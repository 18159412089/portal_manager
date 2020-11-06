package com.fjzxdz.ams.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.air.hugedata.HugeDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirPointService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * 关于大气数据服务模块的监测站的实现
 *
 * @Author lianhuinan
 * @Version 1.0
 * @CreateTime 2019年6月25日 下午3:51:52
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class AirPointServiceImpl implements AirPointService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private HugeDataService hugeDataService;

    @Override
    public List<Map<String, Object>> FactoryCompare(String pointName, String start, String end) {
        List<Map<String, Object>> result = new ArrayList<>();
        String lastStart = DateUtil.getLastYearSameDay(start);
        String lastEnd = DateUtil.getLastYearSameDay(end);
        pointName = pointName.replace(",", "','");
        String sql = "SELECT " +
                "	TIME, AVG( AQI ) aqi, AVG( NO2 ) no2, AVG( O3 ) o3, AVG( PM10 ) pm10, AVG( PM25 ) pm25, " +
                "	AVG( SO2 ) so2, AVG( CO ) co, POINT_CODE ponitcode, POINT_NAME pointname  " +
                "FROM ( " +
                "	SELECT " +
                "		TO_CHAR( d.MONITOR_TIME, 'yyyy' ) TIME, AVG( d.AQI ) AQI, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A21004', d.AVERVALUE, 0 )) NO2, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A050248', d.AVERVALUE, 0 )) O3, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A34002', d.AVERVALUE, 0 )) PM10, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A34004', d.AVERVALUE, 0 )) PM25, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A21026', d.AVERVALUE, 0 )) SO2, " +
                "		sum( DECODE( d.CODE_POLLUTE, 'A21005', d.AVERVALUE, 0 )) CO, " +
                "		p.POINT_CODE POINT_CODE, p.POINT_NAME POINT_NAME  " +
                "	FROM AIR_DAY_DATA d " +
                "		LEFT JOIN AIR_MONITOR_POINT p ON d.POINT_CODE = p.POINT_CODE  " +
                "	WHERE " +
                "       ((d.MONITOR_TIME >= TO_DATE( '" + start + "', 'yyyy-mm-dd' )  " +
                "		AND d.MONITOR_TIME <= TO_DATE( '" + end + "', 'yyyy-mm-dd' ))  " +
                "		OR (d.MONITOR_TIME >= TO_DATE( '" + lastStart + "', 'yyyy-mm-dd' )  " +
                "		AND d.MONITOR_TIME <= TO_DATE( '" + lastEnd + "', 'yyyy-mm-dd' )))  " +
                "		AND p.POINT_CODE IN ( '" + pointName + "' )  " +
                "	GROUP BY d.MONITOR_TIME, p.POINT_CODE, p.POINT_NAME )  " +
                "WHERE NO2<>'1' AND PM10<>'1' AND PM25<>'1' AND SO2<>'1' AND O3<>'1'  " +
                "GROUP BY TIME, POINT_CODE, POINT_NAME  " +
                "ORDER BY POINT_NAME DESC";
        List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql);
        if (ToolUtil.isNotEmpty(list)) {
            String year = StringUtils.substring(start, 0, 4);
            Map<String, Map<String, Map<String, Object>>> compareMap = new HashMap<>(2);
            //区分今年与去年的数据，放置在compareMap中
            for (Map<String, Object> map : list) {
                String time = (String) map.get("time");
                String pointname = (String) map.get("pointname");
                double no2 = new BigDecimal(map.get("no2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int pm10 = new BigDecimal(map.get("pm10").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                int pm25 = new BigDecimal(map.get("pm25").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                double so2 = new BigDecimal(map.get("so2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                String startTime = StringUtils.contains(start, time) ? start : lastStart;
                String endTime = StringUtils.contains(end, time) ? end : lastEnd;
                Map<String, BigDecimal> o_co = hugeDataService.getCoAndO3(startTime,
                        endTime, map.get("ponitcode").toString());
                double co = o_co.get("CO").doubleValue();
                int o3 = o_co.get("O3").intValue();
                if (compareMap.containsKey(time)) {
                    Map<String, Map<String, Object>> yearMap = compareMap.get(year);
                    Map<String, Object> temp = new HashMap<>(6);
                    temp.put("NO2", no2);
                    temp.put("SO2", so2);
                    temp.put("PM10", pm10);
                    temp.put("PM25", pm25);
                    temp.put("O3", o3);
                    temp.put("CO", co);
                    yearMap.put(pointname, temp);
                } else {
                    Map<String, Map<String, Object>> yearMap = new HashMap<>();
                    Map<String, Object> temp = new HashMap<>(6);
                    temp.put("NO2", no2);
                    temp.put("SO2", so2);
                    temp.put("PM10", pm10);
                    temp.put("PM25", pm25);
                    temp.put("O3", o3);
                    temp.put("CO", co);
                    yearMap.put(pointname, temp);
                    compareMap.put(time, yearMap);
                }
            }

            for (Entry<String, Map<String, Object>> entry : compareMap.get(year).entrySet()) {
                double no2 = new BigDecimal(entry.getValue().get("NO2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int pm10 = new BigDecimal(entry.getValue().get("PM10").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                int pm25 = new BigDecimal(entry.getValue().get("PM25").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                double so2 = new BigDecimal(entry.getValue().get("SO2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                double co = new BigDecimal(entry.getValue().get("CO").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int o3 = new BigDecimal(entry.getValue().get("O3").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                Map<String, Object> temp = new HashMap<>();
                temp.put("name", entry.getKey());
                temp.put("NO2", no2);
                temp.put("SO2", so2);
                temp.put("PM10", pm10);
                temp.put("PM25", pm25);
                temp.put("O3", o3);
                temp.put("CO", co);
                Map<String, Object> otherTemp = compareMap.get(year).get(entry.getKey());
                double other_no2 = new BigDecimal(otherTemp.get("NO2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int other_pm10 = new BigDecimal(otherTemp.get("PM10").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                int other_pm25 = new BigDecimal(otherTemp.get("PM25").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                double other_so2 = new BigDecimal(otherTemp.get("SO2").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                double other_co = new BigDecimal(otherTemp.get("CO").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue();
                int other_o3 = new BigDecimal(otherTemp.get("O3").toString()).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
                temp.put("NO2Status", no2 > other_no2 ? "up" : "down");
                temp.put("SO2Status", so2 > other_so2 ? "up" : "down");
                temp.put("PM10Status", pm10 > other_pm10 ? "up" : "down");
                temp.put("PM25Status", pm25 > other_pm25 ? "up" : "down");
                temp.put("COStatus", co > other_co ? "up" : "down");
                temp.put("O3Status", o3 > other_o3 ? "up" : "down");

                result.add(temp);
            }
        }

        return result;
    }

}
