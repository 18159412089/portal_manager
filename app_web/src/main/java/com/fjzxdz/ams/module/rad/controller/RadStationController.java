/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rad.dao.RadStationDao;
import com.fjzxdz.ams.module.rad.entity.RadStation;
import com.fjzxdz.ams.module.rad.param.RadStationParam;
import com.fjzxdz.ams.module.rad.service.RadStationService;
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
 * 辐射基站Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radStation")
@Secured({ "ROLE_USER" })
public class RadStationController extends BaseController {
	
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RadStationService radStationService;
	@Autowired
	private RadStationDao radStationDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rad/radStationList";
	}
	
	/**
	 * 获取所有水利站点信息列表
	 * @return
	 */
	@RequestMapping("/getRadStationInfoList")
	@ResponseBody
	public List<Map<String, Object>> getWtcdSiteInfoList(String stationName) {
	 
		List<Map<String, Object>> list = radStationService.getRadStationInfoList(stationName);
		for (Map<String, Object> map : list) {
			map.put ("UPDATETIME_RJWA","");
		}
		return list;
	}
	
	
	/**
	 * 更新或新增
	 * @param radStation
	 * @return
	 */	
/*	@RequestMapping("/saveRadStation")
	@ResponseBody
	public R saveRadStation(RadStation radStation) {
		try {
			radStationService.save(radStation);
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
/*	@RequestMapping("/deleteRadStation")
	@ResponseBody
	public R deleteRadStation(@RequestParam(value = "uuid") String uuid) {
		try {
			radStationService.delete(uuid);
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
	@RequestMapping("/getRadStation")
	@ResponseBody
	public Map<String, Object> getRadStation(@RequestParam(value = "uuid") String uuid) {
		RadStation radStation = simpleDao.findUnique("from RadStation where PKID=?",uuid);
		return BeanUtil.beanToMap(radStation,false,true);
	}
	
	/**
	 * 查询列表
	 * @param radStationParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/radStationList")
	@ResponseBody
	public PageEU<RadStation> radStationList(RadStationParam radStationParam, HttpServletRequest request) {
		Page<RadStation> page = radStationService.listByPage(radStationParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RadStationParam param, HttpServletResponse response){
		List<RadStation> lists = radStationDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RadStation radStation : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("jzbh", radStation.getJZBH());
			map.put("jzname",radStation.getJZNAME());
			map.put("coderegionshi", radStation.getCODEREGIONSHI());
			map.put("coderegionxian",radStation.getCODEREGIONXIAN());
			map.put("enteraddress", radStation.getENTERADDRESS());
			map.put("qylx",radStation.getQYLX());
			map.put("fsjxh",radStation.getFSJXH());
			map.put("txxqj", radStation.getTXXQJ());
			map.put("ysgzlx",radStation.getYSGZLX());
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
		columnMap.put("title", "辐射基站数据表");

		columnMap.put("jzbh", "编号");
		columnMap.put("jzname", "基站名称");
		columnMap.put("coderegionshi", "市");
		columnMap.put("coderegionxian", "区县");
		columnMap.put("enteraddress", "地址");
		columnMap.put("qylx", "区域类型");
		columnMap.put("fsjxh", "发射机型号");
		columnMap.put("txxqj", "天线下倾角");
		columnMap.put("ysgzlx", "验收共站类型");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
