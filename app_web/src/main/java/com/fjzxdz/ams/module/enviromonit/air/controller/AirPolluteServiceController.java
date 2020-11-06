package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.hugedata.HugeDataServiceImpl;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 数据服务 空气环境质量  
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午4:32:35
 */
@Controller
@RequestMapping("/enviromonit/airPollute")
public class AirPolluteServiceController extends BaseController {

	@Autowired
	private AirPolluteService airPolluteService;
	
	@RequestMapping("/analysisPage")
	public String enter(Model model) {
		return "/moudles/enviromonit/newDataServiceTemp/index8.ftl";
	}
	
	/**
	 * 
	 * @Title:  analysis
	 * @Description:    TODO(污染物分析图表)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月25日 下午5:24:59
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月25日 下午5:24:59    
	 * @param dateType
	 * @param start
	 * @param end
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/analysisCharts")
	@ResponseBody
	public Map<String, Object> analysisCharts(String regionName, String factory, String start, String end, String pointType, String type){
		Map<String, Object> map = airPolluteService.analysisCharts(regionName, factory, start, end, pointType, type);
		return map;
	}
	
	/**
	 * 
	 * @Title:  analysisWords
	 * @Description:    TODO(污染物分析文字)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月26日 下午2:30:28
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月26日 下午2:30:28    
	 * @param regionName
	 * @param factory
	 * @param start
	 * @param end
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/analysisWords")
	@ResponseBody
	public PageEU<Map<String, Object>> analysisWords(String regionName, String dateType, 
			String start, String end, String pointType, String type, HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> mapPage = new Page<Map<String, Object>>();
		mapPage = airPolluteService.analysisWords(regionName, dateType, start, end, page, pointType, type);
		 
		return new PageEU<>(mapPage);
	}
	
	/**
	 * 
	 * @Title:  analysisWords
	 * @Description:    TODO(污染物分析文字)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年6月26日 下午2:30:28
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年6月26日 下午2:30:28    
	 * @param regionName
	 * @param factory
	 * @param start
	 * @param end
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/analysisPointCharts")
	@ResponseBody
	public List<Map<String, Object>> analysisPointCharts(String pointName, String start, 
			String end, String dateType, String queryType){
		List<Map<String, Object>> list;
		try {
			list = airPolluteService.analysisPointCharts(pointName, start, end, dateType, queryType);
			return list;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<>();
		}
	}
	
}
