package com.fjzxdz.ams.module.debriefing.service;

import java.util.List;

public interface AirQualityByYearService {

	List<Object[]> getAirYearOnYearAnalysis(String startTime, String endTime, String citys);

}
