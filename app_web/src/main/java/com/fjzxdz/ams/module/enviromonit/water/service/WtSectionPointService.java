package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionPointParam;

public interface WtSectionPointService {

	JSONArray getPointList(int type);
	JSONArray getPointsList(int type);
    JSONObject getPointByCode(String code);

    void initRedisData();

    Page<WtSectionPoint> listByPage(WtSectionPointParam wtSectionPointParam, Page<WtSectionPoint> page);
}
