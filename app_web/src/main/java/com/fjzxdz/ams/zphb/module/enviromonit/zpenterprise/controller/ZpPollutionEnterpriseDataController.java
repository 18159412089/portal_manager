package com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.license.utils.IdGenerator;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.ValidateUtil;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;

import com.fjzxdz.ams.zphb.module.enviromonit.minutedata.service.ZpPollutionConMinuteDataService;
import com.fjzxdz.ams.zphb.module.enviromonit.monitorpoint.entity.ZpPeMonitorPoint;

import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.dao.ZpPollutionEnterpriseDataDao;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.entity.ZpPollutionEnterpriseData;

import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.param.ZpPollutionEnterpriseDataParam;
import com.fjzxdz.ams.zphb.module.enviromonit.zpenterprise.service.ZpPollutionEnterpriseDataService;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.sql.Timestamp;
import java.util.*;

/**
 * 污染源自动监控企业信息表Controller
 * 
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/enterprise/peenterprisedata")
public class ZpPollutionEnterpriseDataController  extends BaseController {

	@Autowired
	private ZpPollutionEnterpriseDataDao peEnterpriseDataDao;
	@Autowired
	private ZpPollutionEnterpriseDataService peEnterpriseDataService;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private ZpPollutionConMinuteDataService zpPollutionConMinuteDataService;
	/**
	 * 跳转页面
	 * 
	 * @return
	 */

	@RequestMapping("")
	public String index() {
		return "/zphb/moudles/enviromonit/pollutionEnterprise/pollutionEnterpriseDataList";
	}

	/**
	 * 更新或新增
	 * 
	 * @param zpPeEnterpriseData
	 * @return
	 */
	@RequestMapping("/savePeEnterpriseData")
	@ResponseBody
	public R savePeEnterpriseData(ZpPollutionEnterpriseData zpPeEnterpriseData) {
		try {
			String validateResult = ValidateUtil.validate(zpPeEnterpriseData);
			if (validateResult != null) {
				return R.error(validateResult);
			}
			peEnterpriseDataService.save(zpPeEnterpriseData);
		} catch (Exception e) {
			// return R.error(e.getMessage());
			return R.error(e);
		}
		return R.ok();
	}

	/**
	 * 按uuid删除
	 * 
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deletePeEnterpriseData")
	@ResponseBody
	public R deletePeEnterpriseData(@RequestParam(value = "uuid") String uuid) {
		try {
			peEnterpriseDataService.delete(uuid);
		} catch (Exception e) {
			return R.error(e);
		}
		return R.ok();
	}

	/**
	 * 按uuid查询，并返回map
	 * 
	 * @param uuid
	 * @return
	 */

	@RequestMapping("/getPeEnterpriseData")
	@ResponseBody
	public Map<String, Object> getPeEnterpriseData(@RequestParam(value = "uuid") String uuid) {
		ZpPollutionEnterpriseData zpPeEnterpriseData;
		try {
			zpPeEnterpriseData = peEnterpriseDataDao.getById(uuid);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peEnterpriseData", zpPeEnterpriseData);
	}



	/**
	 * 查询列表
	 *
	 * @param peEnterpriseDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/pollutionEnterpriseDataList")
	@ResponseBody
	public PageEU<ZpPollutionEnterpriseData> pollutionEnterpriseDataList(ZpPollutionEnterpriseDataParam peEnterpriseDataParam,
																  HttpServletRequest request) {
		Page<ZpPollutionEnterpriseData> page = peEnterpriseDataService.listByPage(peEnterpriseDataParam, pageQuery(request));
		List<ZpPollutionEnterpriseData> list = page.getResult();

		page.setResult(list);
		return new PageEU<>(page);
	}

	/**
	 * 查询列表
	 * 
	 * @param peEnterpriseDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/peEnterpriseDataList")
	@ResponseBody
	public PageEU<ZpPollutionEnterpriseData> peEnterpriseDataList(ZpPollutionEnterpriseDataParam peEnterpriseDataParam,
																  HttpServletRequest request) {
		Page<ZpPollutionEnterpriseData> page = peEnterpriseDataService.listByPage(peEnterpriseDataParam, pageQuery(request));
		List<ZpPollutionEnterpriseData> list = page.getResult();

		List<ZpPollutionEnterpriseData> newList = new ArrayList<>();
		try {
			for (ZpPollutionEnterpriseData zpPeEnterpriseData : list) {
				String peId = zpPeEnterpriseData.getPeId();
				List<ZpPeMonitorPoint> pointList = simpleDao.findBy(ZpPeMonitorPoint.class, "peId", peId);
				for (int i = 0; i < pointList.size(); i++) {
					pointList.get(i).setZpPeEnterpriseData(null);
				}
				zpPeEnterpriseData.setZpPeMonitorPointList(pointList);
				newList.add(zpPeEnterpriseData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		page.setResult(newList);
		return new PageEU<>(page);
	}

	/**
	 * 获取企业列表信息
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeEnterpriseDatasList")
	@ResponseBody
	public JSONArray getPeEnterpriseDatasList() {
		JSONArray peEnterpriseDatasArray = new JSONArray();
		try {
			List<ZpPollutionEnterpriseData> peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();
			for (ZpPollutionEnterpriseData zpPeEnterpriseData : peEnterpriseDatasList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("uuid", zpPeEnterpriseData.getPeId());
				jsonObject.put("peName", zpPeEnterpriseData.getPeName());
				jsonObject.put("portList", zpPeEnterpriseData.getZpPeMonitorPoint());
				jsonObject.put("address", zpPeEnterpriseData.getAddress());
				jsonObject.put("latitude", zpPeEnterpriseData.getLatValue());
				jsonObject.put("longitude", zpPeEnterpriseData.getLongValue());
				peEnterpriseDatasArray.add(jsonObject);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return peEnterpriseDatasArray;
	}

	/**
	 * 获取下拉企业列表信息
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping("/getCompnentPeEnterpriseDatasList")
	@ResponseBody
	public JSONArray getCompnentPeEnterpriseDatasList() {
		JSONArray peEnterpriseDatasArray = new JSONArray();
		List<ZpPollutionEnterpriseData> peEnterpriseDatasList;
		peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();
		for (ZpPollutionEnterpriseData zpPeEnterpriseData : peEnterpriseDatasList) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", zpPeEnterpriseData.getPeId());
			jsonObject.put("text", zpPeEnterpriseData.getPeName());
			peEnterpriseDatasArray.add(jsonObject);
		}
		return peEnterpriseDatasArray;
	}

	/**
	 * 获取下拉企业列表信息
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping("/getCompnentPeEnterpriseDatasListByEnterpriseName")
	@ResponseBody
	public JSONArray getCompnentPeEnterpriseDatasListByEnterpriseName(
			@RequestParam(value = "enterpriseName") String enterpriseName) {
		JSONArray peEnterpriseDatasArray = new JSONArray();
		List<ZpPollutionEnterpriseData> peEnterpriseDatasList;
		peEnterpriseDatasList = peEnterpriseDataService.getCompnentPeEnterpriseDatasListByEnterpriseName(enterpriseName);
		for (ZpPollutionEnterpriseData zpPeEnterpriseData : peEnterpriseDatasList) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", zpPeEnterpriseData.getPeId());
			jsonObject.put("text", zpPeEnterpriseData.getPeName());
			peEnterpriseDatasArray.add(jsonObject);
		}
		return peEnterpriseDatasArray;
	}

	/**
	 * 获取企业监测点位树
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping("/getPeEnterpriseDatasTreeList")
	@ResponseBody
	public JSONArray getPeEnterpriseDatasTreeList(String enterpriseName) {
		JSONArray result = new JSONArray();

		JSONObject rootObj = new JSONObject();
		rootObj.put("id", IdGenerator.getNewId());
		rootObj.put("text", "企业监测点位");
		rootObj.put("iconCls", "");
		rootObj.put("state", "open");

		JSONObject rootAttributes = new JSONObject();
		rootAttributes.put("nodeType", "ROOT");
		rootObj.put("attributes", rootAttributes);

		List<ZpPollutionEnterpriseData> peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();

		// 企业信息
		JSONArray peEnterpriseDatasArray = new JSONArray();
		for (ZpPollutionEnterpriseData zpPeEnterpriseData : peEnterpriseDatasList) {
			JSONObject enterpriseObj = new JSONObject();

			enterpriseObj.put("id", zpPeEnterpriseData.getPeId());
			enterpriseObj.put("text", zpPeEnterpriseData.getPeName());
			enterpriseObj.put("iconCls", "");
			enterpriseObj.put("state", "closed");

			JSONObject peEnterpriseDataAttributes = zpPeEnterpriseData.toJSONObject();
			peEnterpriseDataAttributes.put("nodeType", "ENTERPRISE");
			enterpriseObj.put("attributes", peEnterpriseDataAttributes);

			// 点位信息
			Set<ZpPeMonitorPoint> portSet = zpPeEnterpriseData.getZpPeMonitorPoint();
			JSONArray childrenArray = new JSONArray();
			for (ZpPeMonitorPoint port : portSet) {
				JSONObject childrenObj = new JSONObject();

				childrenObj.put("id", port.getOutputId());
				childrenObj.put("text", port.getName());
				childrenObj.put("iconCls", "");
				childrenObj.put("state", "open");// 叶子节点的state必须为open，否则将会无限循环

				JSONObject portAttributes = port.toJSONObject();
				portAttributes.put("nodeType", "MONITOR_POINT");
				childrenObj.put("attributes", portAttributes);

				childrenArray.add(childrenObj);
			}
			if(childrenArray.size() <=0){
				enterpriseObj.put("iconCls", "");
				enterpriseObj.put("state", "open");
			} 
			enterpriseObj.put("children", childrenArray);
			peEnterpriseDatasArray.add(enterpriseObj);
		}
		rootObj.put("children", peEnterpriseDatasArray);

		result.add(rootObj);
		return result;
	}

	/**
	 * 获取有废弃排口的企业信息带分页
	 * 
	 * @param page
	 * @param rows
	 * @param outType
	 * @param outName
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<ZpPollutionEnterpriseData> list(@RequestParam(value = "page", required = false) Integer page,
												  @RequestParam(value = "rows", required = false) Integer rows,
												  @RequestParam(value = "outType") String outType,
												  @RequestParam(value = "outName", required = false) String outName, HttpServletRequest request) {
		Page dataPage = new Page<>();
		if (page != null) {
			dataPage.setCurrentPage(page - 1);
		}
		if (rows != null) {
			dataPage.setLimit(rows);
		}
		String sqlStr = "select e.PE_ID, e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.address from PE_ENTERPRISE_DATA e  "
				+ "inner  join  PE_MONITOR_POINT p on e.PE_ID=p.PE_ID where p.OUTFALL_TYPE=  " + outType;

		if (StringUtils.isNotEmpty(outName)) {
			sqlStr += " and p.name like '%" + outName + "%'";
		}
		sqlStr += " GROUP BY  e.PE_NAME,e.PE_ID,e.LONG_VALUE,e.LAT_VALUE,e.address";
		simpleDao.listNativeByPage(sqlStr, dataPage);
		return new PageEU<>(dataPage);
	}
	
	/**
	 * 获取企业信息，用于在地图上显示
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getPeEnterpriseDataInfo")
	@ResponseBody
	public String getPeEnterpriseDataInfo() {
		cn.hutool.json.JSONObject dataLastTimeObjs =  zpPollutionConMinuteDataService.getPointInsertDataLastTime();

        String sqlStr = "SELECT\n" +
				"\tE .PE_ID,\n" +
				"\tE .PE_NAME,\n" +
				"\tE .LONG_VALUE,\n" +
				"\tE .LAT_VALUE,\n" +
				"\tE .ADDRESS,\n" +
				"\tp .OUTPUT_ID\n" +
				"FROM\n" +
				"\tZP_POLLUTION_ENTERPRISE_DATA E left join ZP_POLLUTION_MONITOR_POINT p on E.PE_ID = P.PE_ID" ;

		org.json.JSONArray jsonArray = new org.json.JSONArray();
		HashMap<String,JSONObject> jsonobjs = new HashMap<String,JSONObject>();
		List<Object[]> list = simpleDao.createNativeQuery(sqlStr).getResultList();
		for (Object[] objects : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("peId", objects[0]);
			jsonObject.put("outputId", objects[5]);
			jsonObject.put("peName", objects[1]);
			jsonObject.put("address", (objects[4]));
			jsonObject.put("isOver", "false");
			if (StringUtils.isNotBlank(objects[0].toString())  && StringUtils.isNotBlank(objects[5].toString()) ){
				String id = objects[0].toString()+"#"+objects[5].toString();
			    boolean flag =	zpPollutionConMinuteDataService.isStationOverState(objects[0].toString(),objects[5].toString(), Timestamp.valueOf(dataLastTimeObjs.getStr(id)) );
				if(jsonobjs.containsKey(objects[0].toString())) {
					  if(String.valueOf(flag).equals("true"))
					 	 jsonobjs.get(objects[0].toString()).put("isOver",String.valueOf(flag));
 				}else{
					  jsonObject.put("isOver", String.valueOf(flag));
				}
			}
 			if (null != objects[2]&& null != objects[3]) {
				jsonObject.put("longValue", Double.valueOf(String.valueOf(objects[2])));
				jsonObject.put("latValue", Double.valueOf(String.valueOf(objects[3])));
				if(!jsonobjs.containsKey(objects[0].toString())) {
					jsonobjs.put(objects[0].toString(), jsonObject);
				}
			}
		}

		Iterator iter = jsonobjs.entrySet().iterator();
 		while (iter.hasNext()) {
 			 Map.Entry entry = (Map.Entry) iter.next();
			 JSONObject val =(JSONObject) entry.getValue();

			 jsonArray.put(val);
		}
 		return jsonArray.toString();
	}



	@RequestMapping("/getPePointDataInfo")
	@ResponseBody
	public String getPePointDataInfo(String peId) {

		String sqlStr = "select e.PE_ID, e.PE_NAME, p.name,p.OUTPUT_ID  from ZP_POLLUTION_ENTERPRISE_DATA e  "
				+ "inner  join  ZP_POLLUTION_MONITOR_POINT p on e.PE_ID=p.PE_ID  where e.PE_CODE='"+peId+"' " ;
		sqlStr += " GROUP BY  e.PE_ID, p.name,p.OUTPUT_ID,e.PE_NAME";
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		List<Object[]> list = simpleDao.createNativeQuery(sqlStr).getResultList();
		for (Object[] objects : list) {
			jsonObject.put("peId", objects[0]);
			jsonObject.put("peName", objects[1]);
			jsonObject.put("name", objects[2]);
			jsonObject.put("outputId", (objects[3]));
			jsonArray.put(jsonObject);
		}
		return jsonArray.toString();
	}



}
