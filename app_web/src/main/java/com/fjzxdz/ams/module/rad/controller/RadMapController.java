/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.controller;


import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.fjzxdz.frame.controller.BaseController;
import org.springframework.web.servlet.ModelAndView;

/**
 * 核与辐射地图服务Controller
 * @author ZhangGQ
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radMap")
@Secured({ "ROLE_USER" })
public class RadMapController extends BaseController {

	@RequestMapping("/radMap.do")
	public ModelAndView index(String menu, ModelAndView model, String pid) {
		model.addObject("menu",menu);
		model.addObject("pid",pid);
		model.setViewName("/moudles/rad/radMap");
		return model;
	}
}
