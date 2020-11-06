/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.service;

import java.sql.Timestamp;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.rad.dao.RadSourceAccountDao;
import com.fjzxdz.ams.module.rad.entity.RadSourceAccount;
import com.fjzxdz.ams.module.rad.param.RadSourceAccountParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;

/**
 * 放射源台账Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RadSourceAccountService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RadSourceAccountService.class);

	@Autowired
	private RadSourceAccountDao radSourceAccountDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param radSourceAccount
	 * @param page
	 * @return
	 */
	public Page<RadSourceAccount> listByPage(RadSourceAccountParam radSourceAccountParam, Page<RadSourceAccount> page) {
		Page<RadSourceAccount> listPage = radSourceAccountDao.listByPage(radSourceAccountParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param radSourceAccount
	 */
/*	public void save(RadSourceAccount radSourceAccount) {
		if (StringUtils.isNotEmpty(radSourceAccount.getUuid())) {
			radSourceAccountDao.update(radSourceAccount);
		}else{
			radSourceAccount.setUuid(null);
			radSourceAccountDao.save(radSourceAccount);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		radSourceAccountDao.deleteById(uuid);
	}*/


	public JSONArray getRadSourceAccountDataListForMap(String ENTERID,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select SHR,ENTERID,LY,CS,PKID,UPDATETIME_RJWA,CCRQ,SHRQ,QXSHRQ,FSYYT,BZ,QXSHR,HSMC,QX,CCHD,BH,FSYLB,SFLSTZ,FSYBM,ZT from RAD_SOURCE_ACCOUNT where trim(ENTERID)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",ENTERID,startTime,endTime);
		List list = radSourceAccountDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("SHR",dataObj[j++]);
			obj.put("ENTERID",dataObj[j++]);
			obj.put("LY",dataObj[j++]);
			obj.put("CS",dataObj[j++]);
			obj.put("PKID",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("CCRQ",dataObj[j++]);
			obj.put("SHRQ",dataObj[j++]);
			obj.put("QXSHRQ",dataObj[j++]);
			obj.put("FSYYT",dataObj[j++]);
			obj.put("BZ",dataObj[j++]);
			obj.put("QXSHR",dataObj[j++]);
			obj.put("HSMC",dataObj[j++]);
			obj.put("QX",dataObj[j++]);
			obj.put("CCHD",dataObj[j++]);
			obj.put("BH",dataObj[j++]);
			obj.put("FSYLB",dataObj[j++]);
			obj.put("SFLSTZ",dataObj[j++]);
			obj.put("FSYBM",dataObj[j++]);
			obj.put("ZT",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
}
