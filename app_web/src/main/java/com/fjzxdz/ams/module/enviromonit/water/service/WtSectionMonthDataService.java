package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthDataParam;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

public interface WtSectionMonthDataService {

	List<WtSectionMonthData> getListByCode(String pointCode);

	Page<Map<String, Object>> getPageList(WtSectionMonthDataParam param, Page<Map<String, Object>> page);

	Map<String, Object> getPassMonthAnalysis(WtSectionMonthDataParam param) throws ParseException;

    Page<WtSectionMonthData> listByPage(WtSectionMonthDataParam param, Page<WtSectionMonthData> page);

    void batchSaveWtSectionMonthData(List<WtSectionMonthData> list);

    List<JSONObject> getPolluteValueAverageBySectionCode(String sectionCode, Integer yearNumber, Integer monthNumber);
}
