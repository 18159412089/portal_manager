package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirComplianceRateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(rollbackFor=Exception.class)
public class ZpAirComplianceRateServiceImpl implements ZpAirComplianceRateService {
	
	@Autowired
	private SimpleDao simpleDao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getAirComplianceRate(String start, String end) {
		
		String sql = "SELECT DISTINCT 	POINT_NAME,MONITOR_TIME,	AQI, " + 
				"sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, " + 
				"	sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, "+
				"	sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 "+
				"   FROM	AIR_DAY_DATA WHERE " + 
				"	TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ? " + 
				"	AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ?  " + 
				"	AND POINT_CODE ='350600' "+ 
				"	GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY " + 
				"	MONITOR_TIME ASC";
		
		return simpleDao.createNativeQuery(sql, start,end).getResultList();
	}

	@Override
	public List<Object[]> getAirComplianceRate2(String start, String end, String category) {
		
		String sql = "select AVG(AQI) tep,MONITOR_TIME,AVG(AQI),AVG(PM25),AVG(PM10),"
				+ "AVG(CO),AVG(NO2),AVG(O3),AVG(SO2) "
			    + "FROM (SELECT DISTINCT MONITOR_TIME, AQI, "
			    + "sum(DECODE( CODE_POLLUTE, 'A34004', AVERVALUE, 0 )) PM25, "
			    + "sum(DECODE( CODE_POLLUTE, 'A34002', AVERVALUE, 0 )) PM10, "
			    + "sum(DECODE( CODE_POLLUTE, 'A21005', AVERVALUE, 0 )) CO, "
			    + "sum(DECODE( CODE_POLLUTE, 'A21004', AVERVALUE, 0 )) NO2, "
			    + "sum(DECODE( CODE_POLLUTE, 'A050248', AVERVALUE, 0 )) O3, "
			    + "sum(DECODE( CODE_POLLUTE, 'A21026', AVERVALUE, 0 )) SO2 "
			    + "FROM AIR_DAY_DATA a left join AIR_MONITOR_POINT b on a.POINT_CODE=b.POINT_CODE "
			    + "WHERE a.AQI <> 1 and TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) >= ? "
			    + "AND TO_CHAR( MONITOR_TIME, 'yyyy-mm-dd' ) <= ? ";
		if("0".equals(category)) {
		    sql += "AND a.POINT_CODE IN ( '600602', '350600451','600603' )";
		} else {
		    sql += "AND a.POINT_CODE not IN ( '600602', '350600451','600603' )";
		}
		sql += " GROUP BY MONITOR_TIME,AQI) GROUP BY MONITOR_TIME ORDER BY MONITOR_TIME";
		
		return simpleDao.createNativeQuery(sql, start,end).getResultList();
	}

}
