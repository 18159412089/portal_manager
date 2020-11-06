package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.*;

/**
 * 在线水小时的数据服务功能
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:37:29
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtHourDataServiceImpl implements WtHourDataService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getListByCode</p>
     * <p>Description:  获取站点信息</p>
     *
     * @param pointCode
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService#getListByCode(java.lang.String)
     */
    @Override
    public List<WtHourData> getListByCode(String pointCode) {
        List<WtHourData> list = simpleDao.find("from WtHourData where monitorTime = (SELECT MAX( monitorTime ) FROM WtHourReport) and pointCode='" + pointCode + "'");
        return list;
    }

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 数据服务在线水表格分页数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtHourDataParam param, Page<Map<String, Object>> page) {
        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ";
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
        String sql = "SELECT a.DATATIME, a.POINT_CODE, a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', DATAVALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', DATAVALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', DATAVALUE, 0 )) W01009,"
                + "sum(DECODE( CODE_POLLUTE, 'W01014', DATAVALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', DATAVALUE, 0 )) W01003,"
                + "sum(DECODE( CODE_POLLUTE, 'W01019', DATAVALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', DATAVALUE, 0 )) W21003,"
                + "sum(DECODE( CODE_POLLUTE, 'W21011', DATAVALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', DATAVALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR "
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_HOUR_REPORT b ON a.DATATIME=b.DATATIME and a.POINT_CODE=b.POINT_CODE "
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE "
                + where
                + "GROUP BY a.DATATIME, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY DATATIME DESC";
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
     * <p>Title: getPageListNative</p>
     * <p>Description: 数据服务在线水表格分页数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see
     */
    @Override
    public Page<Map<String, Object>> getPageListNative(WtHourDataParam param, Page<Map<String, Object>> page, String regionName) {
        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            } else {
                where = "";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
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
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_HOUR_REPORT b ON a.DATATIME=b.DATATIME and a.POINT_CODE=b.POINT_CODE "
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE "
                + where
                + " AND c.CATEGORY=1 "
                + " AND c.STATUS=1 "
                + "GROUP BY a.DATATIME, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY DATATIME DESC";
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
     * 实时动态数据大屏  水质自动实时监测
     *
     * @return
     */
    public List<Map> getWtRealTimeData() {
        StringBuilder sql = new StringBuilder();
        sql.append(" 	SELECT * FROM WT_CITY_HOUR_REPORT ");
        sql.append(" 	WHERE (POINT_CODE, DATATIME) IN ( ");
        sql.append(" 	SELECT A.POINT_CODE, MAX(B.DATATIME) ");
        sql.append(" 	FROM WT_CITY_POINT A ");
        sql.append(" 	INNER JOIN WT_CITY_HOUR_REPORT B ON A.POINT_CODE = B.POINT_CODE ");
        sql.append(" 	WHERE A.STATUS = 1 ");
        sql.append(" 	AND B.DATATIME <= SYSDATE ");
        sql.append(" 	GROUP BY A.POINT_CODE) ");
        sql.append(" 	ORDER BY DATATIME DESC ");
        List<Map> mapList = simpleDao.getNativeQueryList(sql.toString());
        JSONArray parseArray = null;
        for (Map map : mapList) {
            List<Map> maxResult = new ArrayList();
            parseArray = JSONArray.parseArray(MapUtils.getString(map, "excessfactorstr", ""));
            for (int j = 0; j < parseArray.size(); j++) {
                JSONObject jsonObject = parseArray.getJSONObject(j);
                if (jsonObject.containsKey("isExcess") && MapUtils.getBoolean(jsonObject, "isExcess")) {
                    maxResult.add(jsonObject);
                }
            }
            if (!maxResult.isEmpty()) {
                //从高到底排序
                Collections.sort(maxResult, new Comparator<Map>() {
                    @Override
                    public int compare(Map o1, Map o2) {
                        return WaterQualityUtil.formatVal(MapUtils.getString(o1, "resultQuality")) - (WaterQualityUtil.formatVal(MapUtils.getString(o2, "resultQuality")));
                    }
                });
                map.put("polluteName", maxResult.get(0).get("polluteName"));
            } else {
                map.put("polluteName", "-");
            }
        }
        return mapList;
    }

    /**
     * <p>Title: getPageListProvince</p>
     * <p>Description: 数据服务在线水表格分页数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService#getPageListNative(com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageListProvince(WtHourDataParam param, Page<Map<String, Object>> page, String regionName) {
        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
            }
        } else {
            if (ToolUtil.isNotEmpty(param.getPointName())) {
                where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
            } else {
                where = "";
            }
            if (ToolUtil.isNotEmpty(regionName)) {
                where = where + " and c.CODE_REGION in (" + toSqlStr(regionName) + ")";
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
                + "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_HOUR_REPORT b ON a.DATATIME=b.DATATIME and a.POINT_CODE=b.POINT_CODE "
                + "INNER JOIN WT_CITY_POINT c ON a.POINT_CODE=c.POINT_CODE "
                + where
                + " AND c.CATEGORY=2 "
                + " AND c.STATUS=1 "
                + "GROUP BY a.DATATIME, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY DATATIME DESC";
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
     * <p>Title: getPassMonthAnalysis</p>
     * <p>Description: 在线水往月环比分析数据</p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService#getPassMonthAnalysis(com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassMonthAnalysis(WtHourDataParam param) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis;
        String sql;

        Map<String, Integer> indexmap;
        Map<String, Object> timeMap = DateUtil.getMonthDaysHour(param.getStartTime(), param.getEndTime());
        String startTime1 = timeMap.get("startTime1").toString();
        String endTime1 = timeMap.get("endTime1").toString();
        String startTime2 = timeMap.get("startTime2").toString();
        String endTime2 = timeMap.get("endTime2").toString();
        xAxis = (List<String>) timeMap.get("xList");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        sql = "SELECT DATATIME,DATAVALUE,POINT_NAME FROM WT_CITY_HOUR_DATA WHERE POINT_CODE = ? AND CODE_POLLUTE = ? "
                + "AND (DATATIME>=TO_DATE(?,'yyyy-mm-dd hh24') AND DATATIME <=TO_DATE(?,'yyyy-mm-dd hh24') "
                + "OR DATATIME>=TO_DATE(?,'yyyy-mm-dd hh24') AND DATATIME <=TO_DATE(?,'yyyy-mm-dd hh24'))";
        list = simpleDao.createNativeQuery(sql, param.getPointCode(), param.getPollutes(), startTime1, endTime1, startTime2, endTime2).getResultList();


        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                String yearMonth = obj[0].toString().substring(0, 7);
                String dateTime = obj[0].toString().substring(8, 13);
                if (series.containsKey(yearMonth)) {
                    if (obj[1] != null && indexmap.containsKey(dateTime)) {
                        series.get(yearMonth)[indexmap.get(dateTime)] = obj[1];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[1] != null && indexmap.containsKey(dateTime)) {
                        tempList[indexmap.get(dateTime)] = obj[1];
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
     *  获取华安县小时数据
     * @param param
     * @param page
     * @return
     */
    @Override
    public Page<Map<String, Object>> getPageAllList(WtHourDataParam param, Page<Map<String, Object>> page) {
        String where = "where ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            where = where + "a.DATATIME >= TO_DATE('" + param.getStartTime() + "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + " and a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            }
        } else {
            String currentStartTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 00:00:00";
            String currentEndTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 23:59:59";

            where = where + "a.DATATIME >= TO_DATE('" + currentStartTime+ "', 'yyyy-mm-dd hh24:mi:ss') and a.DATATIME <= TO_DATE('" +currentEndTime + "','yyyy-mm-dd hh24:mi:ss') ";
            if (ToolUtil.isNotEmpty(param.getPointCode())) {
                where = where + "and  a.POINT_CODE in (" + toSqlStr(param.getPointCode()) + ")";
            }
        }
        String sql = "SELECT  TO_CHAR(a.DATATIME,'yyyy-mm-dd hh24:mi:ss') as DATATIME , a.POINT_CODE, a.POINT_NAME, a.CODE_POLLUTE  ,a.DATAVALUE,a.paramname "
                  + "FROM WT_CITY_HOUR_DATA a "
                + where
                + "ORDER BY a.DATATIME DESC";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> result = byPage.getResult();
        byPage.setResult(result);
        return byPage;
    }




    /**
     * @param str
     * @return String
     * @throws
     * @Title: toSqlStr
     * @Description: 部分sql语句拼接
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:15:33
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:15:33
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
     * @Description: 字符串转数组
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年4月29日 下午5:16:09
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年4月29日 下午5:16:09
     */
    public List<String> strToList(String str) {
        if (ToolUtil.isNotEmpty(str)) {
            return Arrays.asList(str.split(","));
        }
        return new ArrayList<String>();
    }

}
