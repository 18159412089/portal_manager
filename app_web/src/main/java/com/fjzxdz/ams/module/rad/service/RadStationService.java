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

import com.fjzxdz.ams.module.rad.dao.RadStationDao;
import com.fjzxdz.ams.module.rad.entity.RadStation;
import com.fjzxdz.ams.module.rad.param.RadStationParam;
import com.fjzxdz.ams.module.wtcd.entity.WtcdSiteInfo;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 辐射基站Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RadStationService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RadStationService.class);

	@Autowired
	private RadStationDao radStationDao;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private JdbcTemplate jdbcTemplate ;
	
	/**
	 * 分页查询
	 * @param radStation
	 * @param page
	 * @return
	 */
	public Page<RadStation> listByPage(RadStationParam radStationParam, Page<RadStation> page) {
		Page<RadStation> listPage = radStationDao.listByPage(radStationParam, page);
		return listPage;
	}

	public List<Map<String, Object>> getRadStationInfoList(String stationName) {
		 String wherecaseStr = "";
			if( !StringUtils.isEmpty(stationName) ){
				     wherecaseStr = " where    JZNAME like '%"+stationName+"%'" ;
			}
			String queryStr = "select * from RAD_STATION   " + wherecaseStr;
		    List<Map<String, Object>> listPage  =	jdbcTemplate.queryForList(queryStr);
	 
			return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param radStation
	 */
/*	public void save(RadStation radStation) {
		if (StringUtils.isNotEmpty(radStation.getUuid())) {
			radStationDao.update(radStation);
		}else{
			radStation.setUuid(null);
			radStationDao.save(radStation);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		radStationDao.deleteById(uuid);
	}*/
	
}
