package com.fjzxdz.ams.module.enviromonit.camera.service;

import java.util.List;

import org.json.JSONObject;

import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraRegion;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;

import cn.fjzxdz.frame.common.Page;


public interface CameraRegionService {

	CameraRegion getById(String uuid);

    Page<CameraRegion> listByPage(CameraRegion param, Page<CameraRegion> page);

	void saveBatch(List<CameraRegion> cameraRegionList);
	
	void save(CameraRegion cameraRegion);
	
	void deleteAll();

	List<JSONObject> list();
}
