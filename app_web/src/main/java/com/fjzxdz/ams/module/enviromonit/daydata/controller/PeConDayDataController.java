/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.daydata.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.daydata.dao.PeConDayDataDao;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import com.fjzxdz.ams.module.enviromonit.daydata.param.PeConDayDataParam;
import com.fjzxdz.ams.module.enviromonit.daydata.service.PeConDayDataService;

import com.fjzxdz.ams.module.enviromonit.hourdata.entity.PeConHourData;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 自动监控日浓度数据Controller
 * @author slq
 * @date 2019-02-12
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/dayData/pecondaydata")
public class PeConDayDataController extends BaseController {

	@Autowired
	private PeConDayDataDao peConDayDataDao;
	@Autowired
	private PeConDayDataService peConDayDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("index")
	public String index() {
		return "/moudles/enviromonit/peenterprise/peConDayDataList";
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getPeConDayData")
	@ResponseBody
	public Map<String, Object> getPeConDayData(@RequestParam(value = "uuid") String uuid) {
		PeConDayData peConDayData;
		try {
			peConDayData = peConDayDataDao.getById(uuid);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peConDayData", peConDayData);
	}
	
	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/peConDayDataList")
	@ResponseBody
	public PageEU<PeConDayData> peConDayDataList(PeConDayDataParam peConDayDataParam, HttpServletRequest request) {
		Page<PeConDayData> page = peConDayDataService.listByPage(peConDayDataParam, pageQuery(request));
		return new PageEU<>(page);
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
		List<PeConDayData> peConDayDatasList = peConDayDataService.getPeConDayDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "日监测数据");
		columnMap.put("fitColumns", "监测时间");
		columnMap.put("columns", "监测站点");
		columnMap.put("view", "溶解氧");
		ExcelExportUtil.exportExcel(response, columnMap, peConDayDatasList);
		return null;
	}
	
	/**
	 * 根据排口ID获取天数据
	 * @param
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/getPeConDayDataListByOutputId")
	@ResponseBody
	public JSONObject getPeConDayDataListByOutputId(String outputId, HttpServletRequest request) {
		Timestamp queryMeasureStartTime = Utils.getTimestampZero();
		Timestamp queryMeasureEndTime = Utils.getTimestamp();
		int page = 1;
		int pageSize = 10;

		//获取查询参数
		if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureStartTime"))) {
			try {
				queryMeasureStartTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureStartTime"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		if(StringUtils.isNotEmpty((String)request.getParameter("queryMeasureEndTime"))) {
			try {
				queryMeasureEndTime = Utils.parseTimestamp((String) request.getParameter("queryMeasureEndTime"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(StringUtils.isNotEmpty((String)request.getParameter("page"))) {
			page = Integer.parseInt((String) request.getParameter("page"));
		} 
		if(StringUtils.isNotEmpty((String)request.getParameter("pageSize"))) {
			pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
		} 
		List<PeConDayData> peConDayDatasList = peConDayDataService.getPeConDayDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		Integer peConDayDatasListSize = peConDayDataService.getPeConDayDataListSizeByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime);
		
		JSONArray peConDayDataJsonArray = new JSONArray();
		for(int i=0;peConDayDatasList.size()>i;i++){
			PeConDayData peConDayData = peConDayDatasList.get(i);
			String[] pluCodeArr = peConDayData.getPluCode().split(",");
			String[] outputAvgArr = peConDayData.getOutputAvg().split(",");
			Timestamp measureTime = new Timestamp(peConDayData.getMeasureTime().getTime());
			
			JSONObject obj = new JSONObject();
			obj.put("measureTime", measureTime.toString());
			for(int j=0;j<pluCodeArr.length;j++) {
				String pluCode = pluCodeArr[j];
				String outputAvg = outputAvgArr[j];

				obj.put(pluCode, outputAvg);
			}
			peConDayDataJsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		
		result.put("data", peConDayDataJsonArray);
		result.put("maxSize", peConDayDatasListSize);
		result.put("page", page);
		result.put("pageSize", pageSize);
		
		return result;
	}
}
