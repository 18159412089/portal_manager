/*   
 * Copyright (c) 2015-2020 FuJianZhongXingDianzi. All Rights Reserved.   
 *   
 * This software is the confidential and proprietary information of   
 * Founder. You shall not disclose such Confidential Information   
 * and shall use it only in accordance with the terms of the agreements   
 * you entered into with Founder.   
 *   
 */ 
package com.fjzxdz.ams.module.jobSchedule.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enums.JobScheduleDepartmentEnum;
import com.fjzxdz.ams.module.jobSchedule.entity.JobScheduleDepartment;
import com.fjzxdz.ams.module.jobSchedule.param.JobScheduleDepartmentParam;
import com.fjzxdz.ams.module.jobSchedule.service.JobScheduleDepartmentService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import org.springframework.web.servlet.ModelAndView;

/**   
 * 工作调度Controller
 * @Author   chenbk
 */
@Controller
@RequestMapping(value = "/jobSchedule/jobScheduleDepartment")
public class JobScheduleController extends BaseController {

	@Autowired
	private JobScheduleDepartmentService departmentService;
	@Autowired
	private SimpleDao simpleDao;

	@RequestMapping("")
	public ModelAndView Index(ModelAndView modelAndView, String pid) {
		modelAndView.addObject("pid",pid);
		modelAndView.setViewName("/moudles/jobSchedule/jobScheduleDepartmentList");
		return modelAndView;
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageEU<JobScheduleDepartment> list(JobScheduleDepartmentParam param, HttpServletRequest request) {
		Page<JobScheduleDepartment> page = pageQuery(request);
		Page<JobScheduleDepartment> department = departmentService.listByPage(param, page);
		return new PageEU<>(department);
	}

	/**
	 * 
	 * @Title:  save
	 * @Description:    新增部门
	 * @CreateBy: caibai 
	 * @CreateTime: 2019年5月9日 上午9:25:28
	 * @UpdateBy: caibai 
	 * @UpdateTime:  2019年5月9日 上午9:25:28    
	 * @param department
	 * @param request
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/saveDept")
	@ResponseBody
	public R save(JobScheduleDepartment department, HttpServletRequest request) {
		try {
			//CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
			//department.setUserId(user.getUuid());
			//department.setUserName(user.getName());
			departmentService.save(department);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 已选择用户
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getSelectedUsers")
	@ResponseBody
	public R getSelectedUsers(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		JSONArray jsonAry = new JSONArray();
		try {
			String users = departmentService.getUsersById(uuid);
			if(StringUtils.isNotEmpty(users)) {
				users = StringUtils.join(users.split(";"), "','");
				String sql = "select name, loginname,uuid from sys_user where uuid in ('"+users+"')";
				List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
				for (Object[] objects : list) {
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("name", objects[0].toString());
					jsonObject.put("loginname", objects[1].toString());
					jsonObject.put("uuid", objects[2].toString());
					jsonAry.add(jsonObject);
				}
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		map.put("data", jsonAry);
		return R.ok(map);
	}

	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveUser")
	@ResponseBody
	public R saveUser(@RequestParam(value = "uuid") String uuid, @RequestParam(value = "userName") String userName,
			@RequestParam(value = "userId") String userId) {
		R r;
		try {
			r = departmentService.saveUser(uuid, userId, userName);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}

	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/deleteDept")
	@ResponseBody
	public R deleteDept(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = new HashedMap<>();
		map.put("type", "S");
		try {
			JobScheduleDepartment dept = departmentService.getById(uuid);
			if (null != dept) {
				List<Object> list = null;
				if("VEHICLE".equals(dept.getCategory())) {
					list = simpleDao.createNativeQuery("select count(1) from VEHICLE_POLLUTION where DEPARTMENT_ID='"+uuid+"'").getResultList();
				} else if("DMBZRZ".equals(dept.getCategory())) {
					list = simpleDao.createNativeQuery("select count(1) from CLIQUE_BUILD where DEPARTMENT_ID='"+uuid+"'").getResultList();
				}
				if("0".equals(list.get(0).toString())) {
					departmentService.delete(uuid);
				} else {
					map.put("type", "E");
					map.put("message", "该部门在 " + JobScheduleDepartmentEnum.valueOf(dept.getCategory()).getValue() + " 中存在文件，不允许删除");
				}

			} else {
				map.put("type", "E");
				map.put("message", "数据库中没有该记录");
			}
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return R.ok(map);
	}

	/**
	 * 查看用户
	 */
	@RequestMapping(value = "/getDept")
	@ResponseBody
	public R getDept(@RequestParam(value = "uuid") String uuid) {
		JobScheduleDepartment department;
		try {
			department = departmentService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("data", department);
	}

	/**
	 * 禁用部门
	 */
	@RequestMapping(value = "/disableDept")
	@ResponseBody
	public Map<String, String> disableDept(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			JobScheduleDepartment department = departmentService.getById(uuid);
			department.setEnable(new BigDecimal(0));
			departmentService.save(department);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 启用部门
	 */
	@RequestMapping(value = "/enableDept")
	@ResponseBody
	public Map<String, String> enableDept(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			JobScheduleDepartment department = departmentService.getById(uuid);
			department.setEnable(new BigDecimal(1));
			departmentService.save(department);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	@RequestMapping("/getDeptList")
	@ResponseBody
	public JSONArray getDeptList(String category) {
		return departmentService.getDeptList(category);
	}
}
