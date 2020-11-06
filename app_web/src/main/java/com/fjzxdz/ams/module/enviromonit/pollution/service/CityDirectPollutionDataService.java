package com.fjzxdz.ams.module.enviromonit.pollution.service;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.CityDirectPollutionData;

import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

/**
 * @version 1.0
 * @Author lianhuinan
 * @Description //TODO
 * @Date 2019/9/11 0011 17:00
 **/
public interface CityDirectPollutionDataService {

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(工业废水企业区县划分统计)
     * @Date 2019/9/11 0011 16:58
     * @version 1.0
     **/
    Future<JSONArray> getIndustrialWasteWaterEnterpriseCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(工业废气企业区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @version 1.0
     **/
    Future<JSONArray> getIndustrialWasteAirEnterpriseCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(微型水质自动站区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @version 1.0
     **/
    Future<JSONArray> getAutoWaterQualityMonitorStationCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(自建空气监测站区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @version 1.0
     **/
    Future<JSONArray> getAutoAirQualityMonitorStationCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(工地区县划分)
     * @Date 2019/9/18 0018 15:18
     * @version 1.0
     **/
    Future<JSONArray> getAirConstructionSiteCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(水库区县划分)
     * @Date 2019/9/18 0018 15:33
     * @version 1.0
     **/
    Future<JSONArray> getReservoirCountQX();

    /**
     * @param type
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(污水处理厂/常规排口区县划分)
     * @Date 2019/9/18 0018 15:41
     * @version 1.0
     **/
    Future<JSONArray> getConventionalVentingCountQX(String type);

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(小流域区县划分)
     * @Date 2019/9/18 0018 16:01
     * @version 1.0
     **/
    Future<JSONArray> getBasinMonitorCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(废弃排口区县划分)
     * @Date 2019/9/18 0018 16:11
     * @version 1.0
     **/
    Future<JSONArray> getExhaustGasOutletCountQX();

    /**
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @Author lianhuinan
     * @Description //TODO(获取污染源大数据区县划分)
     * @Date 2019/9/11 0011 16:58
     * @version 1.0
     **/
    Future<JSONArray> countPollutionByArea(List departName, String wrylx, String wryzl);

    void saveInfo(CityDirectPollutionData pollutionInfoData);

    void deleteInfo(String pkid);

    /**
     * 动态查询市直查所有单位下的污染源种类以及汇总
     *
     * @return
     */
    List<Map> dynamicCountCityDirectPollutionInfo();

    List<Map> checkLastWeekAlreadyUpdateInfo();

    String patternValid(CityDirectPollutionData pollutionInfoData);

    /**
     * @param result
     * @return java.lang.String
     * @Author lianhuinan
     * @Description //TODO(导入数据处理)
     * @Date 2019/10/11 0011 11:18
     * @version 1.0
     **/
    String save(List<List<Object>> result, String deptPath) throws Exception;
}
