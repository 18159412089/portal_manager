/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.enterprise.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.module.enviromonit.enterprise.dao.PeEnterpriseDataDao;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.enterprise.param.PeEnterpriseDataParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 污染源自动监控企业信息表Service
 * @author slq
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ZpPeEnterpriseDataService2 {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpPeEnterpriseDataService2.class);

	@Autowired
	private PeEnterpriseDataDao peEnterpriseDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peEnterpriseDataParam
	 * @param page
	 * @return
	 */
	public Page<PeEnterpriseData> listByPage(PeEnterpriseDataParam peEnterpriseDataParam, Page<PeEnterpriseData> page) {
		Page<PeEnterpriseData> listPage = peEnterpriseDataDao.listByPage(peEnterpriseDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peEnterpriseData
	 */
	public void save(PeEnterpriseData peEnterpriseData) {
		if (StringUtils.isNotEmpty(peEnterpriseData.getPeId())) {
			PeEnterpriseData peEnterpriseDataTemp = peEnterpriseDataDao.getById(peEnterpriseData.getPeId());
			BeanUtil.copyProperties(peEnterpriseData, peEnterpriseDataTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			peEnterpriseDataDao.update(peEnterpriseDataTemp);
		}else{
			//peEnterpriseData.setUuid(null);
			peEnterpriseData = (PeEnterpriseData) EmptyStringToNullUtil.emptyStringToNull(peEnterpriseData);
			peEnterpriseDataDao.save(peEnterpriseData);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peEnterpriseDataDao.deleteById(uuid);
	}

	public List<PeEnterpriseData> getCompnentPeEnterpriseDatasListByUnitTypeCode(String unitTypeCode) {
		String hql = "select obj from PeEnterpriseData obj";
		if(unitTypeCode!=null && !"".equals(unitTypeCode)) {
			hql = hql + " where obj.unitTypeCode='"+unitTypeCode+"'";
		}
        return peEnterpriseDataDao.createQuery(hql).getResultList();
	}
	
}
