package com.fjzxdz.ams.module.enviromonit.water.service;

import java.util.Map;

import cn.fjzxdz.frame.common.Page;

public interface WtQualityDataService {
	Page<Map<String, Object>> getPageList(String year,String pointName, Page<Map<String, Object>> page);
}
