package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtSectionMonthDataDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtHourDataService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionFactorService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionMonthDataService;
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
public class WtSectionMonthDataServiceImpl implements WtSectionMonthDataService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private WtSectionMonthDataDao wtSectionMonthDataDao;

    @Autowired
    private WtSectionFactorService wtSectionFactorService;

    /**
     * <p>Title: getListByCode</p>
     * <p>Description:  获取站点信息</p>
     *
     * @param pointCode
     * @return
     * @see WtHourDataService#getListByCode(String)
     */
    @Override
    public List<WtSectionMonthData> getListByCode(String pointCode) {
        List<WtSectionMonthData> list = simpleDao.find("from WtHourData where monitorTime = (SELECT MAX( monitorTime ) FROM WtSessionMonthReport) and pointCode='" + pointCode + "'");
        return list;
    }


    @Override
    public Page<WtSectionMonthData> listByPage(WtSectionMonthDataParam param, Page<WtSectionMonthData> page) {
        return wtSectionMonthDataDao.listByPage(param, page);
    }

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 数据服务在线水表格分页数据</p>
     *
     * @param param
     * @param page
     * @return
     * @see WtHourDataService#getPageList(WtHourDataParam, Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(WtSectionMonthDataParam param, Page<Map<String, Object>> page) {
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
        String sql = "SELECT a.DATATIME, a.SECTION_CODE, a.SECTION_NAME,sum(DECODE( CODE_POLLUTE, 'W01010', DATAVALUE, 0 )) W01010,"
                + "sum(DECODE( CODE_POLLUTE, 'W01001', DATAVALUE, 0 )) W01001, sum(DECODE( CODE_POLLUTE, 'W01009', DATAVALUE, 0 )) W01009,"
                + "sum(DECODE( CODE_POLLUTE, 'W01014', DATAVALUE, 0 )) W01014, sum(DECODE( CODE_POLLUTE, 'W01003', DATAVALUE, 0 )) W01003,"
                + "sum(DECODE( CODE_POLLUTE, 'W01019', DATAVALUE, 0 )) W01019, sum(DECODE( CODE_POLLUTE, 'W21003', DATAVALUE, 0 )) W21003,"
                + "sum(DECODE( CODE_POLLUTE, 'W21011', DATAVALUE, 0 )) W21011, sum(DECODE( CODE_POLLUTE, 'W21001', DATAVALUE, 0 )) W21001,"
                + "TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) EXCESSFACTORSTR "
                + "FROM WT_SECTION_MONTH_DATA a INNER JOIN WT_SECTION_MONTH_REPORT b ON a.DATATIME=b.DATATIME and a.SECTION_CODE=b.SECTION_CODE "
                + "INNER JOIN WT_SECTION_POINT c ON a.SECTION_CODE=c.SECTION_CODE AND c.CATEGORY=2 "
                + where
                + "GROUP BY a.DATATIME, a.POINT_CODE, a.SECTION_NAME,TARGET_QUALITY,RESULT_QUALITY,TO_CHAR(EXCESSFACTORSTR) ORDER BY DATATIME DESC";
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
     * @see WtHourDataService#getPassMonthAnalysis(WtHourDataParam)
     */
    @SuppressWarnings("unchecked")
    @Override
    public Map<String, Object> getPassMonthAnalysis(WtSectionMonthDataParam param) throws ParseException {
        List<Object[]> list;
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
        sql = "SELECT DATATIME,POLLUTE_VALUE,SESSION_NAME FROM WT_SECTION_MONTH_DATA WHERE SESSION_CODE = ? AND CODE_POLLUTE = ? "
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


    @Override
    public void batchSaveWtSectionMonthData(List<WtSectionMonthData> list) {

        try {
            wtSectionMonthDataDao.saveBatch(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<JSONObject> getPolluteValueAverageBySectionCode(String sectionCode, Integer yearNumber, Integer monthNumber) {
        StringBuilder sql = new StringBuilder();

        JSONArray factoryArray = wtSectionFactorService.getFactorList();
        for (int i = 0; i < factoryArray.size(); i++) {
            JSONObject factorObj = factoryArray.getJSONObject(i);

            String codePollute = factorObj.getString("codePollute").toUpperCase();
            if (factorObj.getInteger("state") != null && factorObj.getInteger("state") > 0) {
                if (sql.length() > 0) {
                    sql.append("\n union \n");
                }
                sql.append("SELECT CODE_POLLUTE as codePollute,AVG(pollute_value) as polluteValue, POLLUTE_NAME as polluteName from WT_SECTION_MONTH_DATA where 1=1");
                sql.append(" and SECTION_CODE='" + sectionCode + "'");
                sql.append(" and YEAR_NUMBER='" + yearNumber + "'");
                sql.append(" and MONTH_NUMBER<='" + monthNumber + "'");
                sql.append(" and CODE_POLLUTE='" + codePollute + "'");
                sql.append(" GROUP BY CODE_POLLUTE, POLLUTE_NAME");
            }

        }

        List<Object> result = wtSectionMonthDataDao.createNativeQuery(sql.toString()).getResultList();

        List<JSONObject> polluteAverageList = new ArrayList<>();
        for (int i = 0; i < result.size(); i++) {
            Object[] dataObj = (Object[]) result.get(i);

            int j = 0;
            JSONObject obj = new JSONObject();
            obj.put("codePollute", dataObj[j++]);
            obj.put("polluteValue", dataObj[j++]);
            obj.put("polluteName", dataObj[j++]);

            polluteAverageList.add(obj);
        }

        return polluteAverageList;
    }
}
