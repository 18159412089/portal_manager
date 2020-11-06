package com.fjzxdz.ams.module.enviromonit.water.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam;

import cn.fjzxdz.frame.common.Page;

public interface WtDayDataService {

	Page<WtDayData> listByPage(WtDayDataParam param, Page<WtDayData> page);

	Page<Map<String, Object>> getPageList(WtDayDataParam param, Page<Map<String, Object>> page);

	List<Map<String, Object>> getPointsDateByDay(WtDayDataParam param) throws ParseException;

	Map<String, Object> getPassMonthAnalysis(WtDayDataParam param) throws ParseException;

	Map<String, Object> getPassYearAnalysis(WtDayDataParam param) throws ParseException;

	Page<Map<String, Object>> getPageAllList(WtDayDataParam param, Page<Map<String, Object>> page);
}
