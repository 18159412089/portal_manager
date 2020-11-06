package com.fjzxdz.ams.module.wtcd.controller;

import org.springframework.ui.Model;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import cn.fjzxdz.frame.controller.BaseController;

@Controller
@RequestMapping("/wtcd/wtcdMap")
@Secured({ "ROLE_USER" })
public class WtcdMapController extends BaseController {
	
	@RequestMapping("wtcdMap.do")
	public String index(Model model,String menu) {
		  model.addAttribute("menu",menu);
		 return "/moudles/wtcd/wtcdMap";
	}
}
