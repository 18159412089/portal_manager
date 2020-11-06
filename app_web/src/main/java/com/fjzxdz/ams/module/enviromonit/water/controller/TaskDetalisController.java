package com.fjzxdz.ams.module.enviromonit.water.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.water.entity.TaskDetalis;
import com.fjzxdz.ams.module.enviromonit.water.param.TaskDetalisParam;
import com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 
 * 水环境-应急短信下发-派发任务明细列表
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午2:57:06
 */
@Controller
@RequestMapping("/enviromonit/water/taskDetalis")
@Secured({ "ROLE_USER" })
public class TaskDetalisController extends BaseController {

	@Autowired
	private TaskDetalisService taskDetalisService;

	/**
	 * 
	 * @Title:  list
	 * @Description:    水环境-应急短信下发-派发任务明细列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:45:46
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:45:46    
	 * @param param
	 * @param request
	 * @return  PageEU<TaskDetalis> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<TaskDetalis> list(TaskDetalisParam param, HttpServletRequest request) {
		Page<TaskDetalis> page = pageQuery(request);
		Page<TaskDetalis> detailedAssignmentsPage = taskDetalisService.listByPage(param, page);
		return new PageEU<>(detailedAssignmentsPage);
	}
	
	/**
	 * 
	 * @Title:  getInfoById
	 * @Description:    水环境-应急短信下发-派发任务明细列表-查看明细
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:47:34
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:47:34    
	 * @param id
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getInfoById")
	@ResponseBody
	public String getInfoById(String id) {

		TaskDetalis taskDetalis = taskDetalisService.getInfoById(id);
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		jsonObject.put("userName", taskDetalis.getUserName());
		jsonObject.put("content", taskDetalis.getContent());
		jsonArray.add(jsonObject);
		return jsonArray.toString();
	}
}
