package com.fjzxdz.ams.zphb.module.enviromonit.water.service;

import com.alibaba.fastjson.JSONArray;

import java.util.List;
import java.util.Map;

public interface ZpWtCityHourReportService {

    /**
     * 监控情况统计 【污水处理厂】【常规口】【污普废水企业】【微型水质自动站】【小流域】
     * @return
     */
    JSONArray countMonitorSituation();
    /**
     * 考核目标 【国考断面】【省考断面】
     *
     * @param date
     */
    Map assessmentTarget(String date);

    /**
     * 考核目标 【国考断面】【省考断面】
     *
     * @param date
     */
     Map wtData(String date);

    /**
     * 检测站点详情 国考  省考
     * @param flag 国考省考标志
     * @param map 参数集合
     * @return List<Object>
     */
    List<Object> getDetailList4Month(String flag, Map map);

    List<Object> getDetailList4Months(String flag, Map map);
}
