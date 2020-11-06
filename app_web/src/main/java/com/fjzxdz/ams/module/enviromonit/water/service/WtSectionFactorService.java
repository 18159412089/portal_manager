package com.fjzxdz.ams.module.enviromonit.water.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public interface WtSectionFactorService {

    JSONArray getFactorList();

    JSONObject getFactorByName(String polluteName);

    void initRedisData();

    JSONObject getFactorByPolluteCode(String codePollute);
}
