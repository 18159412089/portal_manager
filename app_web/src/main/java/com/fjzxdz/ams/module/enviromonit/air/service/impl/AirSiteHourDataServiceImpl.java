/*
 * Copyright (c) 2015-2020 FuJianZhongXingDianzi. All Rights Reserved.
 *
 * This software is the confidential and proprietary information of
 * Founder. You shall not disclose such Confidential Information
 * and shall use it only in accordance with the terms of the agreements
 * you entered into with Founder.
 *
 */
package com.fjzxdz.ams.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirSiteHourDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataService;
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
public class AirSiteHourDataServiceImpl implements AirSiteHourDataService {
    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(AirSiteHourDataService.class);

    @Autowired
    private AirSiteHourDataDao airSiteHourDataDao;

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: listByPage</p>
     * <p>Description: </p>
     *
     * @param airSiteHourDataParam
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.air.service.AirSiteHourDataServiceA#listByPage(com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<AirSiteHourData> listByPage(AirSiteHourDataParam airSiteHourDataParam, Page<AirSiteHourData> page) {
        Page<AirSiteHourData> listPage = airSiteHourDataDao.listByPage(airSiteHourDataParam, page);
        return listPage;
    }

    @Override
    public Page<AirSiteHourData> alllistByPage(AirSiteHourDataParam param, Page<AirSiteHourData> page) {
        StringBuilder where = new StringBuilder(" where ");
        if (ToolUtil.isNotEmpty(param.getStartTime())) {
            where.append(" a.checktime >= TO_DATE('" + param.getStartTime() + "','yyyy-mm-dd hh24:mi:ss') AND "
                    + "a.checktime <= TO_DATE('" + param.getEndTime() + "','yyyy-mm-dd hh24:mi:ss') ");
            if (ToolUtil.isNotEmpty(param.getPOSCODE())) {
                where.append(" AND a.poscode IN (" + SqlUtil.toSqlStr(param.getPOSCODE()) + ") ");
            }
            if (ToolUtil.isNotEmpty(param.getPOTCODE())) {
                where.append(" AND a.potcode IN (" + SqlUtil.toSqlStr(param.getPOTCODE()) + ")");
            }
        } else {
            where.append("1 = 1");
            String currentStartTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 00:00:00";
            String currentEndTime =  DateUtil.getDay(DateUtil.getAfterDayDate("-1"))+" 23:59:59";
            where.append("and a.checktime >= TO_DATE('" + currentStartTime + "','yyyy-mm-dd hh24:mi:ss') AND "
                    + "a.checktime <= TO_DATE('" + currentEndTime + "','yyyy-mm-dd hh24:mi:ss') ");
            if (ToolUtil.isNotEmpty(param.getPOSCODE())) {
                where.append(" AND a.poscode IN (" + SqlUtil.toSqlStr(param.getPOSCODE()) + ") ");

            }
            if (ToolUtil.isNotEmpty(param.getPOTCODE())) {
                where.append(" AND a.potcode IN (" + SqlUtil.toSqlStr(param.getPOTCODE()) + ")");
            }
        }
        StringBuilder sql = new StringBuilder(" SELECT a.areaname,a.state,a.poscode,a.windspd,a.potcode,a.sareaname,a.temp,a.pressure,a.potname,a.humi,TO_CHAR(a.checktime,'yyyy-mm-dd hh24:mi:ss') as DATATIME  ");
        sql.append(" FROM AIR_SITE_HOUR_DATA a ");
        sql.append(where);
        sql.append(" ORDER BY a.checktime DESC  ");

        return simpleDao.listNativeByPage(sql.toString(), page);
    }

}
