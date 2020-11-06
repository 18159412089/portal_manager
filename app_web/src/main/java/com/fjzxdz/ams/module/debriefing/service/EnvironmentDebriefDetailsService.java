package com.fjzxdz.ams.module.debriefing.service;


import java.util.Map;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefDetails;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefDetailsParam;

import cn.fjzxdz.frame.common.Page;

public interface EnvironmentDebriefDetailsService {

	Page<EnvironmentDebriefDetails> listByPage(EnvironmentDebriefDetailsParam param, Page<EnvironmentDebriefDetails> page);

	void save(EnvironmentDebriefDetails details);

	EnvironmentDebriefDetails getById(String uuid);

	Map<String, Object> getByDebriefing(String debriefing);
	
}
