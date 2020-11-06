/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.hydposition.entity.Hyddevexitdata;
import com.fjzxdz.ams.module.hydposition.dao.HyddevexitdataDao;
import com.fjzxdz.ams.module.hydposition.param.HyddevexitdataParam;

/**
 * 水电站设备出口Service
 * @author htj
 * @version 2019-02-18
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class HyddevexitdataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(HyddevexitdataService.class);

	@Autowired
	private HyddevexitdataDao hyddevexitdataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param hyddevexitdata
	 * @param page
	 * @return
	 */
	public Page<Hyddevexitdata> listByPage(HyddevexitdataParam hyddevexitdataParam, Page<Hyddevexitdata> page) {
		Page<Hyddevexitdata> listPage = hyddevexitdataDao.listByPage(hyddevexitdataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param hyddevexitdata
	 */
	public void save(Hyddevexitdata hyddevexitdata) {
		if (hyddevexitdata.getOutputId() !=null ) {
			hyddevexitdataDao.update(hyddevexitdata);
		}else{
			hyddevexitdata.setOutputId(null);
			hyddevexitdataDao.save(hyddevexitdata);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		hyddevexitdataDao.deleteById(uuid);
	}
	
}
