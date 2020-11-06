package com.fjzxdz.ams.zphb.module.hbdc.service.impl;


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentAttachDao;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentDebriefingDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefing;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefingParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentDebriefingService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor=Exception.class)
public class ZpEnvironmentDebriefingServiceImpl implements ZpEnvironmentDebriefingService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ZpEnvironmentDebriefingServiceImpl.class);
	
	@Autowired
	private EnvironmentDebriefingDao debriefingDao;
	
	@Autowired
	private EnvironmentAttachDao attachDao;
	
	@Autowired
	private SimpleDao simpleDao;

	@Override
	public Page<EnvironmentDebriefing> listByPage(EnvironmentDebriefingParam param, Page<EnvironmentDebriefing> page) {
		return debriefingDao.listByPage(param, page);
	}

	@Override
	public void save(EnvironmentDebriefing debriefing) {
		if(ToolUtil.isEmpty(debriefing.getUuid())) {
			debriefing.setUuid(null);
			debriefingDao.save(debriefing);
		}else {
			EnvironmentDebriefing temp = debriefingDao.getById(debriefing.getUuid());
			temp.setEnable(debriefing.getEnable());
			temp.setLatitude(debriefing.getLatitude());
			temp.setLongitude(debriefing.getLongitude());
			temp.setName(debriefing.getName());
			temp.setStatus(debriefing.getStatus());
			temp.setActime(debriefing.getActime());
			temp.setAttime(debriefing.getAttime());
			temp.setCity(debriefing.getCity());
			temp.setCode(debriefing.getCode());
			temp.setIsover(debriefing.getIsover());
			temp.setOvertime(debriefing.getOvertime());
			temp.setPctime(debriefing.getPctime());
			temp.setActime(debriefing.getActime());
			temp.setTimelimit(debriefing.getTimelimit());
			if(ToolUtil.isNotEmpty(debriefing.getPicture())) {
				if(!debriefing.getPicture().equals(temp.getPicture())) {
					if(ToolUtil.isNotEmpty(temp.getPicture()))
						attachDao.deleteByUuid(temp.getPicture());
					temp.setPicture(debriefing.getPicture());
				}
			}
			debriefingDao.update(temp);
		}
	}

	@Override
	public EnvironmentDebriefing getById(String uuid) {
		return debriefingDao.getById(uuid);
	}

	@Override
	public List<EnvironmentDebriefing> debriefingList(EnvironmentDebriefingParam param) {
		List<EnvironmentDebriefing> list = debriefingDao.selectList("from EnvironmentDebriefing where enable=1");
		if(ToolUtil.isNotEmpty(list))
			return list;
		return new ArrayList<>();
	}

	@Override
	public String getDescribe() {
		List<Object[]> debriefings = simpleDao.createNativeQuery("select * from ENVIRONMEENT_DEBRIEFING where enable=1").getResultList();
		if(ToolUtil.isNotEmpty(debriefings)) {
			StringBuffer result = new StringBuffer();
			StringBuffer str2 = new StringBuffer();
			StringBuffer str1 = new StringBuffer();
			StringBuffer str0 = new StringBuffer();
			int i = 0;
			int j = 0;
			int k = 0;
			for(Object[] debriefing : debriefings) {
				if("2".equals(debriefing[5].toString())) {
					str2.append(debriefing[1].toString()+"、");
					i++;
				}
				if("1".equals(debriefing[5].toString())) {
					str1.append(debriefing[1].toString()+"、");
					j++;
				}
				if("0".equals(debriefing[5].toString())) {
					str0.append(debriefing[1].toString()+"、");
					k++;
				}
			}
			if(i!=0) {
				result.append("完成项目("+i+"个)：").append(str2.substring(0, str2.length()-1)+";");
				
			}
			if(j!=0) {
				result.append("整治中项目("+j+"个)：").append(str1.substring(0, str1.length()-1)+";");
				
			}
			if(k!=0) {
				result.append("滞后项目("+k+"个)：").append(str0.substring(0, str0.length()-1)+";");
				
			}
			return result.toString();
		}
		return "";
	}

	

}
