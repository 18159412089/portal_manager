/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.service;

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

import com.fjzxdz.ams.module.rad.entity.RadXRayAccount;
import com.fjzxdz.ams.module.rad.dao.RadXRayAccountDao;
import com.fjzxdz.ams.module.rad.param.RadXRayAccountParam;

/**
 * 射线装置台账Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RadXRayAccountService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RadXRayAccountService.class);

	@Autowired
	private RadXRayAccountDao radXRayAccountDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param radXRayAccount
	 * @param page
	 * @return
	 */
	public Page<RadXRayAccount> listByPage(RadXRayAccountParam radXRayAccountParam, Page<RadXRayAccount> page) {
		Page<RadXRayAccount> listPage = radXRayAccountDao.listByPage(radXRayAccountParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param radXRayAccount
	 */
/*	public void save(RadXRayAccount radXRayAccount) {
		if (StringUtils.isNotEmpty(radXRayAccount.getUuid())) {
			radXRayAccountDao.update(radXRayAccount);
		}else{
			radXRayAccount.setUuid(null);
			radXRayAccountDao.save(radXRayAccount);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		radXRayAccountDao.deleteById(uuid);
	}*/


	public JSONArray getRadXRayAccountDataListForMap(String ENTERID,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select ENTERID,ZZLX,SHR,LY,CS,PKID,GGXH,UPDATETIME_RJWA,SHRQ,QXSHRQ,BZ,DY,QXSHR,QX,DL,SFLSTZ,GL,ZZMC,YT from RAD_X_RAY_ACCOUNT where trim(ENTERID)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",ENTERID,startTime,endTime);
		List list = radXRayAccountDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("ENTERID",dataObj[j++]);
			obj.put("ZZLX",dataObj[j++]);
			obj.put("SHR",dataObj[j++]);
			obj.put("LY",dataObj[j++]);
			obj.put("CS",dataObj[j++]);
			obj.put("PKID",dataObj[j++]);
			obj.put("GGXH",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("SHRQ",dataObj[j++]);
			obj.put("QXSHRQ",dataObj[j++]);
			obj.put("BZ",dataObj[j++]);
			obj.put("DY",dataObj[j++]);
			obj.put("QXSHR",dataObj[j++]);
			obj.put("QX",dataObj[j++]);
			obj.put("DL",dataObj[j++]);
			obj.put("SFLSTZ",dataObj[j++]);
			obj.put("GL",dataObj[j++]);
			obj.put("ZZMC",dataObj[j++]);
			obj.put("YT",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
}
