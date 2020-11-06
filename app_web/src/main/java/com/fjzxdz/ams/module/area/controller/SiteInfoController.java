/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.area.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.area.dao.SiteInfoDao;
import com.fjzxdz.ams.module.area.entity.SiteInfo;
import com.fjzxdz.ams.module.area.param.SiteInfoParam;
import com.fjzxdz.ams.module.area.service.SiteInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
 * 近岸海域点位信息Controller
 * @author htj
 * @version 2019-02-20
 */
@Controller
 
@RequestMapping(value = "/area/siteInfo")
 
public class SiteInfoController extends BaseController {
	
	@Autowired
	private SiteInfoDao siteInfoDao;
	@Autowired
	private SiteInfoService siteInfoService;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "area/siteInfoList";
	}
	
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("/gotoAreaSiteInfoMap")
	public String gotoAreaSiteInfoMap() {
		return "/moudles/" + "area/areaSiteInfoMap";
	}
	
	/**
	 * 更新或新增
	 * @param siteInfo
	 * @return
	 */	
	@RequestMapping("/saveSiteInfo")
	@ResponseBody
	public R saveSiteInfo(SiteInfo siteInfo) {
		try {
			siteInfoService.save(siteInfo);
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
	@RequestMapping("/deleteSiteInfo")
	@ResponseBody
	public R deleteSiteInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			siteInfoService.delete(uuid);
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
	@RequestMapping("/getSiteInfo")
	@ResponseBody
	public Map<String, Object> getSiteInfo(@RequestParam(value = "uuid") String uuid) {
		SiteInfo siteInfo = siteInfoDao.getById(uuid);
		return BeanUtil.beanToMap(siteInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param siteInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/siteInfoList")
	@ResponseBody
	public PageEU<SiteInfo> siteInfoList(SiteInfoParam siteInfoParam, HttpServletRequest request) {
		Page<SiteInfo> page = siteInfoService.listByPage(siteInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	
	@RequestMapping("/getAreaSiteInfoList")
	@ResponseBody
	public JSONArray getAreaSiteInfoList(String stationName, HttpServletRequest request) {
		JSONArray areaSiteArray = new JSONArray();
		areaSiteArray = siteInfoService.getAreaSiteInfoList(stationName);
		return areaSiteArray;	
	}
	
	

 
	@RequestMapping("/getAreaSiteInfoPage")
	@ResponseBody
	public PageEU<SiteInfo> getAreaSiteInfoPage(String stationName, HttpServletRequest request) {
		JSONArray areaSiteArray = new JSONArray();
		String wherecaseStr = "";
		if( !StringUtils.isEmpty(stationName) ){
			wherecaseStr = " where   si.KDMC like '%"+stationName+"%'" ;
		}
		String queryString = "from SiteInfo as si "+wherecaseStr;	
		Page<SiteInfo>  page=	siteInfoDao.listByPage(queryString, pageQuery(request));
		
		return new PageEU<SiteInfo>(page);
	} 
	
	/**
	 *  根据省控编码获取近海站点信息
	 * @param SKBM
	 * @return
	 */
	@RequestMapping("/getAreaSiteInfoListBySkbm")
	@ResponseBody
	public JSONArray getAreaSiteInfoListBySkbm(String SKBM) {
		JSONArray areaSiteArray = new JSONArray();
		areaSiteArray = siteInfoService.getAreaSiteInfoListBySkbm(SKBM);
		return areaSiteArray;	
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(SiteInfoParam param, HttpServletResponse response){
		List<SiteInfo> lists = siteInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (SiteInfo siteInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("gkbm", siteInfo.getGKBM());
			map.put("skbm",siteInfo.getSKBM());
			map.put("xzqh", siteInfo.getXZQH());
			map.put("gw",siteInfo.getGW());
			map.put("gxsj", siteInfo.getGXSJ());
			map.put("nf",siteInfo.getNF());
			map.put("wd",siteInfo.getWD());
			map.put("jd", siteInfo.getJD());
			map.put("zt",siteInfo.getZT());
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
		columnMap.put("title", "近岸海域点位数据表");

		columnMap.put("gkbm", "国控点位编码");
		columnMap.put("skbm", "省控点位编码");
		columnMap.put("xzqh", "行政区");
		columnMap.put("gw", "海湾");
		columnMap.put("gxsj", "更新时间");
		columnMap.put("nf", "年份");
		columnMap.put("wd", "纬度");
		columnMap.put("jd", "经度");
		columnMap.put("zt", "状态");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
