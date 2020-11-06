/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.hydposition.entity.Hyddevinfo;
import com.fjzxdz.ams.module.hydposition.dao.HyddevinfoDao;
import com.fjzxdz.ams.module.hydposition.param.HyddevinfoParam;

/**
 * 水电站设备基本信息Service
 * @author htj
 * @version 2019-02-18
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class HyddevinfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(HyddevinfoService.class);

	@Autowired
	private HyddevinfoDao hyddevinfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param hyddevinfo
	 * @param page
	 * @return
	 */
	public Page<Hyddevinfo> listByPage(HyddevinfoParam hyddevinfoParam, Page<Hyddevinfo> page) {
		Page<Hyddevinfo> listPage = hyddevinfoDao.listByPage(hyddevinfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param hyddevinfo
	 */
	public void save(Hyddevinfo hyddevinfo) {
		if (StringUtils.isNotEmpty(String.valueOf(hyddevinfo.getHydropowerId()))) {
			hyddevinfoDao.update(hyddevinfo);
		}else{
			hyddevinfo.setHydropowerId(null);
			hyddevinfoDao.save(hyddevinfo);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		hyddevinfoDao.deleteById(uuid);
	}
	
}
