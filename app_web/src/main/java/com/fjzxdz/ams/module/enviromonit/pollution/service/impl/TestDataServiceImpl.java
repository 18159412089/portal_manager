package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.pollution.dao.TestDataDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;
import com.fjzxdz.ams.module.enviromonit.pollution.param.TestDataParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.TestDataService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor = Exception.class)
public class TestDataServiceImpl implements TestDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(TestDataServiceImpl.class);

	@Autowired
	private TestDataDao testDataDao;

	@Override
	public List<TestData> getTestDataList(String mnNumber) {
		return testDataDao.selectList("from TestData f where f.mnNumber = '" + mnNumber + "'");
	}

	@Override
	public Page<TestData> listByPage(TestDataParam param, Page<TestData> page) {
		Page<TestData> userPage = testDataDao.listByPage(param, page);
		return userPage;
	}
	
}
