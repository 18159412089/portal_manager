package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.math.BigDecimal;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.param.AirMonitorPointParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.util.AqiUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * 大气环境服务。地图上站点显示。 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年4月24日 上午11:19:35
 */
@Controller
@RequestMapping("/enviromonit/airMonitorPoint")
@Secured({ "ROLE_USER" })
public class AirMonitorPointController extends BaseController {

	@Autowired
	private AirMonitorPointService airMonitorPointService;

	@Autowired
	private AirHourDataService airHourDataService;

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView) {

		modelAndView.setViewName("/moudles/enviromonit/air/airMonitorPointList");
		return modelAndView;
	}
	/**
	 * 查询列表
	 * @param
	 * @param request
	 * @return
	 */
	@RequestMapping("/airMonitorPointList")
	@ResponseBody
	public PageEU<AirMonitorPoint> airMonitorPointList(AirMonitorPointParam airMonitorPointParam, HttpServletRequest request) {
		Page<AirMonitorPoint> page = airMonitorPointService.listByPage(airMonitorPointParam, pageQuery(request));
		List<AirMonitorPoint> list= page.getResult();
		if (list.size()!=0){
			for (AirMonitorPoint airMonitorPoint : list) {
				if (airMonitorPoint.getPointType().equals("1")){
					airMonitorPoint.setPointType("城市");
				}else if(airMonitorPoint.getPointType().equals("0")){
					airMonitorPoint.setPointType("定位");
				}else{
					airMonitorPoint.setPointType("其他");
				}
			}
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
		AirMonitorPointParam airMonitorPointParam=new AirMonitorPointParam();
		String pointCode=request.getParameter("pointCode");
		String pointName=request.getParameter("pointName");
		String codeAirLevel=request.getParameter("codeAirLevel");
		String codeRegion=request.getParameter("codeRegion");
		String regionName=request.getParameter("regionName");
		String yearNumber=request.getParameter("yearNumber");
		airMonitorPointParam.setPointCode(pointCode);
		airMonitorPointParam.setPointName(pointName);
		airMonitorPointParam.setCodeAirLevel(codeAirLevel);
		airMonitorPointParam.setCodeRegion(codeRegion);
		airMonitorPointParam.setRegionName(regionName);
		airMonitorPointParam.setYearNumber(yearNumber);
		Page<AirMonitorPoint> page = airMonitorPointService.listByPage(airMonitorPointParam, pageQuery(request));
		List<AirMonitorPoint> list=page.getResult();
		if(list.size()!=0) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			columnMap.put("title", "空气环境监测站点");
			columnMap.put("pointCode", "断面编码");
			columnMap.put("pointName", "站点名称");
			columnMap.put("pointType", "站点类型");
			columnMap.put("codeAirLevel", "站点级别");
			columnMap.put("codeRegion", "行政区代码");
			columnMap.put("regionName", "行政区名称");
			columnMap.put("yearNumber", "年份");
			columnMap.put("longitude", "经度");
			columnMap.put("latitude", "纬度");
			List<Map<String, Object>> result = new ArrayList<>();
			for (AirMonitorPoint airMonitorPoint : list) {
				if (airMonitorPoint.getPointType().equals("1")){
					airMonitorPoint.setPointType("城市");
				}else if(airMonitorPoint.getPointType().equals("0")){
					airMonitorPoint.setPointType("定位");
				}else{
					airMonitorPoint.setPointType("其他");
				}
				Map<String, Object> tempMap = new HashMap<>();
				tempMap.put("pointCode",airMonitorPoint.getPointCode());
				tempMap.put("pointName",airMonitorPoint.getPointName());
				tempMap.put("pointType",airMonitorPoint.getPointType());
				tempMap.put("codeAirLevel",airMonitorPoint.getCodeAirLevel());
				tempMap.put("codeRegion",airMonitorPoint.getCodeRegion());
				tempMap.put("regionName",airMonitorPoint.getRegionName());
				tempMap.put("yearNumber",airMonitorPoint.getYearNumber());
				tempMap.put("longitude",airMonitorPoint.getLongitude());
				tempMap.put("latitude",airMonitorPoint.getLatitude());
				result.add(tempMap);
			}
			ExcelExportUtil.exportExcel(response, columnMap, result);
		}
	}
	
	/**
	 *
	 * @Title:  getCityByType
	 * @Description:    大气服务页面 添加城市或监测点
	 * @CreateBy: zhongyunlong
	 * @CreateTime: 2019年5月9日 下午2:50:24
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:50:24    
	 * @param type	站点类型
	 * @param pointCode	城市编号(只有查询城市下面的子站点才需要传)
	 * @param factor	污染因子编号
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getCityByType")
	@ResponseBody
	public String getCityByType(String type, @RequestParam(value = "pointCode", required = false) String pointCode, String factor) {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<AirMonitorPoint> list = new ArrayList<AirMonitorPoint>();

		// 最新城市点位信息
 		List<Object[]> resultList = airMonitorPointService.getCityByType(type, pointCode, factor, getUserDeptName());
		// 最新时间(时间按漳州最新数据为准)的城市信息
//		List<Object[]> pointList = airHourDataService.rankingOrderByAQI(type, pointCode);
		List<Object[]> pointList = airHourDataService.rankingOrderByAQI(type, pointCode, getUserDeptName());
		if (pointCode == null) {
			if (type != null) {
				list = airMonitorPointService.getPointByType(type, getUserDeptName());
			}
		} else {
			list = airMonitorPointService.getMonitorPointByCity(pointCode);
		}

		if (resultList.size() <= 0) {
			for (AirMonitorPoint airMonitorPoint : list) {
				jsonObject = pointInfoIsNull(jsonObject, airMonitorPoint);
				jsonArray.put(jsonObject);
			}
		} else {
			for (Object[] objects : resultList) {
					
				jsonObject = pointInfo(jsonObject,objects,factor);
				jsonArray.put(jsonObject);
			}
			// 部分站点没数据的情况，给予默认值
			if (pointList.size() < list.size()) {
				for (AirMonitorPoint airMonitorPoint : list) {
					int i = 0;
					for (Object[] objects : pointList) {
						if (!airMonitorPoint.getPointCode().equals(objects[1])) {
							i++;
						}
						if (i == pointList.size()) {
							jsonObject = pointInfoIsNull(jsonObject, airMonitorPoint);
							jsonArray.put(jsonObject);
						}
					}

				}
			}
			
		}
		return jsonArray.toString();

	}

	/**
	 * 
	 * @Title:  getCityListByType
	 * @Description:    获取站点信息分页
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年6月20日 下午3:29:39
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年6月20日 下午3:29:39    
	 * @param param
	 * @param request
	 * @return  PageEU<AirMonitorPoint> 
	 * @throws
	 */
	@RequestMapping("/getCityListByType")
	@ResponseBody
	public PageEU<AirMonitorPoint> getCityListByType(AirMonitorPointParam param, HttpServletRequest request) {
		Page<AirMonitorPoint> page = pageQuery(request);
		Page<AirMonitorPoint> airMonitorPoint = airMonitorPointService.listByPage(param, page);
		return new PageEU<>(airMonitorPoint);
	}
	
	/**
	 * 
	 * @Title:  getPointsInfo
	 * @Description:    根据pointCode获取相关数据
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年6月20日 下午3:29:15
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年6月20日 下午3:29:15    
	 * @param pointCode
	 * @return  JSONObject 
	 * @throws
	 */
	@RequestMapping("/getPointsInfo")
	@ResponseBody
	public JSONObject getPointsInfo(String pointCode) {
	    List<Map> list = airMonitorPointService.getPointInfo(pointCode);
	    //String pointCode = MapUtils.getString(list.get(0), "pointCode", "");
	    JSONObject jsonObject = new JSONObject();
	    jsonObject.put("pointName", list.get(0).get("pointName"));
	    jsonObject.put("pointCode", list.get(0).get("pointCode"));
	    jsonObject.put("monitrorTime", list.get(0).get("monitorTime"));
        jsonObject.put("pointType", list.get(0).get("pointType"));
        jsonObject.put("aqi", list.get(0).get("aqi"));
        jsonObject.put("longitude", list.get(0).get("longitude"));
        jsonObject.put("latitude", list.get(0).get("latitude"));
        jsonObject.put("CO", list.get(0).get("co"));
        jsonObject.put("No2", list.get(0).get("no2"));
        jsonObject.put("PM10", list.get(0).get("pm10"));
        jsonObject.put("PM2", list.get(0).get("pm2"));
        jsonObject.put("So2", list.get(0).get("so2"));
        jsonObject.put("O3", list.get(0).get("o3"));
        return jsonObject;
	}
	/**
	 * 
	 * @Title:  getCity
	 * @Description:    获取城市编号和名称    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午2:57:03
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午2:57:03    
	 * @param all	(1为带全部项，0不带)
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getCity")
	@ResponseBody
	public String getCity(@RequestParam(value = "all", required = false)Boolean all) {
		List<AirMonitorPoint> list = airMonitorPointService.getCity();
		com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();
		if (all == null ? false : all) {
			JSONObject area = new JSONObject();
			area.put("uuid", "all");
			area.put("name", "-- 全部 --");
			array.add(area);
		}
		if (list != null) {
			for (AirMonitorPoint airMonitorPoint : list) {
				JSONObject area = new JSONObject();
				area.put("uuid", airMonitorPoint.getPointCode());
				area.put("name", airMonitorPoint.getPointName());
				array.add(area);
			}
		}

		return array.toJSONString();
	}

	/**
	 * 
	 * @Title:  getPointByCity
	 * @Description:    TODO(与地区联动获取该地区下的站点)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年7月1日 下午4:54:41
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年7月1日 下午4:54:41    
	 * @param parent
	 * @param getAll true:加载“全部”节点，反之亦然
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getPointByCity")
	@ResponseBody
	public String getPointByCity(String parent, boolean getAll) {
		com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();
		List<AirMonitorPoint> list = new ArrayList<>();
		if(StringUtils.equals(parent, "all")) {
//			list = airMonitorPointService.getPointByType("0");
            list = airMonitorPointService.getPointByType("0", getUserDeptName());
		}else {
			list = airMonitorPointService.getMonitorPointByCity(parent);
		}
		if (list != null) {
			if(ToolUtil.isEmpty(getAll)?true:getAll) {
				JSONObject all = new JSONObject();
				all.put("uuid", "all");
				all.put("name", "-- 全部 --");
				array.add(all);
			}
			for (AirMonitorPoint airMonitorPoint : list) {
				JSONObject area = new JSONObject();
				area.put("uuid", airMonitorPoint.getPointCode());
				area.put("name", airMonitorPoint.getPointName());
				array.add(area);
			}
		}

		return array.toJSONString();
	}
	
	/**
	 * 获取站点的uuid和名字
	 * @param pointType 站点类型
	 * @return JSONArray
	 */
	@RequestMapping("/getPointListByType")
	@ResponseBody
	public com.alibaba.fastjson.JSONArray getPointListByType(String pointType) {
//		List<AirMonitorPoint> list = airMonitorPointService.getPointByType(pointType);
		List<AirMonitorPoint> list = airMonitorPointService.getPointByType(pointType, getUserDeptName());
		com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();
		if (list != null) {
			for (AirMonitorPoint airMonitorPoint : list) {
				JSONObject area = new JSONObject();
				area.put("id", airMonitorPoint.getPointCode());
				area.put("text", airMonitorPoint.getPointName());
				array.add(area);
			}
		}

		return array;
	}


	/**
	 * 
	 * @Title:  getChildrenPointByType
	 * @Description:    getChildrenPointByType   
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:03:49
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:03:49    
	 * @param type
	 * @param pointCode
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getChildrenPointByType")
	@ResponseBody
	public String getChildrenPointByType(String type,String pointCode) {
		com.alibaba.fastjson.JSONArray array = new com.alibaba.fastjson.JSONArray();
		if (type.equals("1")) {
//			List<AirMonitorPoint> list = airMonitorPointService.getPointByType(type);
			List<AirMonitorPoint> list = airMonitorPointService.getPointByType(type,getUserDeptName());
			if (list != null) {
				for (AirMonitorPoint airMonitorPoint : list) {
					JSONObject area = new JSONObject();
					area.put("uuid", airMonitorPoint.getPointCode());
					area.put("name", airMonitorPoint.getPointName());
					array.add(area);
				}
			}
		}else if (type.equals("0")) {
			List<Object[]> list = airMonitorPointService.getChildrenPointByType(pointCode);
			if (list != null) {
				for (Object[] airMonitorPoint : list) {
					JSONObject area = new JSONObject();
					area.put("uuid", airMonitorPoint[0]);
					area.put("name", airMonitorPoint[1]);
					array.add(area);
				}
			}
		}else if (type.equals("2")) {
//			List<AirMonitorPoint> list = airMonitorPointService.getPointByType(type);
			List<AirMonitorPoint> list = airMonitorPointService.getPointByType(type, getUserDeptName());
			if (list != null) {
				for (AirMonitorPoint airMonitorPoint : list) {
					JSONObject area = new JSONObject();
					area.put("uuid", airMonitorPoint.getPointCode());
					area.put("name", airMonitorPoint.getPointName());
					array.add(area);
				}
			}
		}
		
		return array.toJSONString();
	}
	
	
	@RequestMapping("/getPonitList")
	@ResponseBody
	public com.alibaba.fastjson.JSONArray getPonitList() {
		return airMonitorPointService.getPonitList("");
	}

	/**
	 * 添加对应的污染物的名称和值
	 * 
	 * @param jsonObject
	 * @param name
	 * @param value
	 * @return
	 */
	public JSONObject add(JSONObject jsonObject, String name, String value) {
		if (name.equals("一氧化碳")) {
			jsonObject.put("CO", value);
		} else if (name.equals("二氧化氮")) {
			jsonObject.put("No2", value);
		} else if (name.equals("臭氧(8h)")) {
			jsonObject.put("O3(8h)", value);
		} else if (name.equals("PM10")) {
			jsonObject.put("PM10", value);
		} else if (name.equals("PM2.5")) {
			jsonObject.put("PM2", value);
		} else if (name.equals("二氧化硫")) {
			jsonObject.put("So2", value);
		} else if (name.equals("臭氧")) {
			jsonObject.put("O3", value);
		}
		return jsonObject;

	}
	/**
	 * 站点信息封装
	 * @param jsonObject
	 * @param objects
	 * @return
	 */
	public JSONObject pointInfo(JSONObject jsonObject ,Object objects[],String factor) {
		jsonObject.put("pointName", objects[0]);
		jsonObject.put("pointCode", objects[1]);
		jsonObject.put("value",((BigDecimal )objects[2]).setScale(1,BigDecimal.ROUND_UP).doubleValue());
		jsonObject.put("pointType", objects[3]);
		jsonObject.put("monitrorTime", objects[4]);
		double aqInteger=0;
		if("aqi".equals(factor)) {
			aqInteger = ((BigDecimal )objects[2]).setScale(0,BigDecimal.ROUND_UP).intValue();
			jsonObject.put("aqi",aqInteger);
		}else {
			double d = AqiUtil.countPerIaqi(Double.parseDouble(objects[2].toString()), getPollutionNUmber(factor));
			aqInteger = (new BigDecimal(String.valueOf(d))).setScale(0,BigDecimal.ROUND_UP).intValue();
			jsonObject.put("aqi",objects[14]);
		}
		jsonObject.put("color", aqInteger);
		if (objects[5] != null && objects[6] != null) {
			jsonObject.put("longitude", Double.valueOf(String.valueOf(objects[5])));
			jsonObject.put("latitude", Double.valueOf(String.valueOf(objects[6])));
		}else {
			jsonObject.put("longitude", "-");
			jsonObject.put("latitude", "-");
		}

		jsonObject.put("No2", String.valueOf(objects[7]));
		jsonObject.put("O3", String.valueOf(objects[8]));
		jsonObject.put("PM10", String.valueOf(objects[9]));
		jsonObject.put("PM2", String.valueOf(objects[10]));
		jsonObject.put("So2", String.valueOf(objects[11]));
		jsonObject.put("CO", String.valueOf(objects[12]));
		jsonObject.put("O3(8h)", String.valueOf(objects[13]));
		
		return jsonObject;

	}
	
	public Integer getPollutionNUmber(String factor){
		if("A34004".equals(factor)) {
			return 1;
		}else if("A34002".equals(factor)) {
			return 2;
		}else if("A21005".equals(factor)) {
			return 3;
		}else if("A21004".equals(factor)) {
			return 4;
		}else if("A050248".equals(factor)) {
			return 5;
		}else {
			return 6;
		}
	}

	/**
	 * 设置暂无数据的站点信息
	 * 
	 * @param jsonObject
	 * @param airMonitorPoint
	 * @return
	 */
	public JSONObject pointInfoIsNull(JSONObject jsonObject, AirMonitorPoint airMonitorPoint) {
		jsonObject.put("pointName", airMonitorPoint.getPointName());
		jsonObject.put("pointCode", airMonitorPoint.getPointCode());
		jsonObject.put("monitrorTime", "暂无数据");
		jsonObject.put("pointType", airMonitorPoint.getPointType());
		jsonObject.put("value", "-");
		jsonObject.put("color", -1);
		jsonObject.put("longitude", airMonitorPoint.getLongitude());
		jsonObject.put("latitude", airMonitorPoint.getLatitude());
		jsonObject.put("CO", "-");
		jsonObject.put("No2", "-");
		jsonObject.put("PM10", "-");
		jsonObject.put("PM2", "-");
		jsonObject.put("So2", "-");
		jsonObject.put("O3", "-");
		return jsonObject;
	}
}
