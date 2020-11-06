package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.toolbox.util.DateUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.util.CountUtil;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirComplianceRateService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.*;

@Controller
@RequestMapping("zphb/environment/airComplianceRate")
@Secured({ "ROLE_USER" })
public class ZpAirComplianceRateController {
	
	@Autowired
	private ZpAirComplianceRateService airComplianceRateService;
	
	@RequestMapping("/list")
	@ResponseBody
	public String list(String startTime, String endTime, String export, HttpServletRequest request, HttpServletResponse response){
		
		
		DecimalFormat df = new DecimalFormat("#0.0");
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		List<Object[]> list = airComplianceRateService.getAirComplianceRate(start,end);
		int sumDay = 0;
		int goodDay = 0;
		int PM2Day = 0;
		int PM10Day = 0;
		int NO2Day = 0;
		int O3Day = 0;
		if (list.size() >0) {
			for (Object[] objects : list) {
					if (objects[2] != null && !objects[2].equals("")) {
						sumDay ++;
						if (doubleValue(objects[2]) <=100) {
							goodDay++;
						}
						Aqi aq = AqiUtil.CountAqi(integerValue(objects[3]), integerValue(objects[4]), doubleValue(objects[5])
								,doubleValue(objects[6]), doubleValue(objects[7]), doubleValue(objects[8]));
						Double aqi = aq.getAqi();
						if (aqi >100) {
							if (aq.getName().equals("PM2.5")) {
								PM2Day++;
							}else if (aq.getName().equals("PM10")) {
								PM10Day++;
							}else if (aq.getName().equals("NO2")) {
								NO2Day++;
							}else if (aq.getName().equals("O3")) {
								O3Day++;
							}
						}
					}
				
			}
		}
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		jsonObject.put("city", list.get(0)[0]);
		jsonObject.put("badDay", sumDay-goodDay);
		jsonObject.put("goodDay", goodDay);
		jsonObject.put("sumDay", sumDay);
		jsonObject.put("standard", df.format(goodDay*1.0/sumDay*100)+"%");
		jsonObject.put("PM2Day", PM2Day);
		jsonObject.put("PM10Day", PM10Day);
		jsonObject.put("NO2Day", NO2Day);
		jsonObject.put("O3Day", O3Day);
		if (sumDay-goodDay == 0) {
			jsonObject.put("exceedingO3", "0%");
		}else {
			jsonObject.put("exceedingO3", df.format(O3Day*1.0/(sumDay-goodDay)*100)+"%");
		}
		jsonObject.put("surplusDays", DateUtil.getDaySub(DateUtil.getCurYearMonthDay(), DateUtil.getCurYearLastDay()));
		
		jsonArray.put(jsonObject);
		
		if("yes".equals(request.getParameter("export"))) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			String string = "至0";
			String title = startTime + string + endTime.substring(5, 6) +"市区大气优良比例排名情况";
			columnMap.put("title", title);
			columnMap.put("city", "城市");
			columnMap.put("badDay", "超标天数");
			columnMap.put("standard", "达标比例");
			columnMap.put("PM2Day", "PM2.5超标/天");
			columnMap.put("PM10Day", "PM10超标/天");
			columnMap.put("NO2Day", "NO2超标/天");
			columnMap.put("O3Day", "O3超标/天");
			columnMap.put("exceedingO3", "臭氧超标天数占比");
			List<Map<String, Object>> result = new ArrayList<>();
	        for(Object jstr:jsonArray){
	        	JSONObject tempJSON = JSONObject.parseObject(jstr.toString());
	        	Map<String, Object> tempMap = new HashMap<>();
	        	for(JSONObject.Entry<String, Object> entry : tempJSON.entrySet()) {
	        		tempMap.put(entry.getKey(), entry.getValue());
	        	}
	        	result.add(tempMap);
	        }
			ExcelExportUtil.exportExcel(response, columnMap, result);
			return null;
		}
		
		return jsonArray.toString();
	}
	
	@RequestMapping("/list2")
	@ResponseBody
	public String list2(String startTime, String endTime, String category){
		
		DecimalFormat df = new DecimalFormat("#0.0");
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		List<Object[]> list = airComplianceRateService.getAirComplianceRate2(start,end,category);
		int sumDay = 0;
		int goodDay = 0;
		int PM2Day = 0;
		int PM10Day = 0;
		int NO2Day = 0;
		int O3Day = 0;
		if (list.size() >0) {
			for (Object[] objects : list) {
					if (objects[2] != null && !objects[2].equals("")) {
						sumDay ++;
						if (doubleValue(objects[2]) <=100) {
							goodDay++;
						}
						Aqi aq = AqiUtil.CountAqi(integerValue(objects[3]), integerValue(objects[4]), doubleValue(objects[5])
								,doubleValue(objects[6]), doubleValue(objects[7]), doubleValue(objects[8]));
						Double aqi = aq.getAqi();
						if (aqi >100) {
							if (aq.getName().equals("PM2.5")) {
								PM2Day++;
							}else if (aq.getName().equals("PM10")) {
								PM10Day++;
							}else if (aq.getName().equals("NO2")) {
								NO2Day++;
							}else if (aq.getName().equals("O3")) {
								O3Day++;
							}
						}
					}
				
			}
		}
		List<Object[]> list1 = airComplianceRateService.getAirComplianceRate(start,end);
		int sumDay1 = 0;
		int goodDay1 = 0;
		int PM2Day1 = 0;
		int PM10Day1 = 0;
		int NO2Day1 = 0;
		int O3Day1 = 0;
		if (list.size() >0) {
			for (Object[] objects : list1) {
				if (objects[2] != null && !objects[2].equals("")) {
					sumDay1 ++;
					if (doubleValue(objects[2]) <=100) {
						goodDay1++;
					}
					Aqi aq = AqiUtil.CountAqi(integerValue(objects[3]), integerValue(objects[4]), doubleValue(objects[5])
							,doubleValue(objects[6]), doubleValue(objects[7]), doubleValue(objects[8]));
					Double aqi = aq.getAqi();
					if (aqi >100) {
						if (aq.getName().equals("PM2.5")) {
							PM2Day1++;
						}else if (aq.getName().equals("PM10")) {
							PM10Day1++;
						}else if (aq.getName().equals("NO2")) {
							NO2Day1++;
						}else if (aq.getName().equals("O3")) {
							O3Day1++;
						}
					}
				}

			}
		}
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		jsonObject.put("city", list.get(0)[0]);
		jsonObject.put("badDay", sumDay-goodDay);
		jsonObject.put("goodDay", goodDay);
		jsonObject.put("sumDay", sumDay);
		
//		long discount = DateUtil.getDaySub(DateUtil.getCurYearFirstDay(), DateUtil.getCurYearMonthDay());

		jsonObject.put("standard", df.format(goodDay*1.0/(sumDay)*100)+"%");
		jsonObject.put("PM2Day", PM2Day);
		jsonObject.put("PM10Day", PM10Day);
		jsonObject.put("NO2Day", NO2Day);
		jsonObject.put("O3Day", O3Day1);
		if (sumDay-goodDay == 0) {
			jsonObject.put("exceedingO3", "0%");
		}else {
			jsonObject.put("exceedingO3", df.format(O3Day*1.0/(sumDay-goodDay)*100)+"%");
		}
//		jsonObject.put("surplusDays", DateUtil.getDaySub(DateUtil.getCurYearMonthDay(), DateUtil.getCurYearLastDay()));
		int left = (int) (((100 - 96.6)  * 365) * 0.01 - O3Day1);
		jsonObject.put("surplusDays", left);

		jsonArray.put(jsonObject);
		
		return jsonArray.toString();
	}
	
	public Double doubleValue(Object o) {

		return Double.valueOf(String.valueOf(o));
	}

	public Integer integerValue(Object o) {
		return Double.valueOf(String.valueOf(o)).intValue();
	}
	
	public int sumDay(Object value, int row, int day) {
		if (value != null && !value.equals("")) {
			if (AqiUtil.countPerIaqi(doubleValue(value), row) > 100) {
				day++;
			}
		}


		return day;
	}
	
}
