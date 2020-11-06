package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.util.GetTimes;
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONObject;
/**
 * 超标天数同环比分析
 * @author lilongan
 *
 */
@Controller
@RequestMapping("/enviromonit/water/wtDataServiceCompared")
public class WtDataServiceComparedController {
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 超标天数数据展示
	 * @param pointCode
	 * @param dataTime
	 * @param polluteCode
	 * @param category
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/getDataServiceCompared")
	@ResponseBody
	public JSONObject getDataServiceCompared(String pointCode, String dataTime, String polluteCode,String category) throws ParseException{
 		JSONObject jObject = new JSONObject(); 
		JSONArray nameArr = new JSONArray(); 
		JSONArray valueCurr = new JSONArray(); 
		JSONArray valueYest = new JSONArray(); 
		nameArr.add("00:00:00");
		nameArr.add("01:00:00");
		nameArr.add("02:00:00");
		nameArr.add("03:00:00");
		nameArr.add("04:00:00");
		nameArr.add("05:00:00");
		nameArr.add("06:00:00");
		nameArr.add("07:00:00");
		nameArr.add("08:00:00");
		nameArr.add("09:00:00");
		nameArr.add("10:00:00");
		nameArr.add("11:00:00");
		nameArr.add("12:00:00");
		nameArr.add("13:00:00");
		nameArr.add("14:00:00");
		nameArr.add("15:00:00");
		nameArr.add("16:00:00");
		nameArr.add("17:00:00");
		nameArr.add("18:00:00");
		nameArr.add("19:00:00");
		nameArr.add("20:00:00");
		nameArr.add("21:00:00");
		nameArr.add("22:00:00");
		nameArr.add("23:00:00");
		for(int i = 0 ; i < nameArr.size() ; i++){
			valueCurr.add("0.0");
			valueYest.add("0.0");
		}
		//获取传进来时间的上一年度同个时间
		String timeYest = GetTimes.getNowOfLastYear(dataTime);
		List<Map<String, Object>> result=new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resultYest=new ArrayList<Map<String,Object>>();
		String sql = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + dataTime + "'";
		String sqlYest = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + timeYest + "'";
		result = simpleDao.getNativeQueryList(sql);
		resultYest = simpleDao.getNativeQueryList(sqlYest);
		//循环获取这期的因子值
		for(int i = 0 ; i < result.size() ; i++){
			Map<String, Object> map = result.get(i);
			if(map.containsKey("datatime")){
				String value = (String) map.get("datavalue");
				Object timeO = map.get("datatime");
				String time = timeO.toString().substring(11, 19);
				
				for(int j = 0 ; j < nameArr.size() ; j++){
					if(time == nameArr.get(j) || nameArr.get(j).equals(time)){
						valueCurr.set(j, value);
					}
				}
				
			}
		}

		//循环获取上一期的因子值
		for(int i = 0 ; i < resultYest.size() ; i++){
			Map<String, Object> map = resultYest.get(i);
			if(map.containsKey("datatime")){
				String value = (String) map.get("datavalue");
				Object timeO = map.get("datatime");
				String time = timeO.toString().substring(11, 19);
				
				for(int j = 0 ; j < nameArr.size() ; j++){
					if(time == nameArr.get(j) || nameArr.get(j).equals(time)){
						valueYest.set(j, value);
					}
				}
				
			}
		}
		
		jObject.put("names", nameArr);
		jObject.put("valueCurr", valueCurr);
		jObject.put("valueYest", valueYest);
		return jObject;
	}
	
	
	/**
	 * 超标天数文字描述数据获取
	 * @param pointCode
	 * @param dataTime
	 * @param polluteCode
	 * @param category
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/pollutionAnalysis")
	@ResponseBody
	public List<Map<String, Object>> pollutionAnalysis(String pointCode, String dataTime, String polluteCode,String category) throws ParseException {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resultYest = new ArrayList<Map<String, Object>>();
		//获取传进来时间的上一年度同个时间
		String timeYest = GetTimes.getNowOfLastYear(dataTime);
		String sql = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + dataTime + "'";
		String sqlYest = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + timeYest + "'";
		
		result = simpleDao.getNativeQueryList(sql);
		resultYest = simpleDao.getNativeQueryList(sqlYest);
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("dataTime", dataTime);
		map1.put("times", 0);
		//循环获取这期的因子值
		for(int i = 0 ; i < result.size() ; i++){
			Map<String, Object> map = result.get(i);
			String codePollute = (String) map.get("codePollute");
			String polluteValue = (String) map.get("datavalue");
			org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor(codePollute,polluteValue,WaterQualityEnum.THIRD,"0");
			if (jsonObj.getBoolean("isExcess") == true) {
				int num = (int) map1.get("times");
				num++;
				map1.put("times", num);
			}
		}
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("dataTime", timeYest);
		map2.put("times", 0);
		//循环获取这期的因子值
		for(int i = 0 ; i < resultYest.size() ; i++){
			Map<String, Object> map = resultYest.get(i);
			String codePollute = (String) map.get("codePollute");
			String polluteValue = (String) map.get("datavalue");
			org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor(codePollute,polluteValue,WaterQualityEnum.THIRD,"0");
			if (jsonObj.getBoolean("isExcess") == true) {
				int num = (int) map2.get("times");
				num++;
				map2.put("times", num);
			}
		}
		
		results.add(map1);
		results.add(map2);
		return results;
	}
	
	
	/**
	 * 超标天数数据展示
	 * @param pointCode
	 * @param dataTime
	 * @param polluteCode
	 * @param category
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/getDataServiceSequential")
	@ResponseBody
	public JSONObject getDataServiceSequential(String pointCode, String dataTime, String polluteCode,String category) throws ParseException{
 		JSONObject jObject = new JSONObject(); 
		JSONArray nameArr = new JSONArray(); 
		JSONArray valueCurr = new JSONArray(); 
		JSONArray valueYest = new JSONArray(); 
		nameArr.add("00:00:00");
		nameArr.add("01:00:00");
		nameArr.add("02:00:00");
		nameArr.add("03:00:00");
		nameArr.add("04:00:00");
		nameArr.add("05:00:00");
		nameArr.add("06:00:00");
		nameArr.add("07:00:00");
		nameArr.add("08:00:00");
		nameArr.add("09:00:00");
		nameArr.add("10:00:00");
		nameArr.add("11:00:00");
		nameArr.add("12:00:00");
		nameArr.add("13:00:00");
		nameArr.add("14:00:00");
		nameArr.add("15:00:00");
		nameArr.add("16:00:00");
		nameArr.add("17:00:00");
		nameArr.add("18:00:00");
		nameArr.add("19:00:00");
		nameArr.add("20:00:00");
		nameArr.add("21:00:00");
		nameArr.add("22:00:00");
		nameArr.add("23:00:00");
		for(int i = 0 ; i < nameArr.size() ; i++){
			valueCurr.add("0.0");
			valueYest.add("0.0");
		}
		//获取传进来时间的上一年度同个时间
		String timeYest = GetTimes.getNowOfLastMonth(dataTime);
		List<Map<String, Object>> result=new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resultYest=new ArrayList<Map<String,Object>>();
		String sql = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + dataTime + "'";
		String sqlYest = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + timeYest + "'";
		result = simpleDao.getNativeQueryList(sql);
		resultYest = simpleDao.getNativeQueryList(sqlYest);
		//循环获取这期的因子值
		for(int i = 0 ; i < result.size() ; i++){
			Map<String, Object> map = result.get(i);
			if(map.containsKey("datatime")){
				String value = (String) map.get("datavalue");
				Object timeO = map.get("datatime");
				String time = timeO.toString().substring(11, 19);
				
				for(int j = 0 ; j < nameArr.size() ; j++){
					if(time == nameArr.get(j) || nameArr.get(j).equals(time)){
						valueCurr.set(j, value);
					}
				}
				
			}
		}

		//循环获取上一期的因子值
		for(int i = 0 ; i < resultYest.size() ; i++){
			Map<String, Object> map = resultYest.get(i);
			if(map.containsKey("datatime")){
				String value = (String) map.get("datavalue");
				Object timeO = map.get("datatime");
				String time = timeO.toString().substring(11, 19);
				
				for(int j = 0 ; j < nameArr.size() ; j++){
					if(time == nameArr.get(j) || nameArr.get(j).equals(time)){
						valueYest.set(j, value);
					}
				}
				
			}
		}
		
		jObject.put("names", nameArr);
		jObject.put("valueCurr", valueCurr);
		jObject.put("valueYest", valueYest);
		return jObject;
	}
	
	
	/**
	 * 超标天数文字描述数据获取
	 * @param pointCode
	 * @param dataTime
	 * @param polluteCode
	 * @param category
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/pollutionAnalysisSequential")
	@ResponseBody
	public List<Map<String, Object>> pollutionAnalysisSequential(String pointCode, String dataTime, String polluteCode,String category) throws ParseException {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resultYest = new ArrayList<Map<String, Object>>();
		//获取传进来时间的上一年度同个时间
		String timeYest = GetTimes.getNowOfLastMonth(dataTime);
		String sql = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + dataTime + "'";
		String sqlYest = "SELECT A .DATATIME,A .POINT_NAME,A .CODE_POLLUTE,A .PARAMNAME,A .DATAVALUE FROM WT_CITY_HOUR_DATA A\n" +
				"INNER JOIN WT_CITY_POINT b ON A .POINT_CODE = b.POINT_CODE\n" +
				"WHERE b.POINT_CODE = '" + pointCode + "' "+
				"AND b. CATEGORY = " + category + " AND DATAVALUE IS NOT NULL AND CODE_POLLUTE IN ('" + polluteCode + "')\n" +
				"AND TO_CHAR (DATATIME, 'yyyy-mm-dd') = '" + timeYest + "'";
		
		result = simpleDao.getNativeQueryList(sql);
		resultYest = simpleDao.getNativeQueryList(sqlYest);
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("dataTime", dataTime);
		map1.put("times", 0);
		//循环获取这期的因子值
		for(int i = 0 ; i < result.size() ; i++){
			Map<String, Object> map = result.get(i);
			String codePollute = (String) map.get("codePollute");
			String polluteValue = (String) map.get("datavalue");
			org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor(codePollute,polluteValue,WaterQualityEnum.THIRD,"0");
			if (jsonObj.getBoolean("isExcess") == true) {
				int num = (int) map1.get("times");
				num++;
				map1.put("times", num);
			}
		}
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("dataTime", timeYest);
		map2.put("times", 0);
		//循环获取这期的因子值
		for(int i = 0 ; i < resultYest.size() ; i++){
			Map<String, Object> map = resultYest.get(i);
			String codePollute = (String) map.get("codePollute");
			String polluteValue = (String) map.get("datavalue");
			org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor(codePollute,polluteValue,WaterQualityEnum.THIRD,"0");
			if (jsonObj.getBoolean("isExcess") == true) {
				int num = (int) map2.get("times");
				num++;
				map2.put("times", num);
			}
		}
		
		results.add(map1);
		results.add(map2);
		return results;
	}
	
}
