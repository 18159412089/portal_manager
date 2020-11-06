/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.enterprise.controller;

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
import com.fjzxdz.ams.module.enviromonit.enterprise.dao.PeEnterpriseDataDao;
import com.fjzxdz.ams.module.enviromonit.enterprise.entity.PeEnterpriseData;
import com.fjzxdz.ams.module.enviromonit.enterprise.param.PeEnterpriseDataParam;
import com.fjzxdz.ams.module.enviromonit.enterprise.service.PeEnterpriseDataService;
import com.fjzxdz.ams.module.enviromonit.monitorpoint.entity.PeMonitorPoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 污染源自动监控企业信息表Controller
 * 
 * @author slq
 * @date 2019-02-11
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/enterprise/peenterprisedata")
public class PeEnterpriseDataController extends BaseController {

	@Autowired
	private PeEnterpriseDataDao peEnterpriseDataDao;
	@Autowired
	private PeEnterpriseDataService peEnterpriseDataService;
	@Autowired
	private SimpleDao simpleDao;

	/**
	 * 跳转页面
	 * 
	 * @return
	 */
	@PreAuthorize("hasAuthority('enterprise:peenterprisedata:show')")
	@RequestMapping("")
	public String index() {
		return "/modules/enviromonit/enterprise/peenterprisedataList";
	}

	/**
	 * 更新或新增
	 * 
	 * @param peEnterpriseData
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('enterprise:peenterprisedata:add,enterprise:peenterprisedata:edit')")
	@RequestMapping("/savePeEnterpriseData")
	@ResponseBody
	public R savePeEnterpriseData(PeEnterpriseData peEnterpriseData) {
		try {
			String validateResult = ValidateUtil.validate(peEnterpriseData);
			if (validateResult != null) {
				return R.error(validateResult);
			}
			peEnterpriseDataService.save(peEnterpriseData);
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
	@PreAuthorize("hasAuthority('enterprise:peenterprisedata:delete')")
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
	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getPeEnterpriseData")
	@ResponseBody
	public Map<String, Object> getPeEnterpriseData(@RequestParam(value = "uuid") String uuid) {
		PeEnterpriseData peEnterpriseData;
		try {
			peEnterpriseData = peEnterpriseDataDao.getById(uuid);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok().put("peEnterpriseData", peEnterpriseData);
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
	public PageEU<PeEnterpriseData> peEnterpriseDataList(PeEnterpriseDataParam peEnterpriseDataParam,
			HttpServletRequest request) {
		Page<PeEnterpriseData> page = peEnterpriseDataService.listByPage(peEnterpriseDataParam, pageQuery(request));
		List<PeEnterpriseData> list = page.getResult();

		List<PeEnterpriseData> newList = new ArrayList<>();
		try {
			for (PeEnterpriseData peEnterpriseData : list) {
				String peId = peEnterpriseData.getPeId();
				List<PeMonitorPoint> pointList = simpleDao.findBy(PeMonitorPoint.class, "peId", peId);
				for (int i = 0; i < pointList.size(); i++) {
					pointList.get(i).setPeEnterpriseData(null);
				}
				peEnterpriseData.setPeMonitorPointList(pointList);
				newList.add(peEnterpriseData);
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
			List<PeEnterpriseData> peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();
			for (PeEnterpriseData peEnterpriseData : peEnterpriseDatasList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("uuid", peEnterpriseData.getPeId());
				jsonObject.put("peName", peEnterpriseData.getPeName());
				jsonObject.put("portList", peEnterpriseData.getPeMonitorPoint());
				jsonObject.put("address", peEnterpriseData.getAddress());
				jsonObject.put("latitude", peEnterpriseData.getLatValue());
				jsonObject.put("longitude", peEnterpriseData.getLongValue());
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
		List<PeEnterpriseData> peEnterpriseDatasList;
		peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();
		for (PeEnterpriseData peEnterpriseData : peEnterpriseDatasList) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", peEnterpriseData.getPeId());
			jsonObject.put("text", peEnterpriseData.getPeName());
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
	@RequestMapping("/getCompnentPeEnterpriseDatasListByUnitTypeCode")
	@ResponseBody
	public JSONArray getCompnentPeEnterpriseDatasListByUnitTypeCode(
			@RequestParam(value = "unitTypeCode") String unitTypeCode) {
		JSONArray peEnterpriseDatasArray = new JSONArray();
		List<PeEnterpriseData> peEnterpriseDatasList;
		peEnterpriseDatasList = peEnterpriseDataService.getCompnentPeEnterpriseDatasListByUnitTypeCode(unitTypeCode);
		for (PeEnterpriseData peEnterpriseData : peEnterpriseDatasList) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", peEnterpriseData.getPeId());
			jsonObject.put("text", peEnterpriseData.getPeName());
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

		List<PeEnterpriseData> peEnterpriseDatasList = peEnterpriseDataDao.selectListAll();

		// 企业信息
		JSONArray peEnterpriseDatasArray = new JSONArray();
		for (PeEnterpriseData peEnterpriseData : peEnterpriseDatasList) {
			JSONObject enterpriseObj = new JSONObject();

			enterpriseObj.put("id", peEnterpriseData.getPeId());
			enterpriseObj.put("text", peEnterpriseData.getPeName());
			enterpriseObj.put("iconCls", "");
			enterpriseObj.put("state", "closed");

			JSONObject peEnterpriseDataAttributes = peEnterpriseData.toJSONObject();
			peEnterpriseDataAttributes.put("nodeType", "ENTERPRISE");
			enterpriseObj.put("attributes", peEnterpriseDataAttributes);

			// 点位信息
			Set<PeMonitorPoint> portSet = peEnterpriseData.getPeMonitorPoint();
			JSONArray childrenArray = new JSONArray();
			for (PeMonitorPoint port : portSet) {
				JSONObject childrenObj = new JSONObject();

				childrenObj.put("id", peEnterpriseData.getPeId());
				childrenObj.put("text", peEnterpriseData.getPeName());
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
	public PageEU<PeEnterpriseData> list(@RequestParam(value = "page", required = false) Integer page,
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
		String whereQx = "";
		if(getUserDeptName() != null){
			whereQx = " and  e.QX = '" + getUserDeptName() + "'";
		}
		String sqlStr = "select e.PE_ID, e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.address from PE_ENTERPRISE_DATA e  "
				+ "inner  join  PE_MONITOR_POINT p on e.PE_ID=p.PE_ID where p.OUTFALL_TYPE=  " + outType + whereQx;
		if (StringUtils.isNotEmpty(outName)) {
			sqlStr += " and p.name like '%" + outName + "%'";
		}
		sqlStr += " GROUP BY  e.PE_NAME,e.PE_ID,e.LONG_VALUE,e.LAT_VALUE,e.address";
		simpleDao.listNativeByPage(sqlStr, dataPage);
		return new PageEU<>(dataPage);
	}
	
	/**
	 * 获取企业信息，用于在地图上显示
	 * @param outType
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getPeEnterpriseDataInfo")
	@ResponseBody
	public String getPeEnterpriseDataInfo(@RequestParam(value = "outType") String outType) {
		String whereQx = "";
		if(getUserDeptName() != null){
			whereQx = " and  e.QX = '" + getUserDeptName() + "'";
		}
		String sqlStr = "select e.PE_ID, e.PE_NAME,e.LONG_VALUE,e.LAT_VALUE,e.address,p.cameraid ,p.OUTPUT_STATUS from PE_ENTERPRISE_DATA e  "
				+ "inner  join  PE_MONITOR_POINT p on e.PE_ID=p.PE_ID where p.OUTFALL_TYPE=  " + outType + whereQx;
		sqlStr += " GROUP BY  e.PE_NAME,e.PE_ID,e.LONG_VALUE,e.LAT_VALUE,e.address,p.cameraid ,p.OUTPUT_STATUS";
		JSONObject jsonObject = new JSONObject();
		org.json.JSONArray jsonArray = new org.json.JSONArray();
		List<Object[]> list = simpleDao.createNativeQuery(sqlStr).getResultList();
		for (Object[] objects : list) {
			jsonObject.put("peId", objects[0]);
			jsonObject.put("peName", objects[1]);
			jsonObject.put("address", (objects[4]));
			jsonObject.put("cameraid", (objects[5]));
			jsonObject.put("pointStatus", (objects[6]));
			if (null != objects[2]&& null != objects[3]) {
				jsonObject.put("longValue", Double.valueOf(String.valueOf(objects[2])));
				jsonObject.put("latValue", Double.valueOf(String.valueOf(objects[3])));
				jsonArray.put(jsonObject);
			}
			
		}
		return jsonArray.toString();
	}

}
