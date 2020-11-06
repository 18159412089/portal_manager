/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.wtcd.dao.WtcdRiverwayDataDao;
import com.fjzxdz.ams.module.wtcd.entity.WtcdRiverwayData;
import com.fjzxdz.ams.module.wtcd.param.WtcdRiverwayDataParam;
import com.fjzxdz.ams.module.wtcd.service.WtcdRiverwayDataService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 水利厅实时河道数据Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/wtcd/wtcdRiverwayData")
@Secured({ "ROLE_USER" })
public class WtcdRiverwayDataController extends BaseController {

	@Autowired
	private WtcdRiverwayDataDao wtcdRiverwayDataDao;
	@Autowired
	private WtcdRiverwayDataService wtcdRiverwayDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "wtcd/wtcdRiverwayDataList";
	}
	
	/**
	 * 更新或新增
	 * @param wtcdRiverwayData
	 * @return
	 */	
/*	@RequestMapping("/saveWtcdRiverwayData")
	@ResponseBody
	public R saveWtcdRiverwayData(WtcdRiverwayData wtcdRiverwayData) {
		try {
			wtcdRiverwayDataService.save(wtcdRiverwayData);
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
/*	@RequestMapping("/deleteWtcdRiverwayData")
	@ResponseBody
	public R deleteWtcdRiverwayData(@RequestParam(value = "uuid") String uuid) {
		try {
			wtcdRiverwayDataService.delete(uuid);
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
	@RequestMapping("/getWtcdRiverwayData")
	@ResponseBody
	public Map<String, Object> getWtcdRiverwayData(@RequestParam(value = "uuid") String uuid) {
		WtcdRiverwayData wtcdRiverwayData = wtcdRiverwayDataDao.getById(uuid);
		return BeanUtil.beanToMap(wtcdRiverwayData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtcdRiverwayDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtcdRiverwayDataList")
	@ResponseBody
	public PageEU<WtcdRiverwayData> wtcdRiverwayDataList(WtcdRiverwayDataParam wtcdRiverwayDataParam, HttpServletRequest request) {
		Page<WtcdRiverwayData> page = wtcdRiverwayDataService.listByPage(wtcdRiverwayDataParam, pageQuery(request));
		return new PageEU<>(page);
	}


	
	/**
	 * 查询列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getWtcdRiverwayDataListForMap")
	@ResponseBody
	public JSONObject getWtcdRiverwayDataListForMap(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		JSONArray labelArray = new JSONArray();
		JSONArray dataArray = new JSONArray();
		
		String STCD = "";
		Timestamp startTime = Utils.getTimestampZero();
		Timestamp endTime = Utils.getTimestamp();
		//获取查询参数
		try {
			if(StringUtils.isNotEmpty((String)request.getParameter("STCD"))) {
				STCD = (String) request.getParameter("STCD");
			}
			if(StringUtils.isNotEmpty((String)request.getParameter("starTime"))) {
				startTime = Utils.getTimestamp(request.getParameter("starTime"));
			}
			if(StringUtils.isNotEmpty((String)request.getParameter("endTime"))) {
				endTime = Utils.getTimestamp(request.getParameter("endTime"));
			}
			
			JSONArray rainfallDataArray = wtcdRiverwayDataService.getWtcdRiverwayDataListForMap(STCD,startTime,endTime);
			
			for (Object obj : rainfallDataArray) {
				JSONObject jsonObj = new JSONObject(obj);
				
				labelArray.add(jsonObj.get("UPDATETIME_RJWA"));
				dataArray.add(jsonObj.getStr("ZR"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("labelArray", labelArray);
		result.put("dataArray", dataArray);
		
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(WtcdRiverwayDataParam param, HttpServletResponse response){
		List<WtcdRiverwayData> lists = wtcdRiverwayDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (WtcdRiverwayData wtcdRiverwayData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("stcd", wtcdRiverwayData.getSTCD());
			map.put("stnm", "");//暂时没有对应实体类
			map.put("frgrd", "");
			map.put("zr", wtcdRiverwayData.getZR());
			map.put("rksj",wtcdRiverwayData.getRKSJ());
			map.put("updatetimeRjwa", wtcdRiverwayData.getUpdatetimeRjwa());
			map.put("ymdhm", wtcdRiverwayData.getYMDHM());
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
		columnMap.put("title", "水利厅实时河道数据表");
		columnMap.put("stcd", "测站编码");
		columnMap.put("stnm", "测站名称");
		columnMap.put("frgrd", "流量 立方米");
		columnMap.put("zr", "水位 米");
		columnMap.put("rksj", "入库时间");
		columnMap.put("updatetimeRjwa", "更新时间");
		columnMap.put("ymdhm", "时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
