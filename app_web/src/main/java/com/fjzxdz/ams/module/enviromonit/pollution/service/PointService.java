package com.fjzxdz.ams.module.enviromonit.pollution.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;
import com.fjzxdz.ams.module.enviromonit.pollution.param.PointParam;
import com.fjzxdz.ams.module.enviromonit.pollution.param.TestDataParam2;

import cn.fjzxdz.frame.common.Page;


public interface PointService {

	Point getById(String uuid);

    Page<Point> listByPage(PointParam param, Page<Point> page);
    
    JSONArray getCompanyTree();

    JSONObject getData(String pointuuid) throws Exception;

    JSONObject getDataFlush(String pointuuid, TestDataParam2 param) throws Exception;
}
