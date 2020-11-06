package com.fjzxdz.ams.module.enviromonit.water.service;

import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;

import java.util.List;

public interface WtSectionPointBasinService {
    void batchUpdateWtBasinData(List<WtSectionMonthReport> reportList);
}
