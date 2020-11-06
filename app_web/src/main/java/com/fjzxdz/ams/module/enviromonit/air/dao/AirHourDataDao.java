package com.fjzxdz.ams.module.enviromonit.air.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.air.entity.AirHourData;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
/**
 * 
 * 空气小时数据Dao
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:04:37
 */
@Repository("airHourDataDao")
public class AirHourDataDao extends PagingDaoSupport<AirHourData> {

}
