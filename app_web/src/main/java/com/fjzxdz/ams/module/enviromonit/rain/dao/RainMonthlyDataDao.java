package com.fjzxdz.ams.module.enviromonit.rain.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.rain.entity.RainMonthlyData;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("rainMonthlyDataDao")
public class RainMonthlyDataDao extends PagingDaoSupport<RainMonthlyData> {

}
