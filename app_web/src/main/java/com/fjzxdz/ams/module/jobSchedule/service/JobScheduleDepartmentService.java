package com.fjzxdz.ams.module.jobSchedule.service;


import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.jobSchedule.entity.JobScheduleDepartment;
import com.fjzxdz.ams.module.jobSchedule.param.JobScheduleDepartmentParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;

public interface JobScheduleDepartmentService {

	void save(JobScheduleDepartment jobScheduleDepartment);

	Page<JobScheduleDepartment> listByPage(JobScheduleDepartmentParam param, Page<JobScheduleDepartment> page);

	/**
	 * 通过部门ID获取使用人员    
	 */
	String getUsersById(String uuid);

	/**
	 * 保存用户
	 */ 
	R saveUser(String uuid, String userAccount, String userName);

	/**
	 * 删除部门  
	 */ 
	void delete(String uuid);

	JobScheduleDepartment getById(String uuid);

	/**
	 * 获取不同类型的部门
	 */ 
	JSONArray getDeptList(String category);

}
