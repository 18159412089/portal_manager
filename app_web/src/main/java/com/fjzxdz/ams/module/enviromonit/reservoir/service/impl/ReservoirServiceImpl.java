package com.fjzxdz.ams.module.enviromonit.reservoir.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.reservoir.service.ReservoirService;

import cn.fjzxdz.frame.dao.common.SimpleDao;
@Service
@Transactional(rollbackFor = Exception.class)
public class ReservoirServiceImpl implements ReservoirService {
	
	@Autowired
	private SimpleDao simpleDao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getConDaychart(String eqpID, Integer days) {
		
		String sqlString ;
		sqlString ="SELECT D.NAME AS ," 
				+ "da.MAX_VALUE ,TO_CHAR(da.MEASURE_TIME,'yyyy-mm-dd') ,da.MIN_VALUE,da.AVG_VALUE " 
				+ "FROM HYD_POSITION_INFO P "
				+ "INNER JOIN HYD_DEV_INFO d ON P.HYDROPOWER_ID=d.HYDROPOWER_ID and d.LONGITUDE is not null and d.LATITUDE is not null " 
				+ "inner join HYD_DEV_EXIT_DATA de on d.HYDROPOWER_ID=de.HYDROPOWER_ID "
				+ "left join HYD_DRAIN_DAY_DATA da on de.output_id=da.output_id and da.MEASURE_TIME>= sysdate-"+days
				+ " WHERE P.IS_USED='1' and P.EQP_ID= ? order by da.MEASURE_TIME desc";
		List<Object[]> list = simpleDao.createNativeQuery(sqlString,eqpID).getResultList();
		return list;
	}

}
