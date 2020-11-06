package com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.service; /**
 * There are <a href="">福建中兴电子</a> code generation
 */


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.dao.ZpPollutionEnterpriseDataDao;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.entity.ZpPollutionEnterpriseData;

import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.param.ZpPollutionEnterpriseDataParam;
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
public class ZpPollutionEnterpriseDataService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpPollutionEnterpriseDataService.class);

	@Autowired
	private ZpPollutionEnterpriseDataDao peEnterpriseDataDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param
	 * @param page
	 * @return
	 */
	public Page<ZpPollutionEnterpriseData> listByPage(ZpPollutionEnterpriseDataParam peEnterpriseDataParam, Page<ZpPollutionEnterpriseData> page) {
		Page<ZpPollutionEnterpriseData> listPage = peEnterpriseDataDao.listByPage(peEnterpriseDataParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param
	 */
	public void save(ZpPollutionEnterpriseData peEnterpriseData) {
		if (StringUtils.isNotEmpty(peEnterpriseData.getPeId())) {
			ZpPollutionEnterpriseData peEnterpriseDataTemp = peEnterpriseDataDao.getById(peEnterpriseData.getPeId());
			BeanUtil.copyProperties(peEnterpriseData, peEnterpriseDataTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			peEnterpriseDataDao.update(peEnterpriseDataTemp);
		}else{
			if (StringUtils.isNotEmpty(peEnterpriseData.getPeCode())){
				peEnterpriseData.setPeId(peEnterpriseData.getPeCode());
			}
		 	peEnterpriseData = (ZpPollutionEnterpriseData) EmptyStringToNullUtil.emptyStringToNull(peEnterpriseData);
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

	public List<ZpPollutionEnterpriseData> getCompnentPeEnterpriseDatasListByEnterpriseName(String enterpriseName) {
		String hql = "select obj from ZpPollutionEnterpriseData obj";
		if(enterpriseName!=null && !"".equals(enterpriseName)) {
			hql = hql + " where obj.peName like'%"+enterpriseName+"%'";
		}
        return peEnterpriseDataDao.createQuery(hql).getResultList();
	}
	
}
