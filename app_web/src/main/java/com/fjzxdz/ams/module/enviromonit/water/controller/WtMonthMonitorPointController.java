package com.fjzxdz.ams.module.enviromonit.water.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMonthMonitorPointService;

import cn.fjzxdz.frame.controller.BaseController;

/**
 * 
 * 监控站点
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:00:59
 */
@Controller
@RequestMapping("/enviromonit/water/wtMonthMonitor")
public class WtMonthMonitorPointController extends BaseController {
	@Autowired
	private WtMonthMonitorPointService wtMonthMonitorPointService;

	/**
	 * 
	 * @Title:  getPointList
	 * @Description:    获取监控站点   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:31:38
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:31:38    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public JSONArray getPointList() {//
		return  wtMonthMonitorPointService.getMonitorPointList();
	}
}
