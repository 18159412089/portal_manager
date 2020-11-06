/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rivers.dao.RiversSiteInfoDao;
import com.fjzxdz.ams.module.rivers.entity.RiversSiteInfo;
import com.fjzxdz.ams.module.rivers.param.RiversSiteInfoParam;
import com.fjzxdz.ams.module.rivers.service.RiversSiteInfoService;
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
 * 入海河流点位信息Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rivers/riversSiteInfo")

public class RiversSiteInfoController extends BaseController {
	
	@Autowired
	private RiversSiteInfoDao riversSiteInfoDao;
	@Autowired
	private RiversSiteInfoService riversSiteInfoService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rivers/riversSiteInfoList";
	}
	
	
	
	@RequestMapping("/gotoRiversSiteMap")
	public String gotoRiversSiteMap() {
		return "/moudles/" + "rivers/riversSiteMap";
	}
	
	
	/**
	 * 更新或新增
	 * @param riversSiteInfo
	 * @return
	 */	
/*	@RequestMapping("/saveRiversSiteInfo")
	@ResponseBody
	public R saveRiversSiteInfo(RiversSiteInfo riversSiteInfo) {
		try {
			riversSiteInfoService.save(riversSiteInfo);
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
/*	@RequestMapping("/deleteRiversSiteInfo")
	@ResponseBody
	public R deleteRiversSiteInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			riversSiteInfoService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getRiversSiteInfo")
	@ResponseBody
	public Map<String, Object> getRiversSiteInfo(@RequestParam(value = "uuid") String uuid) {
		RiversSiteInfo riversSiteInfo = riversSiteInfoDao.getById(uuid);
		return BeanUtil.beanToMap(riversSiteInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param riversSiteInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riversSiteInfoList")
	@ResponseBody
	public PageEU<RiversSiteInfo> riversSiteInfoList(RiversSiteInfoParam riversSiteInfoParam, HttpServletRequest request) {
		Page<RiversSiteInfo> page = riversSiteInfoService.listByPage(riversSiteInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	@RequestMapping("/getRiversSiteInfoList")
	@ResponseBody
	public JSONArray getRiversSiteInfoList(String stationName) {
		JSONArray riverSiteArray = new JSONArray();
		riverSiteArray = riversSiteInfoService.getRiverSiteArray(stationName);
		return riverSiteArray;	
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiversSiteInfoParam param, HttpServletResponse response){
		List<RiversSiteInfo> lists = riversSiteInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiversSiteInfo siteInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("pointcode", siteInfo.getPOINTCODE());
			map.put("codeRegion",siteInfo.getCodeRegion());
			map.put("longitude", siteInfo.getLONGITUDE());
			map.put("wsystemname",siteInfo.getWSYSTEMNAME());
			map.put("regionname", siteInfo.getREGIONNAME());
			map.put("codeWsystem",siteInfo.getCodeWsystem());
			map.put("latitude",siteInfo.getLATITUDE());
			map.put("pointname", siteInfo.getPOINTNAME());
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
		columnMap.put("title", "入海河流点位数据表");

		columnMap.put("pointcode", "站点编码");
		columnMap.put("codeRegion", "行政区编码");
		columnMap.put("longitude", "经度");
		columnMap.put("wsystemname", "流域名称");
		columnMap.put("regionname", "行政区名称");
		columnMap.put("codeWsystem", "流域编码");
		columnMap.put("latitude", "纬度");
		columnMap.put("pointname", "站点名称");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
