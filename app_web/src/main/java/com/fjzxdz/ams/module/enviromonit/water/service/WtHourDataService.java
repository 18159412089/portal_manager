package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface WtHourDataService {

	List<WtHourData> getListByCode(String pointCode);

	Page<Map<String, Object>> getPageList(WtHourDataParam param, Page<Map<String, Object>> page);

	Map<String, Object> getPassMonthAnalysis(WtHourDataParam param) throws ParseException;

	Page<Map<String, Object>> getPageListNative(WtHourDataParam param, Page<Map<String, Object>> page,String regionName);

	Page<Map<String, Object>> getPageListProvince(WtHourDataParam param, Page<Map<String, Object>> page, String regionName);

	Page<Map<String, Object>> getPageAllList(WtHourDataParam param, Page<Map<String, Object>> page);
	/**
	 * 实时动态数据大屏  水质自动实时监测
	 *
	 * @return
	 */
	List<Map> getWtRealTimeData();

}
