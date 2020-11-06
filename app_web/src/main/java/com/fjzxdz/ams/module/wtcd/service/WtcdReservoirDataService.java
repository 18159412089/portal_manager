/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.service;

import java.sql.Timestamp;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.wtcd.dao.WtcdReservoirDataDao;
import com.fjzxdz.ams.module.wtcd.entity.WtcdReservoirData;
import com.fjzxdz.ams.module.wtcd.param.WtcdReservoirDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

/**
 * 水利厅水文站点Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtcdReservoirDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtcdReservoirDataService.class);

	@Autowired
	private WtcdReservoirDataDao wtcdReservoirDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtcdReservoirData
	 * @param page
	 * @return
	 */
	public Page<WtcdReservoirData> listByPage(WtcdReservoirDataParam wtcdReservoirDataParam, Page<WtcdReservoirData> page) {
		Page<WtcdReservoirData> listPage = wtcdReservoirDataDao.listByPage(wtcdReservoirDataParam, page);
		return listPage;
	}

	public JSONArray getWtcdReservoirDataListForMap(String STCD,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select W,RKSJ,STCD,UPDATETIME_RJWA,YMDHM,ZI from WTCD_RESERVOIR_DATA where trim(STCD)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",STCD,startTime,endTime);
		List list = wtcdReservoirDataDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("W",dataObj[j++]);
			obj.put("RKSJ",dataObj[j++]);
			obj.put("STCD",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("YMDHM",dataObj[j++]);
			obj.put("ZI",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
	
	/**
	 * 更新或新增
	 * @param wtcdReservoirData
	 */
/*	public void save(WtcdReservoirData wtcdReservoirData) {
		if (StringUtils.isNotEmpty(wtcdReservoirData.getUuid())) {
			wtcdReservoirDataDao.update(wtcdReservoirData);
		}else{
			wtcdReservoirData.setUuid(null);
			wtcdReservoirDataDao.save(wtcdReservoirData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		wtcdReservoirDataDao.deleteById(uuid);
	}*/
	
}
