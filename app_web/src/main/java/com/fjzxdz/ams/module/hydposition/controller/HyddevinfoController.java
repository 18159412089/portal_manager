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

import com.fjzxdz.ams.module.hydposition.entity.Hyddevinfo;
import com.fjzxdz.ams.module.hydposition.service.HyddevinfoService;
import com.fjzxdz.ams.module.hydposition.dao.HyddevinfoDao;
import com.fjzxdz.ams.module.hydposition.param.HyddevinfoParam;

/**
 * 水电站设备基本信息Controller
 * @author htj
 * @version 2019-02-18
 */
@Controller
 
@RequestMapping(value = "/hydposition/hyddevinfo")
 
public class HyddevinfoController extends BaseController {

	@Autowired
	private HyddevinfoDao hyddevinfoDao;
	@Autowired
	private HyddevinfoService hyddevinfoService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "hydposition/hyddevinfoList";
	}
	
	/**
	 * 更新或新增
	 * @param hyddevinfo
	 * @return
	 */	
	@RequestMapping("/saveHyddevinfo")
	@ResponseBody
	public R saveHyddevinfo(Hyddevinfo hyddevinfo) {
		try {
			hyddevinfoService.save(hyddevinfo);
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
	@RequestMapping("/deleteHyddevinfo")
	@ResponseBody
	public R deleteHyddevinfo(@RequestParam(value = "uuid") String uuid) {
		try {
			hyddevinfoService.delete(uuid);
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
	@RequestMapping("/getHyddevinfo")
	@ResponseBody
	public Map<String, Object> getHyddevinfo(@RequestParam(value = "uuid") String uuid) {
		Hyddevinfo hyddevinfo = hyddevinfoDao.getById(uuid);
		return BeanUtil.beanToMap(hyddevinfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param hyddevinfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/hyddevinfoList")
	@ResponseBody
	public PageEU<Hyddevinfo> hyddevinfoList(HyddevinfoParam hyddevinfoParam, HttpServletRequest request) {
		Page<Hyddevinfo> page = hyddevinfoService.listByPage(hyddevinfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(HyddevinfoParam param, HttpServletResponse response){
		List<Hyddevinfo> lists=hyddevinfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (Hyddevinfo hyddevinfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("riverCode", hyddevinfo.getRiverCode());
			map.put("riverName", hyddevinfo.getRiverName());
			map.put("NAME", hyddevinfo.getNAME());
			map.put("normalWaterLevel", hyddevinfo.getNormalWaterLevel());
			map.put("totalCapacity", hyddevinfo.getTotalCapacity());
			map.put("capacity", hyddevinfo.getCapacity());
			map.put("BUILDER", hyddevinfo.getBUILDER());
			map.put("downReservoir", hyddevinfo.getDownReservoir());
			map.put("minWaterLevel", hyddevinfo.getMinWaterLevel());
			map.put("rgnName", hyddevinfo.getRgnName());
			map.put("rgnCode", hyddevinfo.getRgnCode());
			map.put("upReservoir", hyddevinfo.getUpReservoir());
			result.add(map);
		}
		return exportHyddevinfoDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportHyddevinfoDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水电站设备数据表");
		columnMap.put("riverCode", "流域编码");
		columnMap.put("riverName", "流域名称");
		columnMap.put("NAME", "点位名称");
		columnMap.put("normalWaterLevel", "正常蓄水位");
		columnMap.put("totalCapacity", "总容量");
		columnMap.put("capacity", "容量");
		columnMap.put("BUILDER", "承建单位联系人");
		columnMap.put("downReservoir", "下游水库");
		columnMap.put("minWaterLevel", "最小蓄水位");
		columnMap.put("rgnName", "行政区划名称");
		columnMap.put("rgnCode", "行政区划编码");
		columnMap.put("upReservoir", "上游水库");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
