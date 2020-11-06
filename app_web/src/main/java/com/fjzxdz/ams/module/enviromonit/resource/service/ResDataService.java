package com.fjzxdz.ams.module.enviromonit.resource.service;

import cn.fjzxdz.frame.entity.core.Role;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.resource.entity.ResData;
import com.google.gson.JsonArray;

import java.util.List;


public interface ResDataService {

    void save(ResData menu);

    ResData update(ResData menu);

    void deleteById(String id);

    List<Role> findRoleByUrl(String url);

    JsonArray getChildren(String id);

    JsonArray getTopTwoTree();

    JSONArray getIndexMenu(String userId);

    JSONArray getRootMenu();

    JSONArray getMenuTree(String id, Integer enable, Integer openIndex);

    ResData getById(String id);
}
