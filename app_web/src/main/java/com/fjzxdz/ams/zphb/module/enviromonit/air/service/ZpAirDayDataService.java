package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 
 *  数据服务 空气环境质量 接口
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午1:27:44
 */
public interface ZpAirDayDataService {
	
	/**
	 * 
	 * @Title:  listByPage
	 * @Description:    查询空气日数据信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:27:31
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:27:31    
	 * @param param
	 * @param page
	 * @param response
     * @return  Page<Map<String,Object>>
	 * @throws
	 */
	Page<Map<String, Object>> listByPage(AirDayDataParam param, Page<Map<String, Object>> page,
                                         HttpServletResponse response);

	/**
	 *
	 * @Title:  airQuantityForLastMonth
	 * @Description:    获取漳州市过去一个月的空气AQI值
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午1:55:18
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午1:55:18
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> airQuantityForLastMonth();

	List<Object[]> getCityAirDayData();
	/**
	 *
	 * @Title:  getCityByMonth
	 * @Description:    空气日历 日历显示
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午1:57:11
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午1:57:11
	 * @param pointCode
	 * @param startTime
	 * @param endTime
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> getCityByMonth(String pointCode, String startTime, String endTime);
	/**
	 *
	 * @Title:  getCityAirInfo
	 * @Description:    获取该城市当天天气信息
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午1:57:26
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午1:57:26
	 * @param pointCode
	 * @param time
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> getCityAirInfo(String pointCode, String time);


	List<Object []> getCityInfoByCode(String pointCode, String startTime, String endTime);
	

	
	
	
}
