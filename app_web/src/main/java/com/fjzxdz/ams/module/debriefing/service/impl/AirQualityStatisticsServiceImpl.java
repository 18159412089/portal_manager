package com.fjzxdz.ams.module.debriefing.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.debriefing.service.AirQualityStatisticsService;

import cn.fjzxdz.frame.dao.common.SimpleDao;
@Service
@Transactional(rollbackFor=Exception.class)
public class AirQualityStatisticsServiceImpl implements AirQualityStatisticsService {

	@Autowired
	private SimpleDao simpleDao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getAirByTime(String startTime, String endTime) {
		
		String sql = "SELECT DISTINCT MONITOR_TIME ,AQI FROM AIR_DAY_DATA  WHERE TO_CHAR(MONITOR_TIME,'yyyy-mm-dd')>=?"
				+ "AND TO_CHAR(MONITOR_TIME,'yyyy-mm-dd')<=? AND POINT_CODE ='350600' ORDER BY MONITOR_TIME ASC";
		
		return simpleDao.createNativeQuery(sql, startTime,endTime).getResultList();
	}

}
