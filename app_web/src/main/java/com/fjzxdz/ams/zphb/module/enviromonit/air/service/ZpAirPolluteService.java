package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

/**
 * 
 * 关于大气数据服务模块的污染物分析实现接口
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年6月25日 下午3:56:13
 */
public interface ZpAirPolluteService {

	Map<String, Object> analysisCharts(String regionName, String factory, String start, String end, String pointType,
                                       String type);

	Page<Map<String, Object>> analysisWords(String regionName, String dateType, String start, String end,
                                            Page<Map<String, Object>> page, String pointType, String type);

	List<Map<String, Object>> analysisPointCharts(String pointName, String start, String end, String dateTy,
                                                  String queryType) throws ParseException;

}
