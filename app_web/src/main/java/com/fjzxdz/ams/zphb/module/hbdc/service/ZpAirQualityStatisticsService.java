package com.fjzxdz.ams.zphb.module.hbdc.service;

import java.util.List;

public interface ZpAirQualityStatisticsService {

	List<Object[]> getAirByTime(String startTime, String endTime);

}
