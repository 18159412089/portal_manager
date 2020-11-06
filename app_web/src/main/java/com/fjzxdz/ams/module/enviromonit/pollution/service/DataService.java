package com.fjzxdz.ams.module.enviromonit.pollution.service;

import java.util.List;

public interface DataService {

    /**
     * @Author lianhuinan
     * @Description //TODO(导入数据处理)
     * @Date 2019/10/11 0011 11:18
     * @param result
     * @return java.lang.String
     * @version 1.0
     **/
    String save(List<List<Object>> result, String deptPath) throws Exception;
}
