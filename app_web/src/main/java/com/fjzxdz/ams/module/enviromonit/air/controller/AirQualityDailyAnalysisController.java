package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 本年各级别天数变化分析 controller 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:50:42
 */
@Controller
@RequestMapping("/enviromonit/airQualityDailyAnalysis")
@Secured({ "ROLE_USER" })
public class AirQualityDailyAnalysisController extends BaseController{

	
	@Autowired
	private AirDailyService airDailyService;
	
	/**
	 * 
	 * @Title:  getAirQualityAQI
	 * @Description:    数据服务 空气环境质量 本年各级别天数变化分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:50:54
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:50:54    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping(value = "")
	public String getAirQualityAQI() {
		return "/moudles/enviromonit/air/airQualityAqiAnnual";
	}
	
	/**
	 * 
	 * @Title:  airAqiForYear
	 * @Description:    查询一年的AQI指数日报    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:51:13
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:51:13    
	 * @param time
	 * @param pointCode
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/airAqiForYear")
	@ResponseBody
	public R airAqiForYear(String time, String pointCode) {
		List<Object[]> reports = airDailyService.airAqiForYear(time, pointCode);
		JSONObject jsonObject = new JSONObject();
		String day ;
		if (ToolUtil.isNotEmpty(reports)) {
			for (Object[] objects : reports) {
				day =String.valueOf(objects[0]).substring(5,10);
				if (getAqi(objects[2])<0) {
					jsonObject.put(day, "");
				}
				else if (getAqi(objects[2]) <= 50) {
					jsonObject.put(day, "excellent");
				} else if (getAqi(objects[2]) <= 100) {
					jsonObject.put(day, "good");
				} else if (getAqi(objects[2]) <= 150) {
					jsonObject.put(day, "mild");
				} else if (getAqi(objects[2]) <= 200) {
					jsonObject.put(day, "moderate");
				} else if (getAqi(objects[2]) <= 300) {
					jsonObject.put(day, "severe");
				} else if (getAqi(objects[2]) <= 500) {
					jsonObject.put(day, "dangerous");
				}
				if (getAqi(objects[2]) < 0 ) {
					jsonObject.put(day+"pollute", "");
				}else if (getAqi(objects[2]) <= 50) {
					jsonObject.put(day+"pollute", "-");
				}else {
					Aqi aq = AqiUtil.CountAqi(intValue(objects[3]), intValue(objects[4]), getAqi(objects[5]),
							getAqi(objects[6]), getAqi(objects[7]), getAqi(objects[8]));
					jsonObject.put(String.valueOf(objects[0]).substring(5,10)+"pollute", aq.getName());
				}
				
				jsonObject.put(day+"pointName", objects[1]);
				jsonObject.put(day+"time", String.valueOf(objects[0]).substring(0,10));
				jsonObject.put(day+"aqi", intValue(objects[2]));
				jsonObject.put(day+"PM10", intValue(objects[3]));
				jsonObject.put(day+"PM2", intValue(objects[4]));
				jsonObject.put(day+"CO", getAqi(objects[5]));
				jsonObject.put(day+"NO2", getAqi(objects[6]));
				jsonObject.put(day+"O3", getAqi(objects[7]));
				jsonObject.put(day+"SO2", getAqi(objects[8]));
				
			}
		}
		

		return R.ok(jsonObject);
	}
	
	/**
	 * 
	 * @Title:  LevelDaysList
	 * @Description:    查询一年内这个城市空气各级别天数    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:51:33
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:51:33    
	 * @param time
	 * @param pointCode
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/LevelDaysList")
	@ResponseBody
	public PageEU<Map<String, Object>> LevelDaysList(String time, String pointCode, HttpServletRequest request) {

		Page<Map<String, Object>> page = pageQuery(request);
		try {
			List<Object[]> reports = airDailyService.airAqiForYear(time, pointCode);
			int[] days = new int[12];// 有效监测天数
			int[] ExDays = new int[12];// 一级天数
			int[] gdDays = new int[12];// 二级天数
			int[] ratio = new int[12];// 优良天数比例
			int[] other = new int[12];// 劣于二级天数
			int[] plt = new int[12];// 重污染天数
			for (int i = 0; i < 12; i++) {
				days[i] = 0;
				ExDays[i] = 0;
				gdDays[i] = 0;
				ratio[i] = 0;
				other[i] = 0;
				plt[i] = 0;
			}
			int month;
			for (Object[] dailyReport : reports) {
				month = Integer.parseInt(String.valueOf(dailyReport[0]).substring(5, 7));
				days[month-1]++;
				if (getAqi(dailyReport[2]) <= 50) {
					ExDays[month-1]++;
				} else if (getAqi(dailyReport[2]) <= 100) {
					gdDays[month-1]++;
				} else if (getAqi(dailyReport[2]) <= 200) {
					other[month-1]++;
				} else {
					plt[month-1]++;
				}
				ratio[month-1] = (ExDays[month-1] + gdDays[month-1]) * 100 / days[month-1];
			}
			
			List<Map<String, Object>> list = new ArrayList<>();

			for (int i = 0; i < 12; i++) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("month", i + 1);
				jsonObject.put("days", days[i]);
				jsonObject.put("ExDays", ExDays[i]);
				jsonObject.put("gdDays", gdDays[i]);
				jsonObject.put("ratio", ratio[i]);
				jsonObject.put("other", other[i]);
				jsonObject.put("plt", plt[i]);
				Map<String, Object> tempMap = jsonObject;
				list.add(tempMap);
			}
			page.setResult(list);
			page.setTotalCount(12);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new PageEU<>(page);
	}
	
	public Double getAqi(Object object) {
		
		return Double.valueOf(String.valueOf(object));
	}
	
	public Integer intValue(Object a) {

		return Integer.valueOf(String.valueOf(a)).intValue();
	}
}
