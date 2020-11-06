/*
 * Copyright (c) 2015-2020 FuJianZhongXingDianzi. All Rights Reserved.
 *
 * This software is the confidential and proprietary information of
 * Founder. You shall not disclose such Confidential Information
 * and shall use it only in accordance with the terms of the agreements
 * you entered into with Founder.
 *
 */
package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirSiteHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpAirSiteHourDataService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 这里描述这个类是做什么业务
 *
 * @Author zhongyunlong
 * @Version 1.0
 * @CreateTime 2019年4月30日 上午9:53:56
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ZpAirSiteHourDataServiceImpl implements ZpAirSiteHourDataService {
    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(AirSiteHourDataService.class);

    @Autowired
    private AirSiteHourDataDao airSiteHourDataDao;

    /**
     * <p>Title: listByPage</p>
     * <p>Description: </p>
     *
     * @param airSiteHourDataParam
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataServiceA#listByPage(AirSiteHourDataParam, Page)
     */
    @Override
    public Page<AirSiteHourData> listByPage(AirSiteHourDataParam airSiteHourDataParam, Page<AirSiteHourData> page) {
        Page<AirSiteHourData> listPage = airSiteHourDataDao.listByPage(airSiteHourDataParam, page);
        return listPage;
    }
}
