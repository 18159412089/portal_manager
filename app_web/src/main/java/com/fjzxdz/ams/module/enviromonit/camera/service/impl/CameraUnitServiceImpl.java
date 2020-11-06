package com.fjzxdz.ams.module.enviromonit.camera.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.camera.dao.CameraUnitDao;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraUnitService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor=Exception.class)
public class CameraUnitServiceImpl implements CameraUnitService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(CameraUnitServiceImpl.class);

	@Autowired
	private CameraUnitDao cameraUnitDao;


	@Override
	public CameraUnit getById(String uuid) {
		return cameraUnitDao.getById(uuid);
	}

	@Override
	public Page<CameraUnit> listByPage(CameraUnit param, Page<CameraUnit> page) {
		Page<CameraUnit> userPage = cameraUnitDao.listByPage(param, page);
		return userPage;
	}

	@Override
	public void saveBatch(List<CameraUnit> cameraList) {
		
		cameraUnitDao.saveBatch(cameraList);
	}

	public void save(CameraUnit camera) {
		if(StringUtils.isNotEmpty(camera.getUuid())) {
			cameraUnitDao.update(camera);
		} else {
			cameraUnitDao.save(camera);
		}
	}
	
	public void deleteAll() {
		cameraUnitDao.createQuery("delete CAMERA_UNIT", "");
	}
	
	public List<JSONObject> list() {
		
		Query query = cameraUnitDao.createQuery("select unit.unitUuid,unit.parentUuid,unit.name,unit.isParent,unit.createTime, unit.updateTime, unit.remark from CameraUnit as unit");
		List<Object[]> list = query.getResultList();
		
		List<JSONObject> result = new ArrayList<>();
		for (Object[] object : list) {
			String unitUuid = (String) object[0];
			String parentUuid = (String) object[1];
			String name = (String) object[2];
			Boolean isParent = (Boolean) object[3];
			Long createTime = (Long) object[4];
			Long updateTime = (Long) object[5];
			String remark = (String) object[6];
			
			CameraUnit unit = new CameraUnit(unitUuid, parentUuid, name, isParent, createTime, updateTime, remark);
			
			result.add(unit.toTreeNodeJSONObject());
		}
		
		
		return result;
	}
}
