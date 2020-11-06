/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.area.dao.SiteMonitorDataDao;
import com.fjzxdz.ams.module.area.entity.SiteMonitorData;
import com.fjzxdz.ams.module.area.param.SiteMonitorDataParam;
import com.fjzxdz.ams.module.area.service.SiteMonitorDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 近岸海域监测数据Controller
 * @author htj
 * @version 2019-02-20
 */
@Controller
 
@RequestMapping(value = "/area/siteMonitorData")
 
public class SiteMonitorDataController extends BaseController {
	
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private SiteMonitorDataService siteMonitorDataService;
	@Autowired
	private SiteMonitorDataDao siteMonitorDataDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "area/siteMonitorDataList";
	}
	
	/**
	 * 更新或新增
	 * @param siteMonitorData
	 * @return
	 */	
	@RequestMapping("/saveSiteMonitorData")
	@ResponseBody
	public R saveSiteMonitorData(SiteMonitorData siteMonitorData) {
		try {
			siteMonitorDataService.save(siteMonitorData);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deleteSiteMonitorData")
	@ResponseBody
	public R deleteSiteMonitorData(@RequestParam(value = "uuid") String uuid) {
		try {
			siteMonitorDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getSiteMonitorData")
	@ResponseBody
	public Map<String, Object> getSiteMonitorData(@RequestParam(value = "uuid") String uuid) {
		String str[] = uuid.split("_");
		String skCode = str[0];
//		String jcsj = str[1];
		String time = str[1];
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long lt = new Long(time);
        Date date = new Date(lt);
        String jcsj = simpleDateFormat.format(date);
		SiteMonitorData siteMonitorData = simpleDao.findUnique("from SiteMonitorData where SK_CODE=? and to_char(JCSJ,'yyyy-mm-dd hh24:mi:ss')=?",skCode,jcsj);
		return BeanUtil.beanToMap(siteMonitorData,false,true);
	}
	
	@RequestMapping("/getLeftMenuColumnName")
	@ResponseBody
	public JSONArray getLeftMenuColumnName() {
		JSONArray areaSiteArray = new JSONArray();
		areaSiteArray = siteMonitorDataService.getLeftMenuColumnName();
		return areaSiteArray;	
	}
	
	
	
	/**
	 * 获取该监控站点的监控数据
	 * @param skbm
	 * @param columnName
	 * @return
	 */
	@RequestMapping("/getSiteMonitorDataInfo")
	@ResponseBody
	public JSONObject getSiteMonitorDataInfo(String skbm ,String columnName) {
		JSONObject siteMonitorDataObject = new JSONObject();
		siteMonitorDataObject = siteMonitorDataService.getSiteMonitorDataInfo(skbm, columnName);
		return siteMonitorDataObject;	
	}
	
	
	/**
	 * 查询列表
	 * @param siteMonitorDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/siteMonitorDataList")
	@ResponseBody
	public PageEU<SiteMonitorData> siteMonitorDataList(SiteMonitorDataParam siteMonitorDataParam, HttpServletRequest request) {
		Page<SiteMonitorData> page = siteMonitorDataService.listByPage(siteMonitorDataParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(SiteMonitorDataParam param, HttpServletResponse response){
		List<SiteMonitorData> lists = siteMonitorDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (SiteMonitorData siteMonitorData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("stationName", siteMonitorData.getStationName());
			map.put("dwjb",siteMonitorData.getDwjb());
			map.put("gkCode", siteMonitorData.getGkCode());
			map.put("skCode",siteMonitorData.getSiteMonitorDataPk().getSkCode());
			map.put("jclx", siteMonitorData.getJclx());
			map.put("jcsj",siteMonitorData.getSiteMonitorDataPk().getJCSJ());
			map.put("gnlb",siteMonitorData.getGnlb());
			map.put("sqdm", siteMonitorData.getSqdm());
			map.put("sjmc",siteMonitorData.getSjmc());
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
		columnMap.put("title", "近岸海域监测数据表");

		columnMap.put("stationName", "站位名称");
		columnMap.put("dwjb", "点位级别");
		columnMap.put("gkCode", "国控站位编码");
		columnMap.put("skCode", "省控站位编码");
		columnMap.put("jclx", "监测类型");
		columnMap.put("jcsj", "监测时间");
		columnMap.put("gnlb", "功能类别");
		columnMap.put("sqdm", "水期代码");
		columnMap.put("sjmc", "水期名称");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
