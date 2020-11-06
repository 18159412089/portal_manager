package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.pollution.dao.FactorDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;
import com.fjzxdz.ams.module.enviromonit.pollution.param.FactorParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.FactorService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor = Exception.class)
public class FactorServiceImpl implements FactorService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(FactorServiceImpl.class);

	@Autowired
	private FactorDao factorDao;

	@Override
	public Factor getById(String uuid) {
		return factorDao.getById(uuid);
	}

	@Override
	public List<Factor> getFactorList(String pointCode) {
		return factorDao.selectList("from Factor f where f.pointCode = '" + pointCode + "'");
	}

	@Override
	public Page<Factor> listByPage(FactorParam param, Page<Factor> page) {
		Page<Factor> userPage = factorDao.listByPage(param, page);
		return userPage;
	}
	
}
