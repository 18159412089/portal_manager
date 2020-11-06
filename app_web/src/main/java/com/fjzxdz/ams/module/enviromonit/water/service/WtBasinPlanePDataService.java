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

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinPlanePData;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlanePDataDao;
import com.fjzxdz.ams.module.enviromonit.water.param.WtBasinPlanePDataParam;

/**
 * 水系面数据Service
 * @author ZhangGQ
 * @version 2019-06-28
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtBasinPlanePDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtBasinPlanePDataService.class);

	@Autowired
	private WtBasinPlanePDataDao wtBasinPlanePDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtBasinPlanePData
	 * @param page
	 * @return
	 */
	public Page<WtBasinPlanePData> listByPage(WtBasinPlanePDataParam wtBasinPlanePDataParam, Page<WtBasinPlanePData> page) {
		Page<WtBasinPlanePData> listPage = wtBasinPlanePDataDao.listByPage(wtBasinPlanePDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param wtBasinPlanePData
	 */
	public void save(WtBasinPlanePData wtBasinPlanePData) {
		if (StringUtils.isNotEmpty(wtBasinPlanePData.getUuid())) {
			wtBasinPlanePDataDao.update(wtBasinPlanePData);
		}else{
			wtBasinPlanePData.setUuid(null);
			wtBasinPlanePDataDao.save(wtBasinPlanePData);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		wtBasinPlanePDataDao.deleteById(uuid);
	}
	
}
