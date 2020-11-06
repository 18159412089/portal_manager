/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.service;

import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;

import com.fjzxdz.ams.module.area.entity.SiteInfo;
import com.fjzxdz.ams.module.area.dao.SiteInfoDao;
import com.fjzxdz.ams.module.area.param.SiteInfoParam;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteInfo;

/**
 * 近岸海域点位信息Service
 * @author htj
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class SiteInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(SiteInfoService.class);

	@Autowired
	private SiteInfoDao siteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param siteInfo
	 * @param page
	 * @return
	 */
	public Page<SiteInfo> listByPage(SiteInfoParam siteInfoParam, Page<SiteInfo> page) {
		Page<SiteInfo> listPage = siteInfoDao.listByPage(siteInfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param siteInfo
	 */
	public void save(SiteInfo siteInfo) {
	/*	if (StringUtils.isNotEmpty(siteInfo.getUuid())) {
			siteInfoDao.update(siteInfo);
		}else{
			siteInfo.setUuid(null);
			siteInfoDao.save(siteInfo);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		siteInfoDao.deleteById(uuid);
	}
    
	/**
	 * 获取近海岸站点点位信信息
	 * @param stationName
	 * @return
	 */
	public JSONArray getAreaSiteInfoList(String stationName) {
		JSONArray areaSiteArray = new JSONArray();
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			wherecaseStr = " where   si.KDMC like '%"+stationName+"%'" ;
		}
		String queryString = "from SiteInfo as si "+wherecaseStr;				 
		Query query = siteInfoDao.createQuery(queryString); 
		List<RiversSiteInfo> list = query.getResultList();
		areaSiteArray.addAll(list);
		return  areaSiteArray ;
	}
	
	
	
	public JSONArray getAreaSiteInfoListBySkbm(String SKBM) {
		JSONArray areaSiteArray = new JSONArray();
		String wherecaseStr = "where si.SKBM = '"+SKBM+"'";
 
		String queryString = "from SiteInfo as si "+wherecaseStr;				 
		Query query = siteInfoDao.createQuery(queryString);
		List<RiversSiteInfo> list = query.getResultList();
		areaSiteArray.addAll(list);
		return  areaSiteArray ;
	}
	
}
