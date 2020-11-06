package com.fjzxdz.ams;

import java.util.List;

import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.bcel.generic.Select;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class SqlTest {

	@Autowired
	private SimpleDao simpleDao;
	
	@Test
	@Transactional
	public void test() throws Exception {
		String sql = "select m.REGION_NAME,m.POINT_CODE,h.AQI,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE " 
				+ " from AIR_HOUR_DATA h inner JOIN AIR_MONITOR_POINT m on h.POINT_CODE = m.POINT_CODE " 
				+ " AND m.POINT_TYPE = '1' where MONITOR_TIME= (SELECT MAX( MONITOR_TIME ) "
				+ " FROM AIR_HOUR_DATA WHERE POINT_CODE = '350600') "
				+ " group by m.REGION_NAME,m.POINT_CODE,h.AQI ,h.MONITOR_TIME,m.LONGITUDE,m.LATITUDE order by  h.AQI ASC  ";
		Query createNativeQuery = simpleDao.createNativeQuery(sql);
		List<Object[]> resultList = createNativeQuery.getResultList();
		System.out.println("======="+resultList.size());
	}

}
