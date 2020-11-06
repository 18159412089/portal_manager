package com.fjzxdz.ams.zphb.module.hbdc.service;


import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefDetails;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefDetailsParam;

import java.util.Map;

public interface ZpEnvironmentDebriefDetailsService {

	Page<EnvironmentDebriefDetails> listByPage(EnvironmentDebriefDetailsParam param, Page<EnvironmentDebriefDetails> page);

	void save(EnvironmentDebriefDetails details);

	EnvironmentDebriefDetails getById(String uuid);

	Map<String, Object> getByDebriefing(String debriefing);
	
}
