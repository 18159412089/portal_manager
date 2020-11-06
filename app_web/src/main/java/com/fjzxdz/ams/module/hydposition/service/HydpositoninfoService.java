/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.service;

import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.hydposition.dao.HydpositoninfoDao;
import com.fjzxdz.ams.module.hydposition.entity.Hydpositoninfo;
import com.fjzxdz.ams.module.hydposition.param.HydpositoninfoParam;

import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSON;

/**
 * 水电站点位基本信息Service
 * @author htj
 * @version 2019-02-18
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class HydpositoninfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(HydpositoninfoService.class);

	@Autowired
	private HydpositoninfoDao hydpositoninfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param hydpositoninfo
	 * @param page
	 * @return
	 */
	public Page<Hydpositoninfo> listByPage(HydpositoninfoParam hydpositoninfoParam, Page<Hydpositoninfo> page) {
		Page<Hydpositoninfo> listPage = hydpositoninfoDao.listByPage(hydpositoninfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param hydpositoninfo
	 */
	public void save(Hydpositoninfo hydpositoninfo) {
		if (StringUtils.isNotEmpty(String.valueOf(hydpositoninfo.getEqpId()))) {
			hydpositoninfoDao.update(hydpositoninfo);
		}else{
			hydpositoninfo.setEqpId(null);
			hydpositoninfoDao.save(hydpositoninfo);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		hydpositoninfoDao.deleteById(uuid);
	}
	
	public JSONArray getAllHydPostionInfo(String stationName){
		JSONArray hydArray = new JSONArray();
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			wherecaseStr = " where   hp.eqpName like '%"+stationName+"%'" ;
		}
		
		String queryString = " select hp.eqpName ,dev.NAME ,dev.LATITUDE , dev.LONGITUDE,hp.eqpId , dev.ADDR from Hydpositoninfo as hp LEFT JOIN  Hyddevinfo as dev on hp.hydropowerId = dev.hydropowerId "+wherecaseStr ;
		Query query = hydpositoninfoDao.createQuery(queryString);
		List<Object[]> list = query.getResultList();
		for (Object[] objects : list) {
			if (objects[3] == null || objects[2] == null ) {
				continue;
			}
			JSONObject  jsonObject = new JSONObject();
			jsonObject.put("eqpName", objects[0]);
		    jsonObject.put("latitude",  objects[2]);
			jsonObject.put("longitude",  objects[3]);
			jsonObject.put("uuid", objects[4]);
			jsonObject.put("addr", objects[5]);
			jsonObject.put("type", "hydPosition");
			
			hydArray.add(jsonObject);
		}
		return  hydArray ;
	}
	
 
	public JSONArray getHydDeviceInfoById(String eqpId){
		JSONArray hydArray = new JSONArray();
		String queryString = " 	select dev.hydropowerId ,  dev.NAME, dev.ADDR ,dev.CONTACTER ,dev.LONGITUDE,dev.LATITUDE,dev.contacterTel ,dev.riverName,dev.OVERVIEW,dev.riverCode,dev.rgnName,dev.rgnCode from   Hyddevinfo as dev  LEFT JOIN Hydpositoninfo as hp  on  hp.hydropowerId = dev.hydropowerId where hp.eqpId='"+eqpId+"'";
		Query query = hydpositoninfoDao.createQuery(queryString);
		List<Object[]> list = query.getResultList();
		for (Object[] objects : list) {
			JSONObject  jsonObject = new JSONObject();
			jsonObject.put("uuid", objects[0]);
			jsonObject.put("name", objects[1]);
		    jsonObject.put("addr", objects[2]);
			jsonObject.put("contacter", objects[3]);	
			jsonObject.put("longitude", objects[4]);
			jsonObject.put("latitude", objects[5]);
			jsonObject.put("contacterTel", objects[6]);
			jsonObject.put("riverName", (objects[7]==null ?"":objects[7]));
			jsonObject.put("overview", (objects[8]==null ?"":objects[8]));
			jsonObject.put("riverCode", objects[9]);
			jsonObject.put("rgnName", (objects[10]==null ?"":objects[10]));
			jsonObject.put("rgnCode", objects[11]);
			hydArray.add(jsonObject);
		}
		return  hydArray ;
	}
	
	
}
