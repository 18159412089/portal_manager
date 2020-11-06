package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthDataParam;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthReportParam;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface WtSectionMonthReportService {

	Page<Map<String, Object>> getPageList(WtSectionMonthReportParam param, Page<Map<String, Object>> page);

    void generateWtSectionMonthReport(List<WtSectionMonthData> list);

    void batchSaveWtSectionMonthReport(List<WtSectionMonthReport> reportList);
}
