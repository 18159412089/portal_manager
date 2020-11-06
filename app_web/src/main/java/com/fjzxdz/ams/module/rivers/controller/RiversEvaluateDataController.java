/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rivers.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rivers.dao.RiversEvaluateDataDao;
import com.fjzxdz.ams.module.rivers.entity.RiversEvaluateData;
import com.fjzxdz.ams.module.rivers.param.RiversEvaluateDataParam;
import com.fjzxdz.ams.module.rivers.service.RiversEvaluateDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
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
 * 海河流水质评价结果Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rivers/riversEvaluateData")
@Secured({ "ROLE_USER" })
public class RiversEvaluateDataController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RiversEvaluateDataService riversEvaluateDataService;
	@Autowired
	private RiversEvaluateDataDao riversEvaluateDataDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rivers/riversEvaluateDataList";
	}
	
	/**
	 * 更新或新增
	 * @param riversEvaluateData
	 * @return
	 */	
/*	@RequestMapping("/saveRiversEvaluateData")
	@ResponseBody
	public R saveRiversEvaluateData(RiversEvaluateData riversEvaluateData) {
		try {
			riversEvaluateDataService.save(riversEvaluateData);
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
/*	@RequestMapping("/deleteRiversEvaluateData")
	@ResponseBody
	public R deleteRiversEvaluateData(@RequestParam(value = "uuid") String uuid) {
		try {
			riversEvaluateDataService.delete(uuid);
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
	@RequestMapping("/getRiversEvaluateData")
	@ResponseBody
	public Map<String, Object> getRiversEvaluateData(@RequestParam(value = "uuid") String uuid) {
		String str[] = uuid.split("_");
		String code = str[0];
		double pointCode = Double.parseDouble(code);
		String yearNumber = str[1];
		String monthNumber = str[2];
		RiversEvaluateData riversEvaluateData = 
				simpleDao.findUnique("from RiversEvaluateData where POINTCODE=? and YEARNUMBER=? and MONTHNUMBER=?",pointCode,yearNumber,monthNumber);
		return BeanUtil.beanToMap(riversEvaluateData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param riversEvaluateDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riversEvaluateDataList")
	@ResponseBody
	public PageEU<RiversEvaluateData> riversEvaluateDataList(RiversEvaluateDataParam riversEvaluateDataParam, HttpServletRequest request) {
		Page<RiversEvaluateData> page = riversEvaluateDataService.listByPage(riversEvaluateDataParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	
	
	/**
	 * 根据pointCode 获取评价信息列表
	 * @param PointCode
	 * @return
	 */
	@RequestMapping("/getRiverEvaluateDataByPointCode")
	@ResponseBody
	public JSONArray getRiverEvaluateDataByPointCode(@RequestParam(value = "PointCode") String PointCode) {
		JSONArray riversEvaluateDataArray = riversEvaluateDataService.getRiverEvaluateDataByPointCode(PointCode);
		return riversEvaluateDataArray;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiversEvaluateDataParam param, HttpServletResponse response){
		List<RiversEvaluateData> lists = riversEvaluateDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiversEvaluateData monitorData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("pointcode", monitorData.getPOINTCODE());
			map.put("pointname",monitorData.getPOINTNAME());
			map.put("watercode",monitorData.getWATERCODE());
			map.put("watername",monitorData.getWATERNAME());
			map.put("codeRegion", monitorData.getCodeRegion());
			map.put("regionname",monitorData.getREGIONNAME());
			map.put("taskwaters",monitorData.getTASKWATERS());
			map.put("primpollute",monitorData.getPRIMPOLLUTE());
			map.put("yearnumber",monitorData.getYEARNUMBER());
			map.put("monthnumber",monitorData.getMONTHNUMBER());
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
		columnMap.put("title", "入海河流水质评价结果数据表");

		columnMap.put("pointcode", "站点编码");
		columnMap.put("pointname", "站点名称");
		columnMap.put("watercode", "流域编码");
		columnMap.put("watername", "流域名称");
		columnMap.put("codeRegion", "行政区编码");
		columnMap.put("regionname", "行政区名称");
		columnMap.put("taskwaters", "流量");
		columnMap.put("primpollute", "污染源");
		columnMap.put("yearnumber", "年");
		columnMap.put("monthnumber", "月");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
