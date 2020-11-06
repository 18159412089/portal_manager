package cn.fjzxdz.frame.service.sys;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.JsonArray;

import cn.fjzxdz.frame.entity.core.Dept;

public interface DeptService {

    JsonArray getChildren(String id);

    JsonArray getTopTwoTree();

    Dept getDeptByUuid(String uuid);

    void save(Dept dept);

    Dept getById(String uuid);

    JSONArray getDeptTree(String id, Integer enable, Integer openIndex);

	cn.hutool.json.JSONArray getSynDeptTree(String id, Integer enable) throws Exception;
    
    JSONArray getDeptUserTree(String id, Integer enable, Integer openIndex);

	StringBuilder selectChindrenDeptUuid(List<Dept> allDept);

	List<Dept> selectChindrenDept(String deptid);
	
	void changeDeptName(String uuid,String oldname,String newname);

	void changeDeptPid(String uuid, String oldpid,String newpid,String oldname,String newname);

	void save2(Dept dept);

	List<Dept> getDeptByUserId(String userId);

	JsonArray getTopTwoTreeByEnable(int enable);

	JsonArray getChildrenByEnable(String id, int enable);

}
