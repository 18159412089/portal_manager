/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.wtcd.controller;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirSiteHourData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirSiteHourDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.fjzxdz.ams.module.wtcd.dao.WtcdSiteInfoDao;
import com.fjzxdz.ams.module.wtcd.entity.WtcdSiteInfo;
import com.fjzxdz.ams.module.wtcd.param.WtcdSiteInfoParam;
import com.fjzxdz.ams.module.wtcd.service.WtcdSiteInfoService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;

/**
 * 水利厅水文站点Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/wtcd/wtcdSiteInfo")
@Secured({ "ROLE_USER" })
public class WtcdSiteInfoController extends BaseController {
	
	@Autowired
	private WtcdSiteInfoService wtcdSiteInfoService;
	@Autowired
	private WtcdSiteInfoDao wtcdSiteInfoDao;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "wtcd/wtcdSiteInfoList";
	}
	
	/**
	 * 更新或新增
	 * @param wtcdSiteInfo
	 * @return
	 */	
/*	@RequestMapping("/saveWtcdSiteInfo")
	@ResponseBody
	public R saveWtcdSiteInfo(WtcdSiteInfo wtcdSiteInfo) {
		try {
			wtcdSiteInfoService.save(wtcdSiteInfo);
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
/*	@RequestMapping("/deleteWtcdSiteInfo")
	@ResponseBody
	public R deleteWtcdSiteInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			wtcdSiteInfoService.delete(uuid);
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
	@RequestMapping("/getWtcdSiteInfo")
	@ResponseBody
	public Map<String, Object> getWtcdSiteInfo(String uuid) {
		WtcdSiteInfo wtcdSiteInfo = simpleDao.findUnique("from WtcdSiteInfo where STCD=?",uuid);
		return BeanUtil.beanToMap(wtcdSiteInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param wtcdSiteInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtcdSiteInfoList")
	@ResponseBody
	public PageEU<WtcdSiteInfo> wtcdSiteInfoList(WtcdSiteInfoParam wtcdSiteInfoParam, HttpServletRequest request) {
		Page<WtcdSiteInfo> page = wtcdSiteInfoService.listByPage(wtcdSiteInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	/**
	 * 获取所有水利站点信息列表
	 * @return
	 */
	@RequestMapping("/getWtcdSiteInfoList")
	@ResponseBody
	public JSONArray getWtcdSiteInfoList(String stationName) {
		JSONArray result = new JSONArray();
		
		List<WtcdSiteInfo> list = wtcdSiteInfoService.getWtcdSiteInfoList(stationName);
		for (WtcdSiteInfo wtcdSiteInfo : list) {
			result.add(wtcdSiteInfo.toJSONObject());
		}
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(WtcdSiteInfoParam param, HttpServletResponse response){
		List<WtcdSiteInfo> lists = wtcdSiteInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (WtcdSiteInfo wtcdSiteInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("stcd", wtcdSiteInfo.getSTCD());
			map.put("stnm", wtcdSiteInfo.getSTNM());
			map.put("sttp", wtcdSiteInfo.getSTTP());
			map.put("stlc", wtcdSiteInfo.getSTLC());
			map.put("addvcd", wtcdSiteInfo.getADDVCD());
			map.put("essym", wtcdSiteInfo.getESSYM());
			map.put("hnnm", wtcdSiteInfo.getHNNM());
			map.put("bsnm", wtcdSiteInfo.getBSNM());
			map.put("rvnm", wtcdSiteInfo.getRVNM());
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
		columnMap.put("title", "水文站点信息数据表");
		columnMap.put("stcd", "测站编码");
		columnMap.put("stnm", "测站名称");
		columnMap.put("sttp", "站类");
		columnMap.put("stlc", "站址");
		columnMap.put("addvcd", "行政区划码");
		columnMap.put("essym", "建站年月");
		columnMap.put("hnnm", "水系名称");
		columnMap.put("bsnm", "流域名称");
		columnMap.put("rvnm", "河流名称");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
