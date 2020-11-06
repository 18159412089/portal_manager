/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.service;

import java.util.List;

import javax.persistence.Query;

import org.apache.bcel.generic.NEW;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;
import com.fjzxdz.ams.module.rivers.dao.RiversSiteMonitorDataDao;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteMonitorData;
import com.fjzxdz.ams.module.rivers.param.RiversSiteMonitorDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

/**
 * 入海河流监测数据Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiversSiteMonitorDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiversSiteMonitorDataService.class);

	@Autowired
	private RiversSiteMonitorDataDao riversSiteMonitorDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riversSiteMonitorData
	 * @param page
	 * @return
	 */
	public Page<RiversSiteMonitorData> listByPage(RiversSiteMonitorDataParam riversSiteMonitorDataParam, Page<RiversSiteMonitorData> page) {
		Page<RiversSiteMonitorData> listPage = riversSiteMonitorDataDao.listByPage(riversSiteMonitorDataParam, page);
		return listPage;
	}
	
	
	/**
	 * 根据 站点编码 pointCode ,污染物编码 codePollute 获取监测数据信息
	 * @param pointCode
	 * @return
	 */
	public  JSONObject getRiversSiteMonitorDataList(String pointCode ,String columnCode){
		JSONObject jsonObject = new JSONObject() ;
		String queryString  = "from RiversSiteMonitorData rd where rd.POINTCODE ='"+pointCode+"'  and  rd.codePollute = '"+columnCode+"'" +" order by rd.MONITORTIME desc";
		Query query = riversSiteMonitorDataDao.createQuery(queryString);
	    List<RiversSiteMonitorData> list	=	query.getResultList();
	    JSONArray  monitorTimeArr = new JSONArray();
	    JSONArray  pollutantValueArr = new JSONArray();
	    for (RiversSiteMonitorData riversSiteMonitorData : list) {
	    	monitorTimeArr.add( riversSiteMonitorData.getMONITORTIME() == null ? "":riversSiteMonitorData.getMONITORTIME());
	    	pollutantValueArr.add(riversSiteMonitorData.getPOLLUTEVALUE());
	    	 
		}
	    jsonObject.put("monitorTimeArr", monitorTimeArr);
	    jsonObject.put("pollutantValueArr", pollutantValueArr);
	    jsonObject.put("pollutantName", list.get(0).getPOLLUTENAME());
	    
		return jsonObject;
	}
	
	
	/**
	 * 获取左侧列名信息
	 */
	public JSONArray getLeftMenuColumnName(String pointCode){
		JSONArray jsonArray = new JSONArray() ;
		String queryString  = "select DISTINCT POLLUTENAME , codePollute from RiversSiteMonitorData where POINTCODE ='"+pointCode+"'";
		Query query = riversSiteMonitorDataDao.createQuery(queryString);
		List<Object[]> list	=	query.getResultList();
		for (Object[] objects : list) {
			 
			JSONObject  jsonObject = new JSONObject();
			jsonObject.put("polluteName", objects[0]);
		    jsonObject.put("codePollute",  objects[1]);
		    jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	
	/**
	 * 更新或新增
	 * @param riversSiteMonitorData
	 */
/*	public void save(RiversSiteMonitorData riversSiteMonitorData) {
		if (StringUtils.isNotEmpty(riversSiteMonitorData.getUuid())) {
			riversSiteMonitorDataDao.update(riversSiteMonitorData);
		}else{
			riversSiteMonitorData.setUuid(null);
			riversSiteMonitorDataDao.save(riversSiteMonitorData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riversSiteMonitorDataDao.deleteById(uuid);
	}*/
	
}
