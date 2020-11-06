package com.fjzxdz.ams.module.enviromonit.air.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
/**
 * 
 * 空气站点Dao 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:04:49
 */
@Repository("airMonitorPoint")
public class AirMonitorPointDao extends PagingDaoSupport<AirMonitorPoint> {

}
