package com.fjzxdz.ams.zphb.module.hbdc.controller;

import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.util.CountUtil;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpAirQualityByYearService;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.*;

@Controller
@RequestMapping("/zphb/environment/AirQualityByYear")
@Secured({ "ROLE_USER" })
public class ZpAirQualityByYearController {

	@Autowired
	private ZpAirQualityByYearService airQualityByYearService;

	@Autowired
	private AirMonitorPointService airMonitorPointService;

	@RequestMapping(value = "")
	public String getAirQualityAQI() {
		return "/moudles/enviromonit/air/rainMonthlyData";
	}

	@RequestMapping("/getAirYearOnYearAnalysis")
	@ResponseBody
	public String getAirYearOnYearAnalysis(String startTime, String endTime, String export, HttpServletRequest request, HttpServletResponse response){

		DecimalFormat df = new DecimalFormat("#0.0");
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String LastYearStartTime =  CountUtil.getStartDate(startTime,1);
		String LastYearEndtTime =  CountUtil.getEndDate(endTime,1);
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<Object[]> city = airMonitorPointService.getImportantPoint();
		String citys = "(";
		for (Object[] objects : city) {
			//if (!objects[0].equals("350600")) {
				citys += objects[0] + ",";
			//}
			
		}
		citys = citys.substring(0, citys.length() - 1) + ")";
		List<Object[]> nowList = airQualityByYearService.getAirYearOnYearAnalysis(start, end, citys);
		List<Object[]> lastList = airQualityByYearService.getAirYearOnYearAnalysis(LastYearStartTime, LastYearEndtTime,
				citys);
		int now = 0;
		int last = 0;
		
		//double[] aqi = new double[city.size()];
		Object[][] info = new Object[city.size()][13];
		int k = 0;
		for (Object[] allCity : city) {
			int totalDay = 0; // 总天数
			int qualifiedDay = 0; // 合格天数
			int polluteDay = 0; // 污染天数
			int pm2Day = 0;// PM2.5天数 1
			int pm10Day = 0;// PM10天数 2
			int no2Day = 0; // NO2污染天数 4
			int O3Day = 0;// O3天数 5
			if (nowList.size() <= 0) {
				info[k][0] = allCity[1];
				info[k][1] = 0;
				info[k][3] = 0;
				info[k][5] = 0;
				info[k][7] = 0;
				info[k][9] = 0;
				info[k][11] = 0;
			} else {
				for (int j = now; j < nowList.size(); j++) {
					if (!nowList.get(j)[0].equals(allCity[1])) {

						break;
					} else {

						if (nowList.get(j)[2] != null && !nowList.get(j)[2].equals("")) {
							totalDay++;
							if (doubleValue(nowList.get(j)[2]) <= 100) {
								qualifiedDay++;
							}
							if (doubleValue(nowList.get(j)[2]) >= 101 && doubleValue(nowList.get(j)[2]) <= 150) {
								polluteDay++;
								Aqi aq = AqiUtil.CountAqi(integerValue(nowList.get(j)[3]), integerValue(nowList.get(j)[4]),
										doubleValue(nowList.get(j)[5]),doubleValue(nowList.get(j)[6]), 
										doubleValue(nowList.get(j)[7]), doubleValue(nowList.get(j)[8]));
								String aqiName = aq.getName(); 
								if (aqiName.equals("PM2.5")) {
									pm2Day++;
								}else if (aqiName.equals("PM10")) {
									pm10Day++;
								}else if (aqiName.equals("NO2")) {
									no2Day++;
								}else if (aqiName.equals("O3")) {
									O3Day++;
								}
							}
							/*
							 * pm2Day = sumDay(nowList.get(j)[3], 1, pm2Day); pm10Day =
							 * sumDay(nowList.get(j)[4], 2, pm10Day); no2Day = sumDay(nowList.get(j)[5], 4,
							 * no2Day); O3Day = sumDay(nowList.get(j)[6], 5, O3Day);
							 */
						}
					
						now++;
					}
				}
				if (totalDay == 0) {
					info[k][1] = 0;
				}else {
					info[k][1] = df.format(qualifiedDay * 1.0 / totalDay * 100);
				}
				info[k][0] = allCity[1];
				
				info[k][3] = polluteDay;
				info[k][5] = pm2Day;
				info[k][7] = pm10Day;
				info[k][9] = no2Day;
				info[k][11] = O3Day;
			}

			totalDay = 0; // 总天数
			qualifiedDay = 0; // 合格天数
			polluteDay = 0;
			pm2Day = 0;// PM2.5天数 1
			pm10Day = 0;// PM10天数 2
			no2Day = 0; // NO2污染天数 4
			O3Day = 0;// O3天数 5
			if (lastList.size() <= 0) {
				info[k][2] = df.format(
						doubleValue(info[k][1]) - 0);
				info[k][4] = ((int) (doubleValue(info[k][3]) - polluteDay));
				info[k][6] = (int) (doubleValue(info[k][5]) - pm2Day);
				info[k][8] = (int) (doubleValue(info[k][7]) - pm10Day);
				info[k][10] = (int) (doubleValue(info[k][9]) - no2Day);
				info[k][12] = (int) (doubleValue(info[k][11]) - O3Day);

			} else {
				for (int j = last; j < lastList.size(); j++) {
					if (!lastList.get(j)[0].equals(allCity[1])) {

						break;
					} else {

						if (lastList.get(j)[2] != null && !lastList.get(j)[2].equals("")) {
							if (doubleValue(lastList.get(j)[2]) <= 100) {
								totalDay++;
								qualifiedDay++;
							}
							if (doubleValue(lastList.get(j)[2]) >= 101 && doubleValue(lastList.get(j)[2]) <= 150) {
								polluteDay++;
								
								Aqi aq = AqiUtil.CountAqi(integerValue(lastList.get(j)[3]), integerValue(lastList.get(j)[4]),
										doubleValue(lastList.get(j)[5]),doubleValue(lastList.get(j)[6]), 
										doubleValue(lastList.get(j)[7]), doubleValue(lastList.get(j)[8]));
								String aqiName = aq.getName(); 
								if (aqiName.equals("PM2.5")) {
									pm2Day++;
								}else if (aqiName.equals("PM10")) {
									pm10Day++;
								}else if (aqiName.equals("NO2")) {
									no2Day++;
								}else if (aqiName.equals("O3")) {
									O3Day++;
								}
							}
							/*
							 * pm2Day = sumDay(lastList.get(j)[3], 1, pm2Day); pm10Day =
							 * sumDay(lastList.get(j)[4], 2, pm10Day); no2Day = sumDay(lastList.get(j)[5],
							 * 4, no2Day); O3Day = sumDay(lastList.get(j)[6], 5, O3Day);
							 */
						}
					
						last++;
					}
				}
				if (totalDay == 0) {
					info[k][2] = 0;
				}else {
					info[k][2] = df.format(
							doubleValue(info[k][1]) - Double.valueOf(df.format((qualifiedDay * 1.0 / totalDay * 100))));
				}
				
				
				info[k][4] = ((int) (doubleValue(info[k][3]) - polluteDay));
				info[k][6] = (int) (doubleValue(info[k][5]) - pm2Day);
				info[k][8] = (int) (doubleValue(info[k][7]) - pm10Day);
				info[k][10] = (int) (doubleValue(info[k][9]) - no2Day);
				info[k][12] = (int) (doubleValue(info[k][11]) - O3Day);
			}
			k++;
		}
		Object temp;
		for (int j = 0; j < info.length; j++) {
			for (int h = 0; h < info.length - j - 1; h++) {
				if (doubleValue(info[h][1]) < doubleValue(info[h + 1][1])) {
					for (int l = 0; l < info[0].length; l++) {
						temp = info[h][l];
						info[h][l] = info[h + 1][l];
						info[h + 1][l] = temp;
					}
				}
			}
		}
		// 以下变量是统计所有站点的各值总和。
		double sumReach = 0;// 总达标率
		double sumReachYear = 0;// 同比总达标率
		int sumPilluteDay = 0;// 总污染天数
		int sumPilluteDayYear = 0;// 同比总污染天数
		int sumPM2Day = 0;// PM2超标总天数
		int sumPM2DayYear = 0;// 同比PM2超标总天数
		int sumPM10Day = 0;// PM10超标总天数
		int sumPM10DayYear = 0;// 同比PM10超标总天数
		int sumNO2Day = 0;// NO2超标总天数
		int sumNO2DayYear = 0;// 同比NO2超标总天数
		int sumO3Day = 0;// O3超标总天数
		int sumO3DayYear = 0;// 同比O3超标总天数

		for (int j = 0; j < info.length; j++) {
			if("漳州党校".equals(info[j][0])) {
				jsonObject.put("pointName", "芗城区");//+info[j][0]);
			}else if ("蓝田镇".equals(info[j][0])) {
				jsonObject.put("pointName", "龙文区");//+info[j][0]);
			}else {
				jsonObject.put("pointName", info[j][0]);
			}
			jsonObject.put("reach", info[j][1]);
			jsonObject.put("reachYear", info[j][2]);
			jsonObject.put("rank", j + 1);
			jsonObject.put("polluteDay", info[j][3]);
			jsonObject.put("polluteDayYear", info[j][4]);
			jsonObject.put("PM2Day", info[j][5]);
			jsonObject.put("PM2DayYear", info[j][6]);
			jsonObject.put("PM10Day", info[j][7]);
			jsonObject.put("PM10DayYear", info[j][8]);
			jsonObject.put("NO2Day", info[j][9]);
			jsonObject.put("NO2DayYear", info[j][10]);
			jsonObject.put("O3Day", info[j][11]);
			jsonObject.put("O3DayYear", info[j][12]);
			sumReach += doubleValue(info[j][1]);
			sumReachYear += doubleValue(info[j][2]);
			sumPilluteDay += integerValue(info[j][3]);
			sumPilluteDayYear += integerValue(info[j][4]);
			sumPM2Day += integerValue(info[j][5]);
			sumPM2DayYear += integerValue(info[j][6]);
			sumPM10Day += integerValue(info[j][7]);
			sumPM10DayYear += integerValue(info[j][8]);
			sumNO2Day += integerValue(info[j][9]);
			sumNO2DayYear += integerValue(info[j][10]);
			sumO3Day += integerValue(info[j][11]);
			sumO3DayYear += integerValue(info[j][12]);
			jsonArray.put(jsonObject);
		}
		jsonObject.put("pointName", "总和");
		jsonObject.put("reach", "");
		jsonObject.put("reachYear", "");
		jsonObject.put("rank", "");
		jsonObject.put("polluteDay", sumPilluteDay);
		jsonObject.put("polluteDayYear", sumPilluteDayYear);
		jsonObject.put("PM2Day", sumPM2Day);
		jsonObject.put("PM2DayYear", sumPM2DayYear);
		jsonObject.put("PM10Day", sumPM10Day);
		jsonObject.put("PM10DayYear", sumPM10DayYear);
		jsonObject.put("NO2Day", sumNO2Day);
		jsonObject.put("NO2DayYear", sumNO2DayYear);
		jsonObject.put("O3Day", sumO3Day);
		jsonObject.put("O3DayYear", sumO3DayYear);
		jsonArray.put(jsonObject);

		jsonObject.put("pointName", "均值");
		jsonObject.put("reach", df.format(sumReach / city.size()));
		jsonObject.put("reachYear", df.format(sumReachYear / city.size()));
		jsonObject.put("rank", "");
		jsonObject.put("polluteDay", "");
		jsonObject.put("polluteDayYear", "");
		jsonObject.put("PM2Day", "");
		jsonObject.put("PM2DayYear", "");
		jsonObject.put("PM10Day", "");
		jsonObject.put("PM10DayYear", "");
		jsonObject.put("NO2Day", "");
		jsonObject.put("NO2DayYear", "");
		jsonObject.put("O3Day", "");
		jsonObject.put("O3DayYear", "");
		jsonArray.put(jsonObject);
		
		if("no".equals(request.getParameter("export"))) {
			JSONArray result = new JSONArray();
			for(int i = jsonArray.length()-3; i >= jsonArray.length()-5; i--){
				JSONObject tempJSON = JSONObject.parseObject(jsonArray.get(i).toString());
				 result.put(tempJSON);
			 }
			for(int i = 0; i < 3; i++){
				JSONObject tempJSON = JSONObject.parseObject(jsonArray.get(i).toString());
				 result.put(tempJSON);
			 }
			return result.toString();
		}
		
		if("yes".equals(request.getParameter("export"))) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			String string = "至0";
			String title = startTime + string + endTime.substring(5, 6) +"漳州市11个县市区同期对比（综合指数）";
			columnMap.put("title", title);
			columnMap.put("pointName", "县(市/区)");
			columnMap.put("reach", "达标率%");
			columnMap.put("reachYear", "达标率同比");
			columnMap.put("rank", "达标率排名");
			columnMap.put("polluteDay", "污染天数");
			columnMap.put("polluteDayYear", "污染天数同比");
			columnMap.put("PM2Day", "PM2.5污染天数");
			columnMap.put("PM2DayYear", "PM2.5污染天数同比");
			columnMap.put("PM10Day", "PM10污染天数");
			columnMap.put("PM10DayYear", "PM10污染天数同比");
			columnMap.put("NO2Day", "NO2污染天数");
			columnMap.put("NO2DayYear", "NO2污染天数同比");
			columnMap.put("O3Day", "O3污染天数");
			columnMap.put("O3DayYear", "O3污染天数同比");
			List<Map<String, Object>> list = new ArrayList<>();
	        for(Object jstr:jsonArray){
	        	JSONObject tempJSON = JSONObject.parseObject(jstr.toString());
	        	Map<String, Object> tempMap = new HashMap<>();
	        	for(JSONObject.Entry<String, Object> entry : tempJSON.entrySet()) {
	        		tempMap.put(entry.getKey(), entry.getValue());
	        	}
	            list.add(tempMap);
	        }
			ExcelExportUtil.exportExcel(response, columnMap, list);
			return null;
		}

		return jsonArray.toString();

	}

	public int sumDay(Object value, int row, int day) {
		if (value != null && !value.equals("")) {
			if (AqiUtil.countPerIaqi(doubleValue(value), row) > 100
					&& AqiUtil.countPerIaqi(doubleValue(value), row) <= 150) {
				day++;
			}
		}

		return day;
	}

	public Double doubleValue(Object o) {

		return Double.valueOf(String.valueOf(o));
	}

	public Integer integerValue(Object o) {

		return Double.valueOf(String.valueOf(o)).intValue();
	}

}
