package com.fjzxdz.ams.module.enviromonit.rain.service.impl;


import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.module.enviromonit.air.dao.AirMonitorPointDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.rain.dao.RainMonthlyDataDao;
import com.fjzxdz.ams.module.enviromonit.rain.entity.RainMonthlyData;
import com.fjzxdz.ams.module.enviromonit.rain.param.RainMonthlyDataParam;
import com.fjzxdz.ams.module.enviromonit.rain.service.RainMonthlyDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.LoginType;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.MD5Util;

@Service
@Transactional(rollbackFor = Exception.class)
public class RainMonthlyDataServiceImpl implements RainMonthlyDataService {

	@Autowired
	private RainMonthlyDataDao rainMonthlyDataDao;

	@Autowired
	private SimpleDao simpleDao;

	@Override
	public Page<RainMonthlyData> listByPage(RainMonthlyDataParam param, Page<RainMonthlyData> page) {
		// TODO Auto-generated method stub
		return rainMonthlyDataDao.listByPage(param, page);
	}

	public R save(RainMonthlyData rainMonthlyData) {
		List<RainMonthlyData> rainMonthlyDatas = rainMonthlyDataDao.selectListBy("time", rainMonthlyData.getTime());
		System.out.println(rainMonthlyDatas.size());
		if (StringUtils.isNotEmpty(rainMonthlyData.getUuid())) {
			RainMonthlyData rain = getById(rainMonthlyData.getUuid());
			if (!rainMonthlyData.getTime().equals(rain.getTime())) {
				if (rainMonthlyDatas.size() >= 1) {
					return R.error("该月份降雨量数据已存在");
				}
			}else {
				rain.setTime(rainMonthlyData.getTime());
				rain.setDays(rainMonthlyData.getDays());
				rain.setSunshineDuration(rainMonthlyData.getSunshineDuration());
				rain.setRainFall(rainMonthlyData.getRainFall());
				rainMonthlyDataDao.update(rain);
				return R.ok("修改降雨量数据成功");
			}
			
		} else {
			if (rainMonthlyDatas.size() >= 1) {
				return R.error("该月份降雨量数据已存在");
			}
			  rainMonthlyData.setUuid(UUID.randomUUID().toString());
			  rainMonthlyDataDao.save(rainMonthlyData);
		}
		return R.ok("添加降雨量数据成功");
	}

	@Override
	public RainMonthlyData getById(String uuid) {
		// TODO Auto-generated method stub
		
		return rainMonthlyDataDao.getById(uuid);
	}

	

	

}
