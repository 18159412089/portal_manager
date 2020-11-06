/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.minutedata.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.minutedata.service.PeConMinuteDataService;

import com.fjzxdz.ams.zphb.module.enviromonit.minutedata.service.ZpPollutionConMinuteDataService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import java.util.*;


/**
 * 自动监控小时浓度数据Controller
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/minuteData/peconminutedata")
public class ZpPollutionConMinuteDataController extends BaseController {

	@Autowired
	private ZpPollutionConMinuteDataService peConMinuteDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index(ModelAndView modelAndView) {
		modelAndView.setViewName("/moudles/enviromonit/peenterprise/peConMinuteDataList");
		return modelAndView;
	}

    /**
     * 获取企业监测点位树
     * @param
     * @return
     */
    @RequestMapping("/getPeEnterpriseDatasTreeList")
    @ResponseBody
    public cn.hutool.json.JSONArray getPeEnterpriseDatasTreeList(String enterpriseName) {
    	enterpriseName = com.alibaba.druid.util.StringUtils.isEmpty(enterpriseName)   ? "" :enterpriseName;
    	return peConMinuteDataService.getPeEnterpriseDatasTreeList(enterpriseName);
    }

	/**
	 * 根据排口获取监测列表数据及其表头信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getPollutionConMinuteDataListAndTableMetaByOutputId")
	@ResponseBody
	public JSONObject getPeConMinuteDataListAndTableMetaByOutputId(String outputId, HttpServletRequest request) {
		String queryMeasureStartTime = Utils.getTimestampZero().toString();
		String queryMeasureEndTime = Utils.getTimestamp().toString();
		int page = 1;
		int pageSize = 10;
		//获取查询参数
		try {
			 if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureStartTime"))) {
				queryMeasureStartTime = (String) request.getParameter("queryMeasureStartTime");
			} 
			if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureEndTime"))) {
					queryMeasureEndTime = ((String) request.getParameter("queryMeasureEndTime"));
			} 
			if(StringUtils.isNotEmpty((String)request.getParameter("page"))) {
				page = Integer.parseInt((String) request.getParameter("page"));
			} 
			if(StringUtils.isNotEmpty((String)request.getParameter("pageSize"))) {
				pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		cn.hutool.json.JSONObject peConMinuteDataListAndTableMeta = peConMinuteDataService.getPollutionConMinuteDataListAndTableMetaByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		int total = peConMinuteDataService.getPollutionConMinuteDataListSizeByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime);
		JSONObject result = new JSONObject();
		result.put("data", peConMinuteDataListAndTableMeta);
		result.put("maxSize",total);
		result.put("page", page);
		result.put("pageSize", pageSize);
		
		return result;
	}
}
