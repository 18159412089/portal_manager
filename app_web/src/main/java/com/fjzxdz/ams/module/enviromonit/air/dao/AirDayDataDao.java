package com.fjzxdz.ams.module.enviromonit.air.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.air.entity.AirDayData;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
/**
 * 
 * 空气日数据Dao 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:02:57
 */
@Repository("airDayDataDao")
public class AirDayDataDao extends PagingDaoSupport<AirDayData> {

}
