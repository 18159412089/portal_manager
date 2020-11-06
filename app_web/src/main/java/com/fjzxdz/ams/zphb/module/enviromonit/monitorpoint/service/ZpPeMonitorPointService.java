/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.dao.ZpPeMonitorPointDao;
import com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.entity.ZpPeMonitorPoint;
import com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.param.ZpPeMonitorPointParam;
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
public class ZpPeMonitorPointService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpPeMonitorPointService.class);

	@Autowired
	private ZpPeMonitorPointDao zpPeMonitorPointDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param zpPeMonitorPointParam
	 * @param page
	 * @return
	 */
	public Page<ZpPeMonitorPoint> listByPage(ZpPeMonitorPointParam zpPeMonitorPointParam, Page<ZpPeMonitorPoint> page) {
		Page<ZpPeMonitorPoint> listPage = zpPeMonitorPointDao.listByPage(zpPeMonitorPointParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param peMonitorPoint
	 */
	public void save(ZpPeMonitorPoint peMonitorPoint) {
		if (StringUtils.isNotEmpty(peMonitorPoint.getOutputId())) {
			ZpPeMonitorPoint peMonitorPointTemp = zpPeMonitorPointDao.getById(peMonitorPoint.getOutputId());
			BeanUtil.copyProperties(peMonitorPoint, peMonitorPointTemp,CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
			zpPeMonitorPointDao.update(peMonitorPointTemp);
		}else{
			if (StringUtils.isNotEmpty(peMonitorPoint.getCode())) {
				peMonitorPoint.setOutputId(peMonitorPoint.getCode());
			}
			peMonitorPoint = (ZpPeMonitorPoint)EmptyStringToNullUtil.emptyStringToNull(peMonitorPoint);
			zpPeMonitorPointDao.save(peMonitorPoint);
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		zpPeMonitorPointDao.deleteById(uuid);
	}
	/**
	 * 根据peId查询
	 * @param peId
	 */
	public List<ZpPeMonitorPoint> getPeMonitorPointListByPeId(String peId) {
		List<ZpPeMonitorPoint> peMonitorPointsList;
		peMonitorPointsList = zpPeMonitorPointDao.createQuery("select * from ZP_POLLUTION_MONITOR_POINT m where m.PE_ID=?",peId).getResultList();
		return peMonitorPointsList;
	}

	/**
	 *获取下拉排口信息
	 * @param
	 * @return
	 */
	public List<ZpPeMonitorPoint> getCompnentPeMonitorPointDatasList() {
		List<ZpPeMonitorPoint> peMonitorPointsList;
		peMonitorPointsList = zpPeMonitorPointDao.createQuery("select  obj  from ZpPeMonitorPoint  obj").getResultList();
		return peMonitorPointsList;
	}



}
