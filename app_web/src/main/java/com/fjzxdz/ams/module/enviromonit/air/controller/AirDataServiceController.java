package com.fjzxdz.ams.module.enviromonit.air.controller;

import cn.fjzxdz.frame.controller.BaseController;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.*;

/**
 * 
 * 数据服务 空气环境质量  
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午4:32:35
 */
@Controller
@RequestMapping("/enviromonit/airDataService")
@Secured({ "ROLE_USER" })
public class AirDataServiceController extends BaseController {

	@Autowired
	private AirDataService airDataService;
	
	/**
	 * 
	 * @Title:  pollutionAnalysisByPoint
	 * @Description:    跳转到单站点多污染物过程分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:32:21
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:32:21    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/pollutionAnalysisByPoint")
	public String pollutionAnalysisByPoint() {
		return "/moudles/enviromonit/air/airPollutionAnalysis";
	}
	/**
	 * 
	 * @Title:  pollutionAnalysisByPoints
	 * @Description:    跳转到站点污染物过程分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:37:43
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:37:43    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/pollutionAnalysisByPoints")
	public String pollutionAnalysisByPoints() {
		return "/moudles/enviromonit/air/airPollutionAnalysisByPoints";
	}
	/**
	 * 
	 * @Title:  passMonthAnalysis
	 * @Description:    跳转到站点污染物往月环比页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:38:12
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:38:12    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/passMonthAnalysis")
	public String passMonthAnalysis() {
		return "/moudles/enviromonit/air/airPassMonthAnalysis";
	}
	/**
	 * 
	 * @Title:  passYearAnalysis
	 * @Description:    跳转到站点污染物往年同比页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:39:09
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:39:09    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/passYearAnalysis")
	public String passYearAnalysis() {
		return "/moudles/enviromonit/air/airPassYearAnalysis";
	}
	/**
	 * 
	 * @Title:  monthQualityAnalysis
	 * @Description:    跳转到月城市空气质量类别分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:40:02
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:40:02    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/monthQualityAnalysis")
	public String monthQualityAnalysis() {
		return "/moudles/enviromonit/air/airMonthQualityAnalysis";
	}
	/**
	 * 
	 * @Title:  monthPollutionAnalysis
	 * @Description:    跳转到月站点首要污染物分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:40:47
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:40:47    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/monthPollutionAnalysis")
	public String monthPollutionAnalysis() {
		return "/moudles/enviromonit/air/airMonthPollutionAnalysis";
	}
	/**
	 * 
	 * @Title:  monthPollutionConAnalysis
	 * @Description:    站点污染物过程分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:41:06
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:41:06    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/monthPollutionConAnalysis")
	public String monthPollutionConAnalysis() {
		return "/moudles/enviromonit/air/airMonthPollutionConAnalysis";
	}
	
	/**
	 * 
	 * @Title:  getMonthPollutionConAnalysis
	 * @Description:    站点污染物过程分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:44:30
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:44:30    
	 * @param param
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getMonthPollutionConAnalysis")
	@ResponseBody
	public List<Map<String, Object>> getMonthPollutionConAnalysis(AirDataParam param){
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = airDataService.getMonthPollutionConAnalysis(param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 
	 * @Title:  getMonthPollutionAnalysis
	 * @Description:    月站点首要污染物分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午4:55:34
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午4:55:34    
	 * @param param
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getMonthPollutionAnalysis")
	@ResponseBody
	public List<Map<String, Object>> getMonthPollutionAnalysis(AirDataParam param){
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = airDataService.getMonthPollutionAnalysis(param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 
	 * @Title:  getMonthQualityAnalysis
	 * @Description:    月城市空气质量类别分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:21:42
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:21:42    
	 * @param param
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getMonthQualityAnalysis")
	@ResponseBody
	public List<Map<String, Object>> getMonthQualityAnalysis(AirDataParam param){
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = airDataService.getMonthQualityAnalysis(param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 
	 * @Title:  getPassMonthAnalysis
	 * @Description:    站点污染物往月环比    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:28:11
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:28:11    
	 * @param param
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassMonthAnalysis")
	@ResponseBody
	public Map<String, Object> getPassMonthAnalysis(AirDataParam param){
		Map<String, Object> map = new HashMap<>();
		try {
			map = airDataService.getPassMonthAnalysis(param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 
	 * @Title:  getPassYearAnalysisWithPoint
	 * @Description:    站点污染物往年同比    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:29:01
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:29:01    
	 * @param polluteName
	 * @param pointCode
	 * @param time
	 * @param year
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassYearAnalysisWithPoint")
	@ResponseBody
	public Map<String, Object> getPassYearAnalysisWithPoint(String polluteName, String pointCode, String time, int year){
		Map<String, Object> map = new HashMap<>();
		try {
			map = airDataService.getPassYearAnalysisWithPoint(polluteName, pointCode, time, year);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 因子-同比-监测站因子 按天显示
	 * @param polluteName 因子
	 * @param pointCode 站点 可以多个
	 * @param time
	 * @param year 对比年份
	 * @return
	 */
	@RequestMapping("/getPassYearAnalysisAirMorePoint")
	@ResponseBody
	public List<Map<String, Object>> getPassYearAnalysisAirMorePoint(String polluteName, String pointCode, String time, String year){
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = airDataService.getPassYearAnalysisAirMorePoint(polluteName, pointCode, time, year);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 因子-同比-监测站因子 按天显示
	 * @param polluteName 因子
	 * @param pointCode 站点 可以多个
	 * @param time
	 * @param year 对比年份
	 * @return
	 */
	@RequestMapping("/getPassYearAnalysisAirMorePointHB")
	@ResponseBody
	public List<Map<String, Object>> getPassYearAnalysisAirMorePointHB(String polluteName, String pointCode, String time, String year) throws ParseException {
		return airDataService.getPassYearAnalysisAirMorePointHB(polluteName, pointCode, time, year);
	}



	/**
	 * 获取比较数据 因子-同比-监测站因子
	 * @param pointCode
	 * @param year
	 * @param rq
	 * @return
	 */
	@RequestMapping("/getCompareData")
	@ResponseBody
	public Map<String, Object> getCompareData(String pointCode, String year,String rq) {
		Map<String, Object> list = null;
		list = airDataService.getCompareData(pointCode, year, rq);
		return list;
	}


	/**
	 * 
	 * @Title:  getPointsDateByHourOrDay
	 * @Description:    多站点多污染物过程分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:29:50
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:29:50    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointsDateByHour")
	@ResponseBody
	public List<Map<String, Object>> getPointsDateByHourOrDay(AirDataParam param) throws ParseException{
		List<Map<String, Object>> result = airDataService.getPointsDateByHourOrDay(param);
		return result;
	}
	/**
	 * 
	 * @Title:  getPointDateByHourOrDay
	 * @Description:    单站点多污染物过程分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:30:47
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:30:47    
	 * @param param
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointDateByHour")
	@ResponseBody
	public List<Map<String, Object>> getPointDateByHourOrDay(AirDataParam param){
		List<Map<String, Object>> result = new ArrayList<>();
		List<Map<String, Object>> list = airDataService.getPointDateByHourOrDay(param);
		for(Map<String, Object> map : list) {
			JSONArray series = getBarSeries(map);
			Map<String, Object> temp = new HashMap<>();
			temp.put("series", series);
			temp.put("xAxis", map.get("xAxis"));
			temp.put("county", map.get("county"));
			result.add(temp);
		}
		return result;
	}
	
	@RequestMapping("/getSixFactor")
	@ResponseBody
	public JSONArray getSixFactor(){
		String json = "[{'key':'A34004','text':'PM2.5'},{'key':'A34002','text':'PM10'},"
				+ "{'key':'A21004','text':'NO2'},{'key':'A21005','text':'CO'},{'key':'A05024','text':'O3'},"
				+ "{'key':'A21026','text':'SO2'}]";
		return JSONArray.parseArray(json);
	}
	
	/**
	 * 
	 * @Title:  getSixFactorAndAQI
	 * @Description:    TODO(获取小时数据的6因子+aqi)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月19日 下午5:47:43
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月19日 下午5:47:43    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getSixFactorAndAQI")
	@ResponseBody
	public JSONArray getSixFactorAndAQI(){
		String json = "[{'key':'aqi','text':'AQI'},{'key':'A34004','text':'PM2.5'},{'key':'A34002','text':'PM10'},"
				+ "{'key':'A21004','text':'NO2'},{'key':'A21005','text':'CO'},{'key':'A05024','text':'O3'},"
				+ "{'key':'A21026','text':'SO2'}]";
		return JSONArray.parseArray(json);
	}
	
	/**
	 * 
	 * @Title:  getSixFactorAndAQI2
	 * @Description:    TODO(获取天数据的6因子+aqi)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月19日 下午5:47:09
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月19日 下午5:47:09    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getSixFactorAndAQI2")
	@ResponseBody
	public JSONArray getSixFactorAndAQI2(){
		String json = "[{'key':'aqi','text':'AQI'},{'key':'A34004','text':'PM2.5'},{'key':'A34002','text':'PM10'},"
				+ "{'key':'A21004','text':'NO2'},{'key':'A21005','text':'CO'},{'key':'A050248','text':'O3'},"
				+ "{'key':'A21026','text':'SO2'}]";
		return JSONArray.parseArray(json);
	}
	
	/**
	 * 
	 * @Title:  getYearList
	 * @Description:    年份下拉框    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午3:26:52
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午3:26:52    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getYearList")
	@ResponseBody
	public JSONArray getYearList(){
		JSONArray result = new JSONArray();
		Calendar date = Calendar.getInstance();
		int year = Integer.parseInt(String.valueOf(date.get(Calendar.YEAR)));
		for(int i=0;i<6;i++) {
			JSONObject temp = new JSONObject();
			temp.put("id", year-i);
			temp.put("text", year-i);
			if(i==0) {
				temp.put("selected", true);
			}
			result.add(temp);
		}
		return result;
	}
	
	/**
	 * 
	 * @Title:  getBarSeries
	 * @Description:    获取柱形图的series的集合    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午3:27:13
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午3:27:13    
	 * @param map
	 * @return  JSONArray 
	 * @throws
	 */
	public JSONArray getBarSeries(Map<String, Object> map) {
		JSONArray series = new JSONArray();
		JSONObject pm25Json = new JSONObject();
		pm25Json.put("name", "PM2.5");
		pm25Json.put("type", "line");
		pm25Json.put("yAxisIndex", "0");
		pm25Json.put("itemStyle", JSONObject.parse("{normal:{color:'#51a1fa'}}"));
		pm25Json.put("data", map.get("pm25"));
		series.add(pm25Json);
		JSONObject pm10Json = new JSONObject();
		pm10Json.put("name", "PM10");
		pm10Json.put("type", "line");
		pm10Json.put("yAxisIndex", "0");
		pm10Json.put("itemStyle", JSONObject.parse("{normal:{color:'#65b149'}}"));
		pm10Json.put("data", map.get("pm10"));
		series.add(pm10Json);
		JSONObject so2Json = new JSONObject();
		so2Json.put("name", "SO2");
		so2Json.put("type", "line");
		so2Json.put("yAxisIndex", "0");
		so2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ffbf26'}}"));
		so2Json.put("data", map.get("so2"));
		series.add(so2Json);
		JSONObject no2Json = new JSONObject();
		no2Json.put("name", "NO2");
		no2Json.put("type", "line");
		no2Json.put("yAxisIndex", "0");
		no2Json.put("itemStyle", JSONObject.parse("{normal:{color:'#ff5400'}}"));
		no2Json.put("data", map.get("no2"));
		series.add(no2Json);
		JSONObject coJson = new JSONObject();
		coJson.put("name", "CO");
		coJson.put("type", "line");
		coJson.put("yAxisIndex", "1");
		coJson.put("itemStyle", JSONObject.parse("{normal:{color:'#d13430'}}"));
		coJson.put("data", map.get("co"));
		series.add(coJson);
		JSONObject o3Json = new JSONObject();
		o3Json.put("name", "O3-8h");
		o3Json.put("type", "line");
		o3Json.put("yAxisIndex", "0");
		o3Json.put("itemStyle", JSONObject.parse("{normal:{color:'#5d30d1'}}"));
		o3Json.put("data", map.get("o3"));
		series.add(o3Json);
		return series;
	}
}
