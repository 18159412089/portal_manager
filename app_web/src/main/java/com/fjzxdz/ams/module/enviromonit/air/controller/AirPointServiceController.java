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
import com.fjzxdz.ams.module.enviromonit.air.service.AirPointService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirPolluteService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 这里描述这个类是做什么业务 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年7月2日 下午2:32:41
 */
@Controller
@RequestMapping("/enviromonit/airPoint")
public class AirPointServiceController extends BaseController {

	@Autowired
	private AirPointService airPointService;
	
	@RequestMapping("/analysisCharts")
	@ResponseBody
	public List<Map<String, Object>> analysisCharts(String pointName, String start, String end){
		List<Map<String, Object>> list = airPointService.FactoryCompare(pointName, start, end);
		return list;
	}
	
}
