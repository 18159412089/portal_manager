/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.service;

import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.rivers.dao.RiversSiteInfoDao;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteInfo;
import com.fjzxdz.ams.module.rivers.param.RiversSiteInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;

/**
 * 入海河流点位信息Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiversSiteInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiversSiteInfoService.class);

	@Autowired
	private RiversSiteInfoDao riversSiteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riversSiteInfo
	 * @param page
	 * @return
	 */
	public Page<RiversSiteInfo> listByPage(RiversSiteInfoParam riversSiteInfoParam, Page<RiversSiteInfo> page) {
		Page<RiversSiteInfo> listPage = riversSiteInfoDao.listByPage(riversSiteInfoParam, page);
		return listPage;
	}

	public JSONArray getRiverSiteArray(String stationName) {
		JSONArray riversSiteArray = new JSONArray();
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			wherecaseStr = " where   river.POINTNAME like '%"+stationName+"%'" ;
		}
		
		String queryString = "from RiversSiteInfo as river "+wherecaseStr;
				 
		Query query = riversSiteInfoDao.createQuery(queryString);
		List<RiversSiteInfo> list = query.getResultList();
		riversSiteArray.addAll(list);
		return  riversSiteArray ;
		
	}
	
	/**
	 * 更新或新增
	 * @param riversSiteInfo
	 */
/*	public void save(RiversSiteInfo riversSiteInfo) {
		if (StringUtils.isNotEmpty(riversSiteInfo.getUuid())) {
			riversSiteInfoDao.update(riversSiteInfo);
		}else{
			riversSiteInfo.setUuid(null);
			riversSiteInfoDao.save(riversSiteInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riversSiteInfoDao.deleteById(uuid);
	}*/
	
}
