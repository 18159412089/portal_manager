/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.minutedata.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.minutedata.service.PeConMinuteDataService;

import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;
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
@RequestMapping(value = "/minuteData/peconminutedata")
public class PeConMinuteDataController extends BaseController {

	@Autowired
	private PeConMinuteDataService peConMinuteDataService;
	
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

	/*
    * 导出Excel
    * @param response
    * @param list
    * @return
   */
	@RequestMapping("/export")
	@ResponseBody
	public List<Map<String, Object>> export(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Timestamp queryMeasureStartTime = Utils.getTimestampZero();
		Timestamp queryMeasureEndTime = Utils.getTimestamp();
		int page = 1;
		int pageSize = 10;
		String outputId=request.getParameter("outputId");
		queryMeasureStartTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureStartTime"));
		queryMeasureEndTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureEndTime"));
		page = Integer.parseInt((String) request.getParameter("page"));
		pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
		cn.hutool.json.JSONObject json = peConMinuteDataService.getPeConMinuteDataListAndTableMetaByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		List<Map<String, Object>> result = new ArrayList<>();
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "分钟监测数据");
		columnMap.put("fitColumns", "监测时间");
		columnMap.put("columns", "监测站点");
		columnMap.put("view", "溶解氧");
		for(String str:json.keySet()){
			Map<String, Object> map=new HashMap<>();
			map.put(str,json.get(str));
			result.add(map);
		}
		ExcelExportUtil.exportExcel(response, columnMap, result);
		return null;
	}

	/**
	 * 根据排口获取监测列表数据及其表头信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeConMinuteDataListAndTableMetaByOutputId")
	@ResponseBody
	public JSONObject getPeConMinuteDataListAndTableMetaByOutputId(String outputId, HttpServletRequest request) {
		Timestamp queryMeasureStartTime = Utils.getTimestampZero();
		Timestamp queryMeasureEndTime = Utils.getTimestamp();
		int page = 1;
		int pageSize = 10;
		//获取查询参数
		try {
			 if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureStartTime"))) {
				queryMeasureStartTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureStartTime"));
			} 
			if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureEndTime"))) {
					queryMeasureEndTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureEndTime"));
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
		
		cn.hutool.json.JSONObject peConMinuteDataListAndTableMeta = peConMinuteDataService.getPeConMinuteDataListAndTableMetaByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		Integer maxSize = peConMinuteDataService.getPeConMinuteDataListSizeByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime);
		
		JSONObject result = new JSONObject();
		result.put("data", peConMinuteDataListAndTableMeta);
		result.put("maxSize", maxSize);
		result.put("page", page);
		result.put("pageSize", pageSize);
		
		return result;
	}
}
