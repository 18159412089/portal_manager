/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.parsingpig.service;

import cn.fjzxdz.frame.utils.EmptyStringToNullUtil;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDutyUser;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import com.fjzxdz.ams.zphb.parsingpig.entity.ParsingPig;
import com.fjzxdz.ams.zphb.parsingpig.dao.ParsingPigDao;
import com.fjzxdz.ams.zphb.parsingpig.param.ParsingPigParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 养殖业管理Service
 * @author shenlongqin
 * @version 2019-10-14
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ParsingPigService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ParsingPigService.class);

	@Autowired
	private ParsingPigDao parsingPigDao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param parsingPig
	 * @param page
	 * @return
	 */
	public Page<ParsingPig> listByPage(ParsingPigParam parsingPigParam, Page<ParsingPig> page) {
		Page<ParsingPig> listPage = parsingPigDao.listByPage(parsingPigParam, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param parsingPig
	 */
	public void save(ParsingPig parsingPig) {
		if (StringUtils.isNotEmpty(parsingPig.getId())) {
			parsingPigDao.update(parsingPig);
		}else{
			parsingPig = (ParsingPig) EmptyStringToNullUtil.emptyStringToNull(parsingPig);
			parsingPig.setId(String.valueOf(getParsingPigMaxId()));
			parsingPigDao.save(parsingPig);
		}
	}

	/**
	 * 导入数据保存
	 * @param result
	 * @return
	 */
	public String save(String[][] result) {
		List<ParsingPig> list = new ArrayList<ParsingPig>();
		for (int i = 0; i < result.length; i++) {
			String[] row = result[i];
			ParsingPig parsingPig = new ParsingPig();
			parsingPig.setNc(row[1]);
			parsingPig.setYzc(row[2]);
			parsingPig.setFrdb(row[3]);
			parsingPig.setLxdh(row[4]);
			parsingPig.setHpgm(row[5]);
			parsingPig.setWsba(row[6]);
			parsingPig.setZyss(row[7]);
			parsingPig.setBsdm(row[8]);
			parsingPig.setYzdm(row[9]);
			parsingPig.setSfz(row[10]);
			parsingPig.setXydm(row[11]);
			parsingPig.setHgzh(row[12]);
			parsingPig.setXkzh(row[13]);
			parsingPig.setXxdz(row[14]);
			parsingPig.setJd(row[15]);
			parsingPig.setWd(row[16]);
			parsingPig.setEpCode(row[17]);
			parsingPig.setChannelIds(row[18]);
			parsingPig.setSeqno(Long.valueOf(row[19]));
			parsingPig.setId(String.valueOf(getParsingPigMaxId()));
			list.add(parsingPig);
		}
		parsingPigDao.saveBatch(list);
		return "";
	}

	/**
	 * 按uuid删除
	 * @param id
	 */
	public void delete(String id) {
		parsingPigDao.deleteById(id);
	}

	private int getParsingPigMaxId() {
		String sql = "select max(to_number(ID)) from ZP_POLLUTION_RAISING_PIG";
		String maxIdStr = simpleDao.createNativeQuery(sql).getSingleResult().toString();
		int maxId = Integer.valueOf(maxIdStr)+1;
		return maxId;
	}
}
