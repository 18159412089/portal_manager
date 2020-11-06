package com.fjzxdz.ams.module.rad.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

import cn.fjzxdz.frame.constant.TestData;
import cn.fjzxdz.frame.controller.BaseController;

@Controller
@RequestMapping("/rad/mainPage")
public class RadMainController extends BaseController {
	
	@RequestMapping("/main.do")
	public String rad(@RequestParam(value = "type", required = false)String type,String menu,Model model) {
		if (StringUtils.isNotEmpty(type)) {
			model.addAttribute("type", type);
		}else {
			model.addAttribute("type", null);
		}
		model.addAttribute("menu",menu);
		return "/moudles/rad/radMain";
	}

	@RequestMapping("/testData.do")
	@ResponseBody
	public String testData(HttpServletRequest request) {
		String typeStr = request.getParameter("type");
		String testData = "";
		if("RAD".equals(typeStr)){
			testData = TestData.RAD;
		}
		JSONArray tableData = JSONArray.parseArray(testData);
		return tableData.toString();
	}

}
