package com.fjzxdz.ams.zphb.module.hbdc.service;


import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefing;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefingParam;

import java.util.List;

public interface ZpEnvironmentDebriefingService {

	Page<EnvironmentDebriefing> listByPage(EnvironmentDebriefingParam param, Page<EnvironmentDebriefing> page);

	void save(EnvironmentDebriefing debriefing);

	EnvironmentDebriefing getById(String uuid);

	List<EnvironmentDebriefing> debriefingList(EnvironmentDebriefingParam param);

	String getDescribe();
	
}
