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
import com.fjzxdz.ams.module.wtcd.dao.WtcdRainfallDataDao;
import com.fjzxdz.ams.module.wtcd.entity.WtcdRainfallData;
import com.fjzxdz.ams.module.wtcd.param.WtcdRainfallDataParam;
import com.fjzxdz.ams.module.wtcd.service.WtcdRainfallDataService;
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
 * 水利厅实时雨量数据Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/wtcd/wtcdRainfallData")
@Secured({ "ROLE_USER" })
public class WtcdRainfallDataController extends BaseController {

	@Autowired
	private WtcdRainfallDataDao wtcdRainfallDataDao;
	@Autowired
	private WtcdRainfallDataService wtcdRainfallDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "wtcd/wtcdRainfallDataList";
	}
	
	/**
	 * 更新或新增
	 * @param wtcdRainfallData
	 * @return
	 */	
/*	@RequestMapping("/saveWtcdRainfallData")
	@ResponseBody
	public R saveWtcdRainfallData(WtcdRainfallData wtcdRainfallData) {
		try {
			wtcdRainfallDataService.save(wtcdRainfallData);
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
/*	@RequestMapping("/deleteWtcdRainfallData")
	@ResponseBody
	public R deleteWtcdRainfallData(@RequestParam(value = "uuid") String uuid) {
		try {
			wtcdRainfallDataService.delete(uuid);
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
	@RequestMapping("/getWtcdRainfallData")
	@ResponseBody
	public Map<String, Object> getWtcdRainfallData(@RequestParam(value = "uuid") String uuid) {
		WtcdRainfallData wtcdRainfallData = wtcdRainfallDataDao.getById(uuid);
		return BeanUtil.beanToMap(wtcdRainfallData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtcdRainfallDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtcdRainfallDataList")
	@ResponseBody
	public PageEU<WtcdRainfallData> wtcdRainfallDataList(WtcdRainfallDataParam wtcdRainfallDataParam, HttpServletRequest request) {
		Page<WtcdRainfallData> page = wtcdRainfallDataService.listByPage(wtcdRainfallDataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 查询列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getWtcdRainfallDataListForMap")
	@ResponseBody
	public JSONObject getWtcdRainfallDataListForMap(HttpServletRequest request) {
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
			
			JSONArray rainfallDataArray = wtcdRainfallDataService.getWtcdRainfallDataListForMap(STCD,startTime,endTime);
			
			for (Object obj : rainfallDataArray) {
				JSONObject jsonObj = new JSONObject(obj);
				
				labelArray.add(jsonObj.get("UPDATETIME_RJWA"));
				dataArray.add(jsonObj.get("DTRN"));
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
	public List<Map<String, Object>> getListExport(WtcdRainfallDataParam param, HttpServletResponse response){
		List<WtcdRainfallData> lists = wtcdRainfallDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (WtcdRainfallData wtcdRainfallData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("stcd", wtcdRainfallData.getSTCD());
			map.put("stnm", "");//暂时没有对应实体类
			map.put("dtrn", wtcdRainfallData.getDTRN());
			map.put("ymdhm", wtcdRainfallData.getYMDHM());
			map.put("rksj",wtcdRainfallData.getRKSJ());
			map.put("updatetimeRjwa", wtcdRainfallData.getUpdatetimeRjwa());
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
		columnMap.put("title", "水利厅实时雨量数据表");
		columnMap.put("stcd", "测站编码");
		columnMap.put("stnm", "测站名称");
		columnMap.put("dtrn", "雨量 米");
		columnMap.put("ymdhm", "时间");
		columnMap.put("rksj", "入库时间");
		columnMap.put("updatetimeRjwa", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
