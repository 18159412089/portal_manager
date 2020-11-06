package com.fjzxdz.ams.module.enviromonit.pollution.dao;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import org.springframework.stereotype.Repository;


@Repository("pollutionInfoDataDao")
public class PollutionInfoDataDao extends PagingDaoSupport<PollutionInfoData> {
}
