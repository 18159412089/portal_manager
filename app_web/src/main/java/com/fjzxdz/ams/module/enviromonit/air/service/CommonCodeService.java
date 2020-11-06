package com.fjzxdz.ams.module.enviromonit.air.service;

import cn.fjzxdz.frame.pojo.R;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.entity.CommonCode;
import com.google.gson.JsonArray;

public interface CommonCodeService {
	
	JSONArray allCountyByName(String city);

	JsonArray getChildren(String id);

    JsonArray getTopTree(String code, String name);

	R save(CommonCode commonCode);

	CommonCode get(String id);

	R delete(String id);
}
