/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.hourdata.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.ValidateUtil;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import com.fjzxdz.ams.module.enviromonit.hourdata.dao.PeConHourDataDao;
import com.fjzxdz.ams.module.enviromonit.hourdata.entity.PeConHourData;
import com.fjzxdz.ams.module.enviromonit.hourdata.param.PeConHourDataParam;
import com.fjzxdz.ams.module.enviromonit.hourdata.service.PeConHourDataService;

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
import java.util.*;


/**
 * 自动监控小时浓度数据Controller
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/hourData/peconhourdata")
public class PeConHourDataController extends BaseController {

	@Autowired
	private PeConHourDataDao peConHourDataDao;
	@Autowired
	private PeConHourDataService peConHourDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("index")
	public String index() {
		return "/moudles/enviromonit/peenterprise/peConHourDataList";
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
		List<PeConHourData> peConHourDataListByOutputId = peConHourDataService.getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "小时监测数据");
		columnMap.put("fitColumns", "监测时间");
		columnMap.put("columns", "监测站点");
		columnMap.put("view", "溶解氧");
		ExcelExportUtil.exportExcel(response, columnMap, peConHourDataListByOutputId);
		return null;
	}
	/**
	 * 更新或新增
	 * @param peConHourData
	 * @return
	 */	
	@PreAuthorize("hasAnyAuthority('hourData:peconhourdata:add,hourData:peconhourdata:edit')")
	@RequestMapping("/savePeConHourData")
	@ResponseBody
	public R savePeConHourData(PeConHourData peConHourData) {
		try {
			String validateResult=ValidateUtil.validate(peConHourData);
			if(validateResult!=null) {
				return R.error(validateResult);
			}
			peConHourDataService.save(peConHourData);
		} catch (Exception e) {
			//return R.error(e.getMessage());
			return R.error(e);
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@PreAuthorize("hasAuthority('hourData:peconhourdata:delete')")
	@RequestMapping("/deletePeConHourData")
	@ResponseBody
	public R deletePeConHourData(@RequestParam(value = "uuid") String uuid) {
		try {
			peConHourDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e);
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getPeConHourData")
	@ResponseBody
	public Map<String, Object> getPeConHourData(@RequestParam(value = "uuid") String uuid) {
		PeConHourData peConHourData;
		try {
			peConHourData = peConHourDataDao.getById(uuid);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peConHourData", peConHourData);
	}
	
	/**
	 * 查询列表
	 * @param peConHourDataParam
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAuthority('hourData:peconhourdata:show')")
	@RequestMapping("/peConHourDataList")
	@ResponseBody
	public PageEU<PeConHourData> peConHourDataList(PeConHourDataParam peConHourDataParam, HttpServletRequest request) {
		Page<PeConHourData> page = peConHourDataService.listByPage(peConHourDataParam, pageQuery(request));
		return new PageEU<>(page);
	}

	/**
	 * 根据排口获取监测列表信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeConHourDataListByOutputId")
	@ResponseBody
	public JSONObject getPeConHourDataListByOutputId(String outputId, HttpServletRequest request) {
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
		
		
		List<PeConHourData> peConHourDataListByOutputId = peConHourDataService.getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		Integer maxSize = peConHourDataService.getPeConHourDataListSizeByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime);
		
		JSONArray peConDayDataJsonArray = new JSONArray();
		for(int i=0;peConHourDataListByOutputId.size()>i;i++){
			PeConHourData peConHourData = peConHourDataListByOutputId.get(i);
			String[] pluCodeArr = peConHourData.getPluCode().split(",");
			String[] chromaAvgArr = peConHourData.getChromaAvg().split(",");
			Timestamp measureTime = new Timestamp(peConHourData.getMeasureTime().getTime());
			
			JSONObject obj = new JSONObject();
			obj.put("measureTime", measureTime.toString());
			for(int j=0;j<pluCodeArr.length;j++) {
				String pluCode = pluCodeArr[j];
				String outputAvg = chromaAvgArr[j];

				obj.put(pluCode, outputAvg);
			}
			peConDayDataJsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", peConDayDataJsonArray);
		result.put("maxSize", maxSize);
		result.put("page", page);
		result.put("pageSize", pageSize);
		
		return result;
	}
}
