package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fjzxdz.ams.module.enviromonit.water.service.WtQualityDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 
 * 水质月检测数据统计表
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:31:55
 */
@Controller
@RequestMapping("/environment/wtQualityData")
@Secured({ "ROLE_USER" })
public class WtQualityDataController extends BaseController {
	@Autowired
	WtQualityDataService wtQualityService;

	/**
	 * 
	 * @Title:  index
	 * @Description:    水质月检测数据统计表  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:32:36
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:32:36    
	 * @param modelAndView
	 * @param pointCode
	 * @return  ModelAndView 
	 * @throws
	 */
	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView, String pointCode) {
		modelAndView.addObject("pointCode", pointCode);
		modelAndView.setViewName("/moudles/enviromonit/water/waterQualityData");
		return modelAndView;
	}

	/**
	 * 
	 * @Title:  list
	 * @Description:    水质月检测数据统计列表   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:32:49
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:32:49    
	 * @param year
	 * @param pointName
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<Map<String, Object>> list(String year,String pointName, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> pageList = wtQualityService.getPageList(year,pointName, page);
		return new PageEU<>(pageList);
	}

}
