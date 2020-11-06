package com.fjzxdz.ams.module.debriefing.service;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentLetter;

import java.util.List;
import java.util.Map;

public interface EnvironmentLetterService {
    /**
     * create by: wudenglin
     * description: 查找办结状态数量按照区县来进行划分;
     * {
     * name: 'Desert',
     * type: 'bar',
     * label: labelOption,
     * data: [150, 232, 201, 154, 190]
     * }
     * create time: 2019/10/23 0023 13:58
     * @param type 轮次
     * @param userDeptName
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    Map<String, Object> countBJZTByXZQY(String type, String userDeptName);
    Map<String, Object> countBJZTByXZQYTest(String type, String userDeptName);

    /**
     * @param result
     * @return java.lang.String
     * @Author hyl
     * @Description //TODO(导入数据处理)
     * @Date 2019年10月23日11:19:33
     * @version 1.0
     **/
    String save(List<List<Object>> result) throws Exception;

    /**
     * 信访件汇总表查询条件下拉框列表
     *
     * @param type 字段名称
     * @param userDeptName
     * @return
     */
    List<Map> getTypeList(String type, String userDeptName);

    JSONObject countPieWrlx(String lc, String userDeptName);

    JSONObject countPieBjzt(String lc, String wrlx, String userDeptName);

    JSONObject getCount(EnvironmentLetter param);

    /**
     * 新增编辑事件
     * @param letter
     * @return
     */
    String saveLetter(EnvironmentLetter letter);
}
