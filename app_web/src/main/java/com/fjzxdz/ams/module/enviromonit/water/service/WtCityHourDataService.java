package com.fjzxdz.ams.module.enviromonit.water.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.hutool.json.JSONObject;

import javax.servlet.http.HttpServletResponse;

public interface WtCityHourDataService {

	Page<Map<String, Object>> getPageList(WtCityHourDataParam param, Page<Map<String, Object>> page);

	List<Map<String, Object>> getPointsDateByHour(WtCityHourDataParam param) throws ParseException;

	List<Map<String, Object>> getYearDataQuality(String queryYear, String flag);

	List<Map<String, Object>> getMonthDataQuality(String yearMonth);

    List<Map<String, Object>> getRankingQualityDataByTime(String regionCode , String startTime, String endTime, String category, String type);

	List<Map<String, Object>> getRankingQualityDataForPollutant(String regionCode, String startTime, String endTime,
			String category, String type, String pollutantCode,int flag);

	 

	JSONObject getWtYearToYearDataByTime(String regionCode, String codePollute, String startTime, String endTime,
			String type);

	JSONObject getWtYearToYearDataResultByTime(String pointCodes, String startTime, String endTime, String type);

	Page<Map<String, Object>> findList(WtCityHourDataParam param, Page<Map<String, Object>> page, HttpServletResponse response);

	List<Map<String, Object>> exportData(WtCityHourDataParam param);

	List<Map<String, Object>> getDataByCode(WtCityHourData wtCityHourData);

	List<Map<String, Object>> getDataByName(WtCityHourData wtCityHourData);

	void insertData(WtCityHourData wtCityHourData);

	void updateData(WtCityHourData wtCityHourData);
}
