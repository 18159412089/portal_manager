package com.fjzxdz.ams.module.debriefing.service;

import java.util.List;

public interface AirQualityStatisticsService {

	List<Object[]> getAirByTime(String startTime, String endTime);

}
