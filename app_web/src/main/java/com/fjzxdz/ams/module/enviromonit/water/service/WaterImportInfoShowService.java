package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.entity.*;

import java.util.Map;

public interface WaterImportInfoShowService {
    Page<Map<String, Object>> getWtptLivestockPageList(WtptLivestock param, Page<Map<String, Object>> page);

    Page<Map<String, Object>> getWtptPollutionFactorPageList(WtptPollutionFactor param, Page<Map<String, Object>> page);

    Page<Map<String, Object>> getWtptWastewaterOutletPageList(WtptWastewaterOutlet param, Page<Map<String, Object>> page);

    Page<Map<String, Object>> getWtptWastewaterPlantPageList(WtptWastewaterPlant param, Page<Map<String, Object>> page);

    Page<Map<String, Object>> getWtptWastewaterPageList(WtptWastewater param, Page<Map<String, Object>> page);
}
