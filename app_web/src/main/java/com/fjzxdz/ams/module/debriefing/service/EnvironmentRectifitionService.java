package com.fjzxdz.ams.module.debriefing.service;

import cn.fjzxdz.frame.common.Page;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.*;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentRectifitionParam;

import java.util.List;
import java.util.Map;

public interface EnvironmentRectifitionService {

	Page<EnvironmentRectifition> listByPage(EnvironmentRectifitionParam param, Page<EnvironmentRectifition> page);

	List<EnvironmentRectifitionChart> getProjectCountByCity(String status, String startTime, String endTime, String userDeptName, String num);

	List<EnvCancellationAccount> getCancelNumberTimeoutData(String type, String startTime, String endTime);

	EnvironmentRectifition getById(String uuid);

	String save(EnvironmentRectifition rectifition);

	JSONObject getEcharts(String startTime, String endTime, String userDeptName);

	JSONObject getPieEcharts(String startTime, String endTime, String userDeptName);

	/**
	 * @Title:  getCount
	 * @Description:    统计环保督察整改汇总表的信息(这里用一句话描述这个方法的作用)    
	 * @CreateBy: 钟云龙 
	 * @CreateTime: 2019年4月25日 上午9:56:19
	 * @UpdateBy: 钟云龙 
	 * @UpdateTime:  2019年4月25日 上午9:56:19    
	 * @param param
	 * @return  JSONObject 
	 * @throws 
	 */ 
	JSONObject getCount(EnvironmentRectifitionParam param);

	/**
	 * @param page 
	 * @Title:  getDecription
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年4月30日 下午5:09:52
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年4月30日 下午5:09:52    
	 * @param id
	 * @param status
	 * @return  Page<EnvironmentRectifition> 
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDecription(String id, String status,String startTime, String endTime, Page<Map<String, Object>> page);

	/**
	 * @Title:  getDetail
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月5日 上午10:26:22
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月5日 上午10:26:22    
	 * @param id
	 * @param page
	 * @return  Page<Map<String,Object>> 
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDetail(String id, Page<Map<String, Object>> page);

	/**
	 * @param status
	 * @param startTime
	 * @param endTime
	 * @param page
	 * @param userDeptName
	 * @Title:  getDecriptionAll
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月5日 上午11:33:28
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月5日 上午11:33:28    
	 * @return  Page<Map<String,Object>>
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDecriptionAll(String status, String startTime, String endTime, Page<Map<String, Object>> page, String userDeptName);

	/**
	 * @Title:  deleteByUuid
	 * @Description:    通过uuid删除
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月5日 下午3:04:55
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月5日 下午3:04:55    
	 * @param uuid
	 * @return  int 
	 * @throws 
	 */ 
	void deleteByUuid(String uuid);

	/**
	 * @Title:  saveRectifition
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月6日 上午9:33:28
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月6日 上午9:33:28    
	 * @param rectifition  void 
	 * @throws 
	 */ 
	String saveRectifition(EnvironmentRectifition rectifition);
	/**
	 * 【责任名单】导入数据保存
	 * @param result
	 * @return
	 */
    String save(String[][] result);
	/**
	 * 获取未设置项目的数据
	 * @param page
	 * @return
	 */
	Page<Map<String, Object>> getNoSetProjList(Page<Map<String, Object>> page);
	/**
	 * 责任名单上的字段同步到汇总表模块
	 * @param dutyUser
	 */
	String saveDutyUser(EnvironmentDutyUser dutyUser);
	/**
	 * 通过主键删除责任名单数据
	 * @param uuid
	 */
	void deleteDutyUser(String uuid);

	/**
	 * 获取预警列表
	 * @param param
	 * @param page
	 * @return
	 */
	Page<EnvironmentRectifition> getWornListByPage(EnvironmentRectifitionParam param, Page<EnvironmentRectifition> page);

	List<EnvironmentRectifition> allWornList();

	/**
	 * 设置预警天数
	 * @param warnTime
	 * @return
	 */
	void setWarnDay(String warnTime);

	/**
	 * 详情查看
	 * @param id
	 * @param page
	 * @return
	 */
	Page<Map<String, Object>> getProjectDetail(String id, Page<Map<String, Object>> page);

	/**
	 * 获取轮数：第一轮  第二轮。。。
	 * @return
     * @param flag
	 */
    List getNumOfRound(String flag);

	/**
	 * 获取下一轮轮数或者之前被删除的轮数
	 * @return
	 * @param c
	 */
	List getNextRound(String c);
}
