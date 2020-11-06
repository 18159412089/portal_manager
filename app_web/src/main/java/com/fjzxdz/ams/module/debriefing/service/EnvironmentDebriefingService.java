package com.fjzxdz.ams.module.debriefing.service;


import java.util.List;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefing;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefingParam;

import cn.fjzxdz.frame.common.Page;

public interface EnvironmentDebriefingService {

	Page<EnvironmentDebriefing> listByPage(EnvironmentDebriefingParam param, Page<EnvironmentDebriefing> page);

	void save(EnvironmentDebriefing debriefing);

	EnvironmentDebriefing getById(String uuid);

	List<EnvironmentDebriefing> debriefingList(EnvironmentDebriefingParam param);

	String getDescribe();
	
}
