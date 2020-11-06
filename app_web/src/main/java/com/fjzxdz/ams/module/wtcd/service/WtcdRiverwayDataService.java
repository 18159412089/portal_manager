/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.service;

import java.sql.Timestamp;
import java.util.List;

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

import com.fjzxdz.ams.module.wtcd.entity.WtcdRiverwayData;
import com.fjzxdz.ams.module.wtcd.dao.WtcdRiverwayDataDao;
import com.fjzxdz.ams.module.wtcd.param.WtcdRiverwayDataParam;

/**
 * 水利厅水文站点Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class WtcdRiverwayDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(WtcdRiverwayDataService.class);

	@Autowired
	private WtcdRiverwayDataDao wtcdRiverwayDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param wtcdRiverwayData
	 * @param page
	 * @return
	 */
	public Page<WtcdRiverwayData> listByPage(WtcdRiverwayDataParam wtcdRiverwayDataParam, Page<WtcdRiverwayData> page) {
		Page<WtcdRiverwayData> listPage = wtcdRiverwayDataDao.listByPage(wtcdRiverwayDataParam, page);
		return listPage;
	}

	public JSONArray getWtcdRiverwayDataListForMap(String STCD,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select Q,RKSJ,STCD,UPDATETIME_RJWA,YMDHM,ZR from WTCD_RIVERWAY_DATA where trim(STCD)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",STCD,startTime,endTime);
		List list = wtcdRiverwayDataDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("Q",dataObj[j++]);
			obj.put("RKSJ",dataObj[j++]);
			obj.put("STCD",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("YMDHM",dataObj[j++]);
			obj.put("ZR",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
	
	/**
	 * 更新或新增
	 * @param wtcdRiverwayData
	 */
/*	public void save(WtcdRiverwayData wtcdRiverwayData) {
		if (StringUtils.isNotEmpty(wtcdRiverwayData.getUuid())) {
			wtcdRiverwayDataDao.update(wtcdRiverwayData);
		}else{
			wtcdRiverwayData.setUuid(null);
			wtcdRiverwayDataDao.save(wtcdRiverwayData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		wtcdRiverwayDataDao.deleteById(uuid);
	}*/
	
}
