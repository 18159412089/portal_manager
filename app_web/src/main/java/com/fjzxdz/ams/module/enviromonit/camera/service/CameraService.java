package com.fjzxdz.ams.module.enviromonit.camera.service;

import java.util.List;

import org.json.JSONObject;

import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;

import cn.fjzxdz.frame.common.Page;


public interface CameraService {

	Camera getById(String uuid);

    Page<Camera> listByPage(Camera param, Page<Camera> page);

	void saveBatch(List<Camera> cameraList);
	
	void save(Camera camera);
	
	void deleteAll();

	List<JSONObject> list();
}
