package com.fjzxdz.ams.module.enviromonit.water.service;

import com.fjzxdz.ams.module.enviromonit.water.entity.TaskDetalis;
import com.fjzxdz.ams.module.enviromonit.water.param.TaskDetalisParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;

public interface TaskDetalisService {

	Page<TaskDetalis> listByPage(TaskDetalisParam param, Page<TaskDetalis> page);
	
	TaskDetalis getInfoById(String id);

	R save(TaskDetalis taskDetalis);
}
