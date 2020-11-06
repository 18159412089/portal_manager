package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.batik.css.engine.value.StringValue;
import org.omg.CORBA.INTERNAL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.service.WtReportService;
import com.fjzxdz.ams.util.ResultUtil;
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * 
 * 水环境月度汇报 
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:33:22
 */
@Controller
@RequestMapping("/enviromonit/water/wtReportData")
@Secured({ "ROLE_USER" })
public class WtReportController extends BaseController {

	@Autowired
	public SimpleDao simpleDao;
	@Autowired
	WtReportService wtReportService;
	/**
	 * 
	 * @Title:  testReturn
	 * @Description:    小河流域环境质量状况 统计每个质量等级的数量   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:33:44
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:33:44    
	 * @param startTime
	 * @param endTime
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/testReturn")
	public String testReturn(String startTime, String endTime) {
		return "/moudles/enviromonit/water/userAddRiverDate";
	}
	
	/**
	 * 
	 * @Title:  testReturn
	 * @Description:   水环境生态作战图
	 * @CreateBy: chenmingdao 
	 * @UpdateBy: htj 
	 * @UpdateTime:  2019年6月10日   
	 * @param startTime
	 * @param endTime
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/gotoWtOperationalReport")
	public String gotoWtOperationalReport() {
		return "/moudles/enviromonit/water/wtSectionOperationalDataList";
	}
	
	/**
	 * 
	 * @Title:  getBasinQuality
	 * @Description:    小流域环境质量状况 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:34:09
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:34:09    
	 * @param startTime
	 * @param endTime
	 * @return  R 
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getBasinQuality")
	@ResponseBody
	public R getBasinQuality(String startTime, String endTime) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] type = { "Ⅰ类～Ⅲ类水质", "Ⅳ类水质", "Ⅴ类及劣Ⅴ类水质" };
		String year1 = startTime.substring(0, 4);
		String month1 = startTime.substring(5, startTime.length());
		String year2 = endTime.substring(0, 4);
		String month2 = endTime.substring(5, endTime.length());
		String s = year1.equals(year2) ? "INTERSECT" : "UNION ALL";
		String sql = "SELECT RESULT_QUALITY,COUNT(*) FROM ("
				+ "SELECT YEAR_NUMBER,MONTH_NUMBER,BASIN_NAME,RESULT_QUALITY FROM WT_BASIN_MONTH_DATA WHERE YEAR_NUMBER=? AND MONTH_NUMBER>=? "
				+ s
				+ " SELECT YEAR_NUMBER,MONTH_NUMBER,BASIN_NAME,RESULT_QUALITY FROM WT_BASIN_MONTH_DATA WHERE YEAR_NUMBER=? AND MONTH_NUMBER<=?"
				+ ") GROUP BY RESULT_QUALITY ";
		List<Object[]> resultList = simpleDao.createNativeQuery(sql, year1, month1, year2, month2).getResultList();
		int type1 = 0, type2 = 0, type3 = 0;
		for (Object[] objects : resultList) {
			if (objects[0] != null) {
				String value = WaterQualityEnum.valueOf(objects[0].toString()).getValue();
				if ("Ⅰ类,Ⅱ类,Ⅲ类".indexOf(value) >= 0) {
					type1 += Integer.parseInt(objects[1].toString());
				} else if ("Ⅳ类".indexOf(value) >= 0) {
					type2 += Integer.parseInt(objects[1].toString());
				} else if ("Ⅴ类,劣Ⅴ类".indexOf(value) >= 0) {
					type3 += Integer.parseInt(objects[1].toString());
				}
			}
		}
		JSONArray jsonArray = new JSONArray();
		jsonArray.add(JSONObject
				.parse("{value:" + type1 + ",name:'" + type[0] + "',itemStyle: {normal: {color: '#2ba4e9'	}}}"));
		jsonArray.add(JSONObject
				.parse("{value:" + type2 + ",name:'" + type[1] + "',itemStyle: {normal: {color: '#fe8a57'	}}}"));
		jsonArray.add(JSONObject
				.parse("{value:" + type3 + ",name:'" + type[2] + "',itemStyle: {normal: {color: '#ffa800'	}}}"));
		map.put("data", jsonArray);
		return R.ok(map);
	}

	/**
	 * 
	 * @Title:  countBasinQualityList
	 * @Description:    小河流域环境质量状况 统计每个质量等级的数量  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:34:48
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:34:48    
	 * @param startTime
	 * @param endTime
	 * @return  Result 
	 * @throws
	 */
	@RequestMapping("/countWaterQuality")
	@ResponseBody
	public Result countBasinQualityList(String startTime, String endTime) {
		List<Object[]> list = wtReportService.countWaterQuality(startTime, endTime);
		String[] category = { "-", "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "劣Ⅴ", };
		String[] value = new String[category.length];
		for (Object[] objects : list) {
			if (!ToolUtil.isEmpty(objects[0])) {
				for (int i = 0; i < category.length; i++) {
					if (WaterQualityEnum.valueOf(ToolUtil.toStr(objects[0])).getKey().equals(category[i])) {
						value[i] = String.valueOf(objects[1]);
					}
				}
			} else {
				value[0] = String.valueOf(objects[1]);
			}
		}
		return ResultUtil.getOkResult(value);
	}

	/**
	 * 
	 * @Title:  getWatertypeBar
	 * @Description:    河流环境质量状况    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:35:06
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:35:06
	 * category这个wt_city_point(1国控2省控3自建)
	 * @param startTime
	 * @param endTime
	 * @return  R 
	 * @throws
	 */
	@SuppressWarnings({ "unchecked" })
	@RequestMapping("/getWatertypeBar")
	@ResponseBody
	public R getWatertypeBar(String startTime, String endTime) {
		String[] type = { "未知", "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "劣Ⅴ" };
		JSONArray point = new JSONArray();
		JSONArray pointCode = new JSONArray();
		JSONArray pointName = new JSONArray();
		JSONArray time = new JSONArray();
		JSONArray type1 = new JSONArray();
		JSONArray type2 = new JSONArray();
		JSONArray type3 = new JSONArray();
		JSONArray type4 = new JSONArray();
		JSONArray type5 = new JSONArray();
		JSONArray type6 = new JSONArray();
		JSONArray type7 = new JSONArray();
		String lastDayOfMonth = DateUtil.getLastDayOfMonth(DateUtil.parse(endTime, "yyyy-M"), "yyyy-M");
		String start = DateUtil.getTime(DateUtil.parseTime(startTime + "-1 00:00:00"));
		String end = DateUtil.getTime(DateUtil.parseTime(lastDayOfMonth + " 23:59:59"));
		String start2 = DateUtil.getTime(DateUtil.parseTime(endTime + "-1 00:00:00"));
		String sql1 = "SELECT b.POINT_CODE,b.POINT_NAME,a.RESULT_QUALITY,COUNT(a.RESULT_QUALITY),b.CATEGORY,b.POINT_QUALITY FROM WT_CITY_HOUR_REPORT a RIGHT JOIN WT_CITY_POINT b "
				+ "ON a.POINT_CODE=b.POINT_CODE WHERE a.DATATIME>=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') "
				+ "AND a.DATATIME<=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') AND b.STATUS=1 "
				+ "GROUP BY b.POINT_CODE,b.POINT_NAME,a.RESULT_QUALITY,b.CATEGORY,b.POINT_QUALITY ORDER BY b.POINT_CODE DESC,b.POINT_NAME DESC";
		String sql2 = "SELECT TO_CHAR(DATATIME,'yyyy-mm') AS yearmonth,b.POINT_CODE,b.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3),b.CATEGORY "
				+ "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 AND DATAVALUE IS NOT NULL "
				+ "AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') "
				+ "AND DATATIME<=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') GROUP BY TO_CHAR(DATATIME,'yyyy-mm'),b.POINT_CODE,b.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME ,b.CATEGORY "
				+ "ORDER BY yearmonth DESC,b.POINT_CODE,CODE_POLLUTE ASC";
		String sql3 = "SELECT TO_CHAR(DATATIME,'yyyy') AS yearmonth,b.POINT_CODE,b.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,ROUND(AVG(DATAVALUE), 3),b.CATEGORY "
				+ "FROM WT_CITY_HOUR_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE b.STATUS=1 AND DATAVALUE IS NOT NULL "
				+ "AND CODE_POLLUTE IN('W01001','W01009','W01019','W01018','W01017','W21003','W21011') AND DATATIME>=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') "
				+ "AND DATATIME<=TO_DATE(?,'yyyy-mm-dd hh24:mi:ss') GROUP BY TO_CHAR(DATATIME,'yyyy'),b.POINT_CODE,b.POINT_NAME,b.POINT_TYPE,b.POINT_QUALITY,CODE_POLLUTE,PARAMNAME,b.CATEGORY "
				+ "ORDER BY yearmonth DESC,b.POINT_CODE,CODE_POLLUTE ASC";
		List<Object[]> resultList = simpleDao.createNativeQuery(sql1, start, end).getResultList();
		List<Object[]> resultList2 = simpleDao.createNativeQuery(sql2, start2, end).getResultList();
		List<Object[]> resultList3 = simpleDao.createNativeQuery(sql3, start, end).getResultList();
		Map<String, Map<String, Object>> map1 = getQuality(resultList2);
		Map<String, Map<String, Object>> map2 = getQuality(resultList3);
		int i = -1;
		int category1 = 0;
		for (Object[] objects : resultList) {
			if (!pointCode.contains(objects[0])) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("pointCode", objects[0]);
				jsonObject.put("pointName", objects[1]);
				jsonObject.put("category", objects[4]);
				pointCode.add(objects[0]);
				i++;
				point.add(i, jsonObject);
				pointName.add(i, objects[1]);
				time.add(i, 0);
				type1.add(i, "");
				type2.add(i, "");
				type3.add(i, "");
				type4.add(i, "");
				type5.add(i, "");
				type6.add(i, "");
				type7.add(i, "");
				if ("1".equals(objects[4].toString())) {
					category1++;
				}
			}
			String polluteType = WaterQualityEnum.valueOf(StringUtils.nullToString(objects[2])).getKey();
			String pointQuality = WaterQualityEnum.valueOf(StringUtils.nullToString(objects[5])).getKey();
			int a = -1, b = -1;
			for (int j = 0; j < type.length; j++) {
				if (type[j].equals(polluteType)) {
					a = j;
				}
				if (type[j].equals(pointQuality)) {
					b = j;
				}
			}
			if (a > b) {
				time.set(i, (int) time.get(i) + Integer.parseInt(objects[3].toString()));
			}
			if ("-".equals(polluteType)) {
				type1.set(i, StringUtils.nullToString(objects[3]));
			} else if ("Ⅰ".equals(polluteType)) {
				type2.set(i, StringUtils.nullToString(objects[3]));
			} else if ("Ⅱ".equals(polluteType)) {
				type3.set(i, StringUtils.nullToString(objects[3]));
			} else if ("Ⅲ".equals(polluteType)) {
				type4.set(i, StringUtils.nullToString(objects[3]));
			} else if ("Ⅳ".equals(polluteType)) {
				type5.set(i, StringUtils.nullToString(objects[3]));
			} else if ("Ⅴ".equals(polluteType)) {
				type6.set(i, StringUtils.nullToString(objects[3]));
			} else if ("劣Ⅴ".equals(polluteType)) {
				type7.set(i, StringUtils.nullToString(objects[3]));
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("type", type);
		jsonObject.put("point", point);
		jsonObject.put("pointName", pointName);
		jsonObject.put("type1", type1);
		jsonObject.put("type2", type2);
		jsonObject.put("type3", type3);
		jsonObject.put("type4", type4);
		jsonObject.put("type5", type5);
		jsonObject.put("type6", type6);
		jsonObject.put("type7", type7);
		jsonObject.put("count", point.size());
		jsonObject.put("category1", category1);// 国控个数
		jsonObject.put("time", time);// 超标次数
		jsonObject.put("overproofPoint1", getPointName(map1));// 超标站点
		jsonObject.put("overproofPoint2", getPointName(map2));// 超标站点
		return R.ok(jsonObject);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Map<String, Object>> getQuality(List<Object[]> resultList) {
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		for (Object[] objects : resultList) {
			if (!map.containsKey(objects[1].toString())) {
				Map<String, Object> map1 = new HashMap<String, Object>();
				Map<String, cn.hutool.json.JSONArray> map2 = new HashMap<String, cn.hutool.json.JSONArray>();
				map1.put("pointQuality", objects[4]);
				map1.put("pointType", objects[3]);
				map1.put("pointName", objects[2]);
				map1.put("pointCode", objects[1]);
				map1.put("category", objects[8]);
				map2.put(objects[0].toString(), new cn.hutool.json.JSONArray());
				map1.put("monthData", map2);
				map.put(objects[1].toString(), map1);
			} else {
				Map<String, cn.hutool.json.JSONArray> object = (Map<String, cn.hutool.json.JSONArray>) map
						.get(objects[1]).get("monthData");
				if (!object.containsKey(objects[0].toString())) {
					object.put(objects[0].toString(), new cn.hutool.json.JSONArray());
				}
			}
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("codePollute", objects[5]);
			jsonObject.put("polluteName", objects[6]);
			jsonObject.put("polluteValue", objects[7]);
			Map<String, cn.hutool.json.JSONArray> object = (Map<String, cn.hutool.json.JSONArray>) map.get(objects[1])
					.get("monthData");
			object.get(objects[0]).add(jsonObject);
		}
		return map;
	}

	/**
	 * 
	 * @Title:  getSectionName
	 * @Description:    获取超标站点
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:35:46
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:35:46    
	 * @param map
	 * @return  JSONArray 
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	public JSONArray getPointName(Map<String, Map<String, Object>> map) {
		JSONArray pointName = new JSONArray();
        int i=0;
		for (String key1 : map.keySet()) {
			WaterQualityEnum targetQuality = WaterQualityEnum.valueOf(map.get(key1).get("pointQuality").toString());
			String pointType = map.get(key1).get("pointType").toString();

			Map<String, cn.hutool.json.JSONArray> object2 = (Map<String, cn.hutool.json.JSONArray>) map.get(key1)
					.get("monthData");
			for (String yearMonth : object2.keySet()) {
				cn.hutool.json.JSONArray jsonArray = object2.get(yearMonth);
				cn.hutool.json.JSONObject waterQuality2 = WaterQualityUtil.getWaterQuality(jsonArray, pointType,
						targetQuality);
				String excessFactor = waterQuality2.get("excessFactor").toString();
				if (excessFactor.indexOf("true") != -1) {
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("pointCode", map.get(key1).get("pointCode").toString());
					jsonObject.put("pointName", map.get(key1).get("pointName").toString());
					jsonObject.put("category", map.get(key1).get("category").toString());
					pointName.add(i,jsonObject);
					i++;
					// pointName.add(map.get(key1).get("pointName").toString());
				}
			}
		}
		return pointName;
	}
	 /**
	  * 获取各个断面每月份，1-n月 水质级别统计情况 
	  * @param type 省控，国控类别
	  * @return
	  */
	@RequestMapping("/getSectionWaterLevelForMonth")
	@ResponseBody
	public JSONArray getSectionWaterLevelForMonth(String type,String stationName,String  year){
		boolean isCountAvg = true;  // 是否计算平均值
		String stationStr  = "" ;
		String yearStr = "";
		 if(!StringUtils.isEmpty( stationName)){
			stationStr = "r.SECTION_CODE = '"+stationName+"'";  
		}else{
			stationStr = "r.SECTION_CODE is not null ";
		} 
		if(StringUtils.isEmpty(year)){
			yearStr=  "and YEAR_NUMBER ='"+DateUtil.getCurYear()+"'";
		}else{
			yearStr=  "and YEAR_NUMBER ='"+year+"'";
		}
		 
		JSONArray recordArr = new JSONArray();
		JSONObject recordObjects = new JSONObject();
		String sql = " SELECT  r.SECTION_CODE,r.SECTION_NAME,r.TARGET_QUALITY,r.RESULT_QUALITY,r.YEAR_NUMBER,r.MONTH_NUMBER ,r.LAST_YEAR_QUALITY,r.AVERAGE_QUALITY "  
					 +"FROM WT_SECTION_MONTH_REPORT r "
					 + "LEFT JOIN WT_SECTION_POINT p on r.SECTION_CODE = p.SECTION_CODE "
					 + "where  p.CATEGORY = ?  and "+stationStr+" "+yearStr+""
					 + "ORDER BY MONTH_NUMBER ASC";
		List<Object[]> resultList = simpleDao.createNativeQuery(sql,type).getResultList();
		if (resultList.size() < 0)  return null;
		for (Object[] objects : resultList) {
			if(objects[0]!=null){
				 if(recordObjects.containsKey(String.valueOf(objects[0]))){
		        	JSONObject recordObject = recordObjects.getJSONObject(String.valueOf(objects[0])) ;
		            JSONArray monthArr = recordObject.getJSONArray("months");
		            for(int i = 0 ; i < monthArr.size() ; i++){
		            	if(monthArr.get(i).equals(  (objects[5]+"月"))){
		            		recordObject.getJSONArray("resultQualitys").set(i,changeLevelInterValue(objects[3]));
		            	}
		            	//如果当前数据大于1月则统计1-N月平均值
			        	if(Integer.valueOf(objects[5].toString()) >1 && isCountAvg){
			        		   if(monthArr.get(i).equals( "1-"+objects[5]+"月")){
					            		//int monthAvgValue =Integer.valueOf(changeLevelInterValue(objects[7].toString()) ) ;
				            		int monthAvgValue = getMonthAvgValue(recordObject.getJSONArray("resultQualitys"),recordObject.getJSONArray("months"));	
			        			   recordObject.getJSONArray("resultQualitys").set(i,monthAvgValue);
					            	 }
					      }
		            }
		          }else{
		        	JSONObject jsonObject = new JSONObject();
		        	JSONArray  monthArr =   new JSONArray() ;
					JSONArray  qualityArr =   new JSONArray() ;
					jsonObject.put("name", objects[1]);
					jsonObject.put("targetQuality", changeLevelInterValue(objects[2]));
					qualityArr.add(changeLevelInterValue(objects[3]));
					jsonObject.put("resultQualitys",  initQualitys(qualityArr));
					jsonObject.put("lastYearQuality", changeLevelInterValue(objects[6]));
					jsonObject.put("months",initMonthColumn(isCountAvg));
					recordObjects.put(String.valueOf(objects[0]),jsonObject);
			    }
			}
		 }
		Iterator<String> it = recordObjects.keySet().iterator(); 
		while(it.hasNext()){
		// 获得key
			String key = it.next(); 
			JSONObject obj = recordObjects.getJSONObject(key);    
			recordArr.add(obj);
		}
		 return recordArr ;
	}
     
	/**
	 * 计算1-N月水质级别平均值
	 * @param resultQualitys  
	 * @param months
	 * @return
	 */
	private int getMonthAvgValue(JSONArray resultQualitys ,JSONArray months) {
		  float sumlevel = 0 ;
		  int num= 0 ;
		  for(int i = 0 ; i < resultQualitys.size() ; i++ ){
			   if (!months.get(i).toString().contains("-") && !resultQualitys.get(i).toString().equals("-")) {
				   int tempValue = Integer.valueOf( resultQualitys.get(i).toString() );
				   sumlevel = sumlevel+tempValue;
				   num = num +1; 
			   }
		 }
		 int level = Math.round( sumlevel/(num));
		 return  level;
	}
	//初始化水质级别集合
	private JSONArray  initQualitys(JSONArray qualityArr){
		 
		for(int i = 0 ; i< 22; i++){
			qualityArr.add("-");
		}
		return  qualityArr ;
	}
	//初始化月份列表
	private JSONArray  initMonthColumn(boolean isCountAvg){
		JSONArray monthArr = new JSONArray();
		for(int i = 1 ; i<=12; i++){
			monthArr.add(i+"月");
			if(i>1 && isCountAvg){
				monthArr.add("1-"+i+"月");
			}
		}
		return  monthArr ;
	}
	
	
	
	/**
	 * 转换水质级别 int 
	 * @param levelobj
	 * @return
	 */
	private int changeLevelInterValue(Object levelobj) {
		String  levelStr = String.valueOf(levelobj);
		int levelValue = 0;
		switch (levelStr) {
		case "FIRSR":
			levelValue = 1 ;
			break;
		case "SECOND":
			levelValue = 2 ;
			break;
		case "THIRD":
			levelValue = 3 ;
			break;
		case "FOURTH":
			levelValue = 4 ;
			break;
		case "FIFTH":
			levelValue = 5 ;
			break;
		case "OTHER":
			levelValue = 6;
			break;
	    default:
			break;
		}
		return levelValue ;
	}
}
