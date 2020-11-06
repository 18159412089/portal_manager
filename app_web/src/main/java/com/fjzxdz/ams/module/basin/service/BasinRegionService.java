/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.basin.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.basin.entity.BasinRegion;
import com.fjzxdz.ams.module.basin.dao.BasinRegionDao;
import com.fjzxdz.ams.module.basin.param.BasinRegionParam;

/**
 * 流域监控Service
 * @author slq
 * @version 2019-03-12
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class BasinRegionService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(BasinRegionService.class);

	@Autowired
	private BasinRegionDao basinRegionDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param basinRegion
	 * @param page
	 * @return
	 */
	public Page<BasinRegion> listByPage(BasinRegionParam basinRegionParam, Page<BasinRegion> page) {
		Page<BasinRegion> listPage = basinRegionDao.listByPage(basinRegionParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param basinRegion
	 */
	public void save(BasinRegion basinRegion) {
		if (StringUtils.isNotEmpty(basinRegion.getUuid())) {
			basinRegionDao.update(basinRegion);
		}else{
			basinRegion.setUuid(null);
			basinRegionDao.save(basinRegion);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		basinRegionDao.deleteById(uuid);
	}
	
}
