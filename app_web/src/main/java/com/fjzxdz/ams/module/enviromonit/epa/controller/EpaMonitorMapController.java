package com.fjzxdz.ams.module.enviromonit.epa.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.fjzxdz.frame.controller.BaseController;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/epa/epaMonitorMap.do")
@Secured({ "ROLE_USER" })
public class EpaMonitorMapController extends BaseController {
	
	@RequestMapping("")
	public ModelAndView index(String menu, ModelAndView model, String pid) {
		model.addObject("menu",menu);
		model.addObject("pid",pid);
		model.setViewName("/moudles/enviromonit/ecologicalMonitorMap");
		return model;
	}
}
