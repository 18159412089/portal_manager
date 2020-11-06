/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.fjzxdz.frame.controller.BaseController;

/**
 * 主界面Controller
 * @author lilongan
 * @version 2019-06-05
 */
@Controller
 
@RequestMapping(value = "/environment/main")
 
public class MainController extends BaseController {
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/main/main";
	}
	
}
