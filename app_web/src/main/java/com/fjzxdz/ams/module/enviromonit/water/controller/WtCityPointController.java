package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityPointParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * enviromonit/water/wtCityPoint/getPointRegionList
 * 监测站点
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:30:31
 */
@Controller
@RequestMapping("/enviromonit/water/wtCityPoint")
@Secured({ "ROLE_USER" })
public class WtCityPointController extends BaseController{

	@Autowired
	private WtCityPointService wtCityPointService;

	@Autowired
	private SimpleDao simpleDao;

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView) {

		modelAndView.setViewName("/moudles/enviromonit/water/wtCityPointList");
		return modelAndView;
	}

	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/wtCityPointList")
	@ResponseBody
	public PageEU<WtCityPoint> wtCityPointList(WtCityPointParam wtCityPointParam, HttpServletRequest request, HttpServletResponse response) {
		Page<WtCityPoint> page = wtCityPointService.listByPage(wtCityPointParam, pageQuery(request));
		List<WtCityPoint> list=page.getResult();
		if("yes".equals(request.getParameter("export"))&&list.size()!=0) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			columnMap.put("title", "水环境城市站点");
			columnMap.put("pointCode", "站点编码");
			columnMap.put("pointName", "站点名称");
			columnMap.put("codeWsystem", "流域编码");
			columnMap.put("wsystemName", "流域名称");
			columnMap.put("codeRegion", "区县");
			columnMap.put("regionName", "流域");
			columnMap.put("longitude", "经度");
			columnMap.put("latitude", "纬度");
			columnMap.put("pointQuality", "目标水质");
			List<Map<String, Object>> result = new ArrayList<>();
			for (WtCityPoint wtCityPoint : list) {
				Map<String, Object> tempMap = new HashMap<>();
				tempMap.put("pointCode",wtCityPoint.getPointCode());
				tempMap.put("pointName",wtCityPoint.getPointName());
				tempMap.put("codeWsystem",wtCityPoint.getCodeWsystem());
				tempMap.put("wsystemName",wtCityPoint.getWsystemName());
				tempMap.put("codeRegion",wtCityPoint.getCodeRegion());
				tempMap.put("regionName",wtCityPoint.getRegionName());
				tempMap.put("longitude",wtCityPoint.getLongitude());
				tempMap.put("latitude",wtCityPoint.getLatitude());
				tempMap.put("pointQuality",wtCityPoint.getPointQuality());
				result.add(tempMap);
			}
			ExcelExportUtil.exportExcel(response, columnMap, result);
			return null;
		}
		return new PageEU<>(page);
	}
	/**
	 * 导出
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/export")
	@ResponseBody
	public void export(HttpServletRequest request, HttpServletResponse response) {
		WtCityPointParam wtCityPointParam=new WtCityPointParam();
		String pointCode=request.getParameter("pointCode");
		String pointName=request.getParameter("pointName");
		String codeWsystem=request.getParameter("codeWsystem");
		String wsystemName=request.getParameter("wsystemName");
		String codeRegion=request.getParameter("codeRegion");
		String regionName=request.getParameter("regionName");
		wtCityPointParam.setPointCode(pointCode);
		wtCityPointParam.setPointName(pointName);
		wtCityPointParam.setCodeWsystem(codeWsystem);
		wtCityPointParam.setWsystemName(wsystemName);
		wtCityPointParam.setCodeRegion(codeRegion);
		wtCityPointParam.setRegionName(regionName);
		Page<WtCityPoint> page = wtCityPointService.listByPage(wtCityPointParam, pageQuery(request));
		List<WtCityPoint> list=page.getResult();
		if(list.size()!=0) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			columnMap.put("title", "水环境城市站点");
			columnMap.put("pointCode", "站点编码");
			columnMap.put("pointName", "站点名称");
			columnMap.put("codeWsystem", "流域编码");
			columnMap.put("wsystemName", "流域名称");
			columnMap.put("codeRegion", "区县");
			columnMap.put("regionName", "流域");
			columnMap.put("longitude", "经度");
			columnMap.put("latitude", "纬度");
			columnMap.put("pointQuality", "目标水质");
			List<Map<String, Object>> result = new ArrayList<>();
			for (WtCityPoint wtCityPoint : list) {
				Map<String, Object> tempMap = new HashMap<>();
				tempMap.put("pointCode",wtCityPoint.getPointCode());
				tempMap.put("pointName",wtCityPoint.getPointName());
				tempMap.put("codeWsystem",wtCityPoint.getCodeWsystem());
				tempMap.put("wsystemName",wtCityPoint.getWsystemName());
				tempMap.put("codeRegion",wtCityPoint.getCodeRegion());
				tempMap.put("regionName",wtCityPoint.getRegionName());
				tempMap.put("longitude",wtCityPoint.getLongitude());
				tempMap.put("latitude",wtCityPoint.getLatitude());
				tempMap.put("pointQuality",wtCityPoint.getPointQuality());
				result.add(tempMap);
			}
			ExcelExportUtil.exportExcel(response, columnMap, result);
		}
	}
	/**
	 * 
	 * @Title:  getPointList
	 * @Description:    获取站点列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:05:54
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:05:54    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPointList")
	@ResponseBody
	public JSONArray getPointList(int type) {
		return wtCityPointService.getPointList(type);
	}
	
	/**
	 * 
	 * @Title:  getPointsList
	 * @Description:   获取站点列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:07:19
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:07:19    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPointsList")
	@ResponseBody
	public JSONArray getPointsList(int type) {
		return wtCityPointService.getPointsList(type);
	}
	
	/**
	 * 
	 * @Title:  getPointListByRegion
	 * @Description:   获取站点列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:07:19
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:07:19    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPointListByRegion")
	@ResponseBody
	public JSONArray getPointListByRegion(int type,String regionCode) {
		return wtCityPointService.getPointListByRegion(type,regionCode);
	}

	/**
	 *  获取站点中的区域
	 * @return
	 */
	@RequestMapping("/getPointRegionList")
	@ResponseBody
	public JSONArray getPointRegionList() {
		return wtCityPointService.getPointRegionList();
	}

	/**
	 *  获取站点中的流域
	 * @return
	 */
	@RequestMapping("/getPointRiverList")
	@ResponseBody
	public JSONArray getPointRiverList() {
		List<Map<String, Object>> list = simpleDao.getNativeQueryList("select DISTINCT WSYSTEM_NAME name,CODE_WSYSTEM code from WT_CITY_POINT where CATEGORY=1");
		JSONArray result = new JSONArray();
		for(Map<String, Object> map : list){
			JSONObject temp = new JSONObject();
			temp.put("id", map.get("code"));
			temp.put("text", map.get("name"));
			result.add(temp);
		}
		return result;
	}

	/**
	 *
	 * @Description:   获取流域内的站点列表
	 * @return  JSONArray
	 */
	@RequestMapping("/getPointListByRiver")
	@ResponseBody
	public JSONArray getPointListByRiver(String riverName) {
		List<Map<String, Object>> list = simpleDao.getNativeQueryList("select DISTINCT POINT_CODE code, POINT_NAME name from WT_CITY_POINT where WSYSTEM_NAME like '%"+ riverName +"%'");
		JSONArray result = new JSONArray();
		for(Map<String, Object> map : list){
			JSONObject temp = new JSONObject();
			temp.put("id", map.get("code"));
			temp.put("text", map.get("name"));
			result.add(temp);
		}
		return result;
	}


	/**
	 *
	 * @Description:   获取区域内的站点列表
	 * regionCode :区域编码
	 * @return  JSONArray
	 */
	@RequestMapping("/getPointListByRegionCode")
	@ResponseBody
	public JSONArray getPointListByRegionCode(String regionCode) {
		List<Map<String, Object>> list = simpleDao.getNativeQueryList("select DISTINCT POINT_CODE code, POINT_NAME name from WT_CITY_POINT where CODE_REGION = '"+ regionCode +"'");
		JSONArray result = new JSONArray();
		for(Map<String, Object> map : list){
			JSONObject temp = new JSONObject();
			temp.put("id", map.get("code"));
			temp.put("text", map.get("name"));
			result.add(temp);
		}
		return result;
	}


}
