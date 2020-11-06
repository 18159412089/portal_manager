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

import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.hutool.core.bean.BeanUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import com.fjzxdz.ams.module.hydposition.entity.Hyddevexitdata;
import com.fjzxdz.ams.module.hydposition.service.HyddevexitdataService;
import com.fjzxdz.ams.module.hydposition.dao.HyddevexitdataDao;
import com.fjzxdz.ams.module.hydposition.param.HyddevexitdataParam;

/**
 * 水电站设备出口Controller
 * @author htj
 * @version 2019-02-18
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/hydposition/hyddevexitdata")
@Secured({ "ROLE_USER" })
public class HyddevexitdataController extends BaseController {

	@Autowired
	private HyddevexitdataDao hyddevexitdataDao;
	@Autowired
	private HyddevexitdataService hyddevexitdataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "hydposition/hyddevexitdataList";
	}
	
	/**
	 * 更新或新增
	 * @param hyddevexitdata
	 * @return
	 */	
	@RequestMapping("/saveHyddevexitdata")
	@ResponseBody
	public R saveHyddevexitdata(Hyddevexitdata hyddevexitdata) {
		try {
			hyddevexitdataService.save(hyddevexitdata);
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
	@RequestMapping("/deleteHyddevexitdata")
	@ResponseBody
	public R deleteHyddevexitdata(@RequestParam(value = "uuid") String uuid) {
		try {
			hyddevexitdataService.delete(uuid);
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
	@RequestMapping("/getHyddevexitdata")
	@ResponseBody
	public Map<String, Object> getHyddevexitdata(@RequestParam(value = "uuid") String uuid) {
		Hyddevexitdata hyddevexitdata = hyddevexitdataDao.getById(uuid);
		return BeanUtil.beanToMap(hyddevexitdata,false,true);
	}
	
	/**
	 * 查询列表
	 * @param hyddevexitdataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/hyddevexitdataList")
	@ResponseBody
	public PageEU<Hyddevexitdata> hyddevexitdataList(HyddevexitdataParam hyddevexitdataParam, HttpServletRequest request) {
		Page<Hyddevexitdata> page = hyddevexitdataService.listByPage(hyddevexitdataParam, pageQuery(request));
		return new PageEU<>(page);
	}


	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(HyddevexitdataParam param, HttpServletResponse response){
		List<Hyddevexitdata> lists=hyddevexitdataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (Hyddevexitdata hyddevexitdata : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("eqpName", hyddevexitdata.getHydpositoninfo().getEqpName());
			map.put("outputName", hyddevexitdata.getOutputName());
			map.put("outputCode", hyddevexitdata.getOutputCode());
			map.put("minFlow", hyddevexitdata.getMinFlow());
			map.put("STATUS", hyddevexitdata.getSTATUS());
			result.add(map);
		}
		return exportHyddevexitdataDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportHyddevexitdataDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水电站设备出口数据表");
		columnMap.put("eqpName", "站点名称");
		columnMap.put("outputName", "出口名称");
		columnMap.put("outputCode", "出口编码");
		columnMap.put("minFlow", "环评要求最小下泄流量(立方米/秒)");
		columnMap.put("STATUS", "状态");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
