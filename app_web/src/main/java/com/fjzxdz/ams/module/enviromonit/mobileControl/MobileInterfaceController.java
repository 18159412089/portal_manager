package com.fjzxdz.ams.module.enviromonit.mobileControl;

import java.math.BigDecimal;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.air.entity.AirMonitorPoint;
import com.fjzxdz.ams.module.enviromonit.air.service.AirDayDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirHourDataService;
import com.fjzxdz.ams.module.enviromonit.air.service.AirMonitorPointService;
import com.fjzxdz.ams.util.Aqi;
import com.fjzxdz.ams.util.AqiUtil;
import com.fjzxdz.ams.util.ResultUtil;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 移动端接口
 * 
 * @author cbk
 * @date 2019-02-28
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/api")
public class MobileInterfaceController extends BaseController {

	@Autowired
	private AirHourDataService airHourDataService;
	@Autowired
	private AirDayDataService airDayDataService;
	
	@Autowired
	private AirMonitorPointService airMonitorPointService;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 获取城市列表
	 */
	@RequestMapping("/getCitys")
	@ResponseBody
	public Result getCitys() {
		JSONArray array = new JSONArray();
		try {
			List<AirMonitorPoint> list = airMonitorPointService.getCity();
			if (list != null) {
				for (AirMonitorPoint airMonitorPoint : list) {
					JSONObject area = new JSONObject();
					area.put("uuid", airMonitorPoint.getPointCode());
					area.put("name", airMonitorPoint.getPointName());
					array.add(area);
				}
			}

		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(array);

	}

	/**
	 * 某个城市的最新小时数据
	 * 
	 * @param pointCode 城市编号
	 * @return
	 */
	@RequestMapping("/getAirQuantity")
	@ResponseBody
	public Result getAirQuantity(String pointCode) {
		JSONObject jsonObject = new JSONObject();
		List<Object[]> list = airHourDataService.getAirQuantity(pointCode);
		if (list.size() <= 0) {
			jsonObject.put("color", -1);
			jsonObject.put("AQI", "-");
			jsonObject.put("city", "-");
			jsonObject.put("time", "-");

			jsonObject.put("PM2.5", "-");
			jsonObject.put("PM10", "-");
			jsonObject.put("CO", "-");
			jsonObject.put("No2", "-");
			jsonObject.put("O3", "-");
			jsonObject.put("So2", "-");
			jsonObject.put("pollute", "无");
		} else {
			Integer aqInteger = Integer.valueOf(String.valueOf(list.get(0)[2])).intValue();
			jsonObject.put("color", aqInteger);
			jsonObject.put("AQI", list.get(0)[2]);
			jsonObject.put("city", list.get(0)[1]);
			jsonObject.put("time", list.get(0)[0]);
			jsonObject.put("PM2.5", list.get(0)[3]);
			jsonObject.put("PM10", list.get(0)[4]);
			jsonObject.put("CO", list.get(0)[5]);
			jsonObject.put("No2", list.get(0)[6]);
			jsonObject.put("O3", list.get(0)[7]);
			jsonObject.put("So2", list.get(0)[8]);
			if (aqInteger > 50) {
				Aqi aq = AqiUtil.CountAqi(intValue(list.get(0)[3]), intValue(list.get(0)[4]), intValue(list.get(0)[5]),
						intValue(list.get(0)[6]), intValue(list.get(0)[7]), intValue(list.get(0)[8]));
				jsonObject.put("pollute", aq.getName());
			} else {
				jsonObject.put("pollute", "无");
			}
		}
		return ResultUtil.getOkResult(jsonObject);
	}

	/**
	 * 获取水质类别分布
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getWtQuantityDistribution")
	@ResponseBody
	public Result getWtQuantityDistribution() {
		JSONArray jsonArray1 = new JSONArray();
		JSONObject result = new JSONObject();
		try {
			String sql = "SELECT mp.POINT_CODE,mp.POINT_NAME,TO_CHAR(mr.DATATIME,'yyyy-mm-dd hh24:mi:ss') AS DATATIME,"
			        + "mp.POINT_QUALITY,mr.RESULT_QUALITY,mr.EXCESSFACTORSTR, category"
			        + " FROM WT_CITY_POINT mp LEFT JOIN WT_CITY_HOUR_REPORT mr ON mp.POINT_CODE = mr.POINT_CODE"
			        + " AND (mr.POINT_CODE, mr.DATATIME) IN ( SELECT p.POINT_CODE,MAX(r.DATATIME)"
			        + " FROM WT_CITY_POINT p INNER JOIN WT_CITY_HOUR_REPORT r ON p.POINT_CODE = r.POINT_CODE"
			        + " WHERE r.DATATIME >= SYSDATE - 2 AND r.DATATIME <= SYSDATE GROUP BY p.POINT_CODE )"
			        + " WHERE mp.CATEGORY IN (1,2) AND mp.status = 1";
			List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();

			String[] category = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "劣Ⅴ", "-" };
			int pointQualityNum[] = new int[category.length]; // 各级别超标站点个数(一级,二级，三级，四级，五级，劣五，未知)

			for (Object[] objects : list) {
				int a = 0, b = 0;
				if (!ToolUtil.isEmpty(objects[4])) {
					for (int i = 0; i < category.length; i++) {
						if (!ToolUtil.isEmpty(objects[3])) {
							if (WaterQualityEnum.valueOf(ToolUtil.toStr(objects[3])).getKey().equals(category[i])) {
								b = i;
							}
						} else {
							b = -1;// 目标水质为空时 不参与达标率的计算
						}

						if (WaterQualityEnum.valueOf(ToolUtil.toStr(objects[4])).getKey().equals(category[i])) {
							pointQualityNum[i]++;
							a = i;
						}
					}
					if (a <= b) {
					}
				} else {
					pointQualityNum[6]++; // 等于空时为未知
				}
			}

			for (int j = 0; j < pointQualityNum.length; j++) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("value", pointQualityNum[j]);
				jsonObject.put("name", j == 6 ? "未知" : category[j]);
				jsonArray1.add(jsonObject);
			}
			result.put("data", jsonArray1);
		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(jsonArray1);
	}

	/**
	 *  获取所有空气城市站点最新数据
	 */
	@RequestMapping("/getAirLatestData")
	@ResponseBody
	public Result getAirLatestData(String type, @RequestParam(value = "pointCode", required = false) String pointCode, String factor) {
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		try {
			JSONObject jsonObject = new JSONObject();
//	DecimalFormat df = new DecimalFormat("######0");
	List<AirMonitorPoint> list = new ArrayList<AirMonitorPoint>();

	String pointName = "";
	// 最新城市点位信息
		List<Object[]> resultList = airMonitorPointService.getCityByType(type, pointCode,factor, getUserDeptName());
	// 最新时间(时间按漳州最新数据为准)的城市信息
//	List<Object[]> pointList = airHourDataService.rankingOrderByAQI(type, pointCode);
	List<Object[]> pointList = airHourDataService.rankingOrderByAQI(type, pointCode, getUserDeptName());
	if (pointCode == null) {
		if (type != null && type.equals("1")) {
//			list = airMonitorPointService.getPointByType(type);
			list = airMonitorPointService.getPointByType(type, getUserDeptName());
		} else if (type != null && type.equals("0")) {
//			list = airMonitorPointService.getPointByType(type);
			list = airMonitorPointService.getPointByType(type, getUserDeptName());
		}
	} else {
		list = airMonitorPointService.getMonitorPointByCity(pointCode);
	}
	if (resultList.size() > 0) {
		pointName = String.valueOf(resultList.get(0)[0]);
	}

	if (resultList.size() <= 0) {
		for (AirMonitorPoint airMonitorPoint : list) {
			jsonObject = pointInfoIsNull(jsonObject, airMonitorPoint);
			jsonArray.put(jsonObject);
		}
	} else {
		int j = 0;
		int k = 0;
		for (Object[] objects : resultList) {
//			k++;
//			if (pointName.equals(String.valueOf(objects[0]))) {
//				j++;
//				jsonObject = pointInfo(jsonObject,objects,factor);
//			} else {
//				jsonArray.put(jsonObject);
//				j=0;
//				if (j == 0 && k ==resultList.size()) {
//					jsonObject = pointInfo(jsonObject,objects,factor);
//					jsonArray.put(jsonObject);
//				}
				jsonObject = pointInfo(jsonObject,objects,factor);
//				pointName = String.valueOf(objects[0]);
//				j = 0;
//				
//			}
			jsonArray.put(jsonObject);
		}
//		jsonArray.put(jsonObject);
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
		if (pointList.size() == list.size()) {
			for (Object[] objects : pointList) {
				if (objects[2] == null || objects[3] == null) {
					jsonObject = new JSONObject();
					jsonObject.put("pointName", objects[0]);
					jsonObject.put("pointCode", objects[1]);
					jsonObject.put("color", -1);
					jsonObject.put("aqi", "暂无数据");
					jsonObject.put("monitrorTime", "暂无数据");
					if (objects[4] != null && objects[5] != null) {
						jsonObject.put("longitude", Double.valueOf(String.valueOf(objects[4])));
						jsonObject.put("latitude", Double.valueOf(String.valueOf(objects[5])));
					}
					jsonObject.put("pointType", Double.valueOf(String.valueOf(objects[6])));
					jsonObject.put("value", "-");
					jsonArray.put(jsonObject);
				}
			}
		}
		
	}

		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(jsonArray.toList());
	}

	/**
	 * 获取所有水质站点最新数据
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getWaterLatestData")
	@ResponseBody
	public Result getWaterLatestData() {
		JSONArray jsonAry = new JSONArray();
		try {
			String sql = "SELECT mp.POINT_CODE,mp.POINT_NAME,mp.WSYSTEM_NAME,mp.LONGITUDE,mp.LATITUDE,TO_CHAR(mr.DATATIME,'yyyy-mm-dd hh24:mi:ss') AS DATATIME,"
			        + "mp.POINT_QUALITY,mr.RESULT_QUALITY,mr.EXCESSFACTORSTR,category"
			        + " FROM WT_CITY_POINT mp LEFT JOIN WT_CITY_HOUR_REPORT mr ON mp.POINT_CODE = mr.POINT_CODE"
			        + " AND (mr.POINT_CODE, mr.DATATIME) IN ( SELECT p.POINT_CODE,MAX(r.DATATIME)"
			        + " FROM WT_CITY_POINT p INNER JOIN WT_CITY_HOUR_REPORT r ON p.POINT_CODE = r.POINT_CODE"
			        + " WHERE r.DATATIME >= SYSDATE - 2 AND r.DATATIME <= SYSDATE GROUP BY p.POINT_CODE )"
			        + " WHERE mp.CATEGORY IN (1,2) AND mp.status = 1";
			List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
			for (Object[] objects : list) {
				JSONObject json = new JSONObject();
				json.put("mn", StringUtils.nullToString(objects[0]));
				json.put("mnname", StringUtils.nullToString(objects[1]));
				json.put("rivername", StringUtils.nullToString(objects[2]));
				json.put("lng", StringUtils.nullToString(objects[3]));
				json.put("lat", StringUtils.nullToString(objects[4]));
				json.put("datatime", StringUtils.nullToString(objects[5]));
				json.put("pointQuality", StringUtils.nullToString(objects[6]));
				json.put("resultQuality", StringUtils.nullToString(objects[7]));
				json.put("excessFacror", StringUtils.ClobToString((Clob) objects[8]));
				json.put("category", objects[9].toString());
				jsonAry.add(json);
			}

		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(jsonAry);
	}

	/**
	 * 分页获取一个时间段某个空气监测站详细监测数据
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getAirMonitorDetails")
	@ResponseBody
	public Result getAirMonitorDetails(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows,
			@RequestParam(value = "pointCode") String pointCode, @RequestParam(value = "time") String time,
			@RequestParam(value = "startTime") String startTime,@RequestParam(value = "endTime") String endTime,
			@RequestParam(value = "polluteCode") String polluteCode, HttpServletRequest request) {
		Page dataPage = new Page<>();
		try {
			String[] arr = pointCode.split(",");
			String city = "('" + StringUtils.join(arr, "','") + "')";
			if (page != null) {
                dataPage.setCurrentPage(page - 1);
            }
			if (rows != null) {
                dataPage.setLimit(rows);
            }
			String sqlString = "";
			if (time != null && time.equals("24h")) {
//				Map<String, Object> timeMap = DateUtil.get24h();
//				String startTime = timeMap.get("startTime").toString();
//				String endTime = timeMap.get("endTime").toString();

				if (polluteCode != null && polluteCode.equals("aqi")) {
					sqlString = "SELECT POINT_NAME,AQI as AVERVALUE,to_char(MONITOR_TIME,'yyyy-mm-dd hh24') as MONITOR_TIME FROM AIR_HOUR_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >= to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <= to_date('" + endTime
							+ "','yyyy-mm-dd hh24:mi:ss') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME DESC";
				} else {
					sqlString = "SELECT POINT_NAME,AVERVALUE,to_char(MONITOR_TIME,'yyyy-mm-dd hh24') as MONITOR_TIME FROM AIR_HOUR_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >= to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <= to_date('" + endTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND CODE_POLLUTE= '" + polluteCode
							+ "' GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME DESC";
				}
			} else if (time != null && time.equals("30d")) {
//				Map<String, Object> timeMap = DateUtil.get30d();
//				String startTime = timeMap.get("startTime").toString();
//				String endTime = timeMap.get("endTime").toString();
				if (polluteCode != null && polluteCode.equals("aqi")) {
					sqlString = "SELECT POINT_NAME,AQI as AVERVALUE,TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') as MONITOR_TIME FROM AIR_DAY_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >= to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <= to_date('" + endTime
							+ "','yyyy-mm-dd hh24:mi:ss') GROUP BY POINT_NAME,MONITOR_TIME,AQI ORDER BY POINT_NAME,MONITOR_TIME DESC";
				} else {
					sqlString = "SELECT POINT_NAME,AVERVALUE,TO_CHAR(MONITOR_TIME,'yyyy-mm-dd') as MONITOR_TIME FROM AIR_DAY_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >=to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <=to_date('" + endTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND CODE_POLLUTE= '" + polluteCode
							+ "' GROUP BY POINT_NAME,AVERVALUE,MONITOR_TIME ORDER BY POINT_NAME,MONITOR_TIME DESC";
				}

			} else if (time != null && time.equals("1y")) {
//				Map<String, Object> timeMap = DateUtil.get12m();
//				String startTime = timeMap.get("startTime").toString();
//				String endTime = timeMap.get("endTime").toString();
				if (polluteCode != null && polluteCode.equals("aqi")) {
					sqlString = "SELECT POINT_NAME,ROUND(AVG(AQI),2) as AVERVALUE,TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) as MONITOR_TIME FROM AIR_DAY_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >= to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <= to_date('" + endTime
							+ "','yyyy-mm-dd hh24:mi:ss') GROUP BY POINT_NAME,TO_CHAR(MONITOR_TIME,'yyyy-mm') ORDER BY POINT_NAME, MONITOR_TIME DESC";
				} else {
					sqlString = "SELECT POINT_NAME,ROUND(AVG(AVERVALUE),2),TO_CHAR( MONITOR_TIME, 'yyyy-mm' ) as MONITOR_TIME FROM AIR_DAY_DATA WHERE POINT_CODE in "
							+ city + " AND MONITOR_TIME >=to_date('" + startTime
							+ "','yyyy-mm-dd hh24:mi:ss') AND MONITOR_TIME <=to_date('" + endTime + "','yyyy-mm-dd hh24:mi:ss') AND CODE_POLLUTE= '"
							+ polluteCode
							+ "' GROUP BY POINT_NAME,TO_CHAR(MONITOR_TIME,'yyyy-mm') ORDER BY POINT_NAME,MONITOR_TIME DESC";
				}

			}
			simpleDao.listNativeByPage(sqlString, dataPage);

		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(dataPage.getResult());
	}

	/**
	 * 分页获取一个时间段某个水质监测站详细监测数据
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getWaterMonitorDetails")
	@ResponseBody
	public Result getWaterMonitorDetails(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "rows", required = false) Integer rows,
			@RequestParam(value = "pointCode") String pointCode, @RequestParam(value = "polluteCode") String polluteCode,
			@RequestParam(value = "startTime") String startTime,@RequestParam(value = "endTime") String endTime,
			HttpServletRequest request) {
		Page dataPage = new Page<>();
		try {
            if (page != null) {
                dataPage.setCurrentPage(page - 1);
            }
            if (rows != null){
                dataPage.setLimit(rows);
            }
			String sqlString = "select POINT_CODE AS MN,POINT_NAME AS MNNAME,TO_CHAR(DATATIME,'yyyy-MM-dd hh:mm:ss') AS DATATIME,CODE_POLLUTE,DATAVALUE"
			        + " from WT_CITY_HOUR_DATA WHERE POINT_CODE='" + pointCode + "' and CODE_POLLUTE='"
			        + polluteCode + "' and DATATIME>=TO_DATE('" + startTime + "','yyyy-mm-dd hh24:mi:ss')"
			        + " and DATATIME<=TO_DATE('"+ endTime + "','yyyy-mm-dd hh24:mi:ss')";
			
			simpleDao.listNativeByPage(sqlString, dataPage);

		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(dataPage.getResult());
	}
	
	/**
	 * 查询某个城市某个时间范围的空气信息
	 * @param pointCode 站点编号
	 * @param startTime 开始时间
	 * @param endTime   结束时间
	 * @return
	 */
	@RequestMapping("/getCityInfoByCode")
	@ResponseBody
	public Result getCityInfoByCode(String pointCode, String startTime, String endTime) {
		JSONArray jsonAry = new JSONArray();
		try {
			List<Object[]> list = airDayDataService.getCityInfoByCode(pointCode, startTime, endTime);
			if (list.size() >0) {
				for (Object[] objects : list) {
					JSONObject jsonObject = new JSONObject();
					
					jsonObject.put("city", objects[0]);
					jsonObject.put("time", objects[1]);
					jsonObject.put("AQI", objects[2]);
					jsonObject.put("PM2.5", objects[3]);
					jsonObject.put("PM10", objects[4]);
					jsonObject.put("CO", objects[5]);
					jsonObject.put("No2", objects[6]);
					jsonObject.put("O3", objects[7]);
					jsonObject.put("So2", objects[8]);
					Aqi aq = AqiUtil.CountAqi(intValue(objects[3]), intValue(objects[4]), intValue(objects[5]),
							intValue(objects[6]), intValue(objects[7]), intValue(objects[8]));
					jsonObject.put("pollute", aq.getName());
					jsonAry.add(jsonObject);
				}
			}
		} catch (Exception e) {
			return ResultUtil.getFailResult(ReturnEum.FAILED.getCode(), e.getMessage());
		}
		return ResultUtil.getOkResult(jsonAry);
	}
	
	public Integer intValue(Object a) {

		return Double.valueOf(String.valueOf(a)).intValue();
	}
	
	/**
	 * 添加对应的污染物的名称和值
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
			jsonObject.put("PM2.5", value);
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
		jsonObject.put("value",objects[2]);
		jsonObject.put("pointType", objects[3]);
		jsonObject.put("monitrorTime", objects[4]);
		double aqInteger=0;
		if("aqi".equals(factor)) {
			aqInteger = ((BigDecimal )objects[2]).setScale(0,BigDecimal.ROUND_UP).intValue();
			jsonObject.put("aqi",objects[2]);
		}else {
			double d = AqiUtil.countPerIaqi(Double.parseDouble(objects[2].toString()), getPollutionNUmber(factor));
			aqInteger = (new BigDecimal(String.valueOf(d))).setScale(0,BigDecimal.ROUND_UP).intValue();
			jsonObject.put("aqi",objects[14]);
		}
		jsonObject.put("color", aqInteger);
		if (objects[5] != null && objects[6] != null) {
			jsonObject.put("longitude", Double.valueOf(String.valueOf(objects[5])));
			jsonObject.put("latitude", Double.valueOf(String.valueOf(objects[6])));
		}

		jsonObject.put("No2", String.valueOf(objects[7]));
		jsonObject.put("O3", String.valueOf(objects[8]));
		jsonObject.put("PM10", String.valueOf(objects[9]));
		jsonObject.put("PM2.5", String.valueOf(objects[10]));
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
		}else if("A05024".equals(factor)) {
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
		jsonObject.put("aqi", "-");
		//jsonObject.put("color", -1);
		jsonObject.put("longitude", airMonitorPoint.getLongitude());
		jsonObject.put("latitude", airMonitorPoint.getLatitude());
		jsonObject.put("CO", "-");
		jsonObject.put("No2", "-");
		jsonObject.put("PM10", "-");
		jsonObject.put("PM2.5", "-");
		jsonObject.put("So2", "-");
		jsonObject.put("O3", "-");
		return jsonObject;
	}
}
