package com.fjzxdz.ams.module.enviromonit.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.common.dao.PeCommonInfoDao;
import com.fjzxdz.ams.module.enviromonit.common.entity.PeCommonInfo;
import com.fjzxdz.ams.module.enviromonit.common.param.PeCommonInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;

@Component
@Transactional(rollbackFor=Exception.class)
public class PeCommonInfoService {

	@Autowired
	private PeCommonInfoDao peCommonInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	public Page<PeCommonInfo> listByPage(PeCommonInfoParam peCommonInfoParam, Page<PeCommonInfo> page){
		Page<PeCommonInfo> listPage = peCommonInfoDao.listByPage(peCommonInfoParam, page);
		
		return listPage;
	}
	
	public PeCommonInfo getPeCommonInfo(String pluId) {
		return peCommonInfoDao.getById(pluId);
	}
	
	public void getPeCommonInfoList() {
		
	}
}
