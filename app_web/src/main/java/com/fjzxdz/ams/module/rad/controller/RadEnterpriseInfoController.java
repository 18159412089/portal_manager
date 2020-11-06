/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rad.dao.RadEnterpriseInfoDao;
import com.fjzxdz.ams.module.rad.entity.RadEnterpriseInfo;
import com.fjzxdz.ams.module.rad.param.RadEnterpriseInfoParam;
import com.fjzxdz.ams.module.rad.service.RadEnterpriseInfoService;
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
 * 辐射企业信息Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radEnterpriseInfo")
@Secured({ "ROLE_USER" })
public class RadEnterpriseInfoController extends BaseController {
	
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RadEnterpriseInfoService radEnterpriseInfoService;
	@Autowired
	private RadEnterpriseInfoDao radEnterpriseInfoDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rad/radEnterpriseInfoList";
	}
	
	/**
	 * 更新或新增
	 * @param radEnterpriseInfo
	 * @return
	 */	
/*	@RequestMapping("/saveRadEnterpriseInfo")
	@ResponseBody
	public R saveRadEnterpriseInfo(RadEnterpriseInfo radEnterpriseInfo) {
		try {
			radEnterpriseInfoService.save(radEnterpriseInfo);
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
/*	@RequestMapping("/deleteRadEnterpriseInfo")
	@ResponseBody
	public R deleteRadEnterpriseInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			radEnterpriseInfoService.delete(uuid);
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
	@RequestMapping("/getRadEnterpriseInfo")
	@ResponseBody
	public Map<String, Object> getRadEnterpriseInfo(@RequestParam(value = "uuid") String uuid) {
		RadEnterpriseInfo radEnterpriseInfo = simpleDao.findUnique("from RadEnterpriseInfo where ENTERID=?",uuid);
		return BeanUtil.beanToMap(radEnterpriseInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param radEnterpriseInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/radEnterpriseInfoList")
	@ResponseBody
	public PageEU<RadEnterpriseInfo> radEnterpriseInfoList(RadEnterpriseInfoParam radEnterpriseInfoParam, HttpServletRequest request) {
		Page<RadEnterpriseInfo> page = radEnterpriseInfoService.listByPage(radEnterpriseInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 查询列表
	 * @param stationName
	 * @return
	 */
	@RequestMapping("/getradEnterpriseInfoListForMap")
	@ResponseBody
	public String getradEnterpriseInfoListForMap(String stationName) {
		JSONArray enterpriseList = radEnterpriseInfoService.getradEnterpriseInfoListForMap(stationName);
		
		return enterpriseList.toString();
	}
	
	@RequestMapping("/getRadEnterpriseInfoList")
	@ResponseBody
	public List<Map<String, Object>> getRadEnterpriseInfoList(String stationName) {
	 
		List<Map<String, Object>> list = radEnterpriseInfoService.getRadEnterpriseInfoList(stationName);
		for (Map<String, Object> map : list) {
			map.put ("UPDATETIME_RJWA","");
		}
		return list;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RadEnterpriseInfoParam param, HttpServletResponse response){
		List<RadEnterpriseInfo> lists = radEnterpriseInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RadEnterpriseInfo radEnterpriseInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entername", radEnterpriseInfo.getENTERNAME());
			map.put("fddbr", radEnterpriseInfo.getFDDBR());
			map.put("frdh", radEnterpriseInfo.getFRDH());
			map.put("xkzfzjg", radEnterpriseInfo.getXKZFZJG());
			map.put("xkzh", radEnterpriseInfo.getXKZH());
			map.put("szsq",radEnterpriseInfo.getSZSQ());
			map.put("szqx", radEnterpriseInfo.getSZQX());
			map.put("txdz", radEnterpriseInfo.getTXDZ());
			map.put("hylb", radEnterpriseInfo.getHYLB());
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
		columnMap.put("title", "辐射企业数据表");

		columnMap.put("entername", "单位名称");
		columnMap.put("fddbr", "法定代表人");
		columnMap.put("frdh", "法人电话");
		columnMap.put("xkzfzjg", "许可证发证机关");
		columnMap.put("xkzh", "许可证号");
		columnMap.put("szsq", "所在市区");
		columnMap.put("szqx", "所在区县");
		columnMap.put("txdz", "注册地址");
		columnMap.put("hylb", "行业类别");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
