package com.fjzxdz.ams.module.enviromonit.air.service;

import com.fjzxdz.ams.module.enviromonit.air.param.AirDataParam;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;

import java.text.ParseException;
import java.util.List;
import java.util.Map;
/**
 * 
 * 数据服务 空气环境质量 接口 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月30日 下午1:24:22
 */
public interface AirDataService {

	List<Map<String, Object>> getPointDateByHourOrDay(AirDataParam param);
	/**
	 * 
	 * @Title:  getPassYearAnalysisWithPoint
	 * @Description:    站点污染物往年同比    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:29:11
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:29:11    
	 * @param polluteName
	 * @param pointCode
	 * @param time
	 * @param year
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	Map<String, Object> getPassYearAnalysisWithPoint(String polluteName, String pointCode, String time, int year) throws ParseException;

	List<Map<String, Object>> getPointsDateByHourOrDay(AirDataParam param) throws ParseException;
	/**
	 * 
	 * @Title:  getMonthQualityAnalysis
	 * @Description:    月城市空气质量类别分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:27:04
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:27:04    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	List<Map<String, Object>> getMonthQualityAnalysis(AirDataParam param) throws ParseException;
	/**
	 * 
	 * @Title:  getMonthPollutionAnalysis
	 * @Description:    月站点首要污染物分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:26:49
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:26:49    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	List<Map<String, Object>> getMonthPollutionAnalysis(AirDataParam param) throws ParseException;
	/**
	 * 
	 * @Title:  getPassMonthAnalysis
	 * @Description:    站点污染物往月环比    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:28:19
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:28:19    
	 * @param param
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	Map<String, Object> getPassMonthAnalysis(AirDataParam param) throws ParseException;
	
	/**
	 * 
	 * @Title:  getMonthPollutionConAnalysis
	 * @Description:    站点污染物过程分析    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年4月30日 下午1:26:18
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年4月30日 下午1:26:18    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	List<Map<String, Object>> getMonthPollutionConAnalysis(AirDataParam param) throws ParseException;



	List<Object[]> getCurAirQuality(String pointCode, String time);

	List<Object[]> getAirQualityChart(AirDayDataParam param);

	/**
	 * 往年同比 大气 多站点对比
	 *
	 * @param polluteName 因子
	 * @param pointCode   站点
	 * @param time
	 * @param year        对比年份
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("unchecked")
	List<Map<String, Object>> getPassYearAnalysisAirMorePoint(String polluteName, String pointCode, String time, String year) throws ParseException;

	/**
	 * 往年/环比 大气 多站点对比
	 *
	 * @param polluteName 因子
	 * @param pointCode   站点
	 * @param time
	 * @param year        对比年份
	 * @return
	 * @throws ParseException
	 */
	List<Map<String, Object>> getPassYearAnalysisAirMorePointHB(String polluteName, String pointCode, String time, String year) throws ParseException;


    Map<String, Object> getCompareData(String pointCode, String year, String rq);
}

