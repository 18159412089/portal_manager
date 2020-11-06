package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 数据服务 空气环境质量 区域对比分析页面的功能显示
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 上午9:28:25
 */
@Controller
@RequestMapping("/enviromonit/airQualityArea")
@Secured({ "ROLE_USER" })
public class AirAreaComparisonController extends BaseController {

	
	
	@Autowired
	private AirMonitorPointService airMonitorPointService;
	
	@Autowired
	private AirDailyService airDailyService;

	@RequestMapping(value = "")
	public String getAirQualityAQI() {
		return "/moudles/enviromonit/air/airQualityArea";
	}
	/**
	 * 
	 * @Title:  getRegionalCorrelation
	 * @Description:    各地区AQI对比分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午2:50:51
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午2:50:51    
	 * @param param
	 * @param request
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/getRegionalCorrelation")
	@ResponseBody
	public R getRegionalCorrelation(AirDayDataParam param, HttpServletRequest request) {
		
		List<AirMonitorPoint> city = airMonitorPointService.getCity();
		DecimalFormat df = new DecimalFormat("#0.0");
		String[] text = new String [city.size()];
		int num = 0;
		String citys = "(";
		for (AirMonitorPoint objects : city) {
			citys += objects.getPointCode() + ",";
			text[num] = objects.getPointName();
			num++;
		}
		citys = citys.substring(0, citys.length() - 1) + ")";
		List<Object[]> reports = airDailyService.getAllAQI(param.getStartTime(),citys);
		Map<String, Object> map = new HashMap<String, Object>();
		String start = param.getStartTime().substring(0, 5)+ "01-01";
		String end = param.getStartTime().substring(0, 5)+ "12-31";
		List<Object[]> list = airDailyService.getAllAQIByTime(start,end, citys);
		JSONObject jsonObject = new JSONObject();
		String[] names = { "AQI", "本年优良率" };
		jsonObject.put("names", names);
		Integer[] aqi = new Integer[text.length];
		Double[] rate = new Double[text.length];

		for (int i = 0; i < text.length; i++) {
			// 总天数
			int totalDay = 0; 
			// 合格天数
			int qualifiedDay = 0; 
			for (int j = 0; j < reports.size(); j++) {
				if (text[i].equals(reports.get(j)[0])) {
					if (ToolUtil.isNotEmpty(reports.get(j)[1])) {
						aqi[i] = Integer.valueOf(reports.get(j)[1].toString());
					}else {
						aqi[i] = 0;
					}
				}
			}
			for (int j = 0;j<list.size();j++) {
				if (text[i].equals(list.get(j)[0])) {
					if (ToolUtil.isNotEmpty(list.get(j)[1])) {
						totalDay++;
						if (Integer.valueOf(list.get(j)[1].toString())<=100) {
							qualifiedDay++;
						}
					}
				}
			}
			if (totalDay != 0) {
				rate[i] = Double.valueOf(df.format(qualifiedDay * 1.0 / totalDay * 100));
			}else {
				rate[i] = 0.0;
			}
		}
		jsonObject.put("text", text);
		jsonObject.put("aqi", aqi);
		jsonObject.put("rate", rate);
		map.put("data", jsonObject);
		return R.ok(map);
	}

	/**
	 * 
	 * @Title:  list
	 * @Description:    各地区AQI统计信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月29日 下午2:53:24
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月29日 下午2:53:24    
	 * @param param
	 * @param request
	 * @return
	 * @throws Exception  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Map<String, Object>> list(AirDayDataParam param, HttpServletRequest request) throws Exception {
		
		List<AirMonitorPoint> city = airMonitorPointService.getCity();
		DecimalFormat df = new DecimalFormat("#0.0");
		String[] text = new String [city.size()];
		
		int num = 0;
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-mm-dd");
		Date date = sd.parse(param.getStartTime());
		Calendar c = Calendar.getInstance(); 
		c.setTime(date);
		int day=c.get(Calendar.DATE); 
		c.set(Calendar.DATE,day-1); 
		String dayBefore = sd.format(c.getTime());
		String citys = "(";
		for (AirMonitorPoint objects : city) {
			citys += objects.getPointCode() + ",";
			text[num] = objects.getPointName();
			num++;
		}
		citys = citys.substring(0, citys.length() - 1) + ")";
		Page<Map<String, Object>> page = pageQuery(request);
		// AQI
		Integer[] aqi = new Integer[city.size()];
		// 前一天AQI
		Integer[] lastDayAqi = new Integer[city.size()];
		// 本年优良天数
		Integer[] days = new Integer[city.size()];
		// 优良天数比例
		Double[] ratio = new Double[city.size()];
		
		List<Object[]> nowList = airDailyService.getAllAQI(param.getStartTime(),citys);
		List<Object[]> beforeList = airDailyService.getAllAQI(dayBefore,citys);

		String start = param.getStartTime().substring(0, 5)+ "01-01";
		String end = param.getStartTime().substring(0, 5)+ "12-31";

		List<Object[]> list = airDailyService.getAllAQIByTime(start,end, citys);

		for (int i = 0; i < text.length; i++) {
			// 总天数
			int totalDay = 0; 
			// 合格天数
			int qualifiedDay = 0; 
			for (int j = 0; j < nowList.size(); j++) {
				if (text[i].equals(nowList.get(j)[0])) {
					if (ToolUtil.isNotEmpty(nowList.get(j)[1])) {
						aqi[i] = Integer.valueOf(nowList.get(j)[1].toString());
					}else {
						aqi[i] = 0;
					}
				}
			}
			for (int j = 0; j < beforeList.size(); j++) {
				if (text[i].equals(beforeList.get(j)[0])) {
					if (ToolUtil.isNotEmpty(beforeList.get(j)[1])) {
						lastDayAqi[i] = Integer.valueOf(beforeList.get(j)[1].toString());
					}else {
						lastDayAqi[i] = 0;
					}
				}
			}
			for (int j = 0;j<list.size();j++) {
				if (text[i].equals(list.get(j)[0])) {
					if (ToolUtil.isNotEmpty(list.get(j)[1])) {
						totalDay++;
						if (Integer.valueOf(list.get(j)[1].toString())<=100) {
							qualifiedDay++;
						}
					}
				}
			}
			days[i] = qualifiedDay;
			if (totalDay != 0) {
				ratio[i] = Double.valueOf(df.format(qualifiedDay * 1.0 / totalDay * 100));
			}else {
				ratio[i] = 0.0 ;
			}

		}
		List<Map<String, Object>> reMaps = new ArrayList<>();

		for (int i = 0; i < text.length; i++) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("pointCity", text[i]);
			jsonObject.put("aqi", aqi[i]);
			jsonObject.put("lastDayAqi", lastDayAqi[i]);
			jsonObject.put("days", days[i]);
			jsonObject.put("ratio", ratio[i]);
			Map<String, Object> tempMap = jsonObject;
			reMaps.add(tempMap);
		}
		page.setResult(reMaps);
		page.setTotalCount(12);

		return new PageEU<>(page);
	}
}
