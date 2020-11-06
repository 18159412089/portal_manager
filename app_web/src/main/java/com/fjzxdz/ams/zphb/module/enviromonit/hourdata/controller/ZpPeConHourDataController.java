/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enviromonit.hourdata.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.ValidateUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.common.generate.utils.ObjectUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.zphb.module.enviromonit.hourdata.dao.ZpPeConHourDataDao;
import com.fjzxdz.ams.zphb.module.enviromonit.hourdata.entity.ZpPeConHourData;
import com.fjzxdz.ams.zphb.module.enviromonit.hourdata.param.ZpPeConHourDataParam;
import com.fjzxdz.ams.zphb.module.enviromonit.hourdata.service.ZpPeConHourDataService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * 自动监控小时浓度数据Controller
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/hourData/peconhourdata")
public class ZpPeConHourDataController extends BaseController {

	@Autowired
	private ZpPeConHourDataDao zpPeConHourDataDao;
	@Autowired
	private ZpPeConHourDataService zpPeConHourDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap map) throws Exception {
		String enterpriseName = "" ;
		String outputId = "" ;
		if(request.getParameter("enterpriseName") != null) {
			outputId = new String(request.getParameter("outputId").getBytes("iso8859-1"), "utf-8");
			enterpriseName = new String(request.getParameter("enterpriseName").getBytes("iso8859-1"), "utf-8");

		}
		map.put("enterpriseName", enterpriseName);
		map.put("outputId", outputId);
		return "/zphb/moudles/enviromonit/peenterprise/peConHourDataList";
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

		String outputId=request.getParameter("outputId");
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "小时监测数据");
		//columnMap.put("fitColumns", "监测时间");
		cn.hutool.json.JSONObject peConMinuteDataListAndTableMeta = zpPeConHourDataService.getPeConHourDataListByOutputIdExport(outputId,queryMeasureStartTime,queryMeasureEndTime);
		JSONArray clumnNameObj = (JSONArray) peConMinuteDataListAndTableMeta.get("clumnName");
		for(int i=0;i<clumnNameObj.size();i++){
			String fieldName = clumnNameObj.getJSONObject(i).getStr("field");
			String titleName = clumnNameObj.getJSONObject(i).getStr("title");
			columnMap.put(fieldName, titleName);
		}
		JSONArray valueObj = (JSONArray) peConMinuteDataListAndTableMeta.get("rows");
		List<JSONObject> peConHourDataListByOutputId = new ArrayList<JSONObject>();
		for(int i=0;i<valueObj.size();i++){
			JSONObject obj = valueObj.getJSONObject(i);
			//还未完成
			//Map<String, Object> dataMonitorMap = ObjectUtils.objectToMap(obj);
			peConHourDataListByOutputId.add(obj);
		}
		ExcelExportUtil.exportExcelObj(response, columnMap, peConHourDataListByOutputId);
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
	public R savePeConHourData(ZpPeConHourData peConHourData) {
		try {
			String validateResult=ValidateUtil.validate(peConHourData);
			if(validateResult!=null) {
				return R.error(validateResult);
			}
			zpPeConHourDataService.save(peConHourData);
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
			zpPeConHourDataService.delete(uuid);
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
		ZpPeConHourData peConHourData;
		try {
			peConHourData = zpPeConHourDataDao.getById(uuid);
		}catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peConHourData", peConHourData);
	}
	
	/**
	 * 查询列表
	 * @param zpPeConHourDataParam
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAuthority('hourData:peconhourdata:show')")
	@RequestMapping("/peConHourDataList")
	@ResponseBody
	public PageEU<ZpPeConHourData> peConHourDataList(ZpPeConHourDataParam zpPeConHourDataParam, HttpServletRequest request) {
		Page<ZpPeConHourData> page = zpPeConHourDataService.listByPage(zpPeConHourDataParam, pageQuery(request));
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
		
		
		List<ZpPeConHourData> peConHourDataListByOutputId = zpPeConHourDataService.getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime,page,pageSize);
		Integer maxSize = zpPeConHourDataService.getPeConHourDataListSizeByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime);
		
		JSONArray peConDayDataJsonArray = new JSONArray();
		for(int i=0;peConHourDataListByOutputId.size()>i;i++){
			ZpPeConHourData peConHourData = peConHourDataListByOutputId.get(i);
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
