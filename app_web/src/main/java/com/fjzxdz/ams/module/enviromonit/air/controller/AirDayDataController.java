package com.fjzxdz.ams.module.enviromonit.air.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.dao.AirDayDataDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirDayData;
import com.fjzxdz.ams.module.enviromonit.air.param.AirHourDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.param.AirDayDataParam;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Controller
@RequestMapping("/enviromonit/airDayData")
@Secured({ "ROLE_USER" })
public class AirDayDataController extends BaseController {

	@Autowired
	private AirDayDataService airDayDataService;
	@Autowired
	private AirDayDataDao airDayDataDao;

	/**
	 * 
	 * @Title:  calendar
	 * @Description:    跳转到空气日历页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:54:26
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:54:26    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/Calendar")
	public String calendar() {
		return "/moudles/enviromonit/air/airCalendar";
	}

	/**
	 * 
	 * @Title:  index
	 * @Description:    跳转到空气日数据页面    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:54:34
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:54:34    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/index")
	public String index() {
		return "/moudles/enviromonit/air/airDayDataList";
	}

	/**
	 * 
	 * @Title:  list
	 * @Description:    查询空气日数据信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:54:44
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:54:44    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Map<String, Object>> list(AirDayDataParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> airDayDataPage = airDayDataService.listByPage(param, page,response);
		if (ToolUtil.isEmpty(airDayDataPage)) return null;
		if (ToolUtil.isNotEmpty(airDayDataPage.getResult())) {
			for (Map<String, Object> map : airDayDataPage.getResult()) {
				if (ToolUtil.isEmpty(map.get("aqi"))) {
					int pm25 = Integer.parseInt(map.get("pm25").toString());
					int pm10 = Integer.parseInt(map.get("pm10").toString());
					double co = Double.parseDouble(map.get("co").toString());
					double no2 = Double.parseDouble(map.get("no2").toString());
					double o3 = Double.parseDouble(map.get("o3").toString());
					double so2 = Double.parseDouble(map.get("so2").toString());
					map.put("aqi", AqiUtil.CountAqi(pm25, pm10, co, no2, o3, so2).getAqi().intValue());
				}
			}
		}
		return new PageEU<>(airDayDataPage);
	}

	/**
	 * 
	 * @Title:  airQuantityForLastMonth
	 * @Description:    获取漳州市过去一个月的空气AQI值    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:52:43
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:52:43    
	 * @return  Map<String,Object> 
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/airQuantityForLastMonth")
	@ResponseBody
	public Map<String, Object> airQuantityForLastMonth() {

		List<Object[]> list = airDayDataService.airQuantityForLastMonth();
		Map<String, Object> result = new HashMap<>();
		List<String> xAxis = new ArrayList<String>();
		Map<String, Integer> indexmap = new HashMap<String, Integer>();
		Map<String, Object> timeMap = DateUtil.getSomeDay(30);
		xAxis = (List<String>) timeMap.get("xList");
		indexmap = (Map<String, Integer>) timeMap.get("indexmap");

		Map<String, Object[]> series = new HashMap<String, Object[]>();
		Map<String, Object[]> colors = new HashMap<String, Object[]>();
		if (ToolUtil.isNotEmpty(list)) {
			for (Object[] obj : list) {
				if (obj[0] != null) {
					if (series.containsKey(obj[0])) {
						if (obj[1] != null) {
							series.get(obj[0].toString())[indexmap.get(obj[2])] = obj[1];
							colors.get("color")[indexmap.get(obj[2])] = getColor(
									Integer.valueOf(String.valueOf(obj[1])));
						}
					} else {
						Object[] tempList = new Object[indexmap.size()];
						Object[] colorList = new Object[indexmap.size()];
						if (obj[1] != null) {
							tempList[indexmap.get(obj[2])] = obj[1];
							colorList[indexmap.get(obj[2])] = getColor(Integer.valueOf(String.valueOf(obj[1])));
						}
						series.put(obj[0].toString(), tempList);
						colors.put("color", colorList);
					}
				}
			}
		} else {
			Object[] tempList = new Object[indexmap.size()];
			series.put("list", tempList);
		}

		JSONObject timeObject = new JSONObject();
		timeObject.put("data", xAxis);
		result.put("xAxis", timeObject);
		JSONObject dataObject = new JSONObject();
		JSONArray dataArray = new JSONArray();

		for (Object key : series.keySet()) {

			dataObject.put("data", series.get(key));
			dataArray.add(dataObject);
		}
		result.put("data", dataArray);
		return result;
	}

	@RequestMapping("/getCityAirDayData")
	@ResponseBody
	public String getCityAirDayData(String pointCode) {

		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();

		List<Object[]> resultList = airDayDataService.getCityAirDayData();
		for (Object[] objects : resultList) {
			if (String.valueOf(objects[0]).equals("漳州市")) {
				jsonObject.put("name", "芗城区");
				jsonObject.put("value", Integer.valueOf(String.valueOf(objects[2])));
				jsonArray.put(jsonObject);
				jsonObject.put("name", "龙文区");
				jsonObject.put("value", Integer.valueOf(String.valueOf(objects[2])));
				jsonObject.put("itemStyle", getColor(Integer.valueOf(String.valueOf(objects[2]))));
				jsonArray.put(jsonObject);
				continue;
			}
			jsonObject.put("name", String.valueOf(objects[0]));
			jsonObject.put("value", Integer.valueOf(String.valueOf(objects[2])));
			jsonObject.put("itemStyle", getColor(Integer.valueOf(String.valueOf(objects[2]))));
			jsonArray.put(jsonObject);
		}
		return jsonArray.toString();

	}


	/**
	 * 
	 * @Title:  getCityByMonth
	 * @Description:    空气日历 日历显示    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:53:30
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:53:30    
	 * @param pointCode
	 * @param date
	 * @param firstDay
	 * @return
	 * @throws Exception  String 
	 * @throws
	 */
	@RequestMapping("/getCityByMonth")
	@ResponseBody
	public String getCityByMonth(String pointCode, String date, String firstDay) throws Exception {
		String time = date + "-01";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date start = df.parse(time);
		start = DateUtil.addDate(start, -Integer.valueOf(firstDay));
		Date end = DateUtil.addDate(start, +41);
		String startTime = df.format(start);
		String endTime = df.format(end);

		List<String> timeList = new ArrayList<String>();

		while (start.compareTo(end) <= 0) {
			timeList.add(df.format(start));
			start = DateUtil.addDate(start, 1);
		}

		List<Object[]> list = airDayDataService.getCityByMonth(pointCode, startTime, endTime);
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		String day = null;
		int i = 0;
		for (String nowTime : timeList) {
			if (ToolUtil.isNotEmpty(list)) {
				if (i < list.size()) {
					day = list.get(i)[1].toString();
					day = day.substring(0, 10);
				}

				if (nowTime.equals(day) && i < list.size()) {
					int aqi = Integer.valueOf(String.valueOf(list.get(i)[2]));

					if (aqi > 50) {
						Aqi aq = AqiUtil.CountAqi(intValue(list.get(i)[3]), intValue(list.get(i)[4]),
								getAqi(list.get(i)[5]), getAqi(list.get(i)[6]), getAqi(list.get(i)[7]),
								getAqi(list.get(i)[8]));
						jsonObject.put("polluteName", aq.getName());
					} else {
						jsonObject.put("polluteName", "—");
					}
					jsonObject = getColor(aqi, jsonObject);
					jsonObject.put("time", day.substring(0, 10));
					day = day.substring(8, 10);
					if (day.substring(0, 1).equals("0")) {
						jsonObject.put("day", Integer.valueOf(day.substring(1, 2)));
					} else {
						jsonObject.put("day", day);
					}
					jsonObject.put("aqi", aqi);
					jsonObject.put("pointCode", list.get(i)[9]);
					jsonArray.put(jsonObject);
					i++;

				} else {
					String nowDay = nowTime.substring(8, 10);
					if (nowDay.substring(0, 1).equals("0")) {
						jsonObject.put("day", Integer.valueOf(nowDay.substring(1, 2)));
					} else {
						jsonObject.put("day", nowDay);
					}
					jsonObject.put("pointCode", pointCode);
					jsonObject.put("polluteName", "—");
					jsonObject.put("time", "");
					jsonObject.put("color", "not_data");
					jsonArray.put(jsonObject);
				}
			} else {
				String nowDay = nowTime.substring(8, 10);
				if (nowDay.substring(0, 1).equals("0")) {
					jsonObject.put("day", Integer.valueOf(nowDay.substring(1, 2)));
				} else {
					jsonObject.put("day", nowDay);
				}
				jsonObject.put("pointCode", pointCode);
				jsonObject.put("polluteName", "—");
				jsonObject.put("time", "");
				jsonObject.put("color", "not_data");
				jsonArray.put(jsonObject);
			}

		}

		return jsonArray.toString();

	}

	/**
	 * 
	 * @Title:  getCityAirInfo
	 * @Description:    获取该城市当天天气信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月9日 下午1:53:41
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月9日 下午1:53:41    
	 * @param pointCode
	 * @param time
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/getCityAirInfo")
	@ResponseBody
	public String getCityAirInfo(String pointCode, String time) {
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();

		List<Object[]> list = airDayDataService.getCityAirInfo(pointCode, time);
		if (list.size() <= 0) {
			jsonObject.put("AQI", "-");
			jsonObject.put("city", "-");
			jsonObject.put("time", "-");
			jsonObject.put("CO", "-");
			jsonObject.put("No2", "-");
			jsonObject.put("O38", "-");
			jsonObject.put("PM10", "-");
			jsonObject.put("PM2", "-");
			jsonObject.put("So2", "-");
			jsonArray.put(jsonObject);
			return jsonArray.toString();
		}
		jsonObject.put("city", list.get(0)[0]);
		jsonObject.put("time", list.get(0)[1]);
		if (list.get(0)[2] != null) {
			jsonObject.put("AQI", Integer.valueOf(list.get(0)[2].toString()));
		} else {
			jsonObject.put("AQI", "-");
		}
		jsonObject.put("PM2", list.get(0)[3]);
		jsonObject.put("PM10", list.get(0)[4]);
		jsonObject.put("CO", list.get(0)[5]);
		jsonObject.put("No2", list.get(0)[6]);
		jsonObject.put("O38", list.get(0)[7]);
		jsonObject.put("So2", list.get(0)[8]);
		jsonArray.put(jsonObject);
		return jsonArray.toString();

	}

	public Object getColor(int value) {
		if (value <= 50) {
			return JSONObject.parse("{normal: {color: '#00E400'}}");
		} else if (value <= 100) {
			return JSONObject.parse("{normal: {color: '#FFFF00'}}");
		} else if (value <= 150) {
			return JSONObject.parse("{normal: {color: '##FF7E00'}}");
		} else if (value <= 200) {
			return JSONObject.parse("{normal: {color: '#FF0000'}}");
		} else if (value <= 300) {
			return JSONObject.parse("{normal: {color: '#99004C'}}");
		} else {
			return JSONObject.parse("{normal: {color: '#7E0023'}}");
		}
	}

	/**
	 * 添加颜色属性
	 * 
	 * @param aqi
	 * @param jsonObject
	 * @return
	 */
	public JSONObject getColor(int aqi, JSONObject jsonObject) {
		if (aqi >= 0 && aqi <= 50) {
			jsonObject.put("color", "excellent");
		} else if (aqi <= 100) {
			jsonObject.put("color", "good");
		} else if (aqi <= 150) {
			jsonObject.put("color", "mild");
		} else if (aqi <= 200) {
			jsonObject.put("color", "moderate");
		} else if (aqi <= 300) {
			jsonObject.put("color", "severe");
		} else {
			jsonObject.put("color", "dangerous");
		}
		return jsonObject;
	}

	/**
	 * 判断是否石闰年
	 * 
	 * @param year
	 * @return
	 */
	public boolean leapYear(int year) {
		if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 计算这个月一共有多少天
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public int day(int year, String month) {
		int monthDay = 0;
		switch (month) {
		case "01":
			monthDay = 31;
			break;
		case "02":
			if (leapYear(year)) {
				monthDay = 29;
			} else {
				monthDay = 28;
			}
			break;
		case "03":
			monthDay = 31;
			break;
		case "04":
			monthDay = 30;
			break;
		case "05":
			monthDay = 31;
			break;
		case "06":
			monthDay = 30;
			break;
		case "07":
			monthDay = 31;
			break;
		case "08":
			monthDay = 31;
			break;
		case "09":
			monthDay = 30;
			break;
		case "10":
			monthDay = 31;
			break;
		case "11":
			monthDay = 30;
			break;
		case "12":
			monthDay = 31;
			break;
		}

		return monthDay;
	}

	public String getColor(Integer aqi) {
		String color = "#b8b8b8";
		if (aqi >= 0 && aqi <= 50) {
			color = "#00E400";
		} else if (aqi <= 100) {
			color = "#FFFF00";
		} else if (aqi <= 150) {
			color = "#FF7E00";
		} else if (aqi <= 200) {
			color = "#FF0000";
		} else if (aqi <= 300) {
			color = "#99004C";
		} else if (aqi <= 500) {
			color = "#7E0023";
		}
		return color;
	}

	public Double getAqi(Object object) {

		return Double.valueOf(String.valueOf(object));
	}

	public Integer intValue(Object a) {

		return Integer.valueOf(String.valueOf(a)).intValue();
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(AirDayDataParam param, HttpServletResponse response){
		Page<Map<String, Object>> page = new Page<>();
		page.setLimit(100000);
		Page<Map<String, Object>> mapPage = airDayDataService.listByPage(param, page,response);
		List<Map<String, Object>> result = mapPage.getResult();
		/*List<AirDayData> lists = airDayDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (AirDayData airDayData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("monitorTime", airDayData.getMonitorTime());
			map.put("pointName", airDayData.getPointName());
			map.put("aqi", airDayData.getAqi());
			map.put("pm25", "");
			map.put("pm10", "");
			map.put("so2", "");
			map.put("no2", "");
			map.put("o3", "");
			map.put("co", "");
			result.add(map);
		}*/
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
		columnMap.put("title", "空气日监测数据表");
		columnMap.put("monitorTime", "监测时间");
		columnMap.put("pointName", "监测站点");
		columnMap.put("aqi", "AQI");
		columnMap.put("pm25", "PM2.5(μg/m3)");
		columnMap.put("pm10", "PM10(μg/m3)");
		columnMap.put("so2", "SO2(μg/m3)");
		columnMap.put("no2", "NO2(μg/m3)");
		columnMap.put("o3", "O3(μg/m3)");
		columnMap.put("co", "CO(mg/m3)");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
