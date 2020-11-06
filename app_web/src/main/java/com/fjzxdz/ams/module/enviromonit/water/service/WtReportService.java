package com.fjzxdz.ams.module.enviromonit.water.service;

import java.util.List;

public interface WtReportService {
	List<Object[]> countWaterQuality(String startTime,String endTime);
	
}
