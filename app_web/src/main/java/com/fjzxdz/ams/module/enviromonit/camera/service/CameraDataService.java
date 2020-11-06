package com.fjzxdz.ams.module.enviromonit.camera.service;

import java.util.List;

import org.json.JSONObject;

import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraData;

import cn.fjzxdz.frame.common.Page;


public interface CameraDataService {

	CameraData getById(String uuid);

    Page<CameraData> listByPage(CameraData param, Page<CameraData> page);

	void saveBatch(List<CameraData> cameraList);
	
	void save(CameraData camera);
	
	void deleteAll();

	List<JSONObject> list(String name);
}
