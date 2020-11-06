package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityPointParam;

import java.util.List;

public interface WtCityPointService {

	JSONArray getPointList(int type);
	JSONArray getPointsList(int type);
	JSONArray getPointRegionList();
	Page<WtCityPoint> listByPage(WtCityPointParam wtCityPointParam, Page<WtCityPoint> page);
	List<WtCityPoint> findListByCode(WtCityPointParam wtCityPointParam);
	JSONArray getPointListByRegion(int type, String regionCode);
}
