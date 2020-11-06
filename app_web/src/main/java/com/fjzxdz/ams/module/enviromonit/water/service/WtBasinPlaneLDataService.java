/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinPlaneLData;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlaneLDataDao;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinPlaneLDataParam;

/**
 * 水系线数据Service
 * @author ZhangGQ
 * @version 2019-06-28
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtBasinPlaneLDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtBasinPlaneLDataService.class);

	@Autowired
	private WtBasinPlaneLDataDao wtBasinPlaneLDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtBasinPlaneLData
	 * @param page
	 * @return
	 */
	public Page<WtBasinPlaneLData> listByPage(WtBasinPlaneLDataParam wtBasinPlaneLDataParam, Page<WtBasinPlaneLData> page) {
		Page<WtBasinPlaneLData> listPage = wtBasinPlaneLDataDao.listByPage(wtBasinPlaneLDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param wtBasinPlaneLData
	 */
	public void save(WtBasinPlaneLData wtBasinPlaneLData) {
		if (StringUtils.isNotEmpty(wtBasinPlaneLData.getUuid())) {
			wtBasinPlaneLDataDao.update(wtBasinPlaneLData);
		}else{
			wtBasinPlaneLData.setUuid(null);
			wtBasinPlaneLDataDao.save(wtBasinPlaneLData);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		wtBasinPlaneLDataDao.deleteById(uuid);
	}
	
}
