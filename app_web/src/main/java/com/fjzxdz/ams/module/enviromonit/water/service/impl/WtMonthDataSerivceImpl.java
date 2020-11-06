package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMonthDataService;
import com.fjzxdz.ams.util.WaterSeriesUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 数据服务在线水月数据
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:38:38
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtMonthDataSerivceImpl implements WtMonthDataService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 在线月监测数据列表  </p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMonthDataService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtMonthDataParam param, Page<Map<String, Object>> page) {
        String where = "where ";
        String from = "from ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            String startYear = param.getStartTime().substring(0, 4);
            String startMonth = param.getStartTime().substring(5, param.getStartTime().length());
            String endYear = param.getEndTime().substring(0, 4);
            String endMonth = param.getEndTime().substring(5, param.getEndTime().length());
            String flag = startYear.equals(endYear) ? " INTERSECT" : " UNION ALL";
            from = from + "(SELECT * FROM WT_MONTH_DATA WHERE YEAR_NUMBER=" + startYear + " AND MONTH_NUMBER>=" + startMonth + flag + " SELECT * FROM WT_MONTH_DATA WHERE YEAR_NUMBER=" + endYear + " AND MONTH_NUMBER<=" + endMonth + ") ";
        } else {
            from = from + "WT_MONTH_DATA";
        }
        if (ToolUtil.isNotEmpty(param.getPointName())) {
            where = where + " a.POINT_CODE in (" + toSqlStr(param.getPointName()) + ")";
        } else {
            where = "";
        }
        String sql = "SELECT a.YEAR_NUMBER, a.MONTH_NUMBER, a.POINT_CODE, a.POINT_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', POLLUTE_VALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', POLLUTE_VALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', POLLUTE_VALUE, 0 )) W01009, "
                + "sum(DECODE( CODE_POLLUTE, 'W01014', POLLUTE_VALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', POLLUTE_VALUE, 0 )) W01003, "
                + "sum(DECODE( CODE_POLLUTE, 'W01019', POLLUTE_VALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', POLLUTE_VALUE, 0 )) W21003, "
                + "sum(DECODE( CODE_POLLUTE, 'W21011', POLLUTE_VALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', POLLUTE_VALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR "
                + from + " a INNER JOIN WT_MONTH_REPORT b "
                + "ON a.YEAR_NUMBER=b.YEAR_NUMBER AND a.MONTH_NUMBER=b.MONTH_NUMBER AND a.POINT_CODE=b.POINT_CODE "
                + where + "GROUP BY a.YEAR_NUMBER, a.MONTH_NUMBER, a.POINT_CODE, a.POINT_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY a.YEAR_NUMBER DESC,a.MONTH_NUMBER DESC";
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
     * <p>Title: getPointsDateByMonth</p>
     * <p>Description:  在线月监测数据分析</p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMonthDataService#getPointsDateByMonth(com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getPointsDateByMonth(WtMonthDataParam param) throws ParseException {
        String from = "from ";
        if (ToolUtil.isNotEmpty(param.getStartTime()) && ToolUtil.isNotEmpty(param.getEndTime())) {
            String startYear = param.getStartTime().substring(0, 4);
            String startMonth = param.getStartTime().substring(5, param.getStartTime().length());
            String endYear = param.getEndTime().substring(0, 4);
            String endMonth = param.getEndTime().substring(5, param.getEndTime().length());
            String flag = startYear.equals(endYear) ? " INTERSECT" : " UNION ALL";
            from = from + "(SELECT * FROM WT_MONTH_DATA WHERE YEAR_NUMBER=" + startYear + " AND MONTH_NUMBER>=" + startMonth + flag + " SELECT * FROM WT_MONTH_DATA WHERE YEAR_NUMBER=" + endYear + " AND MONTH_NUMBER<=" + endMonth + ") ";
        } else {
            from = from + "WT_MONTH_DATA";
        }

        List<Map<String, Object>> result = new ArrayList<>();
        List<String> pollutes = strToList(param.getPollutes());
        Map<String, Object> timeMap;
        Map<String, Integer> indexmap;
        List<String> xAxis;
        List<Object[]> list = null;
        String sql = "";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
        for (String str : pollutes) {
            Map<String, Object> map = new HashMap<>();
            sql = "SELECT POINT_NAME,POLLUTE_NAME,POLLUTE_VALUE,YEAR_NUMBER,MONTH_NUMBER "
                    + from + " WHERE POINT_CODE in (" + toSqlStr(param.getPointName()) + ") "
                    + "and CODE_POLLUTE='" + str + "' GROUP BY POINT_NAME,YEAR_NUMBER,MONTH_NUMBER,POLLUTE_NAME,POLLUTE_VALUE "
                    + "ORDER BY POINT_NAME,YEAR_NUMBER,MONTH_NUMBER ASC";
            timeMap = DateUtil.getBetweenMonth(param.getStartTime(), param.getEndTime());

            indexmap = (Map<String, Integer>) timeMap.get("indexmap");
            xAxis = (List<String>) timeMap.get("xList");
            list = simpleDao.createNativeQuery(sql).getResultList();
            Map<String, Object[]> series = new HashMap<String, Object[]>();
            for (Object[] obj : list) {
                if (obj[0] != null) {
                    Date parse = df.parse(obj[3].toString() + "-" + obj[4].toString());
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
     * <p>Title: getPassYearAnalysis</p>
     * <p>Description: 在线水站点污染往年同比数据分析</p>
     *
     * @param param
     * @return
     * @throws ParseException
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMonthDataService#getPassYearAnalysis(com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassYearAnalysis(WtMonthDataParam param) throws ParseException {
        List<Object[]> list = null;
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis;
        String sql;

        Map<String, Integer> indexmap;
        Map<String, Object> timeMap = DateUtil.getYearMonth(Integer.parseInt(param.getStartTime()));
        String startTime = timeMap.get("year1").toString();
        String endTime = timeMap.get("year2").toString();
        xAxis = (List<String>) timeMap.get("xList");
        indexmap = (Map<String, Integer>) timeMap.get("indexmap");
        sql = "SELECT YEAR_NUMBER,MONTH_NUMBER,POLLUTE_VALUE,POINT_NAME FROM WT_MONTH_DATA WHERE POINT_CODE = ? AND CODE_POLLUTE = ? AND "
                + "(YEAR_NUMBER=? or YEAR_NUMBER=?) ORDER BY YEAR_NUMBER,MONTH_NUMBER DESC";
        list = simpleDao.createNativeQuery(sql, param.getPointCode(), param.getPollutes(), startTime, endTime).getResultList();


        Map<String, Object[]> series = new HashMap<String, Object[]>();
        for (Object[] obj : list) {
            if (obj[0] != null) {
                if (series.containsKey(obj[0].toString())) {
                    if (obj[2] != null) {
                        series.get(obj[0].toString())[indexmap.get(obj[1].toString())] = obj[2];
                    }
                } else {
                    Object[] tempList = new Object[indexmap.size()];
                    if (obj[2] != null) {
                        tempList[indexmap.get(obj[1].toString())] = obj[2];
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
        result.put("title", list.size() > 0 ? list.get(0)[3].toString() : "暂无数据");
        result.put("formatter", "{value}");
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


}