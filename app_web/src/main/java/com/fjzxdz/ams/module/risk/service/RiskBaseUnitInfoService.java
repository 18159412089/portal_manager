/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.risk.dao.RiskBaseUnitInfoDao;
import com.fjzxdz.ams.module.risk.entity.RiskBaseUnitInfo;
import com.fjzxdz.ams.module.risk.param.RiskBaseUnitInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 风险单元基本信息Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiskBaseUnitInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiskBaseUnitInfoService.class);

	@Autowired
	private RiskBaseUnitInfoDao riskBaseUnitInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riskBaseUnitInfo
	 * @param page
	 * @return
	 */
	public Page<RiskBaseUnitInfo> listByPage(RiskBaseUnitInfoParam riskBaseUnitInfoParam, Page<RiskBaseUnitInfo> page) {
		Page<RiskBaseUnitInfo> listPage = riskBaseUnitInfoDao.listByPage(riskBaseUnitInfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param riskBaseUnitInfo
	 */
/*	public void save(RiskBaseUnitInfo riskBaseUnitInfo) {
		if (StringUtils.isNotEmpty(riskBaseUnitInfo.getUuid())) {
			riskBaseUnitInfoDao.update(riskBaseUnitInfo);
		}else{
			riskBaseUnitInfo.setUuid(null);
			riskBaseUnitInfoDao.save(riskBaseUnitInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riskBaseUnitInfoDao.deleteById(uuid);
	}*/
	
}
