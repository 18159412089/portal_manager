/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.haz.entity.EnterpriseWasteInfo;
import com.fjzxdz.ams.module.haz.dao.EnterpriseWasteInfoDao;
import com.fjzxdz.ams.module.haz.param.EnterpriseWasteInfoParam;

/**
 * 企业产废贮存信息Service
 * @author htj
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class EnterpriseWasteInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(EnterpriseWasteInfoService.class);

	@Autowired
	private EnterpriseWasteInfoDao enterpriseWasteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param enterpriseWasteInfo
	 * @param page
	 * @return
	 */
	public Page<EnterpriseWasteInfo> listByPage(EnterpriseWasteInfoParam enterpriseWasteInfoParam, Page<EnterpriseWasteInfo> page) {
		Page<EnterpriseWasteInfo> listPage = enterpriseWasteInfoDao.listByPage(enterpriseWasteInfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param enterpriseWasteInfo
	 */
	public void save(EnterpriseWasteInfo enterpriseWasteInfo) {
		/*if (StringUtils.isNotEmpty(enterpriseWasteInfo.getUuid())) {
			enterpriseWasteInfoDao.update(enterpriseWasteInfo);
		}else{
			enterpriseWasteInfo.setUuid(null);
			enterpriseWasteInfoDao.save(enterpriseWasteInfo);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		enterpriseWasteInfoDao.deleteById(uuid);
	}
	
}
