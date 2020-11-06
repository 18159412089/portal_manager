/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factor.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.module.enviromonit.factor.dao.PeFactorDao;
import com.fjzxdz.ams.module.enviromonit.factor.entity.PeFactor;
import com.fjzxdz.ams.module.enviromonit.factor.param.PeFactorParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 污染源自动监控点位采集因子Service
 * @author htj
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PeFactorService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PeFactorService.class);

	@Autowired
	private PeFactorDao peFactorDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peFactor
	 * @param page
	 * @return
	 */
	public Page<PeFactor> listByPage(PeFactorParam peFactorParam, Page<PeFactor> page) {
		Page<PeFactor> listPage = peFactorDao.listByPage(peFactorParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peFactor
	 */
	public void save(PeFactor peFactor) {
		if (StringUtils.isNotEmpty(peFactor.getPluEqpId())) {
			PeFactor peFactorTemp = peFactorDao.getById(peFactor.getPluEqpId());
			BeanUtil.copyProperties(peFactor, peFactorTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			peFactorDao.update(peFactorTemp);
		}else{
			//peFactor.setUuid(null);
			peFactor = (PeFactor)EmptyStringToNullUtil.emptyStringToNull(peFactor);
			peFactorDao.save(peFactor);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peFactorDao.deleteById(uuid);
	}
	/**
	 * 根据outputId查询
	 * @param outputId
	 */
	public List<PeFactor> getPeFactorListByOutputId(String outputId) {
		List<PeFactor> peFactorList;
		peFactorList = peFactorDao.createQuery("from PeFactor f where f.outputId=?",outputId).getResultList();
		return peFactorList;
	}
}
