/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.vi.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.module.vi.entity.Visits;
import com.fjzxdz.ams.module.vi.dao.VisitsDao;
import com.fjzxdz.ams.module.vi.param.VisitsParam;

/**
 * 信访投诉Service
 * @author htj
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class VisitsService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(VisitsService.class);

	@Autowired
	private VisitsDao visitsDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param visits
	 * @param page
	 * @return
	 */
	public Page<Visits> listByPage(VisitsParam visitsParam, Page<Visits> page) {
		Page<Visits> listPage = visitsDao.listByPage(visitsParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param visits
	 */
	public void save(Visits visits) {
		if (StringUtils.isNotEmpty(visits.getPETIID())) {
			visitsDao.update(visits);
		}else{
			visits.setPETIID(null);
			visitsDao.save(visits);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		visitsDao.deleteById(uuid);
	}
	
}
