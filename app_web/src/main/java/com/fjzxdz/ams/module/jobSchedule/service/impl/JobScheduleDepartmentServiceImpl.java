package com.fjzxdz.ams.module.jobSchedule.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.jobSchedule.dao.JobScheduleDepartmentDao;
import com.fjzxdz.ams.module.jobSchedule.entity.JobScheduleDepartment;
import com.fjzxdz.ams.module.jobSchedule.param.JobScheduleDepartmentParam;
import com.fjzxdz.ams.module.jobSchedule.service.JobScheduleDepartmentService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
/**
 * 
 * 部门管理service实现
 * @Author   
 * @Version   1.0 
 * @CreateTime 
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class JobScheduleDepartmentServiceImpl implements JobScheduleDepartmentService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(JobScheduleDepartmentServiceImpl.class);

	@Autowired
	private JobScheduleDepartmentDao departmentDao;

	@Override
	public Page<JobScheduleDepartment> listByPage(JobScheduleDepartmentParam param, Page<JobScheduleDepartment> page) {
		//CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
		//param.setUserId(user.getUuid());
		return departmentDao.listByPage(param, page);
	}

	@Override
	public void save(JobScheduleDepartment department) {
		if (ToolUtil.isEmpty(department.getUuid())) {
			department.setUuid(null);
			department.setEnable(new BigDecimal(1));
			departmentDao.save(department);
		} else {
			JobScheduleDepartment temp = departmentDao.getById(department.getUuid());
			temp.setName(department.getName());
			temp.setCategory(department.getCategory());
			if (department.getEnable() != null) {
				temp.setEnable(department.getEnable());
			}
			departmentDao.update(temp);
		}

	}

	@Override
	public String getUsersById(String uuid) {
		JobScheduleDepartment department = departmentDao.getUnique("from JobScheduleDepartment where uuid=?", uuid);
		return department.getUserId();
	}

	@Override
	public R saveUser(String uuid, String userAccount, String userName) {
		JobScheduleDepartment temp = departmentDao.getById(uuid);
		temp.setUserName(userName);
		temp.setUserId(userAccount);
		departmentDao.update(temp);
		return R.ok();
	}

	@Override
	public void delete(String uuid) {
		departmentDao.deleteById(uuid);
	}

	@Override
	public JobScheduleDepartment getById(String uuid) {
		return departmentDao.getById(uuid);
	}

	@Override
	public JSONArray getDeptList(String category) {
		CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
		String uid = user.getUuid();
		List<JobScheduleDepartment> list = departmentDao.selectList(
				"from JobScheduleDepartment where enable=1 and category=? and userId like '%" + uid + "%'", category);
		if (ToolUtil.isNotEmpty(list)) {
			JSONArray array = new JSONArray();
			for (JobScheduleDepartment department : list) {
				JSONObject temp = new JSONObject();
				temp.put("id", department.getUuid());
				temp.put("text", department.getName());
				array.add(temp);
			}
			return array;
		}
		return new JSONArray();
	}

}
