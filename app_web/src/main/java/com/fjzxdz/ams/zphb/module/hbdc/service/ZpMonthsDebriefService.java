package com.fjzxdz.ams.zphb.module.hbdc.service;


import java.util.Map;

public interface ZpMonthsDebriefService {

	Map<String, Object> getCompareCounty(String start, String end, String start2, String end2);

	Map<String, Object> getSixFactoryQualityRate(String start, String end, String start2, String end2);
	
}
