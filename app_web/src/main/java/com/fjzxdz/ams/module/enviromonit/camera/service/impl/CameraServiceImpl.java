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
import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraService;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.EnvCompanyDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.EnvCompanyService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor=Exception.class)
public class CameraServiceImpl implements CameraService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(CameraServiceImpl.class);

	@Autowired
	private CameraDao cameraDao;


	@Override
	public Camera getById(String uuid) {
		return cameraDao.getById(uuid);
	}

	@Override
	public Page<Camera> listByPage(Camera param, Page<Camera> page) {
		Page<Camera> userPage = cameraDao.listByPage(param, page);
		return userPage;
	}

	@Override
	public void saveBatch(List<Camera> cameraList) {
		
		cameraDao.saveBatch(cameraList);
	}

	public void save(Camera camera) {
		if(StringUtils.isNotEmpty(camera.getUuid())) {
			cameraDao.update(camera);
		} else {
			cameraDao.save(camera);
		}
	}
	
	public void deleteAll() {
		cameraDao.createQuery("delete CAMERA", "");
	}

	@Override
	public List<JSONObject> list() {
		
		Query query = cameraDao.createQuery("select "
				+ "cameraUuid, "
				+ "unitUuid, "
				+ "regionUuid, "
				+ "encoderUuid, "
				+ "cameraName, "
				+ "cameraType, "
				+ "smartType, "
				+ "cameraChannelNum, "
				+ "smartSupport, "
				+ "resAuths, "
				+ "orderNum, "
				+ "keyBoardCode, "
				+ "updateTime, "
				+ "onLineStatus "
				+ "from Camera");
		List<Object[]> list = query.getResultList();
		
		List<JSONObject> result = new ArrayList<>();
		for (Object[] object : list) {
			String cameraUuid = (String) object[0];
			String unitUuid = (String) object[1];
			String regionUuid = (String) object[2];
			String encoderUuid = (String) object[3];
			String cameraName = (String) object[4];
			String cameraType = (String) object[5];
			String smartType = (String) object[6];
			String cameraChannelNum = (String) object[7];
			String smartSupport = (String) object[8];
			String resAuths = (String) object[9];
			String orderNum = (String) object[10];
			String keyBoardCode = (String) object[11];
			Long updateTime = (Long) object[12];
			Boolean onLineStatus = (Boolean) object[13];
			
			Camera camera = new Camera();
			camera.setCameraUuid(cameraUuid);
			camera.setUnitUuid(unitUuid);
			camera.setRegionUuid(regionUuid);
			camera.setEncoderUuid(encoderUuid);
			camera.setCameraName(cameraName);
			camera.setCameraType(cameraType);
			camera.setSmartType(smartType);
			camera.setCameraChannelNum(cameraChannelNum);
			camera.setSmartSupport(smartSupport);
			camera.setResAuths(resAuths);
			camera.setOrderNum(orderNum);
			camera.setKeyBoardCode(keyBoardCode);
			camera.setUpdateTime(updateTime);
			camera.setOnLineStatus(onLineStatus);
			
			result.add(camera.toTreeNodeJSONObject());
		}
		
		
		return result;
	}
}
