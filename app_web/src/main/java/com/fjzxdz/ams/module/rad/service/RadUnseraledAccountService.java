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

import com.fjzxdz.ams.module.rad.entity.RadUnseraledAccount;
import com.fjzxdz.ams.module.rad.dao.RadUnseraledAccountDao;
import com.fjzxdz.ams.module.rad.param.RadUnseraledAccountParam;

/**
 * 非密封台账Service
 * @author lilongan
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class RadUnseraledAccountService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RadUnseraledAccountService.class);

	@Autowired
	private RadUnseraledAccountDao radUnseraledAccountDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param radUnseraledAccount
	 * @param page
	 * @return
	 */
	public Page<RadUnseraledAccount> listByPage(RadUnseraledAccountParam radUnseraledAccountParam, Page<RadUnseraledAccount> page) {
		Page<RadUnseraledAccount> listPage = radUnseraledAccountDao.listByPage(radUnseraledAccountParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param radUnseraledAccount
	 */
/*	public void save(RadUnseraledAccount radUnseraledAccount) {
		if (StringUtils.isNotEmpty(radUnseraledAccount.getUuid())) {
			radUnseraledAccountDao.update(radUnseraledAccount);
		}else{
			radUnseraledAccount.setUuid(null);
			radUnseraledAccountDao.save(radUnseraledAccount);
		}
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
/*	public void delete(String uuid) {
		radUnseraledAccountDao.deleteById(uuid);
	}*/

	public JSONArray getRadUnseraledAccountDataListForMap(String ENTERID,Timestamp startTime,Timestamp endTime) {
		String sql = String.format("select SHR,ENTERID,QX,XQSHR,HD,LY,PKID,UPDATETIME_RJWA,SHRQ,QXSHRQ,YT,BZ,PC from RAD_UNSERALED_ACCOUNT where trim(ENTERID)='%s' and UPDATETIME_RJWA BETWEEN '%s' and '%s' order by UPDATETIME_RJWA ASC",ENTERID,startTime,endTime);
		List list = radUnseraledAccountDao.createNativeQuery(sql).getResultList();
		JSONArray result = new JSONArray();
		for (int i=0;i<list.size();i++) {
			Object[] dataObj = (Object[]) list.get(i);
			
			int j=0;
			JSONObject obj = new JSONObject();
			obj.put("SHR",dataObj[j++]);
			obj.put("ENTERID",dataObj[j++]);
			obj.put("QX",dataObj[j++]);
			obj.put("XQSHR",dataObj[j++]);
			obj.put("HD",dataObj[j++]);
			obj.put("LY",dataObj[j++]);
			obj.put("PKID",dataObj[j++]);
			obj.put("UPDATETIME_RJWA",dataObj[j++]);
			obj.put("SHRQ",dataObj[j++]);
			obj.put("QXSHRQ",dataObj[j++]);
			obj.put("YT",dataObj[j++]);
			obj.put("BZ",dataObj[j++]);
			obj.put("PC",dataObj[j++]);
			
			result.put(obj);
		}
		
		return result;
	}
}
