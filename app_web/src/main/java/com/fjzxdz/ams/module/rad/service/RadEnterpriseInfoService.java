/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.rad.dao.RadEnterpriseInfoDao;
import com.fjzxdz.ams.module.rad.entity.RadEnterpriseInfo;
import com.fjzxdz.ams.module.rad.param.RadEnterpriseInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;

/**
 * 辐射企业信息Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RadEnterpriseInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RadEnterpriseInfoService.class);

	@Autowired
	private RadEnterpriseInfoDao radEnterpriseInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	@Autowired
	private JdbcTemplate jdbcTemplate ;
	
	/**
	 * 分页查询
	 * @param radEnterpriseInfo
	 * @param page
	 * @return
	 */
	public Page<RadEnterpriseInfo> listByPage(RadEnterpriseInfoParam radEnterpriseInfoParam, Page<RadEnterpriseInfo> page) {
		Page<RadEnterpriseInfo> listPage = radEnterpriseInfoDao.listByPage(radEnterpriseInfoParam, page);
		return listPage;
	}

 	public JSONArray getradEnterpriseInfoListForMap(String stationName) {
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			     wherecaseStr = " where    ENTERNAME like '%"+stationName+"%'" ;
		}
		String hql = "from RadEnterpriseInfo "+ wherecaseStr +" order by ZCDYB asc";
		List<RadEnterpriseInfo> list = radEnterpriseInfoDao.createQuery(hql).getResultList();
		JSONArray result = new JSONArray();
		for (RadEnterpriseInfo radEnterpriseInfo : list) {
			radEnterpriseInfo.setLongitude();
			radEnterpriseInfo.setLatitude();
		}
		
		return JSONUtil.parseArray(list, false);
	}
	
	public List<Map<String, Object>> getRadEnterpriseInfoList(String stationName) {
		    String wherecaseStr = "";
			if( !StringUtils.isEmpty(stationName) ){
				     wherecaseStr = " where    ENTERNAME like '%"+stationName+"%'" ;
			}
			String queryStr = "select * from RAD_ENTERPRISE_INFO   " + wherecaseStr;
		    List<Map<String, Object>> listPage  =	jdbcTemplate.queryForList(queryStr);
			return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param radEnterpriseInfo
	 */
/*	public void save(RadEnterpriseInfo radEnterpriseInfo) {
		if (StringUtils.isNotEmpty(radEnterpriseInfo.getUuid())) {
			radEnterpriseInfoDao.update(radEnterpriseInfo);
		}else{
			radEnterpriseInfo.setUuid(null);
			radEnterpriseInfoDao.save(radEnterpriseInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		radEnterpriseInfoDao.deleteById(uuid);
	}*/
	
}
