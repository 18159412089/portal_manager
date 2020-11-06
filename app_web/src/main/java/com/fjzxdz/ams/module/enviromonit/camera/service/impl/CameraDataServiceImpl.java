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
import com.fjzxdz.ams.module.enviromonit.camera.dao.CameraDataDao;
import com.fjzxdz.ams.module.enviromonit.camera.entity.Camera;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraData;
import com.fjzxdz.ams.module.enviromonit.camera.entity.CameraUnit;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraDataService;
import com.fjzxdz.ams.module.enviromonit.camera.service.CameraService;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.EnvCompanyDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.EnvCompanyService;

import cn.fjzxdz.frame.common.Page;

@Service
@Transactional(rollbackFor=Exception.class)
public class CameraDataServiceImpl implements CameraDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(CameraDataServiceImpl.class);

	@Autowired
	private CameraDataDao cameraDataDao;


	@Override
	public CameraData getById(String uuid) {
		return cameraDataDao.getById(uuid);
	}

	@Override
	public Page<CameraData> listByPage(CameraData param, Page<CameraData> page) {
		Page<CameraData> userPage = cameraDataDao.listByPage(param, page);
		return userPage;
	}

	@Override
	public void saveBatch(List<CameraData> cameraDataList) {
		
		cameraDataDao.saveBatch(cameraDataList);
	}

	public void save(CameraData cameraData) {
		if(StringUtils.isNotEmpty(cameraData.getUuid())) {
			cameraDataDao.update(cameraData);
		} else {
			cameraDataDao.save(cameraData);
		}
	}
	
	public void deleteAll() {
		Query query = cameraDataDao.createQuery("delete CameraData");
		query.executeUpdate();
	}

	@Override
	public List<JSONObject> list(String searchInput) {
		List<Object[]> list = new ArrayList<>();
		if(searchInput.length()>0) {
			List<Object[]> list1 = getListWithParam(searchInput, "1");
			List<Object[]> list2 = getListWithParam(searchInput, "2");
			List<Object[]> list3 = getListWithParam(searchInput, "3");
			
			list.addAll(list1);
			list.addAll(list2);
			list.addAll(list3);
		}else {
			list = getListWithParam(searchInput, "");
		}
		
		List<JSONObject> result = new ArrayList<>();
		for (Object[] object : list) {
			String id = (String) object[0];
			String pId = (String) object[1];
			String name = (String) object[2];
			String nodeType = (String) object[3];
			Boolean isParent = (Boolean) object[4];
			String iconSkin = (String) object[5];
			
			CameraData cameraData = new CameraData();
			
			cameraData.setId(id);
			cameraData.setpId(pId);
			cameraData.setName(name);
			cameraData.setNodeType(nodeType);
			cameraData.setIsParent(isParent);
			cameraData.setIconSkin(iconSkin);
			
			result.add(cameraData.toJSONObject());
		}
		
		
		return result;
	}
	
	private List<Object[]> getListWithParam(String searchInput, String nodeType) {
		String sql = "";
		if(nodeType.length()>0) {
			sql = "select "
					+ "id, "
					+ "pId, "
					+ "name, "
					+ "nodeType, "
					+ "isParent, "
					+ "iconSkin "
					+ "from CameraData where name like '%"+searchInput+"%' and nodeType=" + nodeType;
		}else {
			sql = "select "
					+ "id, "
					+ "pId, "
					+ "name, "
					+ "nodeType, "
					+ "isParent, "
					+ "iconSkin "
					+ "from CameraData where name like '%"+searchInput+"%'";
		}

		Query query = cameraDataDao.createQuery(sql);
		List<Object[]> list = query.getResultList();
		
		return list;
	}
}
