/**
 * There are <a href=" ">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.bcel.generic.NEW;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.epa.JsonUntil;
import com.fjzxdz.ams.module.sea.dao.SeaSiteDataDao;
import com.fjzxdz.ams.module.sea.entity.SeaSiteData;
import com.fjzxdz.ams.module.sea.param.SeaSiteDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONUtil;

/**
 * 省海洋与渔业厅数据Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class SeaSiteDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(SeaSiteDataService.class);

	@Autowired
	private SeaSiteDataDao seaSiteDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param seaSiteData
	 * @param page
	 * @return
	 */
	public Page<SeaSiteData> listByPage(SeaSiteDataParam seaSiteDataParam, Page<SeaSiteData> page) {
		Page<SeaSiteData> listPage = seaSiteDataDao.listByPage(seaSiteDataParam, page);
		return listPage;
	}
	
 
	public  cn.hutool.json.JSONObject getSeaSiteMonitorInfoByStationID(String stationID ,String oldStationID){
		cn.hutool.json.JSONObject jsonObject = new cn.hutool.json.JSONObject();
		String queryString = "from SeaSiteData where (zdbh ='"+stationID+"' or zdbh ='"+oldStationID+"')  order by  JCSJ desc";
		Query query = seaSiteDataDao.createQuery(queryString);
		query.setFirstResult(0);
		query.setMaxResults(1000);
		@SuppressWarnings("unchecked")
		List<SeaSiteData> list =  query.getResultList();
		cn.hutool.json.JSONArray jcsjMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray ddlMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray ljybhdMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray LJYMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray YLSMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray DDLMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray phMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray YXSYNDMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray sdMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray XSYNDMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray PSYNDMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray fsMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray fxMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray qyMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray swMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray RH_ENCMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray WD_EdCMap= new cn.hutool.json.JSONArray();
		cn.hutool.json.JSONArray BCYDMap= new cn.hutool.json.JSONArray();
		for (SeaSiteData seaSiteData : list) {
			BCYDMap.add(  seaSiteData.getBCSD() == null ? " ":  seaSiteData.getBCSD());
			ddlMap.add( seaSiteData.getDDL()== null ? " ": seaSiteData.getDDL());
			ljybhdMap.add(  seaSiteData.getLJYBHD()== null ? " ": seaSiteData.getLJYBHD() );
			LJYMap.add(   seaSiteData.getLJY()== null ? " ":  seaSiteData.getLJY());
			YLSMap.add( seaSiteData.getYLS()== null ? " ":seaSiteData.getYLS());
			DDLMap.add(seaSiteData.getDDL()== null ? " ": seaSiteData.getDDL());
			phMap.add(  seaSiteData.getPH()== null ? " ":seaSiteData.getPH() );
			YXSYNDMap.add(  seaSiteData.getYXSYND()== null ? " ": seaSiteData.getYXSYND());
			sdMap.add(seaSiteData.getSD()== null ? " ": seaSiteData.getSD());
			XSYNDMap.add(  seaSiteData.getXSYND()== null ? " ":seaSiteData.getXSYND() );
			PSYNDMap.add(  seaSiteData.getPSYND()== null ? " ":seaSiteData.getPSYND() );
			fsMap.add( seaSiteData.getFS()== null ? " ":seaSiteData.getFS() );
			fxMap.add( seaSiteData.getFX()== null ? " ": seaSiteData.getFX() );
			qyMap.add(  seaSiteData.getQY()== null ? " ": seaSiteData.getQY() );
			swMap.add(seaSiteData.getSW()== null ? " ":seaSiteData.getSW() );
			RH_ENCMap.add(seaSiteData.getRhEnc()== null ? " ":seaSiteData.getRhEnc() );
			WD_EdCMap.add(  seaSiteData.getWdEdc()== null ? " ": seaSiteData.getWdEdc() );
			String jcsjTime = null;
			/*if(seaSiteData.getJCSJ() != null){
				 jcsjTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(seaSiteData.getJCSJ());
			}*/
			jcsjMap.add( seaSiteData.getJCSJ());
		 }
		jsonObject.put("CJSJ", jcsjMap);
		jsonObject.put("BCYD", BCYDMap);
		jsonObject.put("DDL", ddlMap);
		jsonObject.put("LJYBHD", ljybhdMap);
		jsonObject.put("LJY", LJYMap);
		jsonObject.put("YLS", YLSMap);
		jsonObject.put("DDL", DDLMap);
		jsonObject.put("PH", phMap);
		jsonObject.put("YXSYND", YXSYNDMap);
		jsonObject.put("SD", sdMap);
		jsonObject.put("XSYND", XSYNDMap);
		jsonObject.put("PSYND", PSYNDMap);
		jsonObject.put("FS", fsMap);
		jsonObject.put("FX", fxMap);
		jsonObject.put("QY", qyMap);
		jsonObject.put("SW", swMap);
		jsonObject.put("RH_ENC", RH_ENCMap);
		jsonObject.put("WD_EDC", WD_EdCMap);
 
		return jsonObject; 
	}
	
	
	/**
	 * 更新或新增
	 * @param seaSiteData
	 */
/*	public void save(SeaSiteData seaSiteData) {
		if (StringUtils.isNotEmpty(seaSiteData.getUuid())) {
			seaSiteDataDao.update(seaSiteData);
		}else{
			seaSiteData.setUuid(null);
			seaSiteDataDao.save(seaSiteData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		seaSiteDataDao.deleteById(uuid);
	}*/
	
}
