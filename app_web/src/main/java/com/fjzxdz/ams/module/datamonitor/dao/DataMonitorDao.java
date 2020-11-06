/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.datamonitor.dao;

import org.springframework.stereotype.Repository;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

import com.fjzxdz.ams.module.datamonitor.entity.DataMonitor;


/**
 * 数据监控DAO接口
 * @author slq
 * @version 2019-02-27
 */
@Repository("dataMonitor")
public class DataMonitorDao extends PagingDaoSupport<DataMonitor> {
	
}
