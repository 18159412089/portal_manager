package com.fjzxdz.ams.module.enviromonit.water.service;

import java.util.List;

import com.fjzxdz.ams.module.enviromonit.water.entity.BaseWtBasinMonitorEntity;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEditEntity;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinMonitorParam;

import cn.fjzxdz.frame.common.Page;
/**
 * 
 * @author wudenglin
 *
 */
public interface WtBasinMonitorService {

	List<WtBasinMonitorEditEntity> listWtBasinMonitor(WtBasinMonitorParam param);
	int updataWtBasinMonitor(String id,String checkVal,String checkedIds);
	List<WtBasinMonitorEditEntity> listUserRiver(String uid,String loginName);
	String getCityUUID(String logName);
	int editWtBasinMonitor(WtBasinMonitorEditEntity param);
	int examineWtBasinMonitor(BaseWtBasinMonitorEntity param);

	/**   
	 * @Title: listByPage   
	 * @Description: TODO(这里用一句话描述这个方法的作用)   
	 * @param: @param param
	 * @param: @param page
	 * @param: @return      
	 * @return: Page<WtBasinMonitorEntityEdit>      
	 * @throws   
	 */
	Page<WtBasinMonitorEditEntity> listByPage(WtBasinMonitorParam param, Page<WtBasinMonitorEditEntity> page);
}
