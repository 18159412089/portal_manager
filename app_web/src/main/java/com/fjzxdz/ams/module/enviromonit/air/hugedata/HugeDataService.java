package com.fjzxdz.ams.module.enviromonit.air.hugedata;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface HugeDataService {

	Map<String, Object> sixIndicatrixByYear(String category);

	Map<String, List<Map<String, Object>>> sixIndicatrixByCounty(String countyCode);

	List<Map<String, Object>> sixIndicatrixByCountyAndMonth(String countyCode);

	/***
	 * 
	 * @Title:  getMonitoringData
	 * @Description:    获取大气环境汇报中的监控数据
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年5月29日 下午2:42:56
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年5月29日 下午2:42:56    
	 * @return  Map<String,Object> 
	 * @throws
	 */
	Map<String, Object> getMonitoringData();

	Map<String, Object> getAirQuantity(String pointCode);
	
	Map<String, BigDecimal> getCoAndO3(String startTime, String EndTime, String point);

	Map<String, BigDecimal> getCoAndO3(String startTime, String EndTime, String point, String table);

}
