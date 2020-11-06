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

import com.fjzxdz.ams.module.haz.entity.JointOrderDetail;
import com.fjzxdz.ams.module.haz.dao.JointOrderDetailDao;
import com.fjzxdz.ams.module.haz.param.JointOrderDetailParam;

/**
 * 联单详细信息Service
 * @author htj
 * @version 2019-02-19
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class JointOrderDetailService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(JointOrderDetailService.class);

	@Autowired
	private JointOrderDetailDao jointOrderDetailDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param jointOrderDetail
	 * @param page
	 * @return
	 */
	public Page<JointOrderDetail> listByPage(JointOrderDetailParam jointOrderDetailParam, Page<JointOrderDetail> page) {
		Page<JointOrderDetail> listPage = jointOrderDetailDao.listByPage(jointOrderDetailParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param jointOrderDetail
	 */
	public void save(JointOrderDetail jointOrderDetail) {
		/*if (StringUtils.isNotEmpty(jointOrderDetail.getUuid())) {
			jointOrderDetailDao.update(jointOrderDetail);
		}else{
			jointOrderDetail.setUuid(null);
			jointOrderDetailDao.save(jointOrderDetail);
		}*/
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		jointOrderDetailDao.deleteById(uuid);
	}
	
}
