package com.fjzxdz.ams.zphb.module.enviromonit.air.service;

import cn.fjzxdz.frame.common.Page;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 
 * 空气日数据Service接口
 * @Author   钟云龙
 * @Version   1.0 
 * @CreateTime 2019年4月29日 上午9:36:15
 */
public interface ZpAirHourDataService {
	
	/**
	 * 
	 * @Title:  listByPage
	 * @Description:    查询空气小时数据    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:29:19
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:29:19    
	 * @param param
	 * @param page
	 * @param response
     * @return  Page<Map<String,Object>>
	 * @throws
	 */
	Page<Map<String, Object>> listByPage(AirHourDataParam param, Page<Map<String, Object>> page,
                                         HttpServletResponse response);


	/**
	 * <p>Title: listByPage</p>
	 * <p>Description: 查询空气月数据</p>
	 *
	 * @param param
	 * @param page
	 * @return
	 * @see ZpAirHourDataService#listByPage(AirHourDataParam, Page, HttpServletResponse)
	 */
	Page<Map<String, Object>> listMonthByPage(AirHourDataParam param, Page<Map<String, Object>> page, HttpServletResponse response);

	/**
	 *
	 * @Title:  rankingOrderByAQI
	 * @Description:    获取最新数据中，前十名城市信息。按空气质量排名
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:33:27
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年5月9日 下午2:33:27
	 * @param pointType 城市类型
	 * @param pointCode	城市编号(用于查询城市站点下监测站点的时候才需要用到)
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> rankingOrderByAQI(String pointType, String pointCode);

	/**
	 *
	 * @Title:  getAirQuantity
	 * @Description:    某个城市的最新小时数据
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年4月29日 上午9:37:35
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年4月29日 上午9:37:35
	 * @param pointCode
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> getAirQuantity(String pointCode);

	/**
	 *
	 * @Title:  getAirInfoByTime
	 * @Description:    查询漳州市市区(芗城和龙文)单日的空气信息
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年4月29日 上午9:32:01
	 * @UpdateBy: zhongyunlong
	 * @UpdateTime:  2019年4月29日 上午9:32:01
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> getAirInfoByTime(String startTime, String endTime);

	JSONArray getAllPointsDayDataRanking(String time);
}
