/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlaneLDataDao;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtBasinPlanePDataDao;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtSectionPointBasinDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPointBasin;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionPointBasinParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionPointBasinService;
import com.fjzxdz.ams.util.WaterQualityUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 水系站点Service
 *
 * @author ZhangGQ
 * @version 2019-06-25
 */
@Component
@Transactional(rollbackFor = Exception.class)
public class WtSectionPointBasinServiceImpl implements WtSectionPointBasinService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(WtSectionPointBasinServiceImpl.class);

    @Autowired
    private WtSectionPointBasinDao wtSectionPointBasinDao;
    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private WtSectionPointServiceImpl wtSectionPointService;
    @Autowired
    private WtBasinPlanePDataDao wtBasinPlanePDataDao;
    @Autowired
    private WtBasinPlaneLDataDao wtBasinPlaneLDataDao;

    /**
     * 分页查询
     *
     * @param
     * @param page
     * @return
     */
    public Page<WtSectionPointBasin> listByPage(WtSectionPointBasinParam wtSectionPointBasinParam, Page<WtSectionPointBasin> page) {
        Page<WtSectionPointBasin> listPage = wtSectionPointBasinDao.listByPage(wtSectionPointBasinParam, page);
        return listPage;
    }

    /**
     * 更新或新增
     *
     * @param wtSectionPointBasin
     */
    public void save(WtSectionPointBasin wtSectionPointBasin) {
        if (StringUtils.isNotEmpty(wtSectionPointBasin.getUuid())) {
            wtSectionPointBasinDao.update(wtSectionPointBasin);
        } else {
            wtSectionPointBasin.setUuid(null);
            wtSectionPointBasinDao.save(wtSectionPointBasin);
        }
    }

    /**
     * 按uuid删除
     *
     * @param uuid
     */
    public void delete(String uuid) {
        wtSectionPointBasinDao.deleteById(uuid);
    }

    @Override
    public void batchUpdateWtBasinData(List<WtSectionMonthReport> reportList) {

        for (WtSectionMonthReport report : reportList) {
            String sectionCode = report.getSectionCode();
            WaterQualityEnum targetQuality = report.getTargetQuality();
            Integer GRADE = WaterQualityUtil.formatVal(targetQuality.toString());

            JSONObject point = wtSectionPointService.getPointByCode(sectionCode);
            String pointId = point.getString("id");

            Map<String, String> params = new HashMap<>();
            params.put("", pointId);
            List<WtSectionPointBasin> pointBasinList = wtSectionPointBasinDao.selectList("from WtSectionPointBasin where sectionPointId='" + pointId + "'");
            for (WtSectionPointBasin pointBasin : pointBasinList) {

                wtBasinPlanePDataDao.createNativeQuery("UPDATE WT_BASIN_PLANE_P_DATA SET GRADE=" + GRADE + " WHERE ID='" + pointBasin.getBasinId() + "'");
                wtBasinPlaneLDataDao.createNativeQuery("UPDATE WT_BASIN_PLANE_L_DATA SET GRADE=" + GRADE + " WHERE ID='" + pointBasin.getBasinId() + "'");
            }

        }
    }
}
