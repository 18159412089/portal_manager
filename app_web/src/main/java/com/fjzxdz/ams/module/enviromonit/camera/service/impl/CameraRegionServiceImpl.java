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

import com.fjzxdz.ams.module.enviromonit.camera.dao.CameraDao;
import com.fjzxdz.ams.module.enviromonit.camera.dao.CameraRegionDao;
import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraRegion;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraRegionService;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraService;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.EnvCompanyDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.EnvCompanyService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor=Exception.class)
public class CameraRegionServiceImpl implements CameraRegionService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(CameraRegionServiceImpl.class);

	@Autowired
	private CameraRegionDao cameraRegionDao;


	@Override
	public CameraRegion getById(String uuid) {
		return cameraRegionDao.getById(uuid);
	}

	@Override
	public Page<CameraRegion> listByPage(CameraRegion param, Page<CameraRegion> page) {
		Page<CameraRegion> userPage = cameraRegionDao.listByPage(param, page);
		return userPage;
	}

	@Override
	public void saveBatch(List<CameraRegion> cameraList) {
		
		cameraRegionDao.saveBatch(cameraList);
	}

	public void save(CameraRegion camera) {
		if(StringUtils.isNotEmpty(camera.getUuid())) {
			cameraRegionDao.update(camera);
		} else {
			cameraRegionDao.save(camera);
		}
	}
	
	public void deleteAll() {
		cameraRegionDao.createQuery("delete CAMERA_REGION", "");
	}

	@Override
	public List<JSONObject> list() {
		
		Query query = cameraRegionDao.createQuery("select "
				+ "cameraRegion.regionUuid,"
				+ "cameraRegion.parentUuid,"
				+ "cameraRegion.parentNodeType,"
				+ "cameraRegion.name,"
				+ "cameraRegion.isParent, "
				+ "cameraRegion.remark, "
				+ "cameraRegion.createTime, "
				+ "cameraRegion.updateTime "
				+ "from CameraRegion AS cameraRegion");
		List<Object[]> list = query.getResultList();
		
		List<JSONObject> result = new ArrayList<>();
		for (Object[] object : list) {
			String regionUuid = (String) object[0];
			String parentUuid = (String) object[1];
			String parentNodeType = (String) object[2];
			String name = (String) object[3];
			Boolean isParent = (Boolean) object[4];
			String remark = (String) object[5];
			Long createTime = (Long) object[6];
			Long updateTime = (Long) object[7];
			
			CameraRegion cameraRegion = new CameraRegion();
			cameraRegion.setRegionUuid(regionUuid);
			cameraRegion.setParentUuid(parentUuid);
			cameraRegion.setParentNodeType(parentNodeType);
			cameraRegion.setName(name);
			cameraRegion.setIsParent(isParent);
			cameraRegion.setRemark(remark);
			cameraRegion.setCreateTime(createTime);
			cameraRegion.setUpdateTime(updateTime);
			
			result.add(cameraRegion.toTreeNodeJSONObject());
		}
		
		return result;
	}
}
