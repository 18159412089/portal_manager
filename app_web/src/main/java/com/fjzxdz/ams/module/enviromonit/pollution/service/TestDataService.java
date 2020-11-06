package com.fjzxdz.ams.module.enviromonit.pollution.service;

import java.util.List;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;
import com.fjzxdz.ams.module.enviromonit.pollution.param.TestDataParam;

import cn.fjzxdz.frame.common.Page;


public interface TestDataService {

	Page<TestData> listByPage(TestDataParam param, Page<TestData> page);
	List<TestData> getTestDataList(String mnNumber);

}
