/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.sea.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.sea.dao.SeaSiteInfoDao;
import com.fjzxdz.ams.module.sea.entity.SeaSiteInfo;
import com.fjzxdz.ams.module.sea.param.SeaSiteInfoParam;
import com.fjzxdz.ams.module.sea.service.SeaSiteDataService;
import com.fjzxdz.ams.module.sea.service.SeaSiteInfoService;
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
 * 海洋与渔业点位信息Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/sea/seaSiteInfo")
 
public class SeaSiteInfoController extends BaseController {

	@Autowired
	private SeaSiteInfoDao seaSiteInfoDao;
	@Autowired
	private SeaSiteInfoService seaSiteInfoService;
	@Autowired
	private SeaSiteDataService seaSiteDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "sea/seaSiteInfoList";
	}
	
	@RequestMapping("/gotoSeaInfoMap")
	public String gotoSeaInfoMap() {
		return "/moudles/" + "sea/seaSiteMap";
	}
	
	
	/**
	 * 更新或新增
	 * @param seaSiteInfo
	 * @return
	 */	
/*	@RequestMapping("/saveSeaSiteInfo")
	@ResponseBody
	public R saveSeaSiteInfo(SeaSiteInfo seaSiteInfo) {
		try {
			seaSiteInfoService.save(seaSiteInfo);
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
/*	@RequestMapping("/deleteSeaSiteInfo")
	@ResponseBody
	public R deleteSeaSiteInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			seaSiteInfoService.delete(uuid);
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
	@RequestMapping("/getSeaSiteInfo")
	@ResponseBody
	public Map<String, Object> getSeaSiteInfo(@RequestParam(value = "uuid") String uuid) {
		SeaSiteInfo seaSiteInfo = seaSiteInfoDao.getById(uuid);
		return BeanUtil.beanToMap(seaSiteInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param seaSiteInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/seaSiteInfoList")
	@ResponseBody
	public PageEU<SeaSiteInfo> seaSiteInfoList(SeaSiteInfoParam seaSiteInfoParam, HttpServletRequest request) {
		Page<SeaSiteInfo> page = seaSiteInfoService.listByPage(seaSiteInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 获取海洋与渔业站点信息
	 */
	@RequestMapping("/getSeaSiteInfoAllList")
	@ResponseBody
	public JSONArray getSeaSiteInfoAllList(String stationName){
		JSONArray seaSiteArray = new JSONArray();
		seaSiteArray = seaSiteInfoService.getSeaSiteArray(stationName);
		return seaSiteArray;		
	}
	
	
	/**
	 * 获取渔业站点监测数据信息  
	 */
	@RequestMapping("/getSeaSiteMonitorInfoList")
	@ResponseBody
	public  cn.hutool.json.JSONObject getSeaSiteMonitorInfoList(String stationId ,String oldStationID){
		cn.hutool.json.JSONObject seaSiteInfo = new cn.hutool.json.JSONObject();
		seaSiteInfo = seaSiteDataService.getSeaSiteMonitorInfoByStationID(stationId,oldStationID);
		return seaSiteInfo;		
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(SeaSiteInfoParam param, HttpServletResponse response){
		List<SeaSiteInfo> lists = seaSiteInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (SeaSiteInfo seaSiteInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("zdbh", seaSiteInfo.getZdbh());
			map.put("yzdbh", seaSiteInfo.getYzdbh());
			map.put("zdmc", seaSiteInfo.getZdmc());
			map.put("jd", seaSiteInfo.getJd());
			map.put("wd",seaSiteInfo.getWd());
			map.put("xzqhbm", seaSiteInfo.getXzqhbm());
			map.put("xzqhmc", seaSiteInfo.getXzqhmc());
			map.put("jcpc", seaSiteInfo.getJcpc());
			map.put("updatetimeRjwa", seaSiteInfo.getUpdatetimeRjwa());
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
		columnMap.put("title", "省海洋与渔业点位数据表");

		columnMap.put("zdbh", "站点编号");
		columnMap.put("yzdbh", "原站点编号");
		columnMap.put("zdmc", "站点名称");
		columnMap.put("jd", "经度");
		columnMap.put("wd", "纬度");
		columnMap.put("xzqhbm", "行政区划代码");
		columnMap.put("xzqhmc", "行政区划名称");
		columnMap.put("jcpc", "监测频次");
		columnMap.put("updatetimeRjwa", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
