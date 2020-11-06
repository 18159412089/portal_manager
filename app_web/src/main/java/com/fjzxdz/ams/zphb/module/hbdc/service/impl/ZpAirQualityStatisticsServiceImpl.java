package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirQualityStatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(rollbackFor=Exception.class)
public class ZpAirQualityStatisticsServiceImpl implements ZpAirQualityStatisticsService {

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
