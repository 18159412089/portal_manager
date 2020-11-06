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
import com.fjzxdz.ams.module.rivers.dao.RiversEvaluateDataDao;
import com.fjzxdz.ams.module.rivers.entity.RiversEvaluateData;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteInfo;
import com.fjzxdz.ams.module.rivers.param.RiversEvaluateDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;

/**
 * 海河流水质评价结果Service
 * @author lilongan
 * @version 2019-02-20
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RiversEvaluateDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RiversEvaluateDataService.class);

	@Autowired
	private RiversEvaluateDataDao riversEvaluateDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param riversEvaluateData
	 * @param page
	 * @return
	 */
	public Page<RiversEvaluateData> listByPage(RiversEvaluateDataParam riversEvaluateDataParam, Page<RiversEvaluateData> page) {
		Page<RiversEvaluateData> listPage = riversEvaluateDataDao.listByPage(riversEvaluateDataParam, page);
		return listPage;
	}
	
	
	/**
	 * 根据pointCode 获取评价信息列表
	 * @param pointCode
	 * @return
	 */
	public JSONArray getRiverEvaluateDataByPointCode(String pointCode){
		JSONArray jsonArray = new JSONArray();
		if (StringUtils.isEmpty(pointCode)) {
			return null;
		}
		String queryString  = "from RiversEvaluateData re where re.POINTCODE '"+pointCode+"'";
		Query query = riversEvaluateDataDao.createQuery(queryString);
		List<RiversEvaluateData> list = query.getResultList();
		jsonArray.addAll(list);
		return jsonArray ;
	}
	
	
	/**
	 * 更新或新增
	 * @param riversEvaluateData
	 */
/*	public void save(RiversEvaluateData riversEvaluateData) {
		if (StringUtils.isNotEmpty(riversEvaluateData.getUuid())) {
			riversEvaluateDataDao.update(riversEvaluateData);
		}else{
			riversEvaluateData.setUuid(null);
			riversEvaluateDataDao.save(riversEvaluateData);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		riversEvaluateDataDao.deleteById(uuid);
	}*/
	
}
