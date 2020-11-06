package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.util.CountUtil;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirQualityStatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/zphb/environment/AirQualityStatistics")
@Secured({ "ROLE_USER" })
public class ZpAirQualityStatisticsController {
	
	@Autowired
	private ZpAirQualityStatisticsService airQualityStatisticsService;
	
	
	@RequestMapping("/list")
	@ResponseBody
	public R getAirQualityStatistics(String startTime, String endTime) throws Exception {
		Map<String, Object> result = new HashMap<>();
		DecimalFormat df = new DecimalFormat("#0.00");
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String LastYearStartTime =  CountUtil.getStartDate(startTime,1);
		String LastYearEndtTime =  CountUtil.getEndDate(endTime,1);
		JSONObject lastObject = new JSONObject();
		JSONArray lastArray = new JSONArray();
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		JSONObject infoObject = new JSONObject();
		JSONArray infoArry = new JSONArray();
		
		List<Object[]> nowList = airQualityStatisticsService.getAirByTime(start,end);
		List<Object[]> lastList = airQualityStatisticsService.getAirByTime(LastYearStartTime,LastYearEndtTime);
		int sumDay = 0;
		int lastGoodDay = 0;
		int nowGoodDay = 0;
		double goodRate = 0;
		if (ToolUtil.isNotEmpty(lastList)&&ToolUtil.isNotEmpty(nowList)) {
			for (Object[] objects : lastList) {
				if (objects[1] != null) {
					sumDay++;
					if (integerValue(objects[1]) <=100) {
						lastGoodDay++;
					}
				}
			}
			if (sumDay != 0) {
				goodRate = lastGoodDay*1.0/sumDay*100;
			}
			//封装上年数据
			lastObject.put("name", "上年优良率");
			lastObject.put("maxValue", df.format(goodRate));
			lastObject.put("minValue", df.format(100-goodRate));
			lastArray.put(lastObject);
			sumDay = 0;
			for (Object[] objects : nowList) {
				if (objects[1] != null) {
					sumDay++;
					if (integerValue(objects[1]) <=100) {
						nowGoodDay++;
					}
				}
			}
			if (sumDay != 0) {
				goodRate = nowGoodDay*1.0/sumDay*100;
			}
			//封装今年数据
			jsonObject.put("name", start.substring(0, 4)+"年优良率");
			jsonObject.put("maxValue", df.format(goodRate));
			jsonObject.put("minValue", df.format(100-goodRate));
			jsonArray.put(jsonObject);
			//封装标题等数据
			String time[] = nowList.get(nowList.size()-1)[0].toString().substring(0, 10).split("-");
			infoObject.put("time", time[1]+"月"+time[2]+"日");
			infoObject.put("day", nowGoodDay);
			infoObject.put("rate", df.format(goodRate)+"%");
			infoObject.put("lastYear", LastYearStartTime.substring(0, 4));
			infoObject.put("nowYear", startTime.substring(0, 4));
			if (nowGoodDay>lastGoodDay) {
				infoObject.put("info", "增加"+(nowGoodDay-lastGoodDay));
			}else {
				infoObject.put("info", "减少"+(lastGoodDay-nowGoodDay));
			}
			infoArry.put(infoObject);
			result.put("lastArray", lastArray);
			result.put("now", jsonArray);
			result.put("info",infoArry);
		}else {
			result = null;
			R.ok(result);
		}
		
		return R.ok(result);
		
	}
	
	
	
	public Integer integerValue(Object o) {

		return Double.valueOf(String.valueOf(o)).intValue();
	}
	
}
