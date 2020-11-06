package com.fjzxdz.ams.module.enviromonit.water.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtWeekData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtWeekDataParam;

import cn.fjzxdz.frame.common.Page;

public interface WtWeekDataService {
	
	Page<WtWeekData> listByPage(WtWeekDataParam param, Page<WtWeekData> page);

	Page<Map<String, Object>> getPageList(WtWeekDataParam param, Page<Map<String, Object>> page);

	List<Map<String, Object>> getPointsDateByWeek(WtWeekDataParam param) throws ParseException;

	Map<String, Object> getPassYearAnalysis(WtWeekDataParam param) throws ParseException;
}
