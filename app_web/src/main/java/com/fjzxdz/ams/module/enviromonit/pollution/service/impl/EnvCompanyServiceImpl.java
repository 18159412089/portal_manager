package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.pollution.dao.EnvCompanyDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.EnvCompanyService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor=Exception.class)
public class EnvCompanyServiceImpl implements EnvCompanyService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(EnvCompanyServiceImpl.class);

	@Autowired
	private EnvCompanyDao envCompanyDao;


	@Override
	public EnvCompany getById(String uuid) {
		return envCompanyDao.getById(uuid);
	}

	@Override
	public Page<EnvCompany> listByPage(EnvCompanyParam param, Page<EnvCompany> page) {
		Page<EnvCompany> userPage = envCompanyDao.listByPage(param, page);
		return userPage;
	}
}
