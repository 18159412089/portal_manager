package com.fjzxdz.ams.module.enviromonit.water.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam;

import cn.fjzxdz.frame.common.Page;

public interface WtMonthDataService {

	Page<Map<String, Object>> getPageList(WtMonthDataParam param, Page<Map<String, Object>> page);

	List<Map<String, Object>> getPointsDateByMonth(WtMonthDataParam param) throws ParseException;

	Map<String, Object> getPassYearAnalysis(WtMonthDataParam param) throws ParseException;

}
