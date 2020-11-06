/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.risk.dao.RiskProductAccessDataDao;
import com.fjzxdz.ams.module.risk.entity.RiskProductAccessData;
import com.fjzxdz.ams.module.risk.param.RiskProductAccessDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 产品及辅料基本信息Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiskProductAccessDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiskProductAccessDataService.class);

	@Autowired
	private RiskProductAccessDataDao riskProductAccessDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riskProductAccessData
	 * @param page
	 * @return
	 */
	public Page<RiskProductAccessData> listByPage(RiskProductAccessDataParam riskProductAccessDataParam, Page<RiskProductAccessData> page) {
		Page<RiskProductAccessData> listPage = riskProductAccessDataDao.listByPage(riskProductAccessDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param riskProductAccessData
	 */
/*	public void save(RiskProductAccessData riskProductAccessData) {
		if (StringUtils.isNotEmpty(riskProductAccessData.getUuid())) {
			riskProductAccessDataDao.update(riskProductAccessData);
		}else{
			riskProductAccessData.setUuid(null);
			riskProductAccessDataDao.save(riskProductAccessData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riskProductAccessDataDao.deleteById(uuid);
	}*/
	
}
