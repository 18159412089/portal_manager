/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.service;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Id;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import com.fjzxdz.ams.module.wtcd.entity.WtcdRainfallData;
import com.fjzxdz.ams.module.wtcd.dao.WtcdRainfallDataDao;
import com.fjzxdz.ams.module.wtcd.param.WtcdRainfallDataParam;

/**
 * 水利厅水文站点Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtcdRainfallDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtcdRainfallDataService.class);

	@Autowired
	private WtcdRainfallDataDao wtcdRainfallDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtcdRainfallData
	 * @param page
	 * @return
	 */
	public Page<WtcdRainfallData> listByPage(WtcdRainfallDataParam wtcdRainfallDataParam, Page<WtcdRainfallData> page) {
		Page<WtcdRainfallData> listPage = wtcdRainfallDataDao.listByPage(wtcdRainfallDataParam, page);
		return listPage;
	}

	public JSONArray getWtcdRainfallDataListForMap(String STCD,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select RKSJ,STCD,UPDATETIME_RJWA,DTRN,YMDHM from WTCD_RAINFALL_DATA where trim(STCD)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",STCD,startTime,endTime);
		List list = wtcdRainfallDataDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("RKSJ",dataObj[j++]);
			obj.put("STCD",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("DTRN",dataObj[j++]);
			obj.put("YMDHM",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
	
	/**
	 * 更新或新增
	 * @param wtcdRainfallData
	 */
/*	public void save(WtcdRainfallData wtcdRainfallData) {
		if (StringUtils.isNotEmpty(wtcdRainfallData.getUuid())) {
			wtcdRainfallDataDao.update(wtcdRainfallData);
		}else{
			wtcdRainfallData.setUuid(null);
			wtcdRainfallDataDao.save(wtcdRainfallData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		wtcdRainfallDataDao.deleteById(uuid);
	}*/
}
