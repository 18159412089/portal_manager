package com.fjzxdz.ams.module.enviromonit.common.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.common.dao.PeCommonCodeDao;
import com.fjzxdz.ams.module.enviromonit.common.entity.PeCommonCode;
import com.fjzxdz.ams.module.enviromonit.common.param.PeCommonCodeParam;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.enterprise.param.PeEnterpriseDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;

@Component
@Transactional(rollbackFor=Exception.class)
public class PeCommonCodeService {
	
	@SuppressWarnings(value = { "unused" })
	private static Logger logger = LogManager.getLogger(PeCommonCodeService.class);

	@Autowired
	private PeCommonCodeDao peCommonCodeDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param peEnterpriseData
	 * @param page
	 * @return
	 */
	public Page<PeCommonCode> listByPage(PeCommonCodeParam peCommonCodeParam, Page<PeCommonCode> page) {
		Page<PeCommonCode> listPage = peCommonCodeDao.listByPage(peCommonCodeParam, page);
		return listPage;
	}
	
	public PeCommonCode getPeCommonCodeByCode(String code) {
		String sql = "select a.ID, a.CODE, a.NAME, a.PARENT_ID, a.SEQ, a.STATUS, a.CREATE_TIME from PE_COMMON_CODE a where a.CODE = ? order by a.SEQ asc";
		List<Object[]> list = simpleDao.createNativeQuery(sql, code).getResultList();
		PeCommonCode result = new PeCommonCode();
		if(list.size()>0) {
			Object[] array = list.get(0);
			result.setId((BigDecimal) array[0]);
			result.setCode((String) array[1]);
			result.setName((String) array[2]);
			result.setParentId((BigDecimal) array[3]);
			result.setSeq((BigDecimal) array[4]);
			result.setStatus((BigDecimal) array[5]);
			result.setCreateTime((Date) array[6]);
		}
		
		return result;
	}
	
	public PeCommonCode getPeCommonCodeById(String id){
		
		PeCommonCode peCommonCode = new PeCommonCode();
		try {
			peCommonCode = peCommonCodeDao.getById(id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return peCommonCode;
	}

	public List<PeCommonCode> getPeCommonCodeListByParentId(BigDecimal parentId) {
		//String hql = "from PeCommonCode obj where obj.parentId=?";
		String hql = "select obj from PeCommonCode obj where obj.parentId="+parentId;
		Query query = peCommonCodeDao.createQuery(hql);
		//query.setParameter(0, parentId);
		List<PeCommonCode> list = query.getResultList();
		System.out.println(query.toString());

		return list;
	}
}
