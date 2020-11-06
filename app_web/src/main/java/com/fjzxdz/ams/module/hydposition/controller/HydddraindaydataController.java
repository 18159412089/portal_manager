/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.hydposition.controller;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.fjzxdz.frame.toolbox.util.DateUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.hydposition.dao.HydddraindaydataDao;
import com.fjzxdz.ams.module.hydposition.entity.Hydddraindaydata;
import com.fjzxdz.ams.module.hydposition.param.HydddraindaydataParam;
import com.fjzxdz.ams.module.hydposition.service.HydddraindaydataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;

/**
 * 水电站下泄流量日统计数据Controller
 * @author htj
 * @version 2019-02-20
 */
@Controller
 
@RequestMapping(value = "/hydposition/hydddraindaydata")
 
public class HydddraindaydataController extends BaseController {

	@Autowired
	private HydddraindaydataDao hydddraindaydataDao;
	@Autowired
	private HydddraindaydataService hydddraindaydataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "hydposition/hydddraindaydataList";
	}
	
	/**
	 * 更新或新增
	 * @param hydddraindaydata
	 * @return
	 */	
	@RequestMapping("/saveHydddraindaydata")
	@ResponseBody
	public R saveHydddraindaydata(Hydddraindaydata hydddraindaydata) {
		try {
			hydddraindaydataService.save(hydddraindaydata);
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
	@RequestMapping("/deleteHydddraindaydata")
	@ResponseBody
	public R deleteHydddraindaydata(@RequestParam(value = "uuid") String uuid) {
		try {
			hydddraindaydataService.delete(uuid);
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
	@RequestMapping("/getHydddraindaydata")
	@ResponseBody
	public Map<String, Object> getHydddraindaydata(@RequestParam(value = "uuid") String uuid) {
		Hydddraindaydata hydddraindaydata = hydddraindaydataDao.getById(uuid);
		return BeanUtil.beanToMap(hydddraindaydata,false,true);
	}
	
	/**
	 * 查询列表
	 * @param hydddraindaydataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/hydddraindaydataList")
	@ResponseBody
	public PageEU<Hydddraindaydata> hydddraindaydataList(HydddraindaydataParam hydddraindaydataParam, HttpServletRequest request) {
 
		Page<Hydddraindaydata> page = hydddraindaydataService.listByPage(hydddraindaydataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	 
	/**
	 *  通过設備ID当前站点下日数据信息
	 *  deviceId 设备id
	 */ 
	@RequestMapping("/getHydDrainDayDataByDeviceID")
	@ResponseBody
	public JSONArray  getHydDrainDayDataByDeviceID(@RequestParam(value = "deviceId")  String deviceId) {
		JSONArray  hydDrainDayDataArr = new JSONArray();
		hydDrainDayDataArr = hydddraindaydataService.getHydDrainDayDataByHydDeviceId(deviceId);
		return hydDrainDayDataArr;
	 }


	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(HydddraindaydataParam param, HttpServletResponse response){
		List<Hydddraindaydata> lists=hydddraindaydataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (Hydddraindaydata hyddevexitdata : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("outputName", hyddevexitdata.getHyddevexitdata().getOutputName());
			map.put("maxValue", hyddevexitdata.getMaxValue());
			map.put("measureTime", hyddevexitdata.getHydddraindaydataPrimaryKey().getMeasureTime());
			map.put("avgValue", hyddevexitdata.getAvgValue());
			map.put("minValue", hyddevexitdata.getMinValue());
			result.add(map);
		}
		return exportHydddraindaydataDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportHydddraindaydataDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水电站下泄流量日统计数据表");
		columnMap.put("outputName", "出口名称");
		columnMap.put("maxValue", "当日最大下泄流量(立方米/秒");
		columnMap.put("measureTime", "监测时间");
		columnMap.put("avgValue", "日均下泄流量(立方米/秒)");
		columnMap.put("minValue", "当日最小下泄流量(立方米/秒)");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
