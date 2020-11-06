package com.fjzxdz.ams.module.risk.controller;

import cn.fjzxdz.frame.constant.TestData;
import cn.fjzxdz.frame.controller.BaseController;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/risk/mainPage")
public class RiskMainController extends BaseController {
	
	@RequestMapping("/main.do")
	public ModelAndView risk(@RequestParam(value = "type", required = false)String type, String menu, ModelAndView model, String pid) {
		if (StringUtils.isNotEmpty(type)) {
			model.addObject("type", type);
		}else {
			model.addObject("type", null);
		}
		model.addObject("menu",menu);
		model.addObject("pid",pid);
		model.setViewName("/moudles/risk/riskMain");
		return model;
	}

	@RequestMapping("/testData.do")
	@ResponseBody
	public String testData(HttpServletRequest request) {
		String typeStr = request.getParameter("type");
		String testData = "";
		if("RISK".equals(typeStr)){
			testData = TestData.RISK;
		}
		JSONArray tableData = JSONArray.parseArray(testData);
		return tableData.toString();
	}

}
