package com.fjzxdz.ams.module.enviromonit.pollution.service;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;

import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

/**
 * @Author lianhuinan
 * @Description //TODO
 * @Date 2019/9/11 0011 17:00
 * @version 1.0
 **/
public interface PollutionInfoService {

    /**
     * @Author lianhuinan
     * @Description //TODO(工业废水企业区县划分统计)
     * @Date 2019/9/11 0011 16:58
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getIndustrialWasteWaterEnterpriseCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(工业废气企业区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getIndustrialWasteAirEnterpriseCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(微型水质自动站区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getAutoWaterQualityMonitorStationCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(自建空气监测站区县划分统计)
     * @Date 2019/9/11 0011 16:59
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getAutoAirQualityMonitorStationCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(工地区县划分)
     * @Date 2019/9/18 0018 15:18
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getAirConstructionSiteCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(水库区县划分)
     * @Date 2019/9/18 0018 15:33
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getReservoirCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(污水处理厂/常规排口区县划分)
     * @Date 2019/9/18 0018 15:41
     * @param type
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getConventionalVentingCountQX(String type);

    /**
     * @Author lianhuinan
     * @Description //TODO(小流域区县划分)
     * @Date 2019/9/18 0018 16:01
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getBasinMonitorCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(废弃排口区县划分)
     * @Date 2019/9/18 0018 16:11
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> getExhaustGasOutletCountQX();

    /**
     * @Author lianhuinan
     * @Description //TODO(获取污染源大数据区县划分)
     * @Date 2019/9/11 0011 16:58
     * @param
     * @return java.util.concurrent.Future<com.alibaba.fastjson.JSONArray>
     * @version 1.0
     **/
    Future<JSONArray> countPollutionByArea(String wrylx, String wryzl);

    void saveInfo(PollutionInfoData pollutionInfoData);

    void deleteInfo(String pkid);


    List<Map> checkLastWeekAlreadyUpdateInfo();

    List<Map> dynamicCountPollutionInfo();
}
