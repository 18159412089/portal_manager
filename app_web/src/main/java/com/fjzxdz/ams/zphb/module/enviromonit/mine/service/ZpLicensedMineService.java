/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.mine.service;

import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.zphb.module.enviromonit.mine.entity.ZpLicensedMine;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.dao.ZpLicensedMineDao;
import com.fjzxdz.ams.zphb.module.enviromonit.mine.param.ZpLicensedMineParam;

/**
 * 矿山管理Service
 * @author queherong
 * @version 2019-10-14
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ZpLicensedMineService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpLicensedMineService.class);

	@Autowired
	private ZpLicensedMineDao zpLicensedMineDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param zpLicensedMineParam
	 * @param page
	 * @return
	 */
	public Page<ZpLicensedMine> listByPage(ZpLicensedMineParam zpLicensedMineParam, Page<ZpLicensedMine> page) {
		Page<ZpLicensedMine> listPage = zpLicensedMineDao.listByPage(zpLicensedMineParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param zpLicensedMine
	 */
	public void save(ZpLicensedMine zpLicensedMine) {
		if (StringUtils.isNotEmpty(zpLicensedMine.getId())) {
			zpLicensedMineDao.update(zpLicensedMine);
		}else{
			zpLicensedMine = (ZpLicensedMine) EmptyStringToNullUtil.emptyStringToNull(zpLicensedMine);
			zpLicensedMine.setId(String.valueOf(getZpLicensedMineMaxId()));
			zpLicensedMineDao.save(zpLicensedMine);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		zpLicensedMineDao.deleteById(uuid);
	}

	/**
	 * 获取最大id
	 * @return
	 */
	public int getZpLicensedMineMaxId() {
		String sql = "select max(to_number(ID)) from ZP_POLLUTION_LICENSED_MINE";
		String maxIdStr = simpleDao.createNativeQuery(sql).getSingleResult().toString();
		int maxId = Integer.valueOf(maxIdStr)+1;
		return maxId;
	}
}
