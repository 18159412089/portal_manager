/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enter.service;

import cn.hutool.core.lang.UUID;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.enter.entity.PollutionEnterpriseInfo;
import com.fjzxdz.ams.module.enter.dao.PollutionEnterpriseInfoDao;
import com.fjzxdz.ams.module.enter.param.PollutionEnterpriseInfoParam;

import javax.persistence.Query;

/**
 * 污染源档案企业信息Service
 * @author lilongan
 * @version 2019-02-26
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PollutionEnterpriseInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PollutionEnterpriseInfoService.class);

	@Autowired
	private PollutionEnterpriseInfoDao pollutionEnterpriseInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 分页查询
	 * @param pollutionEnterpriseInfo
	 * @param page
	 * @return
	 */
	public Page<PollutionEnterpriseInfo> listByPage(PollutionEnterpriseInfoParam pollutionEnterpriseInfoParam, Page<PollutionEnterpriseInfo> page) {
		Page<PollutionEnterpriseInfo> listPage = pollutionEnterpriseInfoDao.listByPage(pollutionEnterpriseInfoParam, page);
		return listPage;
	}

	public void insert(PollutionEnterpriseInfo pollutionEnterpriseInfo) {
		String sql = "INSERT INTO POLLUTION_ENTERPRISE_INFO(\n" +
				"STANDENTERID,\n" +
				"ENTERCODE,\n" +
				"ENTERNAME,\n" +
				"COMPANYNAME,\n" +
				"CODE_ENTERTYPE,\n" +
				"CODE_REGISTERTYPE,\n" +
				"TRADE,\n" +
				"CODE_TRADE,\n" +
				"ENTERADDRESS,\n" +
				"WSYSTEM)VALUES ('" +
				UUID.randomUUID().toString() +"',"+
				pollutionEnterpriseInfo.getEntercode() +","+
		        pollutionEnterpriseInfo.getEntername() +","+
		        pollutionEnterpriseInfo.getCompanyname() +","+
		        pollutionEnterpriseInfo.getCodeEntertype() +","+
		        pollutionEnterpriseInfo.getCodeRegistertype() +","+
		        pollutionEnterpriseInfo.getTrade() +","+
		        pollutionEnterpriseInfo.getCodeTrade() +","+
		        pollutionEnterpriseInfo.getEnteraddress() +","+
		        pollutionEnterpriseInfo.getWsystem() +
				")";
		jdbcTemplate.batchUpdate(sql);
	}
	/**
	 * 更新或新增
	 * @param pollutionEnterpriseInfo
	 */
/*	public void save(PollutionEnterpriseInfo pollutionEnterpriseInfo) {
		if (StringUtils.isNotEmpty(pollutionEnterpriseInfo.getUuid())) {
			pollutionEnterpriseInfoDao.update(pollutionEnterpriseInfo);
		}else{
			pollutionEnterpriseInfo.setUuid(null);
			pollutionEnterpriseInfoDao.save(pollutionEnterpriseInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		pollutionEnterpriseInfoDao.deleteById(uuid);
	}*/
	
}
