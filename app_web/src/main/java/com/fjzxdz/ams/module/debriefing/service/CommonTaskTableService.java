package com.fjzxdz.ams.module.debriefing.service;

import java.math.BigDecimal;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.CommonTaskTable;
import com.fjzxdz.ams.module.debriefing.param.CommonTaskTableParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;

public interface CommonTaskTableService {

	Page<CommonTaskTable> getPageList(CommonTaskTableParam param, Page<CommonTaskTable> page);

	int setStatus(String uuid, BigDecimal status);

	List<Object[]> getRelationNameList(String relation);

	int addTask(CommonTaskTable commonTaskTable);

	JSONObject getChartList(String startTime,String endTime);

	R getDescript(CommonTaskTableParam param);

	/**
	 * @Title:  save
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月6日 下午3:52:55
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月6日 下午3:52:55    
	 * @param commonTaskTable  void 
	 * @throws 
	 */ 
	void save(CommonTaskTable commonTaskTable);

	/**
	 * @Title:  delete
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月6日 下午4:13:28
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月6日 下午4:13:28    
	 * @param uuid  void 
	 * @throws 
	 */ 
	void delete(String uuid);

}
