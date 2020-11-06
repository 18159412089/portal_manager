package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDailyService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * AQI指数分析页面 controller 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:36:43
 */
@Controller
@RequestMapping("/enviromonit/airQualityAQI")
@Secured({ "ROLE_USER" })
public class AirQualityAQIController extends BaseController {

	
	
	
	@Autowired
	private AirDailyService airDailyService;
	
	/**
	 * 
	 * @Title:  getAirQualityAQI
	 * @Description:    数据服务 空气环境质量  AQI指数变化分析页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:37:16
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:37:16    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping(value = "")
	public String getAirQualityAQI() {
		return "/moudles/enviromonit/air/airQualityAQI";
	}
	
	/**
	 * 
	 * @Title:  index
	 * @Description:    数据服务 空气环境质量 空气质量日报查询页面     
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:41:45
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:41:45    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping(value = "/index")
	public String index() {
		return "/moudles/enviromonit/air/airQualityDaily";
	}
	
	/**
	 * 
	 * @Title:  curAirQuantity
	 * @Description:    空气质量日报信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:39:02
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:39:02    
	 * @param param
	 * @param time
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/curAirQuantity")
	@ResponseBody
	public R curAirQuantity(AirDayDataParam param,String time) {
		List<Object []> list = airDailyService.getCurAirQuality(param.getPointCode(),time);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (list.size() <= 0) {
			return null;
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("title", time);
		Double aqi;
		if (list.get(0)[2] == null) {
			aqi = (double) -1;
		}else {
			aqi = getAqi(list.get(0)[2]);
		}
		jsonObject.put("quantityText", getQuantityText(aqi));
		if (aqi<0) {
			jsonObject.put("quantityColor", "item");
		}
		else if (aqi<= 50) {
			jsonObject.put("quantityColor", "excellent");
		} else if (aqi <= 100) {
			jsonObject.put("quantityColor", "good");
		} else if (aqi <= 150) {
			jsonObject.put("quantityColor", "mild");
		} else if (aqi <= 200) {
			jsonObject.put("quantityColor", "moderate");
		} else if (aqi <= 300) {
			jsonObject.put("quantityColor", "severe");
		} else if (aqi <= 500) {
			jsonObject.put("quantityColor", "dangerous");
		}
		jsonObject.put("aqi", aqi);
		Aqi aq = AqiUtil.CountAqi(intValue(list.get(0)[3]), intValue(list.get(0)[4]), getAqi(list.get(0)[5]),
				intValue(list.get(0)[6]), intValue(list.get(0)[7]), getAqi(list.get(0)[8]));
		jsonObject.put("pollutant", aq.getName());
		jsonObject.put("PM25", list.get(0)[3]);
		jsonObject.put("PM10", list.get(0)[4]);
		jsonObject.put("CO", list.get(0)[5]);
		jsonObject.put("NO2", list.get(0)[6]);
		jsonObject.put("O3", list.get(0)[7]);
		jsonObject.put("SO2", list.get(0)[8]);
		map.put("data", jsonObject);
		return R.ok(map);
	}
	/**
	 * 
	 * @Title:  getAirQualityChart
	 * @Description:    本年本地区空气质量状况统计图    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:39:15
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:39:15    
	 * @param param
	 * @return  R 
	 * @throws
	 */
	@RequestMapping(value = "/getAirQualityChart")
	@ResponseBody
	public R getAirQualityChart(AirDayDataParam param) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> list = airDailyService.getAirQualityChart(param);
		Map<String, Object> factoryJson = new HashMap<String, Object>();
		if(ToolUtil.isNotEmpty(list)) {
			int a=0;
			int b=0;
			int c=0;
			int d=0;
			int e=0;
			int f=0;
			for(Object[] report : list) {
				if(ToolUtil.isNotEmpty(report[1])) {
					String aqi = String.valueOf(report[1]);
					if(Integer.parseInt(aqi)<=50) {
						a++;
					}else if(Integer.parseInt(aqi)<=100) {
						b++;
					}else if(Integer.parseInt(aqi)<=150) {
						c++;
					}else if(Integer.parseInt(aqi)<=200) {
						d++;
					}else if(Integer.parseInt(aqi)<=300) {
						e++;
					}else {
						f++;
					}
				}
			}
			factoryJson.put("优", a);
			factoryJson.put("良", b);
			factoryJson.put("轻度污染", c);
			factoryJson.put("中度污染", d);
			factoryJson.put("重度污染", e);
			factoryJson.put("严重污染", f);
		}
		if(ToolUtil.isNotEmpty(factoryJson)) {
			JSONArray data = new JSONArray();
			for(Map.Entry<String, Object> entry : factoryJson.entrySet()) {
				JSONObject temp = new JSONObject();
				temp.put("name", entry.getKey());
				temp.put("value", entry.getValue());
				temp.put("itemStyle", getColor(entry.getKey()));
				data.add(temp);
			}
			map.put("data", data);
		}
		return R.ok(map);
	}
	/**
	 * 
	 * @Title:  airQuantityForLastMonth
	 * @Description:    城市空气近30日AQI指数变化趋势图    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:40:04
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:40:04    
	 * @param param
	 * @return
	 * @throws Exception  R 
	 * @throws
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@RequestMapping(value = "/airQuantityForLastMonth")
	@ResponseBody
	public R airQuantityForLastMonth(AirDayDataParam param) throws Exception {
		Map<String, Object> result = new HashMap<>();
		List<Object[]> list = airDailyService.getAirQualityChart(param);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<String> xAxis = new ArrayList<String>();
		
		Map<String, Integer> indexmap = new HashMap<String, Integer>();
		Map<String, Object> timeMap = DateUtil.getDayLastMonth(sdf.parse(param.getEndTime()));
		Map<String, Object> map = new HashMap<String, Object>();
		xAxis = (List<String>) timeMap.get("xList");
		indexmap = (Map<String, Integer>) timeMap.get("indexmap");
		Map<String,Object[]> series = new HashMap<String,Object[]>();
		for (Object[] obj : list) {
			if (obj[0] != null) {
				if (series.containsKey("1")) {
					if (obj[1] != null) {
						series.get("1")[indexmap.get(obj[0].toString().substring(0, 10))]=obj[1];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[1] != null) {
						tempList[indexmap.get(obj[0].toString().substring(0, 10))]=obj[1];
					}
					series.put("1", tempList);
				}
			}
			
		}
		JSONArray xArray = new JSONArray();
		result.put("xAxis", xAxis);
		for (Object key : series.keySet()) {
			JSONObject xObject = new JSONObject();
			xObject.put("data", series.get(key));
			xObject.put("type", "line");
			xArray.add(xObject);
		}
		result.put("series", xArray);
		return R.ok(result);
	}
	
	/**
	 * 
	 * @Title:  list
	 * @Description:    日报分页查询    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午3:40:43
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午3:40:43    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Map<String, Object>> list(AirDayDataParam param, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> airDayDataPage = airDailyService.listByPage(param, page);
		if(ToolUtil.isNotEmpty(airDayDataPage.getResult())) {
			for(Map<String, Object> map : airDayDataPage.getResult()) {
				int pm25 = Integer.parseInt(map.get("pm25").toString());
				int pm10 = Integer.parseInt(map.get("pm10").toString());
				double co = Double.parseDouble(map.get("co").toString());
				double no2 = Double.parseDouble(map.get("no2").toString());
				double o3 = Double.parseDouble(map.get("o3").toString());
				double so2 = Double.parseDouble(map.get("so2").toString());
				map.put("aqi", AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getAqi().intValue());
				if (ToolUtil.isNotEmpty(map.get("aqi"))) {
					if (intValue(map.get("aqi"))<=50) {
						map.put("pollutant", "-");
						map.put("level", "一级");
						map.put("status", "优");
					}else if (intValue(map.get("aqi"))>50 && intValue(map.get("aqi"))<=100) {
						map.put("pollutant",  AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getName());
						map.put("level", "二级");
						map.put("status", "良");
					}else if (intValue(map.get("aqi"))>100 && intValue(map.get("aqi"))<=150) {
						map.put("pollutant",  AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getName());
						map.put("level", "三级");
						map.put("status", "轻度污染");
					}else if (intValue(map.get("aqi"))>150 && intValue(map.get("aqi"))<=200) {
						map.put("pollutant",  AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getName());
						map.put("level", "四级");
						map.put("status", "中度污染");
					}else if (intValue(map.get("aqi"))>200 && intValue(map.get("aqi"))<=300) {
						map.put("pollutant",  AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getName());
						map.put("level", "五级");
						map.put("status", "重度污染");
					}else if (intValue(map.get("aqi"))>30 && intValue(map.get("aqi"))<=500) {
						map.put("pollutant",  AqiUtil.CountAqi(pm25,pm10,co,no2,o3,so2).getName());
						map.put("level", "六级级");
						map.put("status", "严重污染");
					}
				}
				
			}
		}
		return new PageEU<>(airDayDataPage);
	}

	
	private JSONObject getColor(String level) {
		String result="";
		if("优".equals(level)) {
			result="#00E400";
		}else if("良".equals(level)) {
			result="#FFFF00";
		}else if("轻度污染".equals(level)) {
			result="#FF7E00";
		}else if("中度污染".equals(level)) {
			result="#FF0000";
		}else if("重度污染".equals(level)) {
			result="#99004C";
		}else {
			result="#7E0023";
		}
		JSONObject normalNode = new JSONObject();
		JSONObject colorNode = new JSONObject();
		colorNode.put("color",result);
		normalNode.put("normal", colorNode);
		return normalNode;
	}
	
	public Double getAqi(Object object) {
		
		return Double.valueOf(String.valueOf(object));
	}
	public Integer intValue(Object object) {

		return Double.valueOf(String.valueOf(object)).intValue();
	}
	
	public String getQuantityText(Double aqi) {
		if (aqi<0) {
			return "-";
		}else if (aqi<=50) {
			return "优";
		}else if (aqi<=100) {
			return "良";
		}else if (aqi<=150) {
			return "轻度";
		}else if (aqi<=200) {
			return "中度";
		}else if (aqi<=300) {
			return "重度";
		}
		return "严重"; 
	}
}
