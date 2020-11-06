/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rivers.dao.RiversSiteMonitorDataDao;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteMonitorData;
import com.fjzxdz.ams.module.rivers.param.RiversSiteMonitorDataParam;
import com.fjzxdz.ams.module.rivers.service.RiversSiteMonitorDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 入海河流监测数据Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rivers/riversSiteMonitorData")
 
public class RiversSiteMonitorDataController extends BaseController {

	@Autowired
	private RiversSiteMonitorDataDao riversSiteMonitorDataDao;
	@Autowired
	private RiversSiteMonitorDataService riversSiteMonitorDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rivers/riversSiteMonitorDataList";
	}
	
	/**
	 * 更新或新增
	 * @param riversSiteMonitorData
	 * @return
	 */	
/*	@RequestMapping("/saveRiversSiteMonitorData")
	@ResponseBody
	public R saveRiversSiteMonitorData(RiversSiteMonitorData riversSiteMonitorData) {
		try {
			riversSiteMonitorDataService.save(riversSiteMonitorData);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
/*	@RequestMapping("/deleteRiversSiteMonitorData")
	@ResponseBody
	public R deleteRiversSiteMonitorData(@RequestParam(value = "uuid") String uuid) {
		try {
			riversSiteMonitorDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 根据uuid 获取监测数据列表
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getRiversSiteMonitorData")
	@ResponseBody
	public Map<String, Object> getRiversSiteMonitorData(@RequestParam(value = "uuid") String uuid) {
		RiversSiteMonitorData riversSiteMonitorData = riversSiteMonitorDataDao.getById(uuid);
		return BeanUtil.beanToMap(riversSiteMonitorData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param riversSiteMonitorDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riversSiteMonitorDataList")
	@ResponseBody
	public PageEU<RiversSiteMonitorData> riversSiteMonitorDataList(RiversSiteMonitorDataParam riversSiteMonitorDataParam, HttpServletRequest request) {
		Page<RiversSiteMonitorData> page = riversSiteMonitorDataService.listByPage(riversSiteMonitorDataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/***
	 * 动态获取左边菜单栏列名
	 * @param pointCode
	 * @return
	 */
	@RequestMapping("/getLeftMenuColumnName")
	@ResponseBody
	public JSONArray getLeftMenuColumnName(String pointCode) {
		JSONArray riversSiteMonitorData = riversSiteMonitorDataService.getLeftMenuColumnName(pointCode);
		return riversSiteMonitorData;
	}
	
	
	
	@RequestMapping("/getRiversSiteMonitorDataList")
	@ResponseBody
	public JSONObject getRiversSiteMonitorDataList(String pointCode ,String columnCode) {
		JSONObject riversSiteMonitorData = riversSiteMonitorDataService.getRiversSiteMonitorDataList(pointCode, columnCode);
		return riversSiteMonitorData;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiversSiteMonitorDataParam param, HttpServletResponse response){
		List<RiversSiteMonitorData> lists = riversSiteMonitorDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiversSiteMonitorData monitorData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("pointcode", monitorData.getPOINTCODE());
			map.put("pointname",monitorData.getPOINTNAME());
			map.put("pollutename",monitorData.getPOLLUTENAME());
			map.put("codePollute",monitorData.getCodePollute());
			map.put("monitortime", monitorData.getMONITORTIME());
			map.put("pollutevalue",monitorData.getPOLLUTEVALUE());
			result.add(map);
		}
		return exportEnvironmentNativeWtHourDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportEnvironmentNativeWtHourDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "入海河流监测数据表");

		columnMap.put("pointcode", "站点编码");
		columnMap.put("pointname", "站点名称");
		columnMap.put("pollutename", "污染物名称");
		columnMap.put("codePollute", "污染物编码");
		columnMap.put("monitortime", "监测时间");
		columnMap.put("pollutevalue", "污染物浓度");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
	
	
	
}
