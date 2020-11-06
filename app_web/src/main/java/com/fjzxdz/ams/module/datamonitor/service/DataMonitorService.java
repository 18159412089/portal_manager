/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.datamonitor.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.datamonitor.entity.DataMonitor;
import com.fjzxdz.ams.module.datamonitor.dao.DataMonitorDao;
import com.fjzxdz.ams.module.datamonitor.param.DataMonitorParam;

/**
 * 数据监控Service
 * @author slq
 * @version 2019-02-27
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class DataMonitorService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(DataMonitorService.class);

	@Autowired
	private DataMonitorDao dataMonitorDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param dataMonitor
	 * @param page
	 * @return
	 */
	public Page<DataMonitor> listByPage(DataMonitorParam dataMonitorParam, Page<DataMonitor> page) {
		Page<DataMonitor> listPage = dataMonitorDao.listByPage(dataMonitorParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param dataMonitor
	 */
	public void save(DataMonitor dataMonitor) {
		if (StringUtils.isNotEmpty(dataMonitor.getUuid())) {
			dataMonitorDao.update(dataMonitor);
		}else{
			dataMonitor.setUuid(null);
			dataMonitorDao.save(dataMonitor);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		dataMonitorDao.deleteById(uuid);
	}
	
}
