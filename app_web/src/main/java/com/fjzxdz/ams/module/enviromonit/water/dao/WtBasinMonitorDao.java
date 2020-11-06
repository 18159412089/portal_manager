package com.fjzxdz.ams.module.enviromonit.water.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtBasinMonitorEntity;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("wtBasinMonitorDao")
public class WtBasinMonitorDao extends PagingDaoSupport<WtBasinMonitorEntity> {
}