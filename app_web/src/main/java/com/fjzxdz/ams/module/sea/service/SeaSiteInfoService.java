/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.service;

import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.sea.dao.SeaSiteInfoDao;
import com.fjzxdz.ams.module.sea.entity.SeaSiteInfo;
import com.fjzxdz.ams.module.sea.param.SeaSiteInfoParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

/**
 * 海洋与渔业点位信息Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class SeaSiteInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(SeaSiteInfoService.class);

	@Autowired
	private SeaSiteInfoDao seaSiteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param seaSiteInfo
	 * @param page
	 * @return
	 */
	public Page<SeaSiteInfo> listByPage(SeaSiteInfoParam seaSiteInfoParam, Page<SeaSiteInfo> page) {
		Page<SeaSiteInfo> listPage = seaSiteInfoDao.listByPage(seaSiteInfoParam, page);
		return listPage;
	}
	
	
	/**
	 * 获取渔业点位所有信息 
	 * @return
	 */
	
	public JSONArray getSeaSiteArray(String stationName){
		JSONArray seaSiteArray = new JSONArray();
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			wherecaseStr = " where   sea.zdmc like '%"+stationName+"%'" ;
		}
		
		String queryString = " select sea.zdbh,sea.yzdbh,sea.zdmc,sea.jd,sea.wd,sea.xzqhbm,sea.xzqhmc,sea.jcpc,sea.updatetimeRjwa from SeaSiteInfo as sea "+wherecaseStr+" order by sea.updatetimeRjwa desc";
				 
		Query query = seaSiteInfoDao.createQuery(queryString);
		List<Object[]> list = query.getResultList();
		for (Object[] objects : list) {
			JSONObject  jsonObject = new JSONObject();
			if (objects[4] == null || objects[3] == null ) {
				continue;
			}
			jsonObject.put("zdbh", objects[0]);
		    jsonObject.put("yzdbh", objects[1]);
			jsonObject.put("zdmc", objects[2]);
			jsonObject.put("jd", (double)objects[3]/10000);
			jsonObject.put("wd", (double)objects[4]/10000);
			jsonObject.put("xzqhbm", objects[5]);
			jsonObject.put("xzqhmc", objects[6]);
			jsonObject.put("jcpc",objects[7] );
			jsonObject.put("updatetimeRjwa", objects[8]);
			jsonObject.put("type", "sea");
			seaSiteArray.add(jsonObject);
		}
		return  seaSiteArray ;
	}
	
	
	
	/**
	 * 更新或新增
	 * @param seaSiteInfo
	 */
/*	public void save(SeaSiteInfo seaSiteInfo) {
		if (StringUtils.isNotEmpty(seaSiteInfo.getUuid())) {
			seaSiteInfoDao.update(seaSiteInfo);
		}else{
			seaSiteInfo.setUuid(null);
			seaSiteInfoDao.save(seaSiteInfo);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		seaSiteInfoDao.deleteById(uuid);
	}*/
	
}
