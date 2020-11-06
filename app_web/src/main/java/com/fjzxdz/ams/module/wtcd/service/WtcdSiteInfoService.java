/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.wtcd.dao.WtcdSiteInfoDao;
import com.fjzxdz.ams.module.wtcd.entity.WtcdSiteInfo;
import com.fjzxdz.ams.module.wtcd.param.WtcdSiteInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;

/**
 * 水利厅水文站点Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtcdSiteInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtcdSiteInfoService.class);

	@Autowired
	private WtcdSiteInfoDao wtcdSiteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtcdSiteInfo
	 * @param page
	 * @return
	 */
	public Page<WtcdSiteInfo> listByPage(WtcdSiteInfoParam wtcdSiteInfoParam, Page<WtcdSiteInfo> page) {
		Page<WtcdSiteInfo> listPage = wtcdSiteInfoDao.listByPage(wtcdSiteInfoParam, page);
		return listPage;
	}
	
	/**
	 * 分页查询
	 * @param wtcdSiteInfo
	 * @param page
	 * @return
	 */
	public List<WtcdSiteInfo> getWtcdSiteInfoList(String stationName) {
	    String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			     wherecaseStr = " where   ws.STNM like '%"+stationName+"%'" ;
		}
		List<WtcdSiteInfo> listPage = wtcdSiteInfoDao.createQuery("from WtcdSiteInfo  as ws" + wherecaseStr).getResultList();
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param wtcdSiteInfo
	 */
/*	public void save(WtcdSiteInfo wtcdSiteInfo) {
		if (StringUtils.isNotEmpty(wtcdSiteInfo.getUuid())) {
			wtcdSiteInfoDao.update(wtcdSiteInfo);
		}else{
			wtcdSiteInfo.setUuid(null);
			wtcdSiteInfoDao.save(wtcdSiteInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		wtcdSiteInfoDao.deleteById(uuid);
	}*/
	
}
