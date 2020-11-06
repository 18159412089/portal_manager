package com.fjzxdz.ams.zphb.module.hbdc.service;

import java.util.List;

public interface ZpAirQualityByYearService {

	List<Object[]> getAirYearOnYearAnalysis(String startTime, String endTime, String citys);

}
