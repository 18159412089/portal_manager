/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.rubbish.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.entity.ZpTransferStation;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.dao.ZpTransferStationDao;
import com.fjzxdz.ams.zphb.module.enviromonit.rubbish.param.ZpTransferStationParam;

/**
 * 垃圾处理厂Service
 * @author queherong
 * @version 2019-10-14
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ZpTransferStationService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpTransferStationService.class);

	@Autowired
	private ZpTransferStationDao zpTransferStationDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param
	 * @param page
	 * @return
	 */
	public Page<ZpTransferStation> listByPage(ZpTransferStationParam zpTransferStationParam, Page<ZpTransferStation> page) {
		Page<ZpTransferStation> listPage = zpTransferStationDao.listByPage(zpTransferStationParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param zpTransferStation
	 */
	public void save(ZpTransferStation zpTransferStation) {
		if (StringUtils.isNotEmpty(zpTransferStation.getId())) {
			zpTransferStationDao.update(zpTransferStation);
		}else{
			zpTransferStation.setId(String.valueOf(getZpLicensedMineMaxId()));
			zpTransferStationDao.save(zpTransferStation);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param id
	 */
	public void delete(String id) {
		zpTransferStationDao.deleteById(id);
	}


	public int getZpLicensedMineMaxId() {
		String sql = "select max(to_number(ID)) from ZP_POLLUTION_TRANSFER_STATION";
		String maxIdStr = simpleDao.createNativeQuery(sql).getSingleResult().toString();
		int maxId = Integer.valueOf(maxIdStr)+1;
		return maxId;
	}
	
}
