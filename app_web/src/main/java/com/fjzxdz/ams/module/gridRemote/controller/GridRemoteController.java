package com.fjzxdz.ams.module.gridRemote.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.utils.OtherDBSimpleCurdUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * 网格化远程数据接口调用服务
 * @Author   gsq
 * @Version   1.0 
 * @CreateTime 2019年7月15日 11:06:49
 */
@Controller
@RequestMapping("/gridRemote/service")
@Secured({ "ROLE_USER" })
public class GridRemoteController extends BaseController {

    /**
     * 获取ZZEnvironmentalMessage系统中的网格员总数
     * @return
     * @throws Exception
     */
    @RequestMapping("/getAllUserNum")
    @ResponseBody
    public JSONObject getAllUserNum() throws Exception {
        cn.hutool.json.JSONArray reArray = OtherDBSimpleCurdUtil.findBySQL("ZZEnvironmentalMessage", "environmentalMessage_all_user_num", new HashMap<String, Object>());
        String userAllNum = reArray.getJSONObject(0).getStr("userAllNum");

        JSONObject data = new JSONObject();
        data.put("userAllNum", userAllNum);
        return data;
    }

    /**
     * 获取ZZProblemProcessing系统中的一般事件总数(待处理和已处理)和待处理一般事件总数
     * @return
     * @throws Exception
     */
    @RequestMapping("/getCommonlyCaseNum")
    @ResponseBody
    public JSONObject getCommonlyCaseNum() throws Exception {
        cn.hutool.json.JSONArray reArray = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "problemProcessing_commonly_case_num", new HashMap<String, Object>());
        cn.hutool.json.JSONObject re = reArray.getJSONObject(0);
        String registerCommonlyCaseNum = re.getStr("registerCommonlyCaseNum");
        String commonlyCaseNum = re.getStr("commonlyCaseNum");

        JSONObject data = new JSONObject();
        data.put("registerCommonlyCaseNum", registerCommonlyCaseNum);
        data.put("commonlyCaseNum", commonlyCaseNum);
        return data;
    }

    /**
     * 分页获取ZZProblemProcessing系统中的一般事件列表
     * @return
     * @throws Exception
     */
    @RequestMapping("/getCommonlyCaseList")
    @ResponseBody
    public JSONObject getCommonlyCaseList() throws Exception {
        Integer rows = 20;
        Integer page = 0;

        StringBuilder whereStr2 = new StringBuilder(" where a.rn > " + page * rows + " and a.rn <= " + (page + 1) * rows);

        String columnStr = " b.*," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_SOURCE_NAME', b.[source]) AS [sourceName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[majorTypeId]) AS [majorTypeIdName]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_PROBLEM_TYPE_NAME', b.[smallTypeId]) AS [smallTypeIdName]," +
                "dbo.fjzx_frame_fn_format_date_time(b.[reportTime]) AS [reportFormatTime]," +
                "dbo.fjzx_frame_fn_get_system_code_name('PROBLEM_PROCESSING_OPERATION', b.[status]) AS [statusName]," +
                "dbo.[fjzx_frame_fn_get_system_code_name]('USER', b.[createBy]) AS  createByName," +
                "dbo.fn_web_common_get_department_of_organization_by_department(c.id) AS departmentIdName," +
                "dbo.fjzx_frame_fn_get_system_code_name('USER_LEVEL', c.departmentType) AS userLevel," +
                "COUNT(1) OVER() AS resultTotalCount " +
                "FROM web_xproject_problem_processing_case b " +
                "LEFT JOIN dbo.web_common_department_position d ON b.positionId=d.id " +
                "LEFT JOIN dbo.web_common_department c ON c.id=d.departmentId ";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("column", columnStr);
        paramMap.put("where2", whereStr2.toString());

        cn.hutool.json.JSONArray caseList = OtherDBSimpleCurdUtil.findBySQL("ZZProblemProcessing", "problemProcessing_commonly_case_list_by_page", paramMap);

        JSONObject data = new JSONObject();
        data.put("rows", caseList);
        data.put("total", caseList.getJSONObject(0).get("resultTotalCount"));
        data.put("page", page + 1);
        data.put("pageSize", rows);

        return data;
    }

}
