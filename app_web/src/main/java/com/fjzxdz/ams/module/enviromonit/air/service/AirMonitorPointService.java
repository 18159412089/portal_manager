package com.fjzxdz.ams.module.enviromonit.air.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirMonitorPointParam;

import cn.fjzxdz.frame.common.Page;
/**
 * 
 * 空气站点 Service 接口
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:04:31
 */
public interface AirMonitorPointService {
	
	
	/**
	 * 
	 * @Title:  getCityByType
	 * @Description:    获取所有最新城市的信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:58:26
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:58:26    
	 * @param type
	 * @param pointCode
	 * @param factor
	 * @param userDeptName
     * @return  List<Object[]>
	 * @throws
	 */
	List<Object[]> getCityByType(String type, String pointCode, String factor, String userDeptName);
	
	/**
	 * 
	 * @Title:  getCity
	 * @Description:    获取城市编号和名称    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:57:58
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:57:58    
	 * @return  List<AirMonitorPoint> 
	 * @throws
	 */
	List<AirMonitorPoint> getCity();

	/**
	 * 获取站点
	 * @return
     * @param code
	 */
	JSONArray getPonitList(String code);
	
	/**
	 * 
	 * @Title:  getMonitorPointByCity
	 * @Description:    获取父站点下所有子站点信息   
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:02:39
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:02:39    
	 * @param pointCode
	 * @return  List<AirMonitorPoint> 
	 * @throws
	 */
	List<AirMonitorPoint> getMonitorPointByCity(String pointCode);
	
	/**
	 * 
	 * @Title:  getPointByType
	 * @Description:    获取站点信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:34:37
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:34:37    
	 * @param type	站点类型（1城市 0点位）
	 * @return  List<AirMonitorPoint> 
	 * @throws
	 */
	List<AirMonitorPoint> getPointByType(String type, String deptName);
	
	/**
	 * 
	 * @Title:  getImportantPoint
	 * @Description:    获取重要站点的信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:02:58
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:02:58    
	 * @return  List<Object[]> 
	 * @throws
	 */
	List<Object[]> getImportantPoint();
	
	
	/**
	 * 
	 * @Title:  getChildrenPointByType
	 * @Description:    根据子站点id 查找同父站点下的所有子站点    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:03:18
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:03:18    
	 * @param pointCode
	 * @return  List<Object[]> 
	 * @throws
	 */
	 List<Object []> getChildrenPointByType(String pointCode);

	 /**
	  * 
	  * @Title:  listByPage
	  * @Description:    分页获取
	  * @CreateBy: chenbingke 
	  * @CreateTime: 2019年6月15日 下午1:14:41
	  * @UpdateBy: chenbingke 
	  * @UpdateTime:  2019年6月15日 下午1:14:41    
	  * @param param
	  * @param page
	  * @return  Page<JobScheduleDepartment> 
	  * @throws
	  */
	Page<AirMonitorPoint> listByPage(AirMonitorPointParam param, Page<AirMonitorPoint> page);
	
	/**
     * 
     * @Title:  getPointsInfo
     * @Description:    根据pointCode获取相关数据
     * @CreateBy: chenbingke 
     * @CreateTime: 2019年6月20日 下午3:29:15
     * @UpdateBy: chenbingke 
     * @UpdateTime:  2019年6月20日 下午3:29:15    
     * @param pointCode
     * @return  JSONObject 
     * @throws
     */
	public List<Map> getPointInfo(String pointCode);

}
