package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;


import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import com.fjzxdz.ams.util.AirSeriesUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirEnvironmentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)

/**
 *
 * 大气环境服务 Service 实现类
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午2:31:07
 */
public class ZpAirEnvironmentServiceImpl implements ZpAirEnvironmentService {


    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: 点击地图上的点显示的窗口中。数据分析的数据显示。
     * <p>Description: </p>
     *
     * @param polluteName
     * @param pointCode
     * @param time
     * @return
     * @see ZpAirEnvironmentService#getDataAnalysisCityPoint(String, String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getDataAnalysisCityPoint(String polluteName, String pointCode, String time) {
        List<Object[]> list = new ArrayList<Object[]>();
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis = new ArrayList<String>();
        String startTime = "";
        String endTime = "";
        String sql;
        String[] arr = pointCode.substring(0, pointCode.length()).split(",");
        String city = "('" + StringUtils.join(arr, "','") + "')";
        Map<String, Integer> indexmap = new HashMap<String, Integer>();
        if (time != null && ("24h").equals(time)) {
            Map<String, Object> timeMap = DateUtil.get24h();
            startTime = timeMap.get("startTime").toString();
            endTime = timeMap.get("endTime").toString();
            xAxis = (List<String>) timeMap.get("xList");
            indexmap = (Map<String, Integer>) timeMap.get("indexmap");

            if (polluteName != null && "aqi".equals(polluteName)) {
                sql = "SELECT POINT_NAME,AQI,to_char(MONITOR_TIME,'yyyy-mm-dd hh24') FROM AIR_HOUR_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm-dd hh24') "
                        + "AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd hh24') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime).getResultList();
            } else {
                sql = "SELECT POINT_NAME,AVERVALUE,to_char(MONITOR_TIME,'yyyy-mm-dd hh24') FROM AIR_HOUR_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm-dd hh24') AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd hh24') AND CODE_POLLUTE= ? "
                        + "GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime, polluteName).getResultList();
            }
            if (arr.length == 1) {
                sql = "SELECT '风向',TO_NUMBER(WINDDIRT),to_char(CHECKTIME,'yyyy-mm-dd hh24') FROM AIR_SITE_HOUR_DATA WHERE POTCODE in " + city + " "
                        + "AND CHECKTIME >= to_date(?,'yyyy-mm-dd hh24') AND CHECKTIME <= to_date(?,'yyyy-mm-dd hh24') "
                        + "ORDER BY CHECKTIME ASC";
                List<Object[]> templist = simpleDao.createNativeQuery(sql, startTime, endTime).getResultList();
                if (templist != null) {
                    list.addAll(templist);
                }
            }
        } else if (time != null && "30d".equals(time)) {
            Map<String, Object> timeMap = DateUtil.get30d();
            startTime = timeMap.get("startTime").toString();
            endTime = timeMap.get("endTime").toString();
            xAxis = (List<String>) timeMap.get("xList");
            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            if (polluteName != null && "aqi".equals(polluteName)) {
                sql = "SELECT POINT_NAME,AQI,TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') FROM AIR_DAY_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm-dd') "
                        + "AND MONITOR_TIME <= to_date(?,'yyyy-mm-dd') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime).getResultList();
            } else {
                if(StringUtils.equals(polluteName, "A05024")){
                    polluteName += "8";
                }
                sql = "SELECT POINT_NAME,AVERVALUE,TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') FROM AIR_DAY_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >=to_date(?,'yyyy-mm-dd') AND MONITOR_TIME <=to_date(?,'yyyy-mm-dd') AND CODE_POLLUTE= ? "
                        + "GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime, polluteName).getResultList();
            }

        } else if (time != null && "1y".equals(time)) {
            Map<String, Object> timeMap = DateUtil.get12m();
            startTime = timeMap.get("startTime").toString();
            endTime = timeMap.get("endTime").toString();
            xAxis = (List<String>) timeMap.get("xList");
            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            if (polluteName != null && polluteName.equals("aqi")) {
                sql = "SELECT POINT_NAME,ROUND(AVG(AQI),2),TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) FROM AIR_DAY_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >= to_date(?,'yyyy-mm') "
                        + "AND MONITOR_TIME <= to_date(?,'yyyy-mm') GROUP BY POINT_NAME,TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) ORDER BY POINT_NAME,	TO_CHAR( MONITOR_TIME, 'yyyy-mm' )  ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime).getResultList();
            } else {
                if(StringUtils.equals(polluteName, "A05024")){
                    polluteName += "8";
                }
                sql = "SELECT POINT_NAME,ROUND(AVG(AVERVALUE),2),TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) FROM AIR_DAY_DATA WHERE POINT_CODE in " + city + " "
                        + "AND MONITOR_TIME >=to_date(?,'yyyy-mm') AND MONITOR_TIME <=to_date(?,'yyyy-mm') AND CODE_POLLUTE= ? "
                        + "GROUP BY POINT_NAME,TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) ORDER BY POINT_NAME,	TO_CHAR( MONITOR_TIME, 'yyyy-mm' )  ASC";
                list = simpleDao.createNativeQuery(sql, startTime, endTime, polluteName).getResultList();
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
            xObject.put("type", "line");
            xObject.put("name", key);
            if (("风向").equals(key)) {
                xObject.put("symbol", "arrow");
                xObject.put("symbolSize", 9);
                Object[] tempArr = series.get(key);
                for (int i = 0; i < tempArr.length; i++) {
                    if (tempArr[i] != null) {
                        JSONObject temObject = new JSONObject();
                        temObject.put("symbolRotate", BigDecimal.valueOf(180).subtract((BigDecimal) tempArr[i]));
                        temObject.put("value", tempArr[i]);
                        tempArr[i] = temObject;
                    } else {
                        tempArr[i] = "-";
                    }
                }
                xObject.put("data", tempArr);
            } else {
                xObject.put("data", series.get(key));
            }
            xArray.add(xObject);
        }
        result.put("legend", legendList);
        result.put("series", xArray);
        if(ToolUtil.isNotEmpty(xArray)){
            result.putAll(AirSeriesUtil.getSeriesData(xArray, polluteName));
        }
        return result;
    }


}
