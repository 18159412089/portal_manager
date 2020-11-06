package com.fjzxdz.ams.module.enviromonit.air.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.*;

/**
 * 首要污染物变化分析 页面 controller
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午3:13:09
 */
@Controller
@RequestMapping("/enviromonit/airPrimaryPollutant")
@Secured({"ROLE_USER"})
public class AirPrimaryPollutantController extends BaseController {

    @Autowired
    private AirDailyService airDailyService;

    /**
     * @return String
     * @throws
     * @Title: getAirQualityPollutant
     * @Description: 数据服务 空气环境质量  跳转到首要污染物变化分析页面
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午3:32:23
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午3:32:23
     */
    @RequestMapping(value = "")
    public String getAirQualityPollutant() {
        return "/moudles/enviromonit/air/airPrimaryPollutant";
    }

    /**
     * @param param
     * @return R
     * @throws
     * @Title: getAirPrimaryPollutant
     * @Description: 本地区首要污染物天数构成
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午3:33:49
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午3:33:49
     */
    @RequestMapping(value = "/getAirPrimaryPollutant")
    @ResponseBody
    public R getAirPrimaryPollutant(AirDayDataParam param) {
        Map<String, Object> map = airDailyService.getPollutantGroupBy(param);
        return R.ok(map);
    }

    /**
     * @param param
     * @return R
     * @throws
     * @Title: getAllLevelsDays
     * @Description: 首要污染物天数变化
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午3:34:37
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午3:34:37
     */
    @RequestMapping(value = "/getPrimaryPollutantData")
    @ResponseBody
    public R getAllLevelsDays(AirDayDataParam param) {
        Map<String, Object> map = airDailyService.getPollutantPassYear(param);
        return R.ok(map);
    }

    /**
     * @param param
     * @param request
     * @return PageEU<Map < String, Object>>
     * @throws
     * @Title: list
     * @Description: 历年本地区首要污染物信息
     * @CreateBy: zhongyunlong
     * @CreateTime: 2019年5月9日 下午3:35:37
     * @UpdateBy: zhongyunlong
     * @UpdateTime: 2019年5月9日 下午3:35:37
     */
    @RequestMapping("/list")
    @ResponseBody
    public PageEU<Map<String, Object>> list(AirDayDataParam param, HttpServletRequest request) {

        Page<Map<String, Object>> page = pageQuery(request);
        try {
            JSONArray jsonArray = airDailyService.getPollutantPassYear(param, page);
            List<Map<String, Object>> list = new ArrayList<>();
            if (jsonArray != null) {
                page.setTotalCount(jsonArray.size());
                if (page.isNext()) {
                    for (int i = page.getLimit() * page.getCurrentPage(); i < page.getLimit() * page.getCurrentPage()
                            + 10; i++) {
                        Map<String, Object> tempMap = jsonArray.getJSONObject(i);

                        list.add(tempMap);
                    }
                    page.setResult(list);
                } else {
                    for (int i = page.getLimit() * page.getCurrentPage(); i < page.getTotalCount(); i++) {
                        Map<String, Object> tempMap = jsonArray.getJSONObject(i);

                        list.add(tempMap);
                    }
                    page.setResult(list);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new PageEU<>(page);
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
    @RequestMapping(value = "/getAQIDataRank")
    @ResponseBody
    public List<Map<String, Object>> getAIRQualityPrimaryRank(AirDayDataParam param, String sort, String timeType, String pointType) {
        return airDailyService.getAQIDataRank(param, sort, timeType, pointType);
    }

    @RequestMapping(value = "/getAQIEchart")
    @ResponseBody
    public Map<String, Object> getAIREchart(AirDayDataParam param, String sort, String timeType, String pointType) {
        return airDailyService.getAQIEchart(param, sort, timeType, pointType);
    }

    @RequestMapping(value = "/getAQIText")
    @ResponseBody
    public PageEU getAQIText(AirDayDataParam param, HttpServletRequest request, HttpServletResponse response, String pointType, String timeType) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> textAQIByPointName = airDailyService.getTextAQIByPointName(param, null, pointType, timeType, page, response);
        if (textAQIByPointName == null) {
            return null;
        }
        return new PageEU<>(textAQIByPointName);
    }

    /**
     * 均值比较 大气
     *
     * @param param
     * @return
     */
    @RequestMapping(value = "/getAirMeanEchart")
    @ResponseBody
    public Map<String, Object> getAirMeanEchart(AirDayDataParam param) {
        Map<String, Object> airMeanEchart = airDailyService.getAirMeanEchart(param);
        param.setExportTitle("topAndBottom");
        airMeanEchart.put("topAndBottom", airDailyService.getAirMeanEchart(param));
        return airMeanEchart;
    }

    /**
     * 均值比较 大气 表格
     *
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getAirMeanEchartPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getAirMeanEchartPage(AirDayDataParam param, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> airMeanEchartPage = airDailyService.getAirMeanEchartPage(param, page, response);
        if (ToolUtil.isEmpty(airMeanEchartPage)) {
            return null;
        }
        return new PageEU<>(airMeanEchartPage);
    }


    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @Title:
     * @Description: (获取时间段内的数据形式城市各因子的均值)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:29
     */
    @RequestMapping(value = "/getFactorRegionNameEchart")
    @ResponseBody
    public Map<String, Object> getFactorRegionEchart(AirDayDataParam param, String factor, String pointType, String timeType) {
        return airDailyService.getEchartFactorByRegionName(param, factor, pointType, timeType);
    }

    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @Title:
     * @Description: (获取时间段内的数据形式城市各因子的均值)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:29
     */
    @RequestMapping(value = "/getFactorRegionNameText")
    @ResponseBody
    public PageEU<Map<String, Object>> getFactorRegionText(AirDayDataParam param, String factor, String pointType, String timeType, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> textFactorByRegionName = airDailyService.getTextFactorByRegionName(param, factor, pointType, timeType, page, response);
        if (textFactorByRegionName == null) {
            return null;
        }
        return new PageEU<>(textFactorByRegionName);
    }

    /***
     * @Title:
     * @Description: (获取城市各因子的最前面的三个和最后面的三个数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:30
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:30    
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/getFactorRegionNameRank")
    @ResponseBody
    public List<Map<String, Object>> getFactorRegionRank(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        List<Map<String, Object>> rankFactorByRegionName = airDailyService.getRankFactorByRegionName(param, factor, pointType, timeType, sort);
        return rankFactorByRegionName;
    }

    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @Title:
     * @Description: (获取AQI超标天数统计)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:29
     */
    @RequestMapping(value = "/getAQIExcessEchart")
    @ResponseBody
    public Map<String, Object> getAQIExcessRegionEchart(AirDayDataParam param, String factor, String pointType, String timeType) {
        return airDailyService.getExcessAQICityEchart(param, factor, pointType, timeType, "front");
    }

    /**
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @Title:
     * @Description: (aqi超标天数文字)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:29
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:29
     */
    @RequestMapping(value = "/getAQIExcessText")
    @ResponseBody
    public PageEU<Map<String, Object>> getAQIExcessText(AirDayDataParam param, String factor, String pointType, String timeType, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        Page<Map<String, Object>> textFactorByRegionName = airDailyService.getExcessAQICityText(param, factor, pointType, timeType, page, response);
        if (textFactorByRegionName == null) {
            return null;
        }
        return new PageEU<>(textFactorByRegionName);
    }

    /***
     * @Title:
     * @Description: (获取城市各因子的最前面的三个和最后面的三个数据)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/1 17:30
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/1 17:30
     * @param param
     * @param factor
     * @param pointType
     * @param timeType
     * @return java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping(value = "/getAQIExcessRank")
    @ResponseBody
    public List<Map<String, Object>> getAQIExcessRank(AirDayDataParam param, String factor, String pointType, String timeType, String sort) {
        List<Map<String, Object>> AQIExcess = airDailyService.getExcessAQICityRank(param, factor, pointType, timeType, sort);
        return AQIExcess;
    }

    /**
     * 优良天数echart
     *
     * @param param
     * @return
     */
    @RequestMapping(value = "/getAirExcellentGoodEchart")
    @ResponseBody
    public Map getAirExcellentGoodEchart(AirDayDataParam param) {
        return airDailyService.getAirExcellentGoodEchart(param);
    }

    /**
     * 优良天数表格
     *
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getAirExcellentGoodPage")
    @ResponseBody
    public PageEU<Map<String, Object>> getAirExcellentGoodPage(AirDayDataParam param, HttpServletRequest request, HttpServletResponse response) {
        Page<Map<String, Object>> page = pageQuery(request);
        return airDailyService.getExcellentGoodDaysPage(param, page, response);
    }

    @RequestMapping("/getAQIYearOnYearEchart")
    @ResponseBody
    public List<Map<String, Object>> getAQIYearOnYearEchart(String searchYear, String timeType, String pointCode, String pointType) {
        Calendar cale = Calendar.getInstance();
        int currentYear = cale.get(Calendar.YEAR);
        if (StringUtils.isBlank(searchYear)) {
            searchYear = String.valueOf(currentYear);
        }
        List<Map<String, Object>> aqiCurrentYearOnYearDataShow = airDailyService.getAQIYearOnYearDataShow(searchYear,String.valueOf(currentYear), timeType, pointCode, pointType, 0);
        return aqiCurrentYearOnYearDataShow;
    }

    /**
     * @param searchYear
     * @param timeType
     * @param pointCode
     * @param pointType
     * @return java.util.List<java.util.Map < java.lang.String, java.lang.Object>>
     * @Title: 获取环比数据
     * @Description: (选中月份跟当前月份相比默认是上一个月)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/12 9:28
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/12 9:28
     */
    @RequestMapping("/getAQIRingRadioEchart")
    @ResponseBody
    public List<Map<String, Object>> getAQIRingRadioEchart(String searchYear, String timeType, String pointCode, String pointType) {
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH)+1;
        int countMonthDay=0;
        String currentYearAndMonth=currentYear+"-"+currentMonth;
        List<Map<String, Object>> aqiCurrentYearOnYearDataShow = airDailyService.getAQIYearOnYearDataShow(searchYear,currentYearAndMonth, timeType, pointCode, pointType, countMonthDay);
        return aqiCurrentYearOnYearDataShow;
    }


    /**
     * 优良天数表格
     *
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getPassYearExcellentAnalysisAirMorePoint")
    @ResponseBody
    public List<Map<String, Object>> getPassYearExcellentAnalysisAirMorePoint(String polluteName, String pointCode, String time, int year) throws ParseException {
        List<Map<String, Object>> list = null;
        list = airDailyService.getPassYearExcellentAnalysisAirMorePoint(polluteName, pointCode, time, year);
        return list;
    }

    /**
     * 优良天数--环比
     *
     * @param flag
     * @param pointCode
     * @param time
     * @return
     */
    @RequestMapping(value = "/getCompareDataByMonth")
    @ResponseBody
    public Map getCompareDataByMonth(String flag, String pointCode, String time) throws ParseException {
        String[] pcs = pointCode.split(",");
        Map resultMap = new HashMap();
        for (int i = 0; i < pcs.length; i++) {
            List<Map> mapsByMonth = airDailyService.getMapsByMonth(time, pcs[i], flag);
            resultMap.put(pcs[i], mapsByMonth);
        }

        return resultMap;
    }
    /**
     * 获取比较数据 优良天数-同比-监测站因子
     *
     * @param pointCode
     * @param year
     * @param rq
     * @return
     */
    @RequestMapping("/getCompareData")
    @ResponseBody
    public Map<String, Object> getCompareData(String pointCode, int year, String rq) {
        Map<String, Object> list = null;
        list = airDailyService.getCompareData(pointCode, year, rq);
        return list;
    }
    /**
     * @Title: 获取各因子的超标天数情况每个月的aqi超标天数echart数据
     * @Description: (这里用一句话描述这个方法的作用)
     * @CreateBy: wudenglin
     * @CreateTime: 2019/7/17 14:13
     * @UpdateBy: wudenglin
     * @UpdateTime:2019/7/17 14:13    
      * @param null
     * @return 
     */
    @RequestMapping("/getAQIExcessDayNumEchart")
    @ResponseBody
    public List<Map<String, Object>> getAQIExcessDayNumEchart(String searchYear, String timeType, String pointCode, String pointType) {
        Calendar cale = Calendar.getInstance();
        int currentYear = cale.get(Calendar.YEAR);
        if (StringUtils.isBlank(searchYear)) {
            searchYear = String.valueOf(currentYear);
        }
        List<Map<String, Object>> aqiCurrentYearOnYearDataShow = airDailyService.getAQIYearOnYearDataShow(searchYear,String.valueOf(currentYear), timeType, pointCode, pointType, 0);
        return aqiCurrentYearOnYearDataShow;
    }

}
