package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.PointDao;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.TestDataDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;
import com.fjzxdz.ams.module.enviromonit.pollution.param.PointParam;
import com.fjzxdz.ams.module.enviromonit.pollution.param.TestDataParam2;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PointService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor=Exception.class)
public class PointServiceImpl implements PointService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(PointServiceImpl.class);

	@Autowired
	private PointDao pointDao;
	
	@Autowired
	private TestDataDao testDataDao;
	
	@Autowired
	private SimpleDao simpleDao;

	@Override
	public Point getById(String uuid) {
		return pointDao.getById(uuid);
	}

	@Override
	public Page<Point> listByPage(PointParam param, Page<Point> page) {
		Page<Point> userPage = pointDao.listByPage(param, page);
		return userPage;
	}
	


	@Override
	public JSONArray getCompanyTree() {
        JSONArray jsonArray = new JSONArray();
        String regions[]= {"漳州市辖区","龙文区","芗城区","云霄县","漳浦县","诏安县","诏安县","长泰县","东山县","南靖县",
        		"华安县","龙海市","漳州开发区","古雷开发区","台商投资区","常山开发区"};
        List<Point> points = simpleDao.getAll(Point.class);
		if(ToolUtil.isNotEmpty(points)) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", "漳州市");
			jsonObject.put("name", "漳州市");
			jsonObject.put("text", "漳州市");
			jsonObject.put("parentId", "");
			JSONArray chileArray = new JSONArray();
			for(String str : regions) {
				JSONObject temp = new JSONObject();
				temp.put("id", str);
				temp.put("name", str);
				temp.put("text", str);
				temp.put("parentId", "漳州市");
				JSONArray tempArray = new JSONArray();
				for(Point point:points) {
					if(point.getRegion().equals(str)) {
						JSONObject childtemp = new JSONObject();
						childtemp.put("id", point.getUuid());
						childtemp.put("name", point.getName());
						childtemp.put("text", point.getName());
						childtemp.put("parentId", str);
						tempArray.add(childtemp);
					}
				}
				temp.put("children", tempArray);
				temp.put("state", "closed");
				chileArray.add(temp);
			}
			jsonObject.put("children", chileArray);
			jsonObject.put("state", "");
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	@Override
	public JSONObject getData(String pointuuid) throws Exception {
		Point point = pointDao.getById(pointuuid);
		List<Factor> factors = simpleDao.find("from Factor where pointCode=?", point.getCode());
		JSONObject result = new JSONObject();
		SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(ToolUtil.isNotEmpty(factors)) {
			List<String> titleList = new ArrayList<String>();
			Map<String, List<Object[]>> data = new HashMap<>();
			Set<String> keySet = new HashSet<String>();
			Map<String,String> selMap = new HashMap<String,String>();
			for (Factor factor : factors) {
				if(ToolUtil.isNotEmpty(factor.getUnit())) {
					titleList.add(factor.getName()+"("+factor.getUnit()+")");
					keySet.add(factor.getName()+"("+factor.getUnit()+")");
					data.put(factor.getName()+"("+factor.getUnit()+")", new ArrayList<Object[]>());
					selMap.put(factor.getName()+"("+factor.getUnit()+")", factor.getCode());
				}else {
					titleList.add(factor.getName());
					keySet.add(factor.getName());
					data.put(factor.getName(), new ArrayList<Object[]>());
					selMap.put(factor.getName(), factor.getCode());
				}
			}
			result.put("title", titleList);
			Date date = new Date();
		    String day = sdfTime.format(date);
		    String[] strings = day.split(" ");
			
			TestDataParam2 param = new TestDataParam2();
			param.setMnNumber(point.getMn_code());
			param.setStartTime(strings[0]);
			param.setEndTime(strings[0]);
			List<TestData> testDatas = testDataDao.selectList(param.getQueryString(), param.getParams());
			for(TestData testData : testDatas) {
				JSONObject json = JSONObject.parseObject(testData.gettData());
				Map<String, Object> map = json;
				for (String key : keySet) {
					Object[] temp=new Object[2];
					temp[0] = sdfTime.format(testData.getUploadTime());
					temp[1] = map.get(selMap.get(key));
					List<Object[]> tempList = data.get(key);
					tempList.add(temp);
					data.put(key, tempList);
				}
			}
			
			JSONArray jsonArray = new JSONArray();
			for(String key : keySet){
				JSONObject tempObject = new JSONObject();
				tempObject.put("name", key);
				tempObject.put("type", "line");
				tempObject.put("showAllSymbol","true");
				tempObject.put("symbolSize", "function(value){return Math.round(value[2]/10)+2;");
				tempObject.put("data", data.get(key));
				
				jsonArray.add(tempObject);
			}
			result.put("series", jsonArray);
		}
		return result;
	}
	
	@Override
	public JSONObject getDataFlush(String pointuuid, TestDataParam2 param) throws Exception {
		Point point = pointDao.getById(pointuuid);
		List<Factor> factors = simpleDao.find("from Factor where pointCode=?", point.getCode());
		JSONObject result = new JSONObject();
		SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if ("小时".equals(param.getTest_type())) {
			sdfTime = new SimpleDateFormat("yyyy-MM-dd HH");
		}
		if(ToolUtil.isNotEmpty(factors)) {
			List<String> titleList = new ArrayList<String>();
			Map<String, List<Object[]>> data = new HashMap<>();
			Set<String> keySet = new HashSet<String>();
			Map<String,String> selMap = new HashMap<String,String>();
			for (Factor factor : factors) {
				if(ToolUtil.isNotEmpty(factor.getUnit())) {
					titleList.add(factor.getName()+"("+factor.getUnit()+")");
					keySet.add(factor.getName()+"("+factor.getUnit()+")");
					data.put(factor.getName()+"("+factor.getUnit()+")", new ArrayList<Object[]>());
					selMap.put(factor.getName()+"("+factor.getUnit()+")", factor.getCode());
				}else {
					titleList.add(factor.getName());
					keySet.add(factor.getName());
					data.put(factor.getName(), new ArrayList<Object[]>());
					selMap.put(factor.getName(), factor.getCode());
				}
			}
			result.put("title", titleList);
			param.setMnNumber(point.getMn_code());
			List<TestData> testDatas = testDataDao.selectList(param.getQueryString(), param.getParams());
			for(TestData testData : testDatas) {
				JSONObject json = JSONObject.parseObject(testData.gettData());
				Map<String, Object> map = json;
				for (String key : keySet) {
					Object[] temp=new Object[2];
					temp[0] = sdfTime.format(testData.getUploadTime());
					temp[1] = map.get(selMap.get(key));
					List<Object[]> tempList = data.get(key);
					tempList.add(temp);
					data.put(key, tempList);
				}
			}
			JSONArray jsonArray = new JSONArray();
			for(String key : keySet){
				JSONObject tempObject = new JSONObject();
				tempObject.put("name", key);
				tempObject.put("type", "line");
				tempObject.put("showAllSymbol","true");
				tempObject.put("symbolSize", "function(value){return Math.round(value[2]/10)+2;");
				tempObject.put("data", data.get(key));
				
				jsonArray.add(tempObject);
			}
			result.put("series", jsonArray);
		}
		return result;
	}
}
