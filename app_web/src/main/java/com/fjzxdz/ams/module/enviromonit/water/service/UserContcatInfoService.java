package com.fjzxdz.ams.module.enviromonit.water.service;

import com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo;
import com.fjzxdz.ams.module.enviromonit.water.param.UserContcatInfoParam;

import cn.fjzxdz.frame.common.Page;

public interface UserContcatInfoService {

	Page<UserContcatInfo> getPageList(UserContcatInfoParam param, Page<UserContcatInfo> page);

	UserContcatInfo saveUser(UserContcatInfo userContcatInfo);

	void delUser(String uuid);

	void addUser(UserContcatInfo userContcatInfo);

	String save(String[][] result) throws Exception;

	
}
