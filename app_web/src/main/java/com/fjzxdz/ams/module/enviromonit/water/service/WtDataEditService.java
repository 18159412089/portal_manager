package com.fjzxdz.ams.module.enviromonit.water.service;

import java.util.List;
import java.util.Map;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

public interface WtDataEditService {
	/**
	 * 市账号获取县账号列表需要分页 (zz获取zz_账号列表)
	 * <p>
	 * Title: getPageList
	 * </p>
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param loginName
	 * @param page
	 * @return
	 * @see com.fjzxdz.ams.module.enviromonit.water.service.WtDataEditService#getPageList(java.lang.String,
	 *      cn.fjzxdz.frame.common.Page)
	 */

	List<Map<String, Object>> getPageList(String loginName, Page<Map<String, Object>> page);

	/**
	 * 
	 * @Title: getUserList @Description: 获取小河流域账号数据;市账号登录查看 @param: @param
	 * loginName @param: @return @return: List<Map<String,Object>> @throws
	 */
	List<Map<String, Object>> getUserList(String loginName);

	/**
	 * 
	 * @Title: listRiverMonitor @Description: @param: @param
	 * uid @param: @return @return: List<Map<String,Object>> @throws
	 */
	List<Map<String, Object>> listRiverMonitor(String uid);

	/**   
	 * @Title: listRiverUnknowTown   
	 * @Description: 未知所属县的流域
	 * @param: @return      
	 * @return: List<Map<String,Object>>      
	 * @throws   
	 */
	List<Map<String, Object>> listRiverUnknowTown();
}
