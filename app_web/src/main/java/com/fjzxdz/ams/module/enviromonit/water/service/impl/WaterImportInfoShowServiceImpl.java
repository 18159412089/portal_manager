package com.fjzxdz.ams.module.enviromonit.water.service.impl;


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.water.entity.*;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterImportInfoShowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 水环境数据导入展示
 *
 * @Author huagnyanglai
 * @Version 1.0
 * @CreateTime 2019年9月12日10:38:46
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WaterImportInfoShowServiceImpl implements WaterImportInfoShowService {
    @Autowired
    private SimpleDao simpleDao;
    @Override
    public Page<Map<String, Object>> getWtptLivestockPageList(WtptLivestock param, Page<Map<String, Object>> page) {
        StringBuilder sb = new StringBuilder(" SELECT * FROM WTPT_LIVESTOCK WHERE 1=1 ");
        if (StringUtils.isNotEmpty(param.getYzcmc())) {
            sb.append(" AND YZCMC LIKE ").append(SqlUtil.toSqlStr_like(param.getYzcmc()));
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }

    @Override
    public Page<Map<String, Object>> getWtptPollutionFactorPageList(WtptPollutionFactor param, Page<Map<String, Object>> page) {
        StringBuilder sb = new StringBuilder(" select * from WTPT_POLLUTION_FACTOR WHERE 1=1  ");
        if (StringUtils.isNotEmpty(param.getDwmc())) {
            sb.append(" AND dwmc LIKE ").append(SqlUtil.toSqlStr_like(param.getDwmc()));
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }

    @Override
    public Page<Map<String, Object>> getWtptWastewaterOutletPageList(WtptWastewaterOutlet param, Page<Map<String, Object>> page) {
        StringBuilder sb = new StringBuilder(" select * from WTPT_WASTEWATER_OUTLET WHERE 1=1  ");
        if (StringUtils.isNotEmpty(param.getPwkmc())) {
            sb.append(" AND pwkmc LIKE ").append(SqlUtil.toSqlStr_like(param.getPwkmc()));
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }

    @Override
    public Page<Map<String, Object>> getWtptWastewaterPlantPageList(WtptWastewaterPlant param, Page<Map<String, Object>> page) {
        StringBuilder sb = new StringBuilder(" select * from WTPT_WASTEWATER_PLANT WHERE 1=1  ");
        if (StringUtils.isNotEmpty(param.getDwmc())) {
            sb.append(" AND dwmc LIKE ").append(SqlUtil.toSqlStr_like(param.getDwmc()));
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }

    @Override
    public Page<Map<String, Object>> getWtptWastewaterPageList(WtptWastewater param, Page<Map<String, Object>> page) {
        StringBuilder sb = new StringBuilder(" select * from WTPT_WASTEWATER  WHERE 1=1 ");
        if (StringUtils.isNotEmpty(param.getDwmc())) {
            sb.append(" AND dwmc LIKE ").append(SqlUtil.toSqlStr_like(param.getDwmc()));
        }
        return simpleDao.listNativeByPage(sb.toString(), page);
    }
}
