package com.fjzxdz.ams.module.debriefing.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.debriefing.dao.EnvironmentAttachDao;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentDebriefDetailsDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefDetails;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefDetailsParam;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentDebriefDetailsService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor=Exception.class)
public class EnvironmentDebriefDetailsServiceImpl implements EnvironmentDebriefDetailsService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(EnvironmentDebriefDetailsServiceImpl.class);
	
	@Autowired
	private EnvironmentDebriefDetailsDao detailsDao;
	
	@Autowired
	private EnvironmentAttachDao attachDao;
	
	@Autowired
	private SimpleDao simpleDao;

	@Override
	public Page<EnvironmentDebriefDetails> listByPage(EnvironmentDebriefDetailsParam param, Page<EnvironmentDebriefDetails> page) {
		return detailsDao.listByPage(param, page);
	}

	@Override
	public void save(EnvironmentDebriefDetails details) {
		if(ToolUtil.isEmpty(details.getUuid())) {
			details.setUuid(null);
			detailsDao.save(details);
		}else {
			EnvironmentDebriefDetails temp = detailsDao.getById(details.getUuid());
			temp.setEnable(details.getEnable());
			temp.setDebriefing(details.getDebriefing());
			temp.setName(details.getName());
			temp.setStatus(details.getStatus());
			if(ToolUtil.isNotEmpty(details.getVideo())) {
				if(!(details.getVideo().equals(temp.getVideo()))) {
					attachDao.deleteByUuid(temp.getVideo());
					temp.setVideo(details.getVideo());
				}
			}
			detailsDao.update(temp);
		}
	}

	@Override
	public EnvironmentDebriefDetails getById(String uuid) {
		return detailsDao.getById(uuid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getByDebriefing(String debriefing) {
		Map<String, Object> map = new HashMap<>();
		List<Object[]> list = simpleDao.createNativeQuery("select * from (select a.name,a.PICTURE,b.NAME details,"
				+ "b.ATTACH_VIDEO,a.status,b.uuid,a.TIME_LIMIT,a.CITY,a.PLAN_CITY_TIME,a.AC_CITY_TIME,a.PLAN_TRADE_TIME,"
				+ "a.ACTUAL_TRADE_TIME,a.OVER_TIME,a.ISOVER,ROWNUM "
				+ "from ENVIRONMEENT_DEBRIEFING a LEFT JOIN ENVIRONMEENT_DEBRIEF_DETAILS b on a.UUID=b.DEBRIEFING "
				+ "where a.UUID=? and b.ENABLE=1 ORDER BY b.CREATE_DATE desc) WHERE ROWNUM=1 ", debriefing).getResultList();
		if(ToolUtil.isNotEmpty(list)) {
			map.put("name", list.get(0)[0]);
			map.put("picture", list.get(0)[1]);
			map.put("details", list.get(0)[2]);
			map.put("video", list.get(0)[3]);
			if(list.get(0)[4].equals("0")) {
				map.put("status", "滞后");
			} else if(list.get(0)[3].equals("1")) {
				map.put("status", "整治中");
			} else {
				map.put("status", "完成");
			}
			map.put("uuid", list.get(0)[5]);
			map.put("city", list.get(0)[7]);
			map.put("timelimit", list.get(0)[6]);
			map.put("pctime", list.get(0)[8]);
			map.put("actime", list.get(0)[9]);
			map.put("pttime", list.get(0)[10]);
			map.put("attime", list.get(0)[11]);
			map.put("overtime", list.get(0)[12]);
			map.put("isover", list.get(0)[13]);
		}
		return map;
	}

	/**
	 * 数组转sql in条件语句
	 * @param str
	 * @return
	 */
	public static String List2Sqlin(List<String> str) {
		StringBuffer sb = new StringBuffer();
		for (String s : str) {
			sb.append("'").append(s).append("'").append(",");
		}
		return sb.toString().substring(0, sb.length() - 1);
	}
}
