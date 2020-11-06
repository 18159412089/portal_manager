package com.fjzxdz.ams.module.enviromonit.air.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.fjzxdz.frame.controller.BaseController;

@Controller
@RequestMapping("/env/air/report")
@Secured({ "ROLE_USER" })
public class ReportController extends BaseController{
	
	@RequestMapping("")
	public String index() {
		return "/moudles/enviromonit/air/airReport";

	}
	
	@RequestMapping("/mv")
	public String index(String name,Model model) {
		model.addAttribute("name", name);
		return "/moudles/enviromonit/air/airMv";

	}
}
