/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.monitorpoint.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.dao.PeMonitorPointDao;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.entity.PeMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.param.PeMonitorPointParam;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * monitorPointService
 * @author htj
 * @date 2019-02-11
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class PeMonitorPointService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PeMonitorPointService.class);

	@Autowired
	private PeMonitorPointDao peMonitorPointDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peMonitorPointParam
	 * @param page
	 * @return
	 */
	public Page<PeMonitorPoint> listByPage(PeMonitorPointParam peMonitorPointParam, Page<PeMonitorPoint> page) {
		Page<PeMonitorPoint> listPage = peMonitorPointDao.listByPage(peMonitorPointParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peMonitorPoint
	 */
	public void save(PeMonitorPoint peMonitorPoint) {
		if (StringUtils.isNotEmpty(peMonitorPoint.getOutputId())) {
			PeMonitorPoint peMonitorPointTemp = peMonitorPointDao.getById(peMonitorPoint.getOutputId());
			BeanUtil.copyProperties(peMonitorPoint, peMonitorPointTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			peMonitorPointDao.update(peMonitorPointTemp);
		}else{
			//peMonitorPoint.setUuid(null);
			peMonitorPoint = (PeMonitorPoint)EmptyStringToNullUtil.emptyStringToNull(peMonitorPoint);
			peMonitorPointDao.save(peMonitorPoint);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		peMonitorPointDao.deleteById(uuid);
	}
	/**
	 * 根据peId查询
	 * @param peId
	 */
	public List<PeMonitorPoint> getPeMonitorPointListByPeId(String peId) {
		List<PeMonitorPoint> peMonitorPointsList;
		peMonitorPointsList = peMonitorPointDao.createQuery("select * from PE_MONITOR_POINT m where m.PE_ID=?",peId).getResultList();
		return peMonitorPointsList;
	}

	/**
	 *获取下拉排口信息
	 * @param
	 * @return
	 */
	public List<PeMonitorPoint> getCompnentPeMonitorPointDatasList() {
		List<PeMonitorPoint> peMonitorPointsList;
		peMonitorPointsList = peMonitorPointDao.createQuery("select  obj  from PeMonitorPoint  obj").getResultList();
		return peMonitorPointsList;
	}



}
