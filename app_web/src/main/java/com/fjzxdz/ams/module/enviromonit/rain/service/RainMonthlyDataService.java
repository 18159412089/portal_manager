package com.fjzxdz.ams.module.enviromonit.rain.service;

import com.fjzxdz.ams.module.enviromonit.rain.entity.RainMonthlyData;
import com.fjzxdz.ams.module.enviromonit.rain.param.RainMonthlyDataParam;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;

public interface RainMonthlyDataService {
	Page<RainMonthlyData> listByPage(RainMonthlyDataParam param, Page<RainMonthlyData> page);

	R save(RainMonthlyData rainMonthlyData);

	RainMonthlyData getById(String uuid);

}
