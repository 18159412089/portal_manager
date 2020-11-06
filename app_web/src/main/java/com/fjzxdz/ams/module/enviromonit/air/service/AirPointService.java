package com.fjzxdz.ams.module.enviromonit.air.service;

import java.util.List;
import java.util.Map;

import cn.fjzxdz.frame.common.Page;

/**
 * 
 * 关于大气数据服务模块的监测站实现接口
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年6月25日 下午3:56:13
 */
public interface AirPointService {
	
	public List<Map<String, Object>> FactoryCompare(String pointName, String start, String end);

}
