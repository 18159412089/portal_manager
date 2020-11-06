package com.fjzxdz.ams.zphb.module.hbdc.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.debriefing.dao.CommonAttachDao;
import com.fjzxdz.ams.module.debriefing.entity.CommonAttachment;
import com.fjzxdz.ams.module.debriefing.param.CommonAttachmentParam;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpStandingBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 
 * 环保督察 具体台账 Service 实现类
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午10:04:43
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpStandingBookServiceImpl implements ZpStandingBookService {

	@Autowired
	private SimpleDao simpleDao;

	@Autowired
	private CommonAttachDao commonAttachDao;
	
	/**
	 * 
	 * <p>Title: getSubClass</p>   
	 * <p>Description: 获取大类对应的小类</p>   
	 * @param type
	 * @return   
	 * @see ZpStandingBookService#getSubClass(String)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getSubClass(String type) {
		// TODO Auto-generated method stub
		String sql = "";
		if ("0".equals(type)) {
			sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE RELATION = 'task'";
		} else if ("1".equals(type)) {
			sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE RELATION = 'ENVIRONMEENT_RECTIFITION' AND CODE = 'ENVIRONMEENT_RECTIFITION_02'";
		}
		List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
		return list;
	}

	/**
	 *
	 * <p>Title: listByPage</p>
	 * <p>Description: 获取台账信息</p>
	 * @param param
	 * @param page
	 * @return
	 * @see ZpStandingBookService#listByPage(CommonRelationTableParam, Page)
	 */
	@Override
	public Page<Map<String, Object>> listByPage(CommonRelationTableParam param, Page<Map<String, Object>> page) {
		// TODO Auto-generated method stub
		String where = "";
		if (ToolUtil.isNotEmpty(param.getName()) && !("").equals(param.getName())) {
			where = " name like '%" + param.getName() + "%' and ";
		}

		String sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE " + where
				+ " (CODE NOT IN 'ENVIRONMEENT_RECTIFITION_01'  OR CODE IS NULL) and (RELATION <> 'NUM_OF_ROUND_ZZ' or RELATION <> 'NUM_OF_ROUND_ZP')AND RELATION IS NOT NULL order by CREATE_DATE desc";

		return simpleDao.listNativeByPage(sql, page);
	}

	/**
	 *
	 * <p>Title: save</p>
	 * <p>Description: 保存文件信息</p>
	 * @param commonAttach
	 * @see ZpStandingBookService#save(CommonAttachment)
	 */
	@Override
	public void save(CommonAttachment commonAttach) {
		if (ToolUtil.isEmpty(commonAttach.getUuid())) {
			commonAttach.setUuid(null);
			commonAttachDao.save(commonAttach);
		}

	}

	/**
	 *
	 * <p>Title: listByPage</p>
	 * <p>Description: 获取文件信息</p>
	 * @param param
	 * @param page
	 * @return
	 * @see ZpStandingBookService#listByPage(CommonAttachmentParam, Page)
	 */
	@Override
	public Page<CommonAttachment> listByPage(CommonAttachmentParam param, Page<CommonAttachment> page) {

		return commonAttachDao.listByPage(param, page);
	}

}
