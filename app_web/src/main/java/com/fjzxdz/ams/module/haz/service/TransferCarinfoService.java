/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.haz.entity.TransferCarinfo;
import com.fjzxdz.ams.module.haz.dao.TransferCarinfoDao;
import com.fjzxdz.ams.module.haz.param.TransferCarinfoParam;

/**
 * 危废转移车辆信息Service
 * @author htj
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class TransferCarinfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(TransferCarinfoService.class);

	@Autowired
	private TransferCarinfoDao transferCarinfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param transferCarinfo
	 * @param page
	 * @return
	 */
	public Page<TransferCarinfo> listByPage(TransferCarinfoParam transferCarinfoParam, Page<TransferCarinfo> page) {
		Page<TransferCarinfo> listPage = transferCarinfoDao.listByPage(transferCarinfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param transferCarinfo
	 */
	public void save(TransferCarinfo transferCarinfo) {
		if ( transferCarinfo.getMomId()!=null) {
			transferCarinfoDao.update(transferCarinfo);
		}else{
			transferCarinfo.setMomId(null);
			transferCarinfoDao.save(transferCarinfo);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		transferCarinfoDao.deleteById(uuid);
	}
	
}
