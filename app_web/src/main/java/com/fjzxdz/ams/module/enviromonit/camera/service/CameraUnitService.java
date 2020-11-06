package com.fjzxdz.ams.module.enviromonit.camera.service;

import java.util.List;

import org.json.JSONObject;

import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;

import cn.fjzxdz.frame.common.Page;


public interface CameraUnitService {

	CameraUnit getById(String uuid);

    Page<CameraUnit> listByPage(CameraUnit param, Page<CameraUnit> page);

	void saveBatch(List<CameraUnit> cameraUnitList);
	
	void save(CameraUnit cameraUnit);
	
	void deleteAll();
	
	List<JSONObject> list();
}
