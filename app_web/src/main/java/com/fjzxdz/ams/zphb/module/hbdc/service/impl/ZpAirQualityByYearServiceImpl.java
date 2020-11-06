package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirQualityByYearService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional(rollbackFor=Exception.class)
public class ZpAirQualityByYearServiceImpl implements ZpAirQualityByYearService {
	
	@Autowired
	private SimpleDao simpleDao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getAirYearOnYearAnalysis(String startTime, String endTime, String citys) {
		
		
		String sql = "SELECT DISTINCT POINT_NAME,	MONITOR_TIME,	AQI, " + 
				"sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, "+
				"	sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 "+
				"   FROM	AIR_DAY_DATA WHERE " + 
				"	TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ? " + 
				"	AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ?  " + 
				"	AND POINT_CODE IN   " + citys+ 
				"	GROUP BY MONITOR_TIME,POINT_NAME,AQI ORDER BY " + 
				"	POINT_NAME,MONITOR_TIME ASC";
		return simpleDao.createNativeQuery(sql, startTime,endTime).getResultList();
	}
	
	
	
}
