package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import java.util.Map;

/**
 * 
 * 大气环境服务 接口 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午2:32:48
 */
public interface ZpAirEnvironmentService {
	
	/**
	 * 
	 * @Title:  getDataAnalysisCityPoint
	 * @Description:    点击地图上的点显示的窗口中。数据分析的数据显示。    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:16:37
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:16:37    
	 * @param polluteName
	 * @param pointCode
	 * @param time
	 * @return  Map<String,Object> 
	 * @throws
	 */
	Map<String, Object> getDataAnalysisCityPoint(String polluteName, String pointCode, String time);
}
