package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.util.WaterQualityUtil;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

/**
 * @author lilongan
 * @title: 污染物分析
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/6/28 10:25
 */
@Controller
@RequestMapping("/environment/waterPollutionAnalysis")
public class WaterPollutionAnalysisController extends BaseController {
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 超标天数比例
	 */
	@RequestMapping("/pollutionAnalysis")
	@ResponseBody
	public JSONObject pollutionAnalysis(String regionCode, String startTime, String endTime,
			String category, String type, String pollutantCode) throws ParseException {
		JSONObject jObject = new JSONObject(); 
		if (type == null) {
			return null;
		}
		String gkSkSql = "";
		String timestr = "";
		if ("1".equals(category)) {
			gkSkSql = " and b.category=1 ";
		}
		if ("2".equals(category)) {
			gkSkSql = " and b.category=2 ";
		}
		if ("3".equals(category)) {
			gkSkSql = " and b.category=3 ";
		}
		switch (type) {
		case "month":
			timestr = "AND MONITOR_TIME>='" + startTime + "'" + " AND MONITOR_TIME<='" + endTime + "'";
			jObject = getWTAvgData(regionCode, timestr, gkSkSql, pollutantCode);
			break;
		case "year":

			jObject = getWTAvgData(regionCode, timestr, gkSkSql, pollutantCode);
			break;

		default:
			break;
		}
		return jObject;
	}

	// 获取各因子超标天数
	private JSONObject getWTAvgData(String regionCode, String timestr, String gkSkSql,
			String pollutantCode) {
		JSONObject jObject = new JSONObject(); 
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		String region = "";
		if (ToolUtil.isNotEmpty(regionCode)) {
			region = region + " and b.CODE_REGION in (" + toSqlStr(regionCode) + ")";
		}
		String sql = "select a.POINT_CODE,a.POINT_NAME,a.code_pollute,a.pollute_name,a.pollute_value "
				+ " from WT_DAY_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.CODE_POLLUTE ='"
				+ pollutantCode + "' " + gkSkSql + " " + timestr + " "+region;
		List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
		for(int j = 0 ; j < resultList.size() ; j++){
	    	Object[] obj = (Object[]) resultList.get(j);
			Map<String, Object> mapObj = new HashMap<>();
			JSONArray dataArray = new JSONArray();
			if (obj[4] != null) {
				JSONObject temp1 = new JSONObject();
				temp1.put("codePollute", obj[2]);
				temp1.put("polluteValue", new BigDecimal(String.valueOf(obj[4])));
				temp1.put("polluteName", obj[3]);
				dataArray.add(temp1);
				org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor((String)obj[2],obj[4],WaterQualityEnum.THIRD,"0");
				if (jsonObj.getBoolean("isExcess") == true) {
					mapObj.put("pointCode", obj[0]);
					mapObj.put("pointName", obj[1]);
					mapObj.put("codePollute", obj[2]);
					mapObj.put("pollutantName", obj[3]);
					mapObj.put("pollutantValue", obj[4]);
					result.add(mapObj);
				}
			}
			
		}
		List<String> namelist = new ArrayList<String>();
		List<Integer> numlist = new ArrayList<Integer>();
		if (result.size() > 0){
			for (Map<String, Object> map : result) {
				if (!namelist.contains(map.get("pointName"))) {
					namelist.add((String) map.get("pointName"));
					numlist.add(0);
				}
			}
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (int i=0;i<namelist.size();i++){
				Map<String, String> map = new HashMap<String, String>();
				String poname = namelist.get(i);
				for(Map<String, Object> mapObj : result){
					if(poname == (String) mapObj.get("pointName")){
						int num = numlist.get(i);
						num++;
						numlist.set(i, num);
					} 
				}
			}
		}
		jObject.put("namelist", namelist);
		jObject.put("numlist", numlist);
		return jObject;

	}
	
	
	/**
	 * 超标天数比例
	 */
	@RequestMapping("/pollutionAnalysisList")
	@ResponseBody
	public List<Map<String, Object>> pollutionAnalysisList(String regionCode, String startTime, String endTime,
			String category, String type, String pollutantCode) throws ParseException {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		if (type == null) {
			return null;
		}
		String gkSkSql = "";
		String timestr = "";
		if ("1".equals(category)) {
			gkSkSql = " and b.category=1 ";
		}
		if ("2".equals(category)) {
			gkSkSql = " and b.category=2 ";
		}
		if ("3".equals(category)) {
			gkSkSql = " and b.category=3 ";
		}
		switch (type) {
		case "month":
			timestr = "AND MONITOR_TIME>='" + startTime + "'" + " AND MONITOR_TIME<='" + endTime + "'";
			result = getWTAvgDataList(regionCode, timestr, gkSkSql, pollutantCode);
			break;
		case "year":
 			result = getWTAvgDataList(regionCode, timestr, gkSkSql, pollutantCode);
			break;
 		default:
			break;
		}
		return result;
	}

	/**
	 * 超标天数比例排名
	 */
	@RequestMapping("/pollutionAnalysisOrderList")
	@ResponseBody
	public  JSONObject pollutionAnalysisOrderList(String regionCode, String startTime, String endTime,
														   String category, String type, String pollutantCode) throws ParseException {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		if (type == null) {
			return null;
		}
		String gkSkSql = "";
		String timestr = "";
		if ("1".equals(category)) {
			gkSkSql = " and b.category=1 ";
		}
		if ("2".equals(category)) {
			gkSkSql = " and b.category=2 ";
		}
		if ("3".equals(category)) {
			gkSkSql = " and b.category=3 ";
		}
		switch (type) {
			case "month":
				timestr = "AND MONITOR_TIME>='" + startTime + "'" + " AND MONITOR_TIME<='" + endTime + "'";
				result = getWTAvgDataList(regionCode, timestr, gkSkSql, pollutantCode);
				break;
			case "year":
				result = getWTAvgDataList(regionCode, timestr, gkSkSql, pollutantCode);
				break;
			default:
				break;
		}
		JSONObject  jsonObject =  getOrerderPointForOverCount(result);
		return    jsonObject;

	}



	// 获取各因子超标天数
		private List<Map<String, Object>> getWTAvgDataList(String regionCode, String timestr, String gkSkSql,
				String pollutantCode) {
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			String region = "";
			if (ToolUtil.isNotEmpty(regionCode)) {
				region = region + " and b.CODE_REGION in (" + toSqlStr(regionCode) + ")";
			}
			String sql = "select a.POINT_CODE,a.POINT_NAME,a.code_pollute,a.pollute_name,a.pollute_value "
					+ " from WT_DAY_DATA a INNER JOIN WT_CITY_POINT b ON a.POINT_CODE=b.POINT_CODE WHERE a.CODE_POLLUTE ='"
					+ pollutantCode + "' " + gkSkSql + " " + timestr + " "+region;
			List<Object[]> resultList = simpleDao.createNativeQuery(sql).getResultList();
			for(int j = 0 ; j < resultList.size() ; j++){
		    	Object[] obj = (Object[]) resultList.get(j);
				Map<String, Object> mapObj = new HashMap<>();
				JSONArray dataArray = new JSONArray();
				if (obj[4] != null) {
					JSONObject temp1 = new JSONObject();
					temp1.put("codePollute", obj[2]);
					temp1.put("polluteValue", new BigDecimal(String.valueOf(obj[4])));
					temp1.put("polluteName", obj[3]);
					dataArray.add(temp1);
					org.json.JSONObject jsonObj = WaterQualityUtil.getQualityByFactor((String)obj[2],obj[4],WaterQualityEnum.THIRD,"0");
					if (jsonObj.getBoolean("isExcess") == true) {
						mapObj.put("pointCode", obj[0]);
						mapObj.put("pointName", obj[1]);
						mapObj.put("codePollute", obj[2]);
						mapObj.put("pollutantName", obj[3]);
						mapObj.put("pollutantValue", obj[4]);
						result.add(mapObj);
					}
				}
			  }
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			if (result.size() > 0){
				List<String> namelist = new ArrayList<String>();
				List<Integer> numlist = new ArrayList<Integer>();
				for (Map<String, Object> map : result) {
					if (!namelist.contains(map.get("pointName"))) {
						namelist.add((String) map.get("pointName"));
						numlist.add(0);
					}
				}
				for (int i=0;i<namelist.size();i++){
					Map<String, Object> map = new HashMap<String, Object>();
					String poname = namelist.get(i);
					int num = 0;
					for(Map<String, Object> mapObj : result){
						if(poname == (String) mapObj.get("pointName")){
							num = numlist.get(i);
							num++;
							numlist.set(i, num);
						} 
					}
					map.put("pointName", poname);
					map.put("nums", num);
					list.add(i, map);
				}
			}
			return list;
     }
     //超标次数排名
     private JSONObject  getOrerderPointForOverCount(List<Map<String, Object>> result){
		JSONObject jsonObject = new JSONObject();
		com.alibaba.fastjson.JSONArray top3Array = new com.alibaba.fastjson.JSONArray();
		com.alibaba.fastjson.JSONArray last3Array = new com.alibaba.fastjson.JSONArray();
		int num = 3 ;
		 Collections.sort(result, new Comparator<Map<String,Object>>(){
			 public int compare(Map<String,Object> o1,Map<String,Object> o2){
				 return  (int)o1.get("nums")>(int)o2.get("nums")?1:( (int)o1.get("nums")==(int)o2.get("nums")?0:-1);
			 }
		 });

		 for(int i = 0; i<result.size();  i++){
			 JSONObject rankObject = new JSONObject();
			 if (i < num) {
				 rankObject.put("pointName", result.get(i).get("pointName"));
				 rankObject.put("nums", result.get(i).get("nums"));
				 top3Array.add(rankObject);
			 }else{
				 break;
			 }
		 }
		 int  lastNum = result.size() -3  ;
		 if(lastNum < 0){
			 lastNum = 0;
		 }
		 for(int i = result.size()-1 ; i >=lastNum;  i--){
			 JSONObject rankObject = new JSONObject();
			 rankObject.put("pointName", result.get(i).get("pointName"));
			 rankObject.put("nums", result.get(i).get("nums"));
			 last3Array.add(rankObject);
		 }
		 jsonObject.put("top3", top3Array);
		 jsonObject.put("last3", last3Array);
		 return   jsonObject   ;
	 }

     /**
	 * 
	 * @Title:  toSqlStr
	 * @Description:    部分sql语句拼接 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年4月29日 下午5:15:33
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年4月29日 下午5:15:33    
	 * @param str
	 * @return  String 
	 * @throws
	 */
	public String toSqlStr(String str) {
		String sqlStr=null;
		if(ToolUtil.isNotEmpty(str)) {
			String[] strs=str.split(",");
			sqlStr="'" + StringUtils.join(strs,"','") +"'";
		}
		return sqlStr;
	}
	
	
}
