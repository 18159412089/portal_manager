/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.risk.dao.RiskBaseInfoDao;
import com.fjzxdz.ams.module.risk.entity.RiskBaseInfo;
import com.fjzxdz.ams.module.risk.param.RiskBaseInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 风险源基本信息Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiskBaseInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiskBaseInfoService.class);

	@Autowired
	private RiskBaseInfoDao riskBaseInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riskBaseInfo
	 * @param page
	 * @return
	 */
	public Page<RiskBaseInfo> listByPage(RiskBaseInfoParam riskBaseInfoParam, Page<RiskBaseInfo> page) {
		Page<RiskBaseInfo> listPage = riskBaseInfoDao.listByPage(riskBaseInfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param riskBaseInfo
	 */
/*	public void save(RiskBaseInfo riskBaseInfo) {
		if (StringUtils.isNotEmpty(riskBaseInfo.getUuid())) {
			riskBaseInfoDao.update(riskBaseInfo);
		}else{
			riskBaseInfo.setUuid(null);
			riskBaseInfoDao.save(riskBaseInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riskBaseInfoDao.deleteById(uuid);
	}*/
	
}
