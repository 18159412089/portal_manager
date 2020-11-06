package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterDataShowService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourReportService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.math.BigDecimal;
import java.util.*;

@Service
@Transactional(rollbackFor = Exception.class)
public class WaterDataShowServiceImpl implements WaterDataShowService {
    @Autowired
    private SimpleDao simpleDao;


    /***
     * 小河流域一年的数据情况所有小河流域数据;
     * @return
     */
    @Override
    public List<Object> listRiverData(int month) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT A.MONITOR_CODE,A.MONITOR_NAME,A.LONGITUDE,A.LATITUDE,B.PH_VALUE, ");
        stringBuilder.append(" B.PH_LEVEL,B.RJY_VALUE,B.RJY_LEVEL,GMSY_VALUE,B.GMSY_LEVEL,B.BOD_VALUE,B.BOD_LEVEL,B.ZL_VALUE,B.ZL_LEVEL,B.ANDAN_VALUE,B.ANDAN_LEVEL,");
        stringBuilder.append("B.TARGET_QUALITY,B.RESULT_QUALITY,A.LINES,B.YEAR_NUMBER,B.MONTH_NUMBER,A.ANALYSIS");
        stringBuilder.append("FROM WT_BASIN_MONITOR where B.MONITOR_CODE IS NOT NULL ");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString());
        return nativeQuery.getResultList();
    }

    /***
     * 获取小河流域年目标水质情况比例
     * 算出两个比例然后比较就可以判断
     * @param  month 年份;
     * @return
     * 说明小河流域目标水质比较
     * 每一个流域的从开始到结束的平均质量结果然后比上
     * 所有的结果就是需要的数据
     */

    @Override
    public List<Map<String, Object>> listRiverDataScale(int year, int month, String name) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT  a.BASIN_NAME,ROUND(AVG(replace(a.PH_VALUE,'L','')), 3),ROUND(AVG(replace(a.RJY_VALUE,'L','')), 3),ROUND(AVG(replace(a.GMSY_VALUE,'L','')), 3),ROUND(AVG(replace(a.ANDAN_VALUE,'L','')), 3),ROUND(AVG(replace(a.ZL_VALUE,'L','')), 3),ROUND(AVG(replace(a.BOD_VALUE,'L','')), 3),a.BASIN_CODE from WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.YEAR_NUMBER = '" + year + "' and a.MONTH_NUMBER >='1' ");
        if (StringUtils.isNotBlank(name)) {
            stringBuilder.append(" AND a.BASIN_NAME='" + name + "'");
        }
        stringBuilder.append(" group by a.basin_name,a.BASIN_CODE");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString());
        List<Object[]> resultList = nativeQuery.getResultList();
        JSONArray dataArray = null;
        List<Map<String, Object>> list = new ArrayList<>();
        JSONObject jsonObject = null;
        JSONObject jsonObject1 = null;
        JSONObject jsonObject2 = null;
        JSONObject jsonObject3 = null;
        JSONObject jsonObject4 = null;
        JSONObject jsonObject5 = null;
        Map<String, Object> dataMap = null;

        for (Object[] objects : resultList) {
            dataArray = new JSONArray();
            jsonObject = new JSONObject();
            jsonObject1 = new JSONObject();
            jsonObject2 = new JSONObject();
            jsonObject3 = new JSONObject();
            jsonObject4 = new JSONObject();
            jsonObject5 = new JSONObject();
            jsonObject.put("polluteName", "pH");
            jsonObject.put("polluteValue", new BigDecimal(String.valueOf(objects[1])));
            jsonObject.put("codePollute", "W01001");
            jsonObject1.put("polluteName", "溶解氧");
            jsonObject1.put("polluteValue", new BigDecimal(String.valueOf(objects[2])));
            jsonObject1.put("codePollute", "W01009");
            jsonObject2.put("polluteName", "高锰酸盐");
            jsonObject2.put("polluteValue", new BigDecimal(String.valueOf(objects[3])));
            jsonObject2.put("codePollute", "W01019");
            jsonObject3.put("polluteName", "氨氮");
            jsonObject3.put("polluteValue", new BigDecimal(String.valueOf(objects[4])));
            jsonObject3.put("codePollute", "W21003");
            jsonObject4.put("polluteName", "总磷(以p计)");
            jsonObject4.put("polluteValue", new BigDecimal(String.valueOf(objects[5])));
            jsonObject4.put("codePollute", "W21011");
            jsonObject5.put("polluteName", "五日生化需氧量(BOD5)");
            jsonObject5.put("polluteValue", new BigDecimal(String.valueOf(objects[6])));
            jsonObject5.put("codePollute", "W01017");
            dataArray.add(jsonObject);
            dataArray.add(jsonObject1);
            dataArray.add(jsonObject2);
            dataArray.add(jsonObject3);
            dataArray.add(jsonObject4);
            dataArray.add(jsonObject5);
            WaterQualityEnum targetQuality = WaterQualityEnum.valueOf("THIRD");
            cn.hutool.json.JSONObject waterQuality = WaterQualityUtil.getWaterQuality(dataArray, "0", targetQuality);
            Object resultQuality = waterQuality.get("resultQuality");
            dataMap = new HashMap<>();
            dataMap.put("resultQuality", resultQuality);
            dataMap.put("basinName", objects[0]);
            dataMap.put("basinCode", objects[7]);
            list.add(dataMap);
        }
        return list;
    }

    /**
     * 不升反降流域;
     * 当月份比较之前月份的平均质量;
     *
     * @param month
     * @return List<Oject [ ]> object[0] baseName;object[1] 测试质量;
     */
    @Override
    public List<Object[]> listRiverCurrentMonthQuality(int month) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT a.BASIN_NAME,a.RESULT_QUALITY from WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.YEAR_NUMBER = '2019' AND a.MONTH_NUMBER = '" + month + "' group by a.BASIN_NAME");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString());

        return nativeQuery.getResultList();
    }

    /**
     * 一年中的每一个月的数据的测试质量
     * 用一个流域名称获取这个流域一年的质量等级;
     *
     * @param year
     * @param month
     * @param targetName
     * @return List</ object [ ]> object[0] basin_name,object[1]result_quality
     */
    @Override
    public List<Object[]> listTargetRiverByName(int year, int month, String targetName) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT a.BASIN_NAME,RESULT_QUALITY ,a.MONTH_NUMBER FROM WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.YEAR_NUMBER = '" + year + "' AND a.BASIN_NAME =?");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString(), targetName);
        return nativeQuery.getResultList();
    }

    /**
     * 获取小河流的详情本来是显示1-5月的 现在只显示1-3月的数据;
     *
     * @param targetName
     * @param month
     * @return
     */
    @Override
    public List<Map<String, Object>> listRiverDetailByName(String targetName, int month) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT a.UUID,a.YEAR_NUMBER,a.MONTH_NUMBER,a.BASIN_NAME,a.PH_VALUE,a.PH_LEVEL,a.RJY_VALUE,a.RJY_LEVEL,a.GMSY_VALUE");
        stringBuilder.append(",a.GMSY_LEVEL, a.BOD_VALUE,a.BOD_LEVEL,a.ZL_VALUE,a.ZL_LEVEL,a.ANDAN_VALUE,a.ANDAN_LEVEL,a.TARGET_QUALITY,a.RESULT_QUALITY FROM WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.BASIN_NAME =? and a.year_number='2019' and a.month_number>=1  order by a.year_number ,a.month_number");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString(), targetName);
        List<Object[]> dataList = nativeQuery.getResultList();
        List<Map<String, Object>> resultList = new ArrayList<>();
        Map<String, Object> stringObjectMap = null;

        for (Object[] object : dataList) {
            stringObjectMap = new HashMap<>();
            stringObjectMap.put("uuid", object[0]);
            stringObjectMap.put("yearNumber", object[1]);
            stringObjectMap.put("monthNumber", object[2]);
            stringObjectMap.put("basinName", object[3]);
            stringObjectMap.put("phValue", object[4]);
            stringObjectMap.put("phLevel", object[5]);
            stringObjectMap.put("rjyValue", object[6]);
            stringObjectMap.put("rjyLevel", object[7]);
            stringObjectMap.put("gmsyValue", object[8]);
            stringObjectMap.put("gmsyLevel", object[9]);
            stringObjectMap.put("bodValue", object[10]);
            stringObjectMap.put("bodLevel", object[11]);
            stringObjectMap.put("zlValue", object[12]);
            stringObjectMap.put("zlLevel", object[13]);
            stringObjectMap.put("andanValue", object[14]);
            stringObjectMap.put("andanLevel", object[15]);
            stringObjectMap.put("targetQuality", object[16]);
            stringObjectMap.put("resultQuality", object[17]);

            resultList.add(stringObjectMap);
        }

        return resultList;
    }

    /**
     * 获取一条流域的同比数据
     *
     * @param basinName
     * @param year
     * @return
     */
    @Override
    public List<Map<String, Object>> listScaleCompareToLastYear(String basinName, int year, int month) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT a.BASIN_NAME,a.RESULT_QUALITY FROM WT_BASIN_MONTH_DATA a  ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.BASIN_NAME =? and a.year_number='" + year + "' ");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString(), basinName);
        List<Object[]> objList = nativeQuery.getResultList();
        List<Map<String, Object>> dataList = new ArrayList<>();
        Map<String, Object> dataMap = null;
        for (Object[] obj : objList) {
            dataMap = new HashMap<>();
            dataMap.put("basinName", obj[0]);
            dataMap.put("resultQuality", obj[1]);
            dataList.add(dataMap);
        }
        return dataList;
    }

    @Autowired
    private WtCityHourReportService reportService;

    /**
     * 获取最新的小河流域数据
     */
    public List<Map<String, Object>> getRiverNewData(int year) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT distinct a.BASIN_NAME,a.RESULT_QUALITY,a.MONTH_NUMBER FROM  WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1 ");
        stringBuilder.append("and a.YEAR_NUMBER='" + year + "' order by a.MONTH_NUMBER");
        //(select max(MONTH_NUMBER) from WT_BASIN_MONTH_DATA where YEAR_NUMBER='"+year+"')
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString());
        List<Object[]> objList = nativeQuery.getResultList();
        Collections.sort(objList, new Comparator<Object[]>() {
            @Override
            public int compare(Object[] o1, Object[] o2) {
                return WaterQualityUtil.formatVal(o2[1].toString()) - WaterQualityUtil.formatVal(o1[1].toString());
            }

        });
        List<Map<String, Object>> dataList = new ArrayList<>();
        Map<String, Object> dataMap = null;
        for (Object[] obj : objList) {
            dataMap = new HashMap<>();
            dataMap.put("basinName", obj[0]);
            dataMap.put("resultQuality", WaterQualityEnum.valueOf(String.valueOf(obj[1])).getValue().replace("类", ""));
            dataList.add(dataMap);
        }
        return dataList;
    }

    /**
     * 获取不重复的小河流域的名称(通过名称可以获取小河流域的平均值和同比情况)
     *
     * @return
     */
    @Override
    public List<String> getBasinNameData() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("SELECT distinct a.BASIN_NAME FROM  WT_BASIN_MONTH_DATA a ");
        stringBuilder.append("LEFT JOIN WT_BASIN_MONITOR b on a.BASIN_CODE=b.MONITOR_CODE where b.ischeck=1");
        Query nativeQuery = simpleDao.createNativeQuery(stringBuilder.toString());
        return nativeQuery.getResultList();
    }


}
