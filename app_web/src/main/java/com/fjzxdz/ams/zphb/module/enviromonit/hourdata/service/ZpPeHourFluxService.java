package com.fjzxdz.ams.zphb.module.enviromonit.hourdata.service;

import java.util.concurrent.Future;

public interface ZpPeHourFluxService {

    /**
     * @Author lianhuinan
     * @Description //TODO(添加该排口的天累计流量统计)
     * @Date 2019/9/11 0011 13:25
     * @param peId
     * @return java.util.concurrent.Future<java.lang.Object>
     * @version 1.0
     **/
    Future<Object> getDaySumFlux(String peId);

    /**
     * @Author lianhuinan
     * @Description //TODO(添加该排口的天累计流量统计)
     * @Date 2019/9/11 0011 13:26
     * @param peId
     * @return java.util.concurrent.Future<java.lang.Object>
     * @version 1.0
     **/
    Future<Object> getMonthSumFlux(String peId);

    /**
     * @Author lianhuinan
     * @Description //TODO(添加该排口的天累计流量统计)
     * @Date 2019/9/11 0011 13:26
     * @param peId
     * @return java.util.concurrent.Future<java.lang.Object>
     * @version 1.0
     **/
    Future<Object> getYearSumFlux(String peId);
}
