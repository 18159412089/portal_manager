package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirDailyService;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static cn.fjzxdz.frame.toolbox.util.DateUtil.getMonthDays;

/**
 * 空气日数据业务实现类
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午3:23:04
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpAirDailyServiceImpl implements ZpAirDailyService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: airAqiForYear</p>
     * <p>Description: 查询一年的AQI指数日报</p>
     *
     * @param time
     * @param pointCode
     * @return
     * @see AirDailyService#airAqiForYear(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> airAqiForYear(String time, String pointCode) {
        StringBuilder sql = new StringBuilder("SELECT  MONITOR_TIME,POINT_NAME,round(AQI) , ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,  ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co,  ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,  ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2  ");
        sql.append(" FROM AIR_DAY_DATA WHERE TO_CHAR(MONITOR_TIME,'yyyy')= ? ");
        sql.append(" AND POINT_CODE = ? GROUP BY MONITOR_TIME,POINT_NAME,AQI ORDER BY MONITOR_TIME ASC");
        List<Object[]> list = simpleDao.createNativeQuery(sql.toString(), time, pointCode).getResultList();
        return list;
    }

    /**
     * <p>Title: getAllAQI</p>
     * <p>Description: 获取该时间里所有城市站点的AQI</p>
     *
     * @param startTime
     * @param citys
     * @return
     * @see AirDailyService#getAllAQI(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAllAQI(String startTime, String citys) {

        String sql = "SELECT DISTINCT POINT_NAME,round(AQI)  FROM AIR_DAY_DATA  WHERE POINT_CODE in" + citys + " and TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') = ? ORDER BY POINT_NAME asc";

        return simpleDao.createNativeQuery(sql, startTime).getResultList();
    }

    /**
     * <p>Title: getAllAQIByTime</p>
     * <p>Description: 获取本年里所有城市站点的AQI</p>
     *
     * @param start
     * @param end
     * @param citys
     * @return
     * @see AirDailyService#getAllAQIByTime(String, String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAllAQIByTime(String start, String end, String citys) {
        String sql = "SELECT DISTINCT POINT_NAME,round(AQI)  FROM AIR_DAY_DATA  WHERE POINT_CODE in" + citys + " and TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') >= ? "
                + "AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') <= ? ORDER BY POINT_NAME asc";
        return simpleDao.createNativeQuery(sql, start, end).getResultList();
    }

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 日报分页查询</p>
     *
     * @param param
     * @param page
     * @return
     * @see AirDailyService#listByPage(AirDayDataParam, Page)
     */
    @Override
    public Page<Map<String, Object>> listByPage(AirDayDataParam param, Page<Map<String, Object>> page) {
        String sql = "SELECT to_Char(MONITOR_TIME,'yyyy-mm-dd') monitorTime, POINT_NAME, AQI,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, "
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO "
                + "FROM AIR_DAY_DATA where POINT_CODE ='" + param.getPointCode() + "'and to_Char(MONITOR_TIME,'yyyy-mm-dd') >= '" + param.getStartTime()
                + "' and  to_Char(MONITOR_TIME,'yyyy-mm-dd') <= '" + param.getEndTime() + "' GROUP BY MONITOR_TIME, POINT_NAME, AQI "
                + "ORDER BY MONITOR_TIME desc";
        Page<Map<String, Object>> list = simpleDao.listNativeByPage(sql, page);
        return list;
    }

    /**
     * <p>Title: getCurAirQuality</p>
     * <p>Description: 空气质量日报信息</p>
     *
     * @param pointCode
     * @param time
     * @return
     * @see AirDailyService#getCurAirQuality(String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getCurAirQuality(String pointCode, String time) {
        StringBuilder sql = new StringBuilder("SELECT TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ),POINT_NAME,AQI, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) Co, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, ");
        sql.append(" sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,sum( ");
        sql.append(" DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2  ");
        sql.append(" FROM AIR_DAY_DATA WHERE POINT_CODE = ?  ");
        sql.append(" AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd')=? ");
        sql.append(" GROUP BY MONITOR_TIME,POINT_NAME,AQI");
        return simpleDao.createNativeQuery(sql.toString(), pointCode, time).getResultList();
    }

    /**
     * <p>Title: getAirQualityChart</p>
     * <p>Description: 本年本地区空气质量状况统计图</p>
     *
     * @param param
     * @return
     * @see AirDailyService#getAirQualityChart(AirDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object[]> getAirQualityChart(AirDayDataParam param) {

        String sql = "SELECT DISTINCT MONITOR_TIME,round(AQI) " +
                "FROM AIR_DAY_DATA WHERE  " +
                "TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ?  " +
                "AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ?  " +
                "AND POINT_CODE = ? ORDER BY MONITOR_TIME ASC";

        List<Object[]> list = simpleDao.createNativeQuery(sql, param.getStartTime(), param.getEndTime(), param.getPointCode()).getResultList();
        return list;
    }

    /**
     * <p>Title: getAllLevelsDays</p>
     * <p>Description: 本地区各级天数 历年比较</p>
     *
     * @param pointCode
     * @param startTime
     * @param endTime
     * @param yearNum
     * @return
     * @see AirDailyService#getAllLevelsDays(String, String, String, String)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getAllLevelsDays(String pointCode, String startTime, String endTime, String yearNum) {
        Map<String, Object> map = new HashMap<String, Object>();
        String sql = "SELECT DISTINCT MONITOR_TIME,round(AQI) FROM AIR_DAY_DATA WHERE POINT_CODE =? and ("
                + getYearSQL(startTime, endTime, Integer.valueOf(yearNum)) + ")order by MONITOR_TIME";
        List<Object[]> list = simpleDao.createNativeQuery(sql, pointCode).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            List<Integer> years = getYearList(endTime, Integer.valueOf(yearNum));
            map.put("years", years);
            JSONArray arr = new JSONArray();
            List<Integer> excellentList = new ArrayList<>();
            List<Integer> goodList = new ArrayList<>();
            List<Integer> otherList = new ArrayList<>();
            for (Integer year : years) {
                int excellent = 0;
                int good = 0;
                int other = 0;
                for (Object[] report : list) {
                    if ((report[0].toString().substring(0, 10)).contains(year.toString())) {
                        if (Integer.valueOf(report[1].toString()) >= 0 && Integer.valueOf(report[1].toString()) <= 50) {
                            excellent++;
                        } else if (Integer.valueOf(report[1].toString()) <= 100) {
                            good++;
                        } else {
                            other++;
                        }
                    }
                }
                excellentList.add(excellent);
                goodList.add(good);
                otherList.add(other);
            }
            JSONObject excellentJson = new JSONObject();
            excellentJson.put("name", "优天数");
            excellentJson.put("type", "line");
            excellentJson.put("symbol", "circle");
            excellentJson.put("symbolSize", 6);
            excellentJson.put("itemStyle", JSONObject.parse("{normal: {color: '#2da5e9'}}"));
            excellentJson.put("data", excellentList);
            arr.add(excellentJson);
            JSONObject goodJson = new JSONObject();
            goodJson.put("name", "良天数");
            goodJson.put("type", "line");
            goodJson.put("symbol", "rect");
            goodJson.put("symbolSize", 6);
            goodJson.put("itemStyle", JSONObject.parse("{normal: {color: '#95db99'}}"));
            goodJson.put("data", goodList);
            arr.add(goodJson);
            ;
            JSONObject otherJson = new JSONObject();
            otherJson.put("name", "劣于二级天数");
            otherJson.put("type", "line");
            otherJson.put("symbol", "roundRect");
            otherJson.put("symbolSize", 6);
            otherJson.put("itemStyle", JSONObject.parse("{normal: {color: '#fe8a57'}}"));
            otherJson.put("data", otherList);
            arr.add(otherJson);
            map.put("series", arr);
            return map;
        }
        return null;
    }

    private List<Integer> getYearList(String date, int num) {
        List<Integer> years = new ArrayList<>();
        Integer year = Integer.parseInt(date.substring(0, 4));
        for (int i = year - num + 1; i <= year; i++) {
            years.add(i);
        }
        return years;
    }

    private String getYearSQL(String startDate, String endDate, int num) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String sql = "";
        for (int i = 0; i < num; i++) {
            Calendar start = Calendar.getInstance();
            Calendar end = Calendar.getInstance();
            try {
                start.setTime(sdf.parse(startDate));
                end.setTime(sdf.parse(endDate));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            start.add(Calendar.YEAR, -i);
            end.add(Calendar.YEAR, -i);
            if (i == 0) {
                sql = sql + "(to_char(MONITOR_TIME,'yyyy-MM-dd')>='" + sdf.format(start.getTime()) + "' and to_char(MONITOR_TIME,'yyyy-MM-dd')<='" + sdf.format(end.getTime()) + "')";
            } else {
                sql = sql + " or (to_char(MONITOR_TIME,'yyyy-MM-dd')>='" + sdf.format(start.getTime()) + "' and to_char(MONITOR_TIME,'yyyy-MM-dd')<='" + sdf.format(end.getTime()) + "')";
            }
        }
        return sql;
    }


    @Override
    @SuppressWarnings("unchecked")
    public JSONArray getAllLevelsDaysForm(String pointCode, String startTime, String endTime, String yearNum) {

        String sql = "SELECT DISTINCT MONITOR_TIME,round(AQI),POINT_NAME FROM AIR_DAY_DATA WHERE POINT_CODE =? and ("
                + getYearSQL(startTime, endTime, Integer.valueOf(yearNum)) + ")order by MONITOR_TIME";
        List<Object[]> list = simpleDao.createNativeQuery(sql, pointCode).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            List<Integer> years = getYearList(startTime, Integer.valueOf(yearNum));
            JSONArray arr = new JSONArray();
            for (Integer year : years) {
                JSONObject temp = new JSONObject();
                temp.put("year", year);
                temp.put("adArea", list.get(0)[2]);
                temp.put("timeRange", year + startTime.substring(4, startTime.length())
                        + " ~ " + year + endTime.substring(4, endTime.length()));
                int excellent = 0;
                int good = 0;
                int other = 0;
                int sum = 0;
                int aqi = 0;
                for (Object[] report : list) {
                    if (report[0].toString().substring(0, 10).contains(year.toString())) {
                        if (Integer.valueOf(report[1].toString()) >= 0 && Integer.valueOf(report[1].toString()) <= 50) {
                            excellent++;
                            sum++;
                        } else if (Integer.valueOf(report[1].toString()) <= 100) {
                            good++;
                            sum++;
                        } else {
                            other++;
                            sum++;
                        }
                        if (Integer.parseInt(report[1].toString()) > 300) {
                            aqi++;
                        }
                    }
                }
                temp.put("efDays", sum);
                temp.put("eclDays", excellent);
                temp.put("goodDays", good);
                if (sum == 0) {
                    temp.put("ratio", "");
                } else {
                    temp.put("ratio", numDivideFormat(excellent + good, sum));
                }
                temp.put("lowerDays", other);
                temp.put("aqi300", aqi);
                arr.add(temp);
            }
            return arr;
        }
        return null;
    }


    /**
     * <p>Title: getPollutantGroupBy</p>
     * <p>Description: 本地区首要污染物天数构成</p>
     *
     * @param param
     * @return
     * @see AirDailyService#getPollutantGroupBy(AirDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPollutantGroupBy(AirDayDataParam param) {

        int day = 0;
        int pm25 = 0;
        int pm10 = 0;
        int CO = 0;
        int NO2 = 0;
        int O3 = 0;
        int SO2 = 0;

        String sql = " SELECT  MONITOR_TIME,round(AQI), " +
                "	sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " +
                "	sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " +
                "	sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, " +
                "	sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " +
                "	sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, " +
                "	sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 " +
                "	FROM  AIR_DAY_DATA WHERE POINT_CODE = ? AND " +
                "	TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ?  " +
                "	AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ?  " +
                "	GROUP BY MONITOR_TIME,AQI ORDER BY MONITOR_TIME ASC";
        List<Object[]> list = simpleDao.createNativeQuery(sql, param.getPointCode(), param.getStartTime(), param.getEndTime()).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            Map<String, Object> map = new HashMap<>();
            List<String> columnList = new ArrayList<>();
            JSONArray data = new JSONArray();
            for (int i = 0; i < list.size(); i++) {
                Object[] temp = list.get(i);

                if (temp[1] != null) {
                    if (Integer.valueOf(temp[1].toString()) <= 50) {
                        //tempJSON.put("name", "无首要污染物");
                        day++;
                    } else {
                        Aqi aq = AqiUtil.CountAqi(Integer.valueOf(temp[2].toString()), Integer.valueOf(temp[3].toString()),
                                Double.valueOf(temp[4].toString()), Double.valueOf(temp[5].toString()), Double.valueOf(temp[6].toString()), Double.valueOf(temp[7].toString()));
                        if ("PM2.5".equals(aq.getName())) {
                            pm25++;
                        } else if ("PM10".equals(aq.getName())) {
                            pm10++;
                        } else if ("CO".equals(aq.getName())) {
                            CO++;
                        } else if ("NO2".equals(aq.getName())) {
                            NO2++;
                        } else if ("O3".equals(aq.getName())) {
                            O3++;
                        } else if ("SO2".equals(aq.getName())) {
                            SO2++;
                        }

                    }

                }

            }
            columnList.add("无首要污染物");
            columnList.add("PM10");
            columnList.add("PM2.5");

            columnList.add("CO");
            columnList.add("NO2");
            columnList.add("O3");
            columnList.add("SO2");
            JSONObject tempJSON = new JSONObject();
            tempJSON.put("name", "无首要污染物");
            tempJSON.put("value", day);
            data.add(tempJSON);

            JSONObject pm10Object = new JSONObject();
            pm10Object.put("name", "PM10");
            pm10Object.put("value", pm10);
            data.add(pm10Object);
            JSONObject pm2Object = new JSONObject();
            pm2Object.put("name", "PM2.5");
            pm2Object.put("value", pm25);
            data.add(pm2Object);
            JSONObject coObject = new JSONObject();
            coObject.put("name", "CO");
            coObject.put("value", CO);
            data.add(coObject);
            JSONObject no2Object = new JSONObject();
            no2Object.put("name", "NO2");
            no2Object.put("value", NO2);
            data.add(no2Object);
            JSONObject o3Object = new JSONObject();
            o3Object.put("name", "O3");
            o3Object.put("value", O3);
            data.add(o3Object);
            JSONObject so2Object = new JSONObject();
            so2Object.put("name", "SO2");
            so2Object.put("value", SO2);
            data.add(so2Object);

            map.put("columns", columnList);
            map.put("data", data);
            return map;
        }
        return null;
    }

    /**
     * <p>Title: getPollutantPassYear</p>
     * <p>Description: 首要污染物天数变化</p>
     *
     * @param param
     * @return
     * @see AirDailyService#getPollutantPassYear(AirDayDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPollutantPassYear(AirDayDataParam param) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<String> names = new ArrayList<>();
        names.add("PM2.5");
        names.add("PM10");
        names.add("CO");
        names.add("NO2");
        names.add("O3");
        names.add("SO2");
        map.put("names", names);
        List<Integer> years = getYearList(param.getEndTime(), param.getYearNum());
        map.put("years", years);
        String sql = "SELECT MONITOR_TIME,sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25,  " +
                "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,  " +
                "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2,round(AQI) " +
                "FROM  AIR_DAY_DATA WHERE POINT_CODE = ? and(" + getYearSQL(param.getStartTime(), param.getEndTime(), param.getYearNum()) +
                ") GROUP BY MONITOR_TIME,AQI  ORDER BY MONITOR_TIME ASC";
        List<Object[]> list = simpleDao.createNativeQuery(sql, param.getPointCode()).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray seriesArr = new JSONArray();
            for (String name : names) {
                JSONObject tempJSON = new JSONObject();
                List<Integer> temp = new ArrayList<>();
                for (Integer year : years) {
                    int sum = 0;
                    for (Object[] report : list) {
                        if (report[0].toString().substring(0, 4).equals(year.toString())) {
                            Aqi aq = AqiUtil.CountAqi(Integer.valueOf(report[1].toString()), Integer.valueOf(report[2].toString()),
                                    Double.valueOf(report[3].toString()), Double.valueOf(report[4].toString()), Double.valueOf(report[5].toString()), Double.valueOf(report[6].toString()));
                            if (aq.getName().equals(name) && Integer.valueOf(report[7].toString()) > 50) {
                                sum++;
                            }
                        }

                    }
                    temp.add(sum);
                }

                tempJSON.put("name", name);
                tempJSON.put("type", "line");
                tempJSON.put("symbolSize", 6);
                tempJSON.put("smooth", true);
                tempJSON.put("data", temp);
                seriesArr.add(tempJSON);
            }
            map.put("series", seriesArr);
            return map;
        }

        return null;
    }

    /**
     * <p>Title: getPollutantPassYear</p>
     * <p>Description: 历年本地区首要污染物信息</p>
     *
     * @param param
     * @param page
     * @return
     * @see AirDailyService#getPollutantPassYear(AirDayDataParam, Page)
     */
    @SuppressWarnings({"unchecked", "unused"})
    @Override
    public JSONArray getPollutantPassYear(AirDayDataParam param, Page<Map<String, Object>> page) {
        String sql = "SELECT MONITOR_TIME,POINT_NAME,sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25,  " +
                "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2,  " +
                "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3,  " +
                "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2,round(AQI)  " +
                "FROM  AIR_DAY_DATA WHERE POINT_CODE = ? and(" + getYearSQL(param.getStartTime(), param.getEndTime(), param.getYearNum()) +
                ") GROUP BY MONITOR_TIME,POINT_NAME,AQI  ORDER BY MONITOR_TIME ASC";
        List<Object[]> list = simpleDao.createNativeQuery(sql, param.getPointCode()).getResultList();
        List<String> names = new ArrayList<>();
        names.add("PM2.5");
        names.add("PM10");
        names.add("CO");
        names.add("NO2");
        names.add("O3");
        names.add("SO2");
        List<Integer> years = getYearList(param.getEndTime(), param.getYearNum());

        if (ToolUtil.isNotEmpty(list)) {
            JSONArray arr = new JSONArray();
            for (Integer year : years) {
                JSONObject tempJSON = new JSONObject();
                tempJSON.put("year", year);
                tempJSON.put("adArea", list.get(0)[1]);
                tempJSON.put("efDays", year + param.getStartTime().substring(4, param.getStartTime().length())
                        + " ~ " + year + param.getEndTime().substring(4, param.getEndTime().length()));
                for (String name : names) {
                    int sum = 0;
                    int noneDays = 0;
                    for (Object[] report : list) {
                        if (report[0].toString().substring(0, 4).equals(year.toString())) {
                            Aqi aq = AqiUtil.CountAqi(Integer.valueOf(report[2].toString()), Integer.valueOf(report[3].toString()),
                                    Double.valueOf(report[4].toString()), Double.valueOf(report[5].toString()), Double.valueOf(report[6].toString()), Double.valueOf(report[7].toString()));
                            if (Integer.valueOf(report[8].toString()) <= 50) {
                                noneDays++;
                            } else if (aq.getName().equals(name)) {
                                sum++;
                            }


                        }

                    }
                    tempJSON.put(name.replace(".", ""), sum);
                    tempJSON.put("noneDays", noneDays);
                }
                arr.add(tempJSON);
            }
            return arr;
        }
        return null;
    }

    /**
     * @param numerator
     * @param denominator
     * @return String
     * @throws
     * @Title: numDivideFormat
     * @Description: 保留两位小数
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:29:21
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:29:21
     */
    public String numDivideFormat(int numerator, int denominator) {
        float numeratorf = numerator;//转换成浮点型
        float denominatorf = denominator;
        NumberFormat nt = NumberFormat.getPercentInstance();//获取百分数实例
        nt.setMinimumFractionDigits(2);
        return nt.format(numeratorf / denominatorf);//得到结果
    }

    /***
     * @Title: 通过时间查询空气质量数据(页面index6)根据数据的时间
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/25 16:55
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/25 16:55
     * @param param pointType为国控省控和自建0国1省2自
     * @param page
     * @return cn.fjzxdz.frame.common.Page<java.util.Map < java.lang.String, java.lang.Object>>
     */
    public Page<Map<String, Object>> listSearchAirPageByTime(AirDayDataParam param, String TimeType, String pointType, Page<Map<String, Object>> page) {
        String timeBySearche = getTimeBySearche(TimeType);
        String sql = "SELECT to_Char(MONITOR_TIME,'yyyy-mm-dd') monitorTime, POINT_NAME, AQI,"
                + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, "
                + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
                + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2, sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO "
                + "FROM AIR_DAY_DATA INNER JOIN AIR_MONITOR_POINT ON AIR_DAY_DATA.POINT_CODE=AIR_MONITOR_POINT.POINT_CODE where AIR_MONITOR_POINT.PONITTYPE='" + pointType + "'  rownum <= '3' AND POINT_CODE ='" + param.getPointCode() + "'and to_Char(MONITOR_TIME,'" + timeBySearche + "') >= '" + param.getStartTime()
                + "' and  to_Char(MONITOR_TIME,'" + timeBySearche + "') <= '" + param.getEndTime() + "' GROUP BY MONITOR_TIME, POINT_NAME, AQI "
                + "ORDER BY MONITOR_TIME desc ";
        Page<Map<String, Object>> list = simpleDao.listNativeByPage(sql, page);
        return list;
    }

    /*
     * @Title:  根据查询条件获取查询的时间是什么
     * @Description:    (根据传入的时间来判断如果是年 选择月选择日选择的处理情况)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/25 17:23
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/25 17:23
     * @param timeType时间类型
     * @return java.lang.String
     */
    public String getTimeBySearche(String TimeType) {
        if (StringUtils.isBlank(TimeType))
            return "yyyy-mm-dd hh24";
        if (TimeType.equals("year")) {
            return "yyyy";
        } else if (TimeType.equals("month")) {
            return "yyyy-mm";
        } else if (TimeType.equals("day")) {
            return "yyyy-mm-dd";
        } else if (TimeType.equals("hour")) {
            return "yyyy-mm-dd hh24";
        }
        return "yyyy-mm-dd hh24";
    }

    /*
     * @Title:  获取前三的aqi数据就是说aqi最小的三个数据
     * @Description:    (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/25 17:45
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/25 17:45
     * @param rankType(如果为front(靠前的数据) AQI就是最低的三条数据leanback为靠后的三条数据
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.String>>
     */
    @Override
    public List<Map<String, Object>> getAQIDataRank(AirDayDataParam param, String sort, String timeType, String pointType) {
        String orderBy = null;
        String where = getSearchWhere(param, timeType, pointType);
        String table = " AIR_DAY_DATA a";
        String tablePoint = " a.POINT_CODE ";
        if (StringUtils.isBlank(pointType))
            pointType = "0";
        if (StringUtils.isNotBlank(sort) && sort.equals("front")) {
            orderBy = " ORDER BY AQI  ASC nulls last ";//升序从小到大
        } else {
            orderBy = " ORDER BY AQI DESC nulls last ";//从大到小;
        }
        if (StringUtils.isNotBlank(timeType) && timeType.equals("hour")) {
            table = " AIR_HOUR_DATA a ";
            tablePoint = " a.POINT_CODE ";
        }
        String sql = "select Round(AVG(AQI)) aqi  ,round(avg(NO2)) NO2,round(avg(O3)) O3,round(avg(PM10)) PM10,round(avg(PM25)) PM25,round(avg(SO2)) SO2,round(avg(CO),1) CO,POINT_CODE,POINT_NAME,REGION_NAME from(SELECT  a.REGION_NAME, a.POINT_NAME,a.POINT_CODE,to_Char(a.MONITOR_TIME," + SqlUtil.toSqlStr(getTimeBySearche(timeType)) + ") MONITOR_TIME,   avg(AQI)  AQI,"
                + "sum(DECODE( a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0 )) NO2, sum(DECODE( a.CODE_POLLUTE, 'A050248', a.AVERVALUE, 0 )) O3, "
                + "sum(DECODE( a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0 )) PM10, sum(DECODE( a.CODE_POLLUTE, 'A34004', a.AVERVALUE, 0 )) PM25, "
                + "sum(DECODE( a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0 )) SO2, sum(DECODE( a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0 )) CO "
                + "FROM  " + table + " inner join air_monitor_point b on b.POINT_CODE= " + tablePoint + where + " and b.POINT_TYPE=" + SqlUtil.toSqlStr(pointType) + " and a.aqi>2 "
                + " GROUP BY a.POINT_NAME, a.REGION_NAME,a.POINT_CODE,MONITOR_TIME ) group by  POINT_CODE,POINT_NAME ,REGION_NAME " + orderBy;
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sql);
        for (Map<String, Object> data : nativeQueryList) {
            Aqi aq = AqiUtil.CountAqi(Integer.valueOf(data.get("pm25").toString()), Integer.valueOf(data.get("pm10").toString()), Double.valueOf(data.get("co").toString()), Double.valueOf(data.get("no2").toString()), Double.valueOf(data.get("o3").toString()), Double.valueOf(data.get("so2").toString()));
            data.put("major", aq.getName());
        }
        return nativeQueryList;
    }

    /**
     * @param param
     * @param sort
     * @param timeType
     * @param pointType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @Title: 获取水环境aqi的echart图
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/27 9:26
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/27 9:26
     */
    @Override
    public Map<String, Object> getAQIEchart(AirDayDataParam param, String sort, String timeType, String pointType) {
        String orderBy = null;
        String where = getSearchWhere(param, timeType, pointType);
        String table = " AIR_DAY_DATA a";
        String tablePoint = " a.POINT_CODE ";
        if (StringUtils.isBlank(pointType))
            pointType = "0";
        if (StringUtils.isNotBlank(sort) && sort.equals("front")) {
            orderBy = " ORDER BY AQI DESC ";//从小到大
        } else {
            orderBy = " ORDER BY AQI  ASC ";//从大到小
        }
        if (StringUtils.isNotBlank(timeType) && timeType.equals("hour")) {
            table = " AIR_HOUR_DATA a ";
            tablePoint = "a.POINT_CODE";
        }
        Map<String, Object> resultMap = new HashMap<>();
        String sql = "SELECT a.POINT_NAME,a.point_code, ROUND(avg(AQI),0) AQI "
                + "FROM  " + table + " inner join air_monitor_point b on b.POINT_CODE=" + tablePoint + where + " and b.POINT_TYPE=" + pointType + " and AQI>2 "
                + " GROUP BY a.POINT_NAME,a.point_code "
                + orderBy;
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sql);
        List aqiList = new ArrayList();
        List pointName = new ArrayList();
        List colorList = new ArrayList();
        //装入两个数组;一个是名称,一个是aqi值
        for (Map<String, Object> dataMap : nativeQueryList) {
            aqiList.add(dataMap.get("aqi"));
            pointName.add(dataMap.get("pointName"));
            colorList.add(getAQIColorList((BigDecimal) dataMap.get("aqi")));
        }
        resultMap.put("aqi", aqiList);
        resultMap.put("pointName", pointName);
        resultMap.put("colorList", colorList);
        return resultMap;
    }

    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param page
     * @param response
     * @return cn.fjzxdz.frame.common.Page<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title:
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/4 15:21
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/4 15:21
     */
    @Override
    public Page<Map<String, Object>> getTextAQIByPointName(AirDayDataParam param, String factor, String pointType, String timeType, Page<Map<String, Object>> page, HttpServletResponse response) {
        String orderBy = "";
        String resultsql = "";
        String where = getSearchWhere(param, timeType, pointType);
        String table = " AIR_DAY_DATA a";
        String tablePoint = " a.POINT_CODE ";
        if (StringUtils.isBlank(pointType))
            pointType = "0";
        if (StringUtils.isNotBlank(timeType) && timeType.equals("hour")) {
            table = " AIR_HOUR_DATA a ";
            tablePoint = "a.POINT_CODE";
        }
        String oldSql = "SELECT a.POINT_NAME, ROUND(avg(AQI)) AQI,a.CODE_REGION,a.REGION_NAME,a.point_code "
                + "FROM  " + table + " inner join air_monitor_point b on b.POINT_CODE=" + tablePoint + where + " and b.POINT_TYPE=" + pointType
                + " GROUP BY a.POINT_NAME,a.CODE_REGION,a.REGION_NAME,a.point_code ";
        resultsql = "Select d.*,c.countDay from(" + oldSql + ") d join " + getEffectiveDayNum(param, timeType, "pointName").toString() + " on c.point_name=d.point_name order by d.aqi";
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(resultsql);
            return exportExlAQIByPointname(response, list, param.getExportTitle(), param, factor);
        }
        return simpleDao.listNativeByPage(resultsql, page);
    }

    /**
     * aqi因子分析导出excel
     *
     * @param response    相应参数
     * @param list        导出的list
     * @param exportTitle 导出excel的表头
     * @param param       查询参数
     * @return 2019年7月4日09:34:22
     */
    private Page<Map<String, Object>> exportExlAQIByPointname(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle, AirDayDataParam param, String factor) {
        int i = 1;
        for (Map<String, Object> map : list) {
            map.put("pm", i);
            if ("day".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime() + "~" + param.getEndTime());
            }
            if ("month".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 7) + "~" + param.getEndTime().substring(0, 7));
            }
            if ("year".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 4) + "~" + param.getEndTime().substring(0, 4));
            }
            i++;
        }
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("pm", "排名");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionName", "地区名称");
        columnMap.put("pointName", "站点名称");
        columnMap.put("aqi", "综合指数");
        columnMap.put("countday", "有效监测天数");
        columnMap.put("codeRegion", "地区编码");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    public String getSearchWhere(AirDayDataParam param, String timeType, String pointType) {
        String where = " where 1=1";
        String timeBySearche = getTimeBySearche(timeType);
        if (!"topAndBottom".equals(param.getExportTitle())) {
            if (StringUtils.isNotBlank(param.getPointCode())) {
                where += " AND a.POINT_CODE in ('" + param.getPointCode() + "')";
            }
            if (StringUtils.isNotBlank(param.getCodeRegion())) {
                where += " AND   SUBSTR(a.CODE_REGION, 1, 6) IN (" + SqlUtil.toSqlStr(param.getCodeRegion()) + ")";
            }
        }
        if (StringUtils.isNotBlank(param.getStartTime()) && StringUtils.isNotBlank(timeType)) {
            if (timeType.equals("hour")) {
                param.setStartTime(param.getStartTime() + " 00:00:00");
            } else if (timeType.equals("year")) {
                param.setStartTime(param.getStartTime().substring(0, 4));
            } else if (timeType.equals("month")) {
                param.setStartTime(param.getStartTime().substring(0, 7));
            }
            where += " and to_Char(MONITOR_TIME,'" + timeBySearche + "') >= " + SqlUtil.toSqlStr(param.getStartTime());
        }
        if (StringUtils.isNotBlank(param.getEndTime()) && StringUtils.isNotBlank(timeType)) {
            if (timeType.equals("hour")) {
                param.setEndTime(param.getEndTime() + " 23:59:59");
            } else if (timeType.equals("year")) {
                param.setEndTime(param.getEndTime().substring(0, 4));
            } else if (timeType.equals("month")) {
                param.setEndTime(param.getEndTime().substring(0, 7));
            }
            where += " and  to_Char(MONITOR_TIME,'" + timeBySearche + "') <= " + SqlUtil.toSqlStr(param.getEndTime());
        }
        return where;
    }

    /*
     * @Title:
     * @Description:    (根据aqi值来进行柱状图颜色的处理)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/27 16:22
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/27 16:22
     * @param oldAqi传入的aqi值
     * @return
     * [优：#00E400，良：#FFFF00，轻度：#FF7E00，中度：#FF0000，重度：#99004C，严重：#7E0023，暂无数据：#B8B8B8
     */

    public String getAQIColorList(BigDecimal oldAqi) {
        if (oldAqi == null) return "#B8B8B8";
        int aqi = oldAqi.intValue();
        if (aqi >= 0 && aqi <= 50) {
            return "#00E400";
        } else if (aqi > 50 && aqi <= 100) {
            return "#FFFF00";
        } else if (aqi > 100 && aqi <= 150) {
            return "#FF7E00";
        } else if (aqi > 150 && aqi <= 200) {
            return "#FF0000";
        } else if (aqi > 200 && aqi <= 250) {
            return "#99004C";
        } else if (aqi > 250 && aqi <= 300) {
            return "#7E0023";
        } else {
            return "#B8B8B8";
        }
    }

    /**
     * 均值比较 大气 echart
     *
     * @param param 查询参数
     * @return
     */
    public Map<String, Object> getAirMeanEchart(AirDayDataParam param) {
        String where = getSearchWhere(param, param.getStart(), param.getPointType());//start表示timeType
        Map<String, Object> resultMap = new HashMap<>();
        StringBuilder sql = new StringBuilder();
        sql.append("  select REGION_NAME, ");
        sql.append("  POINT_CODE, ");
        sql.append("  POINT_NAME, ");
        sql.append("  count(POINT_CODE) efDay, ");
        if ("CO".equals(param.getEnd())) {
            sql.append("  round(avg(AQI),1)   AQI ");//这里用end装因子类型
        } else {
            sql.append("  round(avg(AQI))   AQI ");//这里用end装因子类型
        }
        sql.append("  from (SELECT a.REGION_NAME, ");
        sql.append(" to_Char(a.MONITOR_TIME," + SqlUtil.toSqlStr(getTimeBySearche(param.getStart())) + ") MONITOR_TIME, ");
        sql.append("  a.POINT_CODE, ");
        sql.append("  a.POINT_NAME, ");
        sql.append(getSqlByType(param.getEnd()));//这里用end装因子类型
        if (StringUtils.isNotEmpty(param.getPointType())) {
            sql.append("  FROM AIR_DAY_DATA a ");
        } else {
            sql.append("  FROM AIR_HOUR_DATA a ");
        }
        sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE   ");
        if (StringUtils.isNotEmpty(param.getPointType()) && !"null".equals(param.getPointType())) {
            sql.append(" AND B.POINT_TYPE =  ").append(SqlUtil.toSqlStr(param.getPointType()));
        } else {
            sql.append("  and a.REGION_NAME in ('龙文区', '芗城区') ");
        }
        sql.append(where);
        sql.append("  GROUP BY a.REGION_NAME,MONITOR_TIME,a.POINT_CODE, a.POINT_NAME ");
        sql.append("  ) ");
        sql.append("  group by REGION_NAME,POINT_CODE, POINT_NAME ");
        sql.append(" order by AQI ");

        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sql.toString());
        if ("topAndBottom".equals(param.getExportTitle())) {
            resultMap.put("topAndBottom", nativeQueryList);
            return resultMap;
        }
        List aqiList = new ArrayList();
        List pointName = new ArrayList();
        List colorList = new ArrayList();
        //装入两个数组;一个是名称,一个是aqi值
        for (Map<String, Object> dataMap : nativeQueryList) {
            aqiList.add(dataMap.get("aqi"));
            pointName.add(dataMap.get("pointName"));
            colorList.add(getAQIColorList((BigDecimal) dataMap.get("aqi")));
        }
        resultMap.put("aqi", aqiList);
        resultMap.put("pointName", pointName);
        resultMap.put("colorList", colorList);
        return resultMap;
    }

    /**
     * 均值比较 大气 表格
     *
     * @param param    查询参数
     * @param page     分页
     * @param response
     * @return
     */
    public Page<Map<String, Object>> getAirMeanEchartPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        String where = getSearchWhere(param, param.getStart(), param.getPointType());//start表示timeType
        StringBuilder sql = new StringBuilder();
        sql.append("  select REGION_NAME, ");
        sql.append("  POINT_CODE, ");
        sql.append("  POINT_NAME, ");
        sql.append("  count(POINT_CODE) efDay, ");
        if ("CO".equals(param.getEnd())) {
            sql.append("  round(avg(AQI),1)   AQI ");//这里用end装因子类型
        } else {
            sql.append("  round(avg(AQI))   AQI ");//这里用end装因子类型
        }
        sql.append("  from (SELECT a.REGION_NAME, ");
        sql.append(" to_Char(a.MONITOR_TIME," + SqlUtil.toSqlStr(getTimeBySearche(param.getStart())) + ") MONITOR_TIME, ");
        sql.append("  a.POINT_CODE, ");
        sql.append("  a.POINT_NAME, ");
        sql.append(getSqlByType(param.getEnd()));//这里用end装因子类型
        if (StringUtils.isNotEmpty(param.getPointType())) {
            sql.append("  FROM AIR_DAY_DATA a ");
        } else {
            sql.append("  FROM AIR_HOUR_DATA a ");
        }
        sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE  ");
        if (StringUtils.isNotEmpty(param.getPointType()) && !"null".equals(param.getPointType())) {
            sql.append(" AND B.POINT_TYPE =  ").append(SqlUtil.toSqlStr(param.getPointType()));
        } else {
            sql.append("  and a.REGION_NAME in ('龙文区', '芗城区') ");
        }
        sql.append(where);
        sql.append("  GROUP BY a.REGION_NAME,MONITOR_TIME,a.POINT_CODE, a.POINT_NAME ");
        sql.append("  ) ");
        sql.append("  group by REGION_NAME,POINT_CODE, POINT_NAME ");
        sql.append(" order by AQI ");
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(sql.toString());
            return exportExlAirMean(response, list, param.getExportTitle(), param);
        }
        return simpleDao.listNativeByPage(sql.toString(), page);
    }

    /**
     * 导出excel 均值比较
     *
     * @param response    相应参数
     * @param list        导出的list
     * @param exportTitle 导出excel的表头
     * @param param       查询参数
     * @return 2019年7月4日09:34:22
     */
    private Page<Map<String, Object>> exportExlAirMean(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle, AirDayDataParam param) {
        int i = 1;
        for (Map<String, Object> map : list) {
            map.put("pm", i);
            if ("day".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime() + "~" + param.getEndTime());
            }
            if ("month".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 7) + "~" + param.getEndTime().substring(0, 7));
            }
            if ("year".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 4) + "~" + param.getEndTime().substring(0, 4));
            }
            i++;
        }
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("pm", "排名");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionName", "地区");
        columnMap.put("pointName", "监测站点");
        columnMap.put("aqi", "均值");
        columnMap.put("efday", "有效监测天数");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /**
     * 通过因子类型统计因子
     *
     * @param type 因子类型
     * @return sum(DECODE ( a.CODE_POLLUTE, ' A21004 ', a.AVERVALUE, 0))  AQI 统计sql 为了方便，别名统一aqi
     * @author huangyl
     */
    private String getSqlByType(String type) {
        // 基本类型
        switch (type) {
            case "NO2":
                return " sum(DECODE(a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0))  AQI";
            case "O38":
                return " sum(DECODE(a.CODE_POLLUTE, 'A050248', a.AVERVALUE, 0)) AQI";
            case "PM10":
                return " sum(DECODE(a.CODE_POLLUTE, 'A34002', a.AVERVALUE, 0))  AQI";
            case "PM25":
                return " sum(DECODE(a.CODE_POLLUTE, 'A34004', a.AVERVALUE, 0))  AQI";
            case "SO2":
                return " sum(DECODE(a.CODE_POLLUTE, 'A21026', a.AVERVALUE, 0))  AQI";
            case "CO":
                return " sum(DECODE(a.CODE_POLLUTE, 'A21005', a.AVERVALUE, 0))  AQI";
            default:
                return " sum(DECODE(a.CODE_POLLUTE, 'A21004', a.AVERVALUE, 0))  AQI ";
        }
    }

    /*
     * @Title:
     * @Description:    (根据条件因子查询数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 13:18
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 13:18
     * @param param
     * @param factor(条件因子co,co2......)
     * @param pointType
     * @param timeType
     * @return java.lang.String
     */
    public String getFactorDataByRegionName(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        //如果时间为hour就取小时数据
        pointType = "1";
        StringBuilder sqlBuilder = new StringBuilder();
        String sqlByType = getSqlByType(factor);
        if (factor.equals("CO")) {
            sqlBuilder.append("Select Round(AVG(aqi),1) AQI,regionName from (");
        } else {
            sqlBuilder.append("Select Round(AVG(aqi),0) AQI,regionName from(");
        }
        sqlBuilder.append("Select a.point_name regionName , ");
        sqlBuilder.append(sqlByType);
        StringBuilder preSelectSql = getPreSelectSql(param, timeType, pointType);
        preSelectSql.append(" group by a.point_name,a.MONITOR_TIME");
        sqlBuilder.append(preSelectSql);
        sqlBuilder.append(" ) group by regionName");
        sqlBuilder.append(" order by AQI");
        if (StringUtils.isNotBlank(sort) && sort.equals("front")) {
            sqlBuilder.append(" ASC NULLS LAST ");
        } else {
            sqlBuilder.append(" DESC NULLS LAST ");
        }
        return sqlBuilder.toString();
    }

    /**
     * @param param     类型参数(空气类的类型参数)
     * @param timeType
     * @param pointType
     * @return java.lang.StringBuilder
     * @Title: 查询因子的查询语句获取
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 13:52
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 13:52    @param  preSelectSQL查询因子的前半段语句select * from
     */
    public StringBuilder getPreSelectSql(AirDayDataParam param, String timeType, String pointType) {
        StringBuilder stringBuilder = new StringBuilder();
        String table = (StringUtils.isNotBlank(timeType) && timeType.equals("hour")) ? " AIR_HOUR_DATA a " : " AIR_DAY_DATA a ";
        String where = getSearchWhere(param, timeType, pointType);
        stringBuilder.append(" from ");
        stringBuilder.append(table);
        stringBuilder.append(" inner join air_monitor_point b on b.POINT_CODE=a.POINT_CODE ");
        stringBuilder.append(where);
        stringBuilder.append(" and b.POINT_TYPE=");
        stringBuilder.append(pointType);
        return stringBuilder;
    }

    /*
     * @Title:
     * @Description:    (城市因子获取可以使用的数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/28 17:08
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/28 17:08
     * @param param
     * @param factor(条件因子
     * @param pointType自建还是省控0省控2自建
     * @param timeType时间类型
     * @param groupBy 根据什么进行分类的
     * @param orderBy根据什么进行排序
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    @Override
    public Map<String, Object> getEchartFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType) {
        String sql = getFactorDataByRegionName(param, factor, pointType, timeType, "front");//默认排序从小到大
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sql);
        List factorList = new ArrayList();
        List regionNameList = new ArrayList();
        List colorList = new ArrayList();
        for (Map<String, Object> dataMap : nativeQueryList) {
            factorList.add(dataMap.get("aqi"));
            regionNameList.add(dataMap.get("regionname"));
            colorList.add(getAQIColorList((BigDecimal) dataMap.get("aqi")));
        }
        resultMap.put("factor", factorList);
        resultMap.put("regionName", regionNameList);
        resultMap.put("colorList", colorList);
        return resultMap;
    }

    /*
     * @Title:
     * @Description:    (城市各因子平均值分析)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/5 13:33
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/5 13:33
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param page
     * @param response
     * @return cn.fjzxdz.frame.common.Page<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @Override
    public Page<Map<String, Object>> getTextFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType, Page<Map<String, Object>> page, HttpServletResponse response) {
        String sql = getFactorDataByRegionName(param, factor, pointType, timeType, "front");
        int index = sql.lastIndexOf("order");
        String result = sql.substring(0, index);
        String resultsql = "";
        resultsql += "Select d.*,c.countDay from(" + result + ") d join " + getEffectiveDayNum(param, timeType, "regionName").toString() + " on c.region_name=d.regionName order by d.aqi";
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(resultsql);
            return exportExlFactorByRegionName(response, list, param.getExportTitle(), param, factor);
        }

        return simpleDao.listNativeByPage(resultsql, page);
    }

    /**
     * 城市各因子分析情况导出
     *
     * @param response    相应参数
     * @param list        导出的list
     * @param exportTitle 导出excel的表头
     * @param param       查询参数
     * @return 2019年7月4日09:34:22
     */
    private Page<Map<String, Object>> exportExlFactorByRegionName(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle, AirDayDataParam param, String factor) {
        int i = 1;
        for (Map<String, Object> map : list) {
            map.put("pm", i);
            if ("day".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime() + "~" + param.getEndTime());
            }
            if ("month".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 7) + "~" + param.getEndTime().substring(0, 7));
            }
            if ("year".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 4) + "~" + param.getEndTime().substring(0, 4));
            }
            i++;
        }
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("pm", "排名");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionname", "地区名称");
        columnMap.put("aqi", factor + "平均值");
        columnMap.put("countday", "有效监测天数");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /*
     * @Title:
     * @Description:    (获取根据城市来进行获取个各因子的数据进行排名)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 10:30
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 10:30
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @Override
    public List<Map<String, Object>> getRankFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        String sql = getFactorDataByRegionName(param, factor, pointType, timeType, sort);
        String completeSql = "Select * from (" + sql + ") where  ROWNUM<=3";
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(completeSql);
        return nativeQueryList;
    }


    /*
     * @Title:
     * @Description:    (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 11:36
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 11:36
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @Override
    public Map<String, Object> getExcessAQICityEchart(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select count(REGION_NAME) count,REGION_NAME from(");
        stringBuilder.append(getExcessAQICitySql(param, factor, pointType, timeType, "front"));
        stringBuilder.append(") group by REGION_NAME order by count");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString());
        Map<String, Object> resultMap = new HashMap<>();
        List countList = new ArrayList();
        List regionNameList = new ArrayList();
        List colorList = new ArrayList();
        //装入两个数组;一个是名称,一个是aqi值
        for (Map<String, Object> dataMap : nativeQueryList) {
            countList.add(dataMap.get("count"));
            regionNameList.add(dataMap.get("regionName"));
            colorList.add(getAQIColorList((BigDecimal) dataMap.get("count")));
        }
        resultMap.put("count", countList);
        resultMap.put("regionName", regionNameList);
        resultMap.put("colorList", colorList);
        return resultMap;
    }
    /*
     * @Title:
     * @Description:    (获取aqi超标的城市的天数的文字部分)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 11:36
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 11:36
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */

    @Override
    public Page<Map<String, Object>> getExcessAQICityText(AirDayDataParam param, String factor, String pointType, String timeType, Page<Map<String, Object>> page, HttpServletResponse response) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select d.*,c.countDay from (");
        stringBuilder.append("select count(REGION_NAME) count,REGION_NAME from(");
        stringBuilder.append(getExcessAQICitySql(param, factor, pointType, timeType, "front"));
        stringBuilder.append(") group by REGION_NAME ");
        stringBuilder.append(") d join ");
        stringBuilder.append(getEffectiveDayNum(param, timeType, "regionName"));
        stringBuilder.append(" on c.region_name=d.region_name order by d.count ");
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            List<Map<String, Object>> list = simpleDao.getNativeQueryList(stringBuilder.toString());
            return exportExlAQIExcess(response, list, param.getExportTitle(), param);
        }
        return simpleDao.listNativeByPage(stringBuilder.toString(), page);
    }

    /**
     * 导出excel关于aqi超标的天数的数据
     *
     * @param response    相应参数
     * @param list        导出的list
     * @param exportTitle 导出excel的表头
     * @param param       查询参数
     * @return 2019年7月4日09:34:22
     */
    private Page<Map<String, Object>> exportExlAQIExcess(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle, AirDayDataParam param) {
        int i = 1;
        for (Map<String, Object> map : list) {
            map.put("pm", i);
            if ("day".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime() + "~" + param.getEndTime());
            }
            if ("month".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 7) + "~" + param.getEndTime().substring(0, 7));
            }
            if ("year".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 4) + "~" + param.getEndTime().substring(0, 4));
            }
            i++;
        }
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("pm", "排名");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionName", "地区名称");
        columnMap.put("countday", "有效监测天数");
        columnMap.put("count", "超标天数");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /*
     * @Title:
     * @Description:    (获取aqi超标的前三个数据和后三个数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 11:36
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 11:36
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @Override
    public List<Map<String, Object>> getExcessAQICityRank(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        if (StringUtils.isNotBlank(sort) && sort.equals("front")) {
            sort = "desc";
        } else {
            sort = "asc";
        }
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select * from (Select count(region_name) count ,region_name from(");
        stringBuilder.append(getExcessAQICitySql(param, factor, pointType, timeType, sort));
        stringBuilder.append(") group by region_name order by count " + sort + ")where rownum<=3");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(stringBuilder.toString());
        return nativeQueryList;
    }


    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.lang.StringBuilder
     * @Title: 获取aqi超标天数的sql
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 13:24
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 13:24
     */
    public StringBuilder getExcessAQICitySql(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        if (StringUtils.isNotBlank(param.getStartTime()) && StringUtils.isNotBlank(timeType)) {
            if (timeType.equals("year")) {
                param.setStartTime(param.getStartTime().substring(0, 4));
            } else if (timeType.equals("month")) {
                param.setStartTime(param.getStartTime().substring(0, 7));
            }
        }
        if (StringUtils.isNotBlank(param.getEndTime()) && StringUtils.isNotBlank(timeType)) {
            if (timeType.equals("year")) {
                param.setEndTime(param.getEndTime().substring(0, 4));
            } else if (timeType.equals("month")) {
                param.setEndTime(param.getEndTime().substring(0, 7));
            }
        }

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select a.aqi aqi, a.REGION_NAME, a.MONITOR_TIME  from AIR_DAY_DATA a join AIR_MONITOR_POINT b on a.point_code = a.point_code where b.point_type=1 and a.aqi>=100 ");
        String searchTime = getTimeBySearche(timeType);
        if (StringUtils.isNotBlank(param.getStartTime()) && StringUtils.isNotBlank(param.getEndTime())) {
            stringBuilder.append("AND '" + param.getStartTime());
            stringBuilder.append("'<= TO_CHAR(MONITOR_TIME,'" + searchTime + "')");
            stringBuilder.append(" and '" + param.getEndTime() + "'>=TO_CHAR(MONITOR_TIME,'" + searchTime + "')");
        }
        if (StringUtils.isNotBlank(sort) && sort.equals("front")) {
            sort = "desc";
        } else {
            sort = "asc";
        }
        stringBuilder.append("group by a.MONITOR_TIME, a.aqi, a.REGION_NAME order by a.aqi " + sort + " nulls last");
        return stringBuilder;
    }

    /**
     * @param
     * @return java.lang.String
     * @Title:
     * @Description: (获取有效监测天数)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 17:28
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 17:28
     */
    public StringBuilder getEffectiveDayNum(AirDayDataParam param, String timeType, String pointNameOrRegionName) {
        StringBuilder stringBuilder = new StringBuilder();
        String table = "AIR_DAY_DATA";
        if (StringUtils.isNotBlank(timeType) && timeType.equals("hour")) {
            table = "AIR_HOUR_DATA";
        }
        if (StringUtils.isNotBlank(pointNameOrRegionName) && pointNameOrRegionName.equals("pointName")) {
            stringBuilder.append("(select count(POINT_NAME) countDay,POINT_NAME from (");
            stringBuilder.append("select TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd'),POINT_NAME from " + table + " WHERE 1=1 ");
        } else {
            stringBuilder.append("(select count(REGION_NAME) countDay,REGION_NAME from (");
            stringBuilder.append("select TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd'),REGION_NAME from " + table + " WHERE 1=1 ");
        }
        String searchTime = getTimeBySearche(timeType);
        if (StringUtils.isNotBlank(param.getStartTime()) && StringUtils.isNotBlank(param.getEndTime())) {
            stringBuilder.append("AND '" + param.getStartTime());
            stringBuilder.append("'<= TO_CHAR(MONITOR_TIME,'" + searchTime + "')");
            stringBuilder.append(" and '" + param.getEndTime() + "'>=TO_CHAR(MONITOR_TIME,'" + searchTime + "')");
        }
        if (StringUtils.isNotBlank(pointNameOrRegionName) && pointNameOrRegionName.equals("pointName")) {
            stringBuilder.append("group by TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd'), point_name)");
            stringBuilder.append(" group by point_name) c");
        } else {
            stringBuilder.append("group by TO_CHAR(MONITOR_TIME, 'yyyy-mm-dd'), REGION_NAME,REGION_NAME)");
            stringBuilder.append(" group by REGION_NAME) c");
        }

        return stringBuilder;
    }

    /**
     * 均值比较 大气
     *
     * @param param 查询参数
     * @return
     */
    public Map getAirExcellentGoodEchart(AirDayDataParam param) {
        List<Map> excellentMap = getExcellentGoodDays("excellent", param);
        List<Map> goodMap = getExcellentGoodDays("good", param);
        JSONArray arrEx = new JSONArray();
        JSONArray arrExName = new JSONArray();
        JSONArray arrGo = new JSONArray();
        JSONArray arrGoName = new JSONArray();
        String regionName = "";
        String regionName1 = "";
        Map resultMap = new HashMap();
        for (Map exMap : excellentMap) {
            arrEx.add(Integer.parseInt(MapUtils.getString(exMap, "days", "")));
            regionName = MapUtils.getString(exMap, "regionName", "");
            arrGoName.add(regionName);
            for (Map goMap : goodMap) {
                regionName1 = MapUtils.getString(goMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    arrExName.add(regionName1);
                    arrGo.add(Integer.parseInt(MapUtils.getString(goMap, "days", "")));
                    break;
                }
            }
        }
        resultMap.put("ex", arrEx);
        resultMap.put("go", arrGo);
        resultMap.put("arrExName", arrExName.size() > arrGoName.size() ? arrExName : arrGoName);
        return resultMap;
    }

    /**
     * 根据等级查询天数
     *
     * @param flag  查询空气等级 重度  轻度  中度 等
     * @param param 查询参数
     * @return
     */
    private List getExcellentGoodDays(String flag, AirDayDataParam param) {
        String searchWhere = getSearchWhere(param, param.getStart(), param.getPointType());
        StringBuilder sql = new StringBuilder();
        sql.append(" select REGION_NAME,CODE_REGION,count(CODE_REGION) days");
        sql.append(" from ");
        sql.append(" ( SELECT  a.REGION_NAME,a.CODE_REGION,  ");
        sql.append(" to_Char(a.MONITOR_TIME," + SqlUtil.toSqlStr(getTimeBySearche(param.getStart())) + ") MONITOR_TIME, ");
        sql.append(" a.POINT_CODE, a.POINT_NAME,round(AVG(a.AQI)) AQI ");
        sql.append(" FROM AIR_DAY_DATA a ");
        sql.append(" INNER JOIN AIR_MONITOR_POINT B ON A.POINT_CODE = B.POINT_CODE  AND B.POINT_TYPE = '1' ");
        sql.append(searchWhere);
        if ("excellent".equals(flag)) {
            sql.append(" and a.AQI >= 0 and  a.AQI <= 50 ");
        }
        if ("good".equals(flag)) {
            sql.append("and a.AQI > 50 and  a.AQI <= 100 ");
        }
        if ("mild".equals(flag)) {//轻度
            sql.append("and a.AQI > 100 and  a.AQI <= 150 ");
        }
        if ("moderate".equals(flag)) {//中度
            sql.append("and a.AQI > 150 and  a.AQI <= 200 ");
        }
        if ("severe".equals(flag)) {//重度
            sql.append("and a.AQI > 200 ");
        }
        sql.append(" GROUP BY a.REGION_NAME,MONITOR_TIME, a.POINT_CODE, a.POINT_NAME,a.CODE_REGION ");
        sql.append(" order by MONITOR_TIME ");
        sql.append("  ) ");
        sql.append(" group by REGION_NAME,CODE_REGION  ORDER BY DAYS DESC ");
        return simpleDao.getNativeQueryList(sql.toString());
    }

    /**
     * 优良天数 大气 表格
     *
     * @param param    查询参数
     * @param page     分页
     * @param response 为了导出使用
     * @return
     */
    public PageEU<Map<String, Object>> getExcellentGoodDaysPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response) {
        List<Map> excellentMap = getExcellentGoodDays("excellent", param);
        List<Map> goodMap = getExcellentGoodDays("good", param);
        List<Map> mild = getExcellentGoodDays("mild", param);
        List<Map> moderate = getExcellentGoodDays("moderate", param);
        List<Map> severe = getExcellentGoodDays("severe", param);
        List<Map> ef = getExcellentGoodDays("", param);
        String regionName = "";
        String regionName1 = "";
        List<Map<String, Object>> resultList = new ArrayList<>();
        for (Map exMap : excellentMap) {
            Map map = new HashMap();
            map.put("excellent", Integer.parseInt(MapUtils.getString(exMap, "days", "")));//优天数
            regionName = MapUtils.getString(exMap, "regionName", "");
            map.put("regionName", regionName);
            for (Map goMap : goodMap) {
                regionName1 = MapUtils.getString(goMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    map.put("good", Integer.parseInt(MapUtils.getString(goMap, "days", "")));//良天数
                    break;
                }
            }
            for (Map mildMap : mild) {
                regionName1 = MapUtils.getString(mildMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    map.put("mild", Integer.parseInt(MapUtils.getString(mildMap, "days", "")));//轻度污染
                    break;
                }
            }
            for (Map moderateMap : moderate) {
                regionName1 = MapUtils.getString(moderateMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    map.put("moderate", Integer.parseInt(MapUtils.getString(moderateMap, "days", "")));//重度污染
                    break;
                }
            }
            for (Map severeMap : severe) {
                regionName1 = MapUtils.getString(severeMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    map.put("severe", Integer.parseInt(MapUtils.getString(severeMap, "days", "")));//重度污染
                    break;
                }
            }
            for (Map efMap : ef) {
                regionName1 = MapUtils.getString(efMap, "regionName", "");
                if (regionName.equals(regionName1)) {
                    map.put("efday", Integer.parseInt(MapUtils.getString(efMap, "days", "")));//有效监测天数
                    break;
                }
            }
            resultList.add(map);
        }
        if (StringUtils.isNotEmpty(param.getExportExl())) {
            return exportExcellentGoodDays(response, resultList, param.getExportTitle(), param);//导出excel
        }
        page.setTotalCount(resultList.size());
        page.setResult(resultList);
        return new PageEU<>(page);
    }

    /**
     * 优良天数 表格导出
     *
     * @param response
     * @param list
     * @param exportTitle
     * @param param
     * @return
     */
    private PageEU<Map<String, Object>> exportExcellentGoodDays(HttpServletResponse response, List<Map<String, Object>> list, String exportTitle, AirDayDataParam param) {
        int i = 1;
        for (Map<String, Object> map : list) {
            map.put("pm", i);
            if ("month".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 7) + "~" + param.getEndTime().substring(0, 7));
            }
            if ("year".equals(param.getStart())) {
                map.put("monitorTime", param.getStartTime().substring(0, 4) + "~" + param.getEndTime().substring(0, 4));
            }
            i++;
        }
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", exportTitle);
        columnMap.put("pm", "排名");
        columnMap.put("monitorTime", "监测时间");
        columnMap.put("regionName", "地区名称");
        columnMap.put("efday", "有效监测天数");
        columnMap.put("excellent", "优天数");
        columnMap.put("good", "良天数");
        columnMap.put("mild", "轻度污染天数");
        columnMap.put("moderate", "中度污染天数");
        columnMap.put("severe", "重度污染天数");
        ExcelExportUtil.exportExcel(response, columnMap, list);
        return null;
    }

    /*
     * @Title:
     * @Description:    (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/8 11:26
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/8 11:26
     * @param param
     * @param timeType
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    @Override
    public List<Map<String, Object>> getAQIYearOnYearDataShow(String searchYear, String currentYear, String timeType, String pointCode, String pointType, int countMonthDay) {

        List<Map<String, Object>> resultList = new ArrayList<>();
        if (StringUtils.isNotBlank(pointCode)) {
            List<String> pointCodes = Arrays.asList(pointCode.split(","));
            for (String searchPointCode : pointCodes)
                try {
                    Map<String, Object> resultMap = getString(searchYear, currentYear, searchPointCode, timeType, countMonthDay, pointType);
                    resultMap.put("pointCode", searchPointCode);
                    resultList.add(resultMap);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            return resultList;
        }
        List<Map<String, Object>> pointCodeAndPointName = getPointCodeAndPointName(pointType);
        for (Map<String, Object> dataMap : pointCodeAndPointName) {
            try {
                Map<String, Object> resultMap = getString(searchYear, String.valueOf(currentYear), String.valueOf(dataMap.get("pointCode")), timeType, countMonthDay, pointType);
                resultMap.put("pointCode", dataMap.get("pointCode"));
                resultList.add(resultMap);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return resultList;
    }

    @Override
    public List<Map<String, Object>> getAQIRingRatioDataShow(String searchYearAndMonth, String pointCode, String pointType) {
        return null;
    }

    /*
     * @Title:
     * @Description:    (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/11 15:25
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/11 15:25
     * @param searchYear
     * @param currentYear
     * @param pointCode
     * @param switchYearOrMonth
     * @param countMonthDay
     * @param YearOnYearCityOrSite
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    public Map<String, Object> getString(String searchYear, String currentYear, String pointCode, String timeType, int countMonthDay, String pointType) throws ParseException {
        Map<String, Object> result = new HashMap<>();
        Map<String, Integer> indexmap;
        List<String> xAxis;
        Map<String, Object> timeMap = getxAxisList(timeType, searchYear, currentYear);
        xAxis = (List<String>) timeMap.get("xAxis");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap"); //对应的是几月几号-第几天;比如1-1是第一天;
        List<Object[]> list = getAQICompareData(timeType, pointCode, currentYear, searchYear);
        result.put("formatter", "{value}");
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
            if (series.keySet().size() == 1 && !key.toString().equals(currentYear)) {
                legendList.add(currentYear + "," + pointCode);
                JSONObject xObject = new JSONObject();
                xObject.put("data", new ArrayList<>());
                xObject.put("type", "line");
                xObject.put("name", currentYear);
                xArray.add(xObject);
            }
            legendList.add(key.toString() + "," + pointCode);
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
     * @param switchString YearOnYearSite站点同比YearOnYearCity城市同比
     * @param pointCode
     * @param currentYear
     * @param searchYear
     * @return java.util.List<java.lang.Object [ ]>
     * @Title:
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/11 15:27
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/11 15:27
     */

    public List<Object[]> getAQICompareData(String timeType, String pointCode, String currentYear, String searchYear) {
        StringBuilder sqlStringBuilder = new StringBuilder();
        switch (timeType) {
            case "day"://同比城市或者站点
                sqlStringBuilder.append("SELECT to_char(MONITOR_TIME,'yyyy'),Round(AQI),to_char(MONITOR_TIME,'mm-dd'),POINT_NAME FROM AIR_DAY_DATA WHERE 1=1 ");
                sqlStringBuilder.append("AND point_code='" + pointCode);
                sqlStringBuilder.append("' AND AQI is not null AND  (to_char(MONITOR_TIME,'yyyy')='" + searchYear);
                sqlStringBuilder.append("' OR to_char(MONITOR_TIME,'yyyy')= '" + currentYear);
                sqlStringBuilder.append("') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY to_char(MONITOR_TIME,'yyyy'),POINT_NAME,MONITOR_TIME ASC");
                break;
            case "month"://同比城市或者站点
                sqlStringBuilder.append("SELECT TO_CHAR(MONITOR_TIME,'yyyy') TIME,Round(avg(AQI)) AQI,to_char(MONITOR_TIME,'mm') searchTime,POINT_NAME  FROM AIR_DAY_DATA WHERE (to_Char(monitor_time,'yyyy')=" + currentYear);
                sqlStringBuilder.append(" or " + searchYear + "=TO_CHAR(monitor_time,'yyyy')) AND POINT_CODE='" + pointCode + "' and AQI is not null GROUP BY TO_CHAR(MONITOR_TIME,'yyyy'),POINT_NAME,to_char(MONITOR_TIME,'mm')   ORDER BY TO_CHAR(MONITOR_TIME,'yyyy'),AQI ASC ");
                break;
            case "countMonthDay"://环比城市或者站点
                sqlStringBuilder.append("SELECT to_char(MONITOR_TIME,'yyyy-mm'),Round(AQI),to_char(MONITOR_TIME,'dd'),POINT_NAME FROM AIR_DAY_DATA WHERE 1=1 ");
                sqlStringBuilder.append("AND point_code='" + pointCode);
                sqlStringBuilder.append("' AND AQI is not null AND  (to_char(MONITOR_TIME,'yyyy-mm')='" + searchYear);
                sqlStringBuilder.append("' OR to_char(MONITOR_TIME,'yyyy-mm')= '" + currentYear);
                sqlStringBuilder.append("') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME ASC");
                break;
            case "AQICountDay"://aqi同比处理
                sqlStringBuilder.append("Select to_char(MONITOR_TIME, 'yyyy'),count(to_char(MONITOR_TIME, 'mm')) ,to_char(MONITOR_TIME,'mm') searchTime,POINT_NAME,avg(AQI) AQI from(");
                sqlStringBuilder.append("select POINT_CODE, MONITOR_TIME,avg(AQI) AQI,POINT_NAME from AIR_DAY_DATA ");
                sqlStringBuilder.append(" where aqi > 100 and (to_char(MONITOR_TIME,'yyyy')='" + searchYear + "'");
                sqlStringBuilder.append(" OR to_char(MONITOR_TIME,'yyyy')='" + currentYear);
                sqlStringBuilder.append("') AND point_code='" + pointCode);
                sqlStringBuilder.append("' group by POINT_CODE, MONITOR_TIME,POINT_NAME");
                sqlStringBuilder.append(") group by to_char(MONITOR_TIME, 'yyyy'),to_char(MONITOR_TIME, 'yyyy-mm'), to_char(MONITOR_TIME, 'mm'), POINT_NAME");
                break;
            default:
                break;
        }
        simpleDao.getNativeQueryList(sqlStringBuilder.toString());
        return simpleDao.createNativeQuery(sqlStringBuilder.toString()).getResultList();
    }

    /*
     * @Title:
     * @Description:    (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/11 15:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/11 15:29
     * @param month(站点或城市的同比月份),day(站点或城市同比365天的数据x),countMonthDay(站点或城市的环比获取月份天数)
     * @param searchYear
     * @param countMonthDay
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    public Map<String, Object> getxAxisList(String timeType, String searchYear, String currentYear) throws ParseException {
        Map<String, Object> dataMap = new HashMap<>();
        Map<String, Integer> indexmap = new HashMap<String, Integer>();
        Map<String, Object> timeMap;
        List<String> xAxis = new ArrayList<>();
        if (timeType.equals("AQICountDay")) {
            timeType = "month";
        }
        switch (timeType) {
            case "month"://就是获取01然后就是12一共是12个数据
                for (int i = 1; i <= 12; i++) {
                    if (i < 10) {
                        indexmap.put("0" + String.valueOf(i), i - 1);
                        xAxis.add("0" + String.valueOf(i));
                    } else {
                        indexmap.put(String.valueOf(i), i - 1);
                        xAxis.add(String.valueOf(i));
                    }
                }
                break;
            case "day"://获取的是01-01几月几号到几月几号一年365的数据
                timeMap = DateUtil.getYearDay(Integer.valueOf(searchYear));
                xAxis = (List<String>) timeMap.get("xList");
                indexmap = (Map<String, Integer>) timeMap.get("indexmap");
                break;
            case "countMonthDay"://获取一个月有多少天的数据
                Map<String, Object> monthDays = getMonthDays(searchYear, currentYear);
                xAxis = (List<String>) monthDays.get("xList");
                indexmap = (Map<String, Integer>) monthDays.get("indexmap");
                break;
            default:
                break;
        }
        dataMap.put("indexmap", indexmap);
        dataMap.put("xAxis", xAxis);
        return dataMap;
    }

    /**
     * @param pointType
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title: 获取全部的站点和省控或者其他的什么
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/11 10:38
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/11 10:38
     */
    public List<Map<String, Object>> getPointCodeAndPointName(String pointType) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("select a.POINT_NAME,a.POINT_CODE from AIR_DAY_DATA a join air_monitor_point b on  a.point_code=b.point_code where  b.point_type=" + pointType + " group by  a.POINT_CODE,a.POINT_NAME");
        return simpleDao.getNativeQueryList(stringBuilder.toString());
    }

    /**
     * 往年同比 大气 多站点对比 优良天数-环比
     *
     * @param polluteName 因子
     * @param pointCode   站点
     * @param time
     * @param year        对比年份
     * @return
     * @throws ParseException
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getPassYearExcellentAnalysisAirMorePoint(String polluteName, String pointCode, String time, int year) throws ParseException {
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
            timeMap = DateUtil.getYearMonth42(year + "");
            startTime1 = DateUtil.getCurFullYear() + "-01";
            endTime1 = DateUtil.getCurFullYear() + "-12";
            startTime2 = year + "-01";
            endTime2 = year + "-12";
        } else {
            timeMap = DateUtil.getYearDay(year);
            startTime1 = timeMap.get("year1") + "-01-01";
            endTime1 = timeMap.get("year1") + "-12-31";
            startTime2 = timeMap.get("year2") + "-01-01";
            endTime2 = timeMap.get("year2") + "-12-31";
        }
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        int idx = 0;
        for (String pcode : points) {
            sql = new StringBuilder();
            xAxis = new ArrayList<String>();
            result = new HashMap<>();
            xAxis = (List<String>) timeMap.get("xList");

            sql.append("  SELECT YEAR,MONTH,POINT_NAME, POINT_CODE, COUNT(POINT_CODE) DAYS ");
            sql.append("  FROM (SELECT ");
            sql.append("  TO_CHAR(MONITOR_TIME, 'YYYY') YEAR, TO_CHAR(MONITOR_TIME, 'MM') MONTH, ");
            sql.append("  A.REGION_NAME, ");
            sql.append("  A.CODE_REGION, ");
            sql.append("   MONITOR_TIME, ");
            sql.append("  A.POINT_CODE, ");
            sql.append("  A.POINT_NAME, ");
            sql.append("  ROUND(AVG(A.AQI))AQI ");
            sql.append("  FROM AIR_DAY_DATA A ");
            sql.append("  WHERE 1 = 1 ");
            sql.append(" and a.POINT_CODE = ").append(SqlUtil.toSqlStr(pcode));
            sql.append(" AND (TO_CHAR(MONITOR_TIME, 'YYYY-MM') >=  ").append(SqlUtil.toSqlStr(startTime1));
            sql.append(" AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') <=  ").append(SqlUtil.toSqlStr(endTime1));
            sql.append(" OR TO_CHAR(MONITOR_TIME, 'YYYY-MM') >=  ").append(SqlUtil.toSqlStr(startTime2));
            sql.append(" AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') <=  ").append(SqlUtil.toSqlStr(endTime2));
            sql.append("  ) ");
            if ("excellent".equals(polluteName)) {
                sql.append(" AND A.AQI >= 0 AND  A.AQI <= 50 ");
            } else {
                sql.append("  and a.AQI > 50 and  a.AQI <= 100 ");
            }
            sql.append(" GROUP BY A.REGION_NAME, MONITOR_TIME, A.POINT_CODE, A.POINT_NAME, A.CODE_REGION,TO_CHAR(MONITOR_TIME, 'YYYY') , TO_CHAR(MONITOR_TIME, 'MM') ");
            sql.append(" ORDER BY MONITOR_TIME) ");
            sql.append(" GROUP BY POINT_NAME, POINT_CODE,YEAR,MONTH ");
            sql.append(" ORDER BY DAYS DESC ");

            list = simpleDao.createNativeQuery(sql.toString()).getResultList();
            result.put("formatter", "{value}(天)");
            Map<String, Object[]> series = new HashMap<String, Object[]>();
            String code = "";
            for (Object[] obj : list) {
                title = (String) obj[2];
                code = (String) obj[3];
                if (obj[0] != null) {
                    if (series.containsKey(obj[0])) {
                        if (obj[4] != null) {
                            series.get(obj[0].toString())[indexmap.get(obj[1])] = obj[4];
                        }
                    } else {
                        Object[] tempList = new Object[indexmap.size()];
                        if (obj[4] != null) {
                            tempList[indexmap.get(obj[1])] = obj[4];
                        }
                        series.put(obj[0].toString(), tempList);
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
    public Map<String, Object> getCompareData(String pointCode, int year, String rq) {

        StringBuilder sql = new StringBuilder();
        String curFullYear = DateUtil.getCurFullYear();
        List<Map> curExList = null;
        List<Map> curGdList = null;
        List<Map> pastExList = null;
        List<Map> pastGoList = null;
        //月
        curExList = getMaps(pointCode, rq, sql, curFullYear, "excellent");
        sql = new StringBuilder();
        curGdList = getMaps(pointCode, rq, sql, curFullYear, "");
        sql = new StringBuilder();
        pastExList = getMaps(pointCode, rq, sql, year + "", "excellent");
        sql = new StringBuilder();
        pastGoList = getMaps(pointCode, rq, sql, year + "", "");
        Map curMap = new HashMap();
        if (ToolUtil.isNotEmpty(curExList)) {
            Map map = curExList.get(0);
            curMap.put("curEx", MapUtils.getString(map, "days"));
        }
        if (ToolUtil.isNotEmpty(curGdList)) {
            Map map = curGdList.get(0);
            curMap.put("curGd", MapUtils.getString(map, "days"));
        }
        if (ToolUtil.isNotEmpty(pastExList)) {
            Map map = pastExList.get(0);
            curMap.put("pastEx", MapUtils.getString(map, "days"));
        }
        if (ToolUtil.isNotEmpty(pastGoList)) {
            Map map = pastGoList.get(0);
            curMap.put("pastGd", MapUtils.getString(map, "days"));
        }
        int i = Integer.parseInt(MapUtils.getString(curMap, "curEx", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastEx", "0"));
        int i1 = Integer.parseInt(MapUtils.getString(curMap, "curGd", "0")) - Integer.parseInt(MapUtils.getString(curMap, "pastGd", "0"));
        curMap.put("ex", i);
        curMap.put("gd", i1);
        return curMap;
    }

    /**
     * 获取比较数据 优良天数-同比-监测站因子
     *
     * @param pointCode   站点编码
     * @param rq          日期
     * @param sql         日
     * @param curFullYear 比对年度
     * @return
     */
    private List<Map> getMaps(String pointCode, String rq, StringBuilder sql, String curFullYear, String flag) {
        sql.append("        SELECT YEAR,MONTH,POINT_NAME, POINT_CODE, COUNT(POINT_CODE) DAYS ");
        sql.append("        FROM (SELECT ");
        sql.append("        TO_CHAR(MONITOR_TIME, 'YYYY') YEAR, TO_CHAR(MONITOR_TIME, 'MM') MONTH, ");
        sql.append("        A.REGION_NAME, ");
        sql.append("        A.CODE_REGION, ");
        sql.append("         MONITOR_TIME, ");
        sql.append("        A.POINT_CODE, ");
        sql.append("        A.POINT_NAME, ");
        sql.append("        ROUND(AVG(A.AQI))                  AQI ");
        sql.append("        FROM AIR_DAY_DATA A ");
        sql.append("        WHERE 1 = 1 ");
        sql.append("       and a.POINT_CODE = ").append(SqlUtil.toSqlStr(pointCode));
        sql.append("       AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') =  ").append(SqlUtil.toSqlStr(curFullYear + "-" + rq));
        if ("excellent".equals(flag)) {
            sql.append("        AND A.AQI >= 0 AND  A.AQI <= 50 ");
        } else {
            sql.append("        and a.AQI > 50 and  a.AQI <= 100 ");
        }
        sql.append("        GROUP BY A.REGION_NAME, MONITOR_TIME, A.POINT_CODE, A.POINT_NAME, A.CODE_REGION,TO_CHAR(MONITOR_TIME, 'YYYY') , TO_CHAR(MONITOR_TIME, 'MM') ");
        sql.append("        ORDER BY MONITOR_TIME) ");
        sql.append("        GROUP BY POINT_NAME, POINT_CODE,YEAR,MONTH ");
        sql.append("        ORDER BY DAYS DESC ");
        return simpleDao.getNativeQueryList(sql.toString());
    }

    /**
     * 获取比较数据 优良天数-环比-监测站因子   超标天数--环比
     *
     * @param pointCode 站点编码
     * @param time      日期
     * @param flag      优良flag
     * @return
     */
    public List<Map> getMapsByMonth(String time, String pointCode, String flag) {
        StringBuilder sql = new StringBuilder();
        sql.append("        SELECT YEAR,MONTH,POINT_NAME, POINT_CODE, COUNT(POINT_CODE) DAYS ");
        sql.append("        FROM (SELECT ");
        sql.append("        TO_CHAR(MONITOR_TIME, 'YYYY') YEAR, TO_CHAR(MONITOR_TIME, 'MM') MONTH, ");
        sql.append("        A.REGION_NAME, ");
        sql.append("        A.CODE_REGION, ");
        sql.append("         MONITOR_TIME, ");
        sql.append("        A.POINT_CODE, ");
        sql.append("        A.POINT_NAME, ");
        sql.append("        ROUND(AVG(A.AQI))                  AQI ");
        sql.append("        FROM AIR_DAY_DATA A ");
        sql.append("  WHERE 1 = 1 ");
        sql.append("       AND a.POINT_CODE = ").append(SqlUtil.toSqlStr(pointCode));
        sql.append("       AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') =  ").append(SqlUtil.toSqlStr(time));
        if ("excellent".equals(flag)) {
            sql.append("        AND A.AQI >= 0 AND  A.AQI <= 50 ");
        } else if ("good".equals(flag)) {
            sql.append("        and a.AQI > 50 and  a.AQI <= 100 ");
        } else if ("excess".equals(flag)) {
            sql.append("   AND  A.AQI >= 100 ");
        }
        sql.append("        GROUP BY A.REGION_NAME, MONITOR_TIME, A.POINT_CODE, A.POINT_NAME, A.CODE_REGION,TO_CHAR(MONITOR_TIME, 'YYYY') , TO_CHAR(MONITOR_TIME, 'MM') ");
        sql.append("        ORDER BY MONITOR_TIME) ");
        sql.append("        GROUP BY POINT_NAME, POINT_CODE,YEAR,MONTH ");
        sql.append("        UNION ALL ");
        //当前时间
        sql.append("        SELECT YEAR,MONTH,POINT_NAME, POINT_CODE, COUNT(POINT_CODE) DAYS ");
        sql.append("        FROM (SELECT ");
        sql.append("        TO_CHAR(MONITOR_TIME, 'YYYY') YEAR, TO_CHAR(MONITOR_TIME, 'MM') MONTH, ");
        sql.append("        A.REGION_NAME, ");
        sql.append("        A.CODE_REGION, ");
        sql.append("         MONITOR_TIME, ");
        sql.append("        A.POINT_CODE, ");
        sql.append("        A.POINT_NAME, ");
        sql.append("        ROUND(AVG(A.AQI))                  AQI ");
        sql.append("        FROM AIR_DAY_DATA A ");
        sql.append("  WHERE 1 = 1 ");
        sql.append("       and a.POINT_CODE = ").append(SqlUtil.toSqlStr(pointCode));
        sql.append("       AND TO_CHAR(MONITOR_TIME, 'YYYY-MM') =  ").append(SqlUtil.toSqlStr(DateUtil.getCurYearMonth()));
        if ("excellent".equals(flag)) {
            sql.append("        AND A.AQI >= 0 AND  A.AQI <= 50 ");
        } else if ("good".equals(flag)) {
            sql.append("        AND a.AQI > 50 AND  a.AQI <= 100 ");
        } else if ("excess".equals(flag)) {
            sql.append("   AND  A.AQI >= 100 ");
        }
        sql.append("        GROUP BY A.REGION_NAME, MONITOR_TIME, A.POINT_CODE, A.POINT_NAME, A.CODE_REGION,TO_CHAR(MONITOR_TIME, 'YYYY') , TO_CHAR(MONITOR_TIME, 'MM') ");
        sql.append("        ORDER BY MONITOR_TIME) ");
        sql.append("        GROUP BY POINT_NAME, POINT_CODE,YEAR,MONTH ");
        return simpleDao.getNativeQueryList(sql.toString());
    }


    /***
     * @Title:
     * @Description: (aqi超标天数同比获取aqiechart图数据情况)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/17 14:31
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/17 14:31
     * @param null
     * @return
     */
    public String getAQIExcessEchartSql(String searchYear, String currentYear) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("select count(MONITOR_TIME),to_char(MONITOR_TIME,'yyyy-mm'),to_char(MONITOR_TIME,'mm'),POINT_NAME from ");
        sqlBuilder.append("(select POINT_CODE, MONITOR_TIME,avg(AQI),POINT_NAME from AIR_DAY_DATA");
        sqlBuilder.append("where aqi > 100 and to_char(MONITOR_TIME,'yyyy')='" + searchYear + "'");
        sqlBuilder.append("group by POINT_CODE, MONITOR_TIME,POINT_NAME) group by to_char(MONITOR_TIME,'yyyy-mm'),POINT_NAME,to_char(MONITOR_TIME,'mm');");
        return sqlBuilder.toString();
    }

}
