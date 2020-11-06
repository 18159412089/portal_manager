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

import com.fjzxdz.ams.module.basin.entity.BasinCamera;
import com.fjzxdz.ams.module.basin.dao.BasinCameraDao;
import com.fjzxdz.ams.module.basin.param.BasinCameraParam;

/**
 * 流域监控Service
 * @author slq
 * @version 2019-03-12
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class BasinCameraService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(BasinCameraService.class);

	@Autowired
	private BasinCameraDao basinCameraDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param basinCamera
	 * @param page
	 * @return
	 */
	public Page<BasinCamera> listByPage(BasinCameraParam basinCameraParam, Page<BasinCamera> page) {
		Page<BasinCamera> listPage = basinCameraDao.listByPage(basinCameraParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param basinCamera
	 */
	public void save(BasinCamera basinCamera) {
		if (StringUtils.isNotEmpty(basinCamera.getUuid())) {
			basinCameraDao.update(basinCamera);
		}else{
			basinCamera.setUuid(null);
			basinCameraDao.save(basinCamera);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		basinCameraDao.deleteById(uuid);
	}
	
}
