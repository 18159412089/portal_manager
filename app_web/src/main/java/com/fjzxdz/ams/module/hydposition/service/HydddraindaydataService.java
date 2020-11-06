/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.service;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.persistence.Query;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.hydposition.dao.HydddraindaydataDao;
import com.fjzxdz.ams.module.hydposition.entity.Hydddraindaydata;
import com.fjzxdz.ams.module.hydposition.param.HydddraindaydataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 水电站下泄流量日统计数据Service
 * @author htj
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class HydddraindaydataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(HydddraindaydataService.class);

	@Autowired
	private HydddraindaydataDao hydddraindaydataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param hydddraindaydata
	 * @param page
	 * @return
	 */
	public Page<Hydddraindaydata> listByPage(HydddraindaydataParam hydddraindaydataParam, Page<Hydddraindaydata> page) {
		Page<Hydddraindaydata> listPage = hydddraindaydataDao.listByPage(hydddraindaydataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param hydddraindaydata
	 */
	public void save(Hydddraindaydata hydddraindaydata) {
		/*if (StringUtils.isNotEmpty(hydddraindaydata.getUuid())) {
			hydddraindaydataDao.update(hydddraindaydata);
		}else{
			hydddraindaydata.setUuid(null);
			hydddraindaydataDao.save(hydddraindaydata);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		hydddraindaydataDao.deleteById(uuid);
	}
	
	
	/**
	 * 根据 设备 hydropowerId 获取 水电站下泄流量日统计数据
	 * @param hydropowerId
	 * @return
	 */
	public  JSONArray getHydDrainDayDataByHydDeviceId(String hydropowerId){
		JSONArray hydDayDataArray = new JSONArray();
		String queryString = " 	select ed.outputCode ,ed.outputName,ed.STATUS,dd.minValue ,dd.maxValue,dd.avgValue,dd.hydddraindaydataPrimaryKey.measureTime from Hydddraindaydata as dd  LEFT JOIN Hyddevexitdata as ed on dd.hydddraindaydataPrimaryKey.outputId = ed.outputId where ed.hydropowerId='"+ hydropowerId+"'  ORDER BY dd.hydddraindaydataPrimaryKey.measureTime DESC";
		Query query = hydddraindaydataDao.createQuery(queryString);
		List<Object[]> list = query.getResultList();
		for (Object[] objects : list) {
			JSONObject  jsonObject = new JSONObject();
			jsonObject.put("outputCode", objects[0]);
			jsonObject.put("outputName", objects[1]);
		    jsonObject.put("STATUS", objects[2]);
			jsonObject.put("minValue", objects[3]);			
			jsonObject.put("maxValue", objects[4]);		
			jsonObject.put("avgValue", objects[5]);	
			String measureTime = "";
			if(objects[6] != null){
				measureTime = new SimpleDateFormat("yyyy-MM-dd").format(objects[6]);
			}
			jsonObject.put("measureTime", measureTime);		
			hydDayDataArray.add(jsonObject);
		}
		return  hydDayDataArray ;
	}
	
	
	
	
	
	
	
	
	
	
}
