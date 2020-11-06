package com.fjzxdz.ams.module.enviromonit.air.hugedata;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.weather.BaiduWeather;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/environment/hugeData")
public class HugeDataController extends BaseController {

	@Autowired
	private HugeDataService hugeDataService;

	@RequestMapping("")
	public ModelAndView index(String target, ModelAndView modelAndView) {
		modelAndView.setViewName("/moudles/enviromonit/air/hugedata/hugedata");
		modelAndView.addObject("target",target);
		return modelAndView;
	}

	@RequestMapping("/sixIndicatrixByYear")
	@ResponseBody
	public Map<String, Object> sixIndicatrixByYear(String category){


		Map<String, Object> map = hugeDataService.sixIndicatrixByYear(category);

		return map;
	}

	@RequestMapping("/sixIndicatrixByCounty")
	@ResponseBody
	public Map<String ,List<Map<String, Object>>> sixIndicatrixByCounty(String CountyCode){


		Map<String ,List<Map<String, Object>>> map = hugeDataService.sixIndicatrixByCounty(CountyCode);

		return map;
	}

	@RequestMapping("/sixIndicatrixByC_M")
	@ResponseBody
	public Map<String, Object> sixIndicatrixByCountyAndMonth(String CountyCode){

		Map<String, Object> resultMap = new HashMap<>(4);
		List<Map<String, Object>> list = hugeDataService.sixIndicatrixByCountyAndMonth(CountyCode);
		
		resultMap.put("data", list);
		resultMap.put("code", "0");
		resultMap.put("msg", "");
		resultMap.put("count", "1");

		return resultMap;
	}
	
	/**
	 * 
	 * @Title:  getAirQuantity
	 * @Description:    某个城市的最新小时数据    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:35:12
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:35:12    
	 * @param pointCode 城市变化
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getAirQuantity")
	@ResponseBody
	public Map<String, Object> getAirQuantity(String pointCode) {
		
		Map<String, Object> map = hugeDataService.getAirQuantity(pointCode);
		
		return map;
	}

	/***
	 * 
	 * @Title:  getMonitoringData
	 * @Description: 获取大气环境汇报中的监控数据
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年5月29日 下午2:36:33
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年5月29日 下午2:36:33    
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getMonitoringData")
	@ResponseBody
	public Map<String, Object> getMonitoringData() {
		Map<String, Object> map;
		try {
			map = hugeDataService.getMonitoringData();
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok(map);
	}

	/***
	 * 
	 * @Title:  getWeather
	 * @Description:    获取天气预报信息
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年5月30日 下午2:52:29
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年5月30日 下午2:52:29    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getWeather")
	@ResponseBody
	public String getWeather() {
		BaiduWeather baidu = new BaiduWeather();
		return baidu.getWeatherInform();
	}

}
