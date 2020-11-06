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

import com.fjzxdz.ams.module.haz.entity.JointOrderInfo;
import com.fjzxdz.ams.module.haz.dao.JointOrderInfoDao;
import com.fjzxdz.ams.module.haz.param.JointOrderInfoParam;

/**
 * 联单转移联单信息Service
 * @author htj
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class JointOrderInfoService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(JointOrderInfoService.class);

	@Autowired
	private JointOrderInfoDao jointOrderInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param jointOrderInfo
	 * @param page
	 * @return
	 */
	public Page<JointOrderInfo> listByPage(JointOrderInfoParam jointOrderInfoParam, Page<JointOrderInfo> page) {
		Page<JointOrderInfo> listPage = jointOrderInfoDao.listByPage(jointOrderInfoParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param jointOrderInfo
	 */
	public void save(JointOrderInfo jointOrderInfo) {
		/*if (StringUtils.isNotEmpty(jointOrderInfo.getUuid())) {
			jointOrderInfoDao.update(jointOrderInfo);
		}else{
			jointOrderInfo.setUuid(null);
			jointOrderInfoDao.save(jointOrderInfo);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		jointOrderInfoDao.deleteById(uuid);
	}
	
}
