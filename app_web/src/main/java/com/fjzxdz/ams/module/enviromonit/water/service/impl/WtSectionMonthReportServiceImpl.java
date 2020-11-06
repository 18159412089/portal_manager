package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtSectionMonthReportDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthReportParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionMonthReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 在线水小时的数据服务功能
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:37:29
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtSectionMonthReportServiceImpl implements WtSectionMonthReportService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private WtSectionMonthReportDao wtSectionMonthReportDao;

    @Override
    public Page<Map<String, Object>> getPageList(WtSectionMonthReportParam param, Page<Map<String, Object>> page) {
        return null;
    }

    @Override
    public void generateWtSectionMonthReport(List<WtSectionMonthData> list) {

    }

    @Override
    public void batchSaveWtSectionMonthReport(List<WtSectionMonthReport> reportList) {

        wtSectionMonthReportDao.saveBatch(reportList);
    }
}
