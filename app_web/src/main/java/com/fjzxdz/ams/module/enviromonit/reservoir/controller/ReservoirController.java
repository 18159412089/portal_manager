/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.reservoir.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.reservoir.service.ReservoirService;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.util.DateUtil;

/**
 * monitorPointController
 * @author htj
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/reservoir/reservoir")
@Secured({ "ROLE_USER"})
public class ReservoirController extends BaseController {

	@Autowired
	private ReservoirService reservoirService;
	
	
	
	/**
	 * 水库数据分析
	 * @param eqpID 水库id
	 * @param days 过去多少天
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getConDaychart")
	@ResponseBody
	public Map<String, Object> getConDaychart(String eqpID,Integer days) throws Exception {
		Map<String, Object> result = new HashMap<>();
		List<String> xAxis = new ArrayList<String>();
		Map<String, Object> timeMap = DateUtil.getSomeDay(days);
		xAxis = (List<String>) timeMap.get("xList");
		Map<String, Integer> indexmap = (Map<String, Integer>) timeMap.get("indexmap");
		
		String unit = "";
		List<Object[]> list = reservoirService.getConDaychart(eqpID, days);
		
		Map<String,Object[]> series = new HashMap<String,Object[]>();
		Map<String,String> keyMap = new	HashMap<String,String>();
		for (Object[] obj : list) {
			if(obj[0]!=null) {
				keyMap.put("maxValue", "当日最大下泄流量");
				keyMap.put("minValue", "当日最小下泄流量");
				keyMap.put("avgValue", "日均下泄流量");
				if (series.containsKey("maxValue")) {
					if (obj[1] != null) {
						series.get("maxValue")[indexmap.get(obj[2])]=obj[1];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[1] != null) {
						tempList[indexmap.get(obj[2])]=obj[1];
					}
					series.put("maxValue", tempList);
				}
				if (series.containsKey("minValue")) {
					if (obj[3] != null) {
						series.get("minValue")[indexmap.get(obj[2])]=obj[3];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[3] != null) {
						tempList[indexmap.get(obj[2])]=obj[3];
					}
					series.put("minValue", tempList);
				}
				if (series.containsKey("avgValue")) {
					if (obj[4] != null) {
						series.get("avgValue")[indexmap.get(obj[2])]=obj[4];
					}
				}else {
					Object[] tempList = new Object[indexmap.size()];
					if (obj[4] != null) {
						tempList[indexmap.get(obj[2])]=obj[4];
					}
					series.put("avgValue", tempList);
				}
			}
		}
		List<String> legendList = new ArrayList<String>();
		JSONArray xArray = new JSONArray();
		result.put("xAxis", xAxis);
		for (Object key : series.keySet()) {
			legendList.add(keyMap.get(key));
			JSONObject xObject = new JSONObject();
			xObject.put("data", series.get(key));
			xObject.put("type", "line");
			xObject.put("name", keyMap.get(key));
			xArray.add(xObject);
		}
		result.put("unit", unit);
		result.put("legend", legendList);
		result.put("series", xArray);
		
		return result;
	}
	
}
