package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;

import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

/**
 * 空气日数据业务层(拓展)
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年4月29日 下午3:14:32
 */
public interface ZpAirDailyService {

    /**
     * @param time
     * @param pointCode
     * @return List<Object [ ]>
     * @throws
     * @Title: airAqiForYear
     * @Description: 查询一年的AQI指数日报
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:16:44
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:16:44
     */
    List<Object[]> airAqiForYear(String time, String pointCode);

    /**
     * @param startTime
     * @param citys
     * @return List<Object [ ]>
     * @throws
     * @Title: getAllAQI
     * @Description: 获取该时间里所有城市站点的AQI
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:16:53
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:16:53
     */
    List<Object[]> getAllAQI(String startTime, String citys);

    /**
     * @param start
     * @param end
     * @param citys
     * @return List<Object [ ]>
     * @throws
     * @Title: getAllAQIByTime
     * @Description: 获取本年里所有城市站点的AQI
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:17:02
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:17:02
     */
    List<Object[]> getAllAQIByTime(String start, String end, String citys);

    /**
     * @param param
     * @param page
     * @return Page<Map < String, Object>>
     * @throws
     * @Title: listByPage
     * @Description: 日报分页查询
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:17:12
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:17:12
     */
    Page<Map<String, Object>> listByPage(AirDayDataParam param, Page<Map<String, Object>> page);

    /**
     * @param pointCode
     * @param time
     * @return List<Object [ ]>
     * @throws
     * @Title: getCurAirQuality
     * @Description: 空气质量日报信息
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:17:21
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:17:21
     */
    List<Object[]> getCurAirQuality(String pointCode, String time);

    /**
     * @param param
     * @return List<Object [ ]>
     * @throws
     * @Title: getAirQualityChart
     * @Description: 本年本地区空气质量状况统计图
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:17:31
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:17:31
     */
    List<Object[]> getAirQualityChart(AirDayDataParam param);

    /**
     * @param pointCode
     * @param startTime
     * @param endTime
     * @param yearNum
     * @return Map<String, Object>
     * @throws
     * @Title: getAllLevelsDays
     * @Description: 本地区各级天数 历年比较
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:17:44
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:17:44
     */
    Map<String, Object> getAllLevelsDays(String pointCode, String startTime, String endTime, String yearNum);

    /**
     * @param pointCode
     * @param startTime
     * @param endTime
     * @param yearNum
     * @return JSONArray
     * @throws
     * @Title: getAllLevelsDaysForm
     * @Description: 获取年度本地区的空气分布信息
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:27:26
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:27:26
     */
    JSONArray getAllLevelsDaysForm(String pointCode, String startTime, String endTime, String yearNum);

    /**
     * @param param
     * @return Map<String, Object>
     * @throws
     * @Title: getPollutantGroupBy
     * @Description: 本地区首要污染物天数构成
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:18:01
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:18:01
     */
    Map<String, Object> getPollutantGroupBy(AirDayDataParam param);

    /**
     * @param param
     * @return Map<String, Object>
     * @throws
     * @Title: getPollutantPassYear
     * @Description: 首要污染物天数变化
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:18:09
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:18:09
     */
    Map<String, Object> getPollutantPassYear(AirDayDataParam param);

    /**
     * @param param
     * @param page
     * @return JSONArray
     * @throws
     * @Title: getPollutantPassYear
     * @Description: 历年本地区首要污染物信息
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年4月29日 下午3:18:18
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年4月29日 下午3:18:18
     */
    JSONArray getPollutantPassYear(AirDayDataParam param, Page<Map<String, Object>> page);

    /*
     * @Title:
     * @Description:    (获取aqi排名前三或者后三的数据(前三值得是aqi最小的三位)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/26 11:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/26 11:29
     * @param param
     * @param page
     * @return com.alibaba.fastjson.JSONArray
     */
    List<Map<String, Object>> getAQIDataRank(AirDayDataParam param, String sort, String TimeType, String pointType);

    /*
     * @Title:
     * @Description:    (获取大气环境aqiEchart图)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/27 9:24
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/27 9:24
     * @param param
     * @param sort
     * @param TimeType
     * @param pointType
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    Map<String, Object> getAQIEchart(AirDayDataParam param, String sort, String TimeType, String pointType);

    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param page
     * @param response
     * @return cn.fjzxdz.frame.common.Page<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title:
     * @Description: (获取aqi分析的页面值)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/4 15:22
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/4 15:22
     */
    Page<Map<String, Object>> getTextAQIByPointName(AirDayDataParam param, String factor, String pointType,
                                                    String timeType, Page<Map<String, Object>> page,
                                                    HttpServletResponse response);

    /*
     * @Title:
     * @Description:    (城市因子获取可以使用的数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/28 17:08
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/28 17:08
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param groupBy
     * @param orderBy
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    Map<String, Object> getEchartFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType);    /*
     * @Title:
     * @Description:    (城市因子文字获取可以使用的数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/6/28 17:08
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/6/28 17:08
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param groupBy
     * @param orderBy
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */

    Page<Map<String, Object>> getTextFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType, Page<Map<String, Object>> page, HttpServletResponse response);

    /**
     * 均值比较 大气
     *
     * @param param
     * @return
     */
    Map<String, Object> getAirMeanEchart(AirDayDataParam param);

    /**
     * 优良天数 大气
     *
     * @param param
     * @return
     */
    Map getAirExcellentGoodEchart(AirDayDataParam param);

    /***
     * @Title:
     * @Description: (获取城市均值比较的前三位)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:40
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:40
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort(front取前三位)
     * @param sort(leanback取后三位)
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     */
    List<Map<String, Object>> getRankFactorByRegionName(AirDayDataParam param, String factor, String pointType, String timeType, String sort);

    /**
     * @param param     大气实体
     * @param factor    因子
     * @param pointType 站点类型
     * @param timeType  时间类型
     * @param sort      排序使用
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title:
     * @Description: ()
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 12:00
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 12:00
     */
    Map<String, Object> getExcessAQICityEchart(AirDayDataParam param, String factor, String pointType, String timeType, String sort);/*
     * @Title:
     * @Description:    (获取文字aqi)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 12:05
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 12:05
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */

    Page<Map<String, Object>> getExcessAQICityText(AirDayDataParam param, String factor, String pointType, String timeType, Page<Map<String, Object>> page, HttpServletResponse response);

    /*
     * @Title:
     * @Description:    (AQI超标分析获取前三和后三个数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/3 13:08
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/3 13:08
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @param sort
     * @return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    List<Map<String, Object>> getExcessAQICityRank(AirDayDataParam param, String factor, String pointType, String timeType, String sort);

    /**
     * 均值比较 大气 表格
     *
     * @param param
     * @return
     */
    Page<Map<String, Object>> getAirMeanEchartPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response);


    /**
     * 优良天数 大气 表格
     *
     * @param param
     * @param page
     * @param response
     * @return
     */
    PageEU<Map<String, Object>> getExcellentGoodDaysPage(AirDayDataParam param, Page<Map<String, Object>> page, HttpServletResponse response);

    /***
     * @Title:
     * @Description: (获取AQI的同比数据同比指的是当年的数据和选择年份的数据的相比情况)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/8 11:19
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/8 11:19
     * @param param 获取时间查询时间根据查询时间来进行数据的拼装
     * @param timeType 时间类型有 day和month两种
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     */
    List<Map<String, Object>> getAQIYearOnYearDataShow(String searchYear, String currentYear, String timeType, String pointCode, String pointType, int countMonthDay);

    /**
     * @param searchYearAndMonth 查找的年月
     * @param pointCode
     * @param pointType
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title:
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/11 10:32
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/11 10:32
     */
    List<Map<String, Object>> getAQIRingRatioDataShow(String searchYearAndMonth, String pointCode, String pointType);

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
    List<Map<String, Object>> getPassYearExcellentAnalysisAirMorePoint(String polluteName, String pointCode, String time, int year) throws ParseException;

    /**
     * 获取比较数据 因子-同比-监测站因子
     *
     * @param pointCode 站点
     * @param year      对比年度
     * @param rq        比较日期 日 月
     * @return
     */
    Map<String, Object> getCompareData(String pointCode, int year, String rq);

    /**
     * 获取比较数据 优良天数-环比-监测站因子
     *
     * @param time   对比时间
     * @param pointCode  站点编码
     * @param flag 优良区别
     * @return
     */
    List<Map> getMapsByMonth(String time, String pointCode, String flag);
}
