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

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.hydposition.dao.HydpositoninfoDao;
import com.fjzxdz.ams.module.hydposition.entity.Hydpositoninfo;
import com.fjzxdz.ams.module.hydposition.param.HydpositoninfoParam;
import com.fjzxdz.ams.module.hydposition.service.HydpositoninfoService;

import cn.hutool.core.bean.BeanUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 水电站点位基本信息Controller
 * @author htj
 * @version 2019-02-18
 */
@Controller
 
@RequestMapping(value = "/hydposition/hydpositoninfo")
 
public class HydpositoninfoController extends BaseController {

	@Autowired
	private HydpositoninfoDao hydpositoninfoDao;
	@Autowired
	private HydpositoninfoService hydpositoninfoService;

	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "hydposition/hydpositoninfoList";
	}
	
	/**
	 * 跳转地图界面
	 * @return
	 */
	@RequestMapping("/hydPositionMap")
	public String gotoMap() {
		return "/moudles/" + "hydposition/hydPositionMap";
	}
	
	
	/**
	 * 更新或新增
	 * @param hydpositoninfo
	 * @return
	 */	
	@RequestMapping("/saveHydpositoninfo")
	@ResponseBody
	public R saveHydpositoninfo(Hydpositoninfo hydpositoninfo) {
		try {
			hydpositoninfoService.save(hydpositoninfo);
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
	@RequestMapping("/deleteHydpositoninfo")
	@ResponseBody
	public R deleteHydpositoninfo(@RequestParam(value = "uuid") String uuid) {
		try {
			hydpositoninfoService.delete(uuid);
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
	@RequestMapping("/getHydpositoninfo")
	@ResponseBody
	public Map<String, Object> getHydpositoninfo(@RequestParam(value = "uuid") String uuid) {
		Hydpositoninfo hydpositoninfo = hydpositoninfoDao.getById(uuid);
		return BeanUtil.beanToMap(hydpositoninfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param hydpositoninfo
	 * @param request
	 * @return
	 */
	@RequestMapping("/hydpositoninfoList")
	@ResponseBody
	public PageEU<Hydpositoninfo> hydpositoninfoList(HydpositoninfoParam hydpositoninfoParam, HttpServletRequest request) {
		Page<Hydpositoninfo> page = hydpositoninfoService.listByPage(hydpositoninfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 *  获取有坐标信息的水电站信息
	*/
	@RequestMapping("/getAllHydpositoninfo")
	@ResponseBody
	public JSONArray  getAllHydpositoninfo(String stationName) {
		
		JSONArray  hydPositionArray = new JSONArray();
		hydPositionArray = hydpositoninfoService.getAllHydPostionInfo(stationName);
		return hydPositionArray;
	 }
	
 /**
	 *  通过水电站站点id 查询站点下的设备信息
	 *  eqpId 点位ID
	*/ 
	@RequestMapping("/getHydDeviceinfoByID")
	@ResponseBody
	public JSONArray  getHydDeviceinfoByID(@RequestParam(value = "eqpId")  String eqpId) {
		JSONArray  hydDeviceArray = new JSONArray();
		hydDeviceArray = hydpositoninfoService.getHydDeviceInfoById(eqpId);
		return hydDeviceArray;
	 }


	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(HydpositoninfoParam param, HttpServletResponse response){
		List<Hydpositoninfo> lists=hydpositoninfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (Hydpositoninfo hydpositoninfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("eqpName", hydpositoninfo.getEqpName());
			map.put("CYC", hydpositoninfo.getCYC());
			map.put("isUsed", hydpositoninfo.getIsUsed());
			result.add(map);
		}
		return exportHydpositoninfoDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportHydpositoninfoDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水电站站点数据表");
		columnMap.put("eqpName", "点位名称");
		columnMap.put("CYC", "更新频率");
		columnMap.put("isUsed", "是否正在使用");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
