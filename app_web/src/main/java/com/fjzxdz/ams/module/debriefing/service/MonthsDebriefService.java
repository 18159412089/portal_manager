package com.fjzxdz.ams.module.debriefing.service;


import java.util.Map;

public interface MonthsDebriefService {

	Map<String, Object> getCompareCounty(String start,String end,String start2,String end2);

	Map<String, Object> getSixFactoryQualityRate(String start, String end, String start2, String end2);
	
}
