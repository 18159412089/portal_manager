/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.haz.dao.EnterpriseWasteInfoDao;
import com.fjzxdz.ams.module.haz.entity.EnterpriseWasteInfo;
import com.fjzxdz.ams.module.haz.param.EnterpriseWasteInfoParam;
import com.fjzxdz.ams.module.haz.service.EnterpriseWasteInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 企业产废贮存信息Controller
 * @author htj
 * @version 2019-02-19
 */
@Controller
 
@RequestMapping(value = "/haz/enterpriseWasteInfo")
 
public class EnterpriseWasteInfoController extends BaseController {

	@Autowired
	private EnterpriseWasteInfoDao enterpriseWasteInfoDao;
	@Autowired
	private EnterpriseWasteInfoService enterpriseWasteInfoService;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "haz/enterpriseWasteInfoList";
	}
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("/analysis")
	public String analysis() {
		return "/moudles/" + "haz/wasteTransferStatisticalAnalysis";
	}
	/**
	 * 更新或新增
	 * @param enterpriseWasteInfo
	 * @return
	 */	
	@RequestMapping("/saveEnterpriseWasteInfo")
	@ResponseBody
	public R saveEnterpriseWasteInfo(EnterpriseWasteInfo enterpriseWasteInfo) {
		try {
			enterpriseWasteInfoService.save(enterpriseWasteInfo);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deleteEnterpriseWasteInfo")
	@ResponseBody
	public R deleteEnterpriseWasteInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			enterpriseWasteInfoService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getEnterpriseWasteInfo")
	@ResponseBody
	public Map<String, Object> getEnterpriseWasteInfo(@RequestParam(value = "uuid") String uuid) {
		EnterpriseWasteInfo enterpriseWasteInfo = enterpriseWasteInfoDao.getById(uuid);
		return BeanUtil.beanToMap(enterpriseWasteInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param enterpriseWasteInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/enterpriseWasteInfoList")
	@ResponseBody
	public PageEU<EnterpriseWasteInfo> enterpriseWasteInfoList(EnterpriseWasteInfoParam enterpriseWasteInfoParam, HttpServletRequest request) {
		Page<EnterpriseWasteInfo> page = enterpriseWasteInfoService.listByPage(enterpriseWasteInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 危废产生
	 * @param qy 区域
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getWasteProduceStatistics")
	@ResponseBody
	public Map<String, Object> getWasteProduceStatistics(String qy,String startTime,String endTime) {
		String time[] = endTime.split("-");//2018-01
		if(time[1].equals("12")||time[1]=="12" ){
			endTime = String.valueOf(Integer.parseInt(time[0])+1)+"-01";
		}
		Map<String, Object> result = new HashMap<>();
		String sql = 
				"SELECT\n" +
						"	TO_CHAR (UPDATETIME, 'yyyy-mm') AS TIME,\n" +
						"	\"SUM\" (QUANTITY) AS num\n" +
						"FROM\n" +
						"	HAZ_ENTERPRISE_WASTE_INFO\n" +
						"WHERE\n" +
						"	TO_CHAR (UPDATETIME, 'yyyy-mm') >= '"+startTime+"'\n" +
						"AND TO_CHAR (UPDATETIME, 'yyyy-mm') < '"+endTime+"'\n" +
						"GROUP BY\n" +
						"	TO_CHAR (UPDATETIME, 'yyyy-mm')\n" +
						"ORDER BY TIME";
		//业务处理
		List<Object> list = simpleDao.createNativeQuery(sql).getResultList();
		JSONArray array = new JSONArray();
		for (Object obj : list) {
			String objStr = "";
			try {
				objStr = (new ObjectMapper()).writeValueAsString(obj);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			String str = objStr.substring(1,objStr.length()-1);
			String []arr = str.split(",");
			JSONObject objs = new JSONObject();
			objs.put("rq", arr[0]);
			objs.put("num", arr[1]);
			array.add(objs);
		}
		result.put("data", array);
		return result;
	}
	
	/**
	 * 危废转移统计分析
	 * @param qy 区域
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getWasteTransferStatistics")
	@ResponseBody
	public Map<String, Object> getWasteTransferStatistics(String qy,String startTime,String endTime) {
		String time[] = endTime.split("-");//2018-01
		if(time[1].equals("12")||time[1]=="12" ){
			endTime = String.valueOf(Integer.parseInt(time[0])+1)+"-01";
		}
		Map<String, Object> result = new HashMap<>();
		String sql = 
				"SELECT\n" +
						"	*\n" +
						"FROM\n" +
						"	(\n" +
						"		SELECT\n" +
						"			TO_CHAR (UPDATETIME, 'yyyy-mm') TIME,\n" +
						"			NVL (\n" +
						"				SUM (\n" +
						"					DECODE (DANWEI, '千克', ZYL)\n" +
						"				) / 1000,\n" +
						"				0\n" +
						"			) + SUM (DECODE(DANWEI, '吨', ZYL)) D\n" +
						"		FROM\n" +
						"			HAZ_JOINT_ORDER_DETAIL\n" +
						"		GROUP BY\n" +
						"			TO_CHAR (UPDATETIME, 'yyyy-mm')\n" +
						"	)\n" +
						"WHERE\n" +
						"	TIME >= '"+startTime+"'\n" +
						"AND TIME < '"+endTime+"'\n" +
						"ORDER BY TIME";
		//业务处理
		List<Object> list = simpleDao.createNativeQuery(sql).getResultList();
		JSONArray array = new JSONArray();
		for (Object obj : list) {
			String objStr = "";
			try {
				objStr = (new ObjectMapper()).writeValueAsString(obj);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			String str = objStr.substring(1,objStr.length()-1);
			String []arr = str.split(",");
			JSONObject objs = new JSONObject();
			objs.put("rq", arr[0]);
			objs.put("num", arr[1]);
			array.add(objs);
		}
		result.put("data", array);
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(EnterpriseWasteInfoParam param, HttpServletResponse response){
		List<EnterpriseWasteInfo> lists = enterpriseWasteInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (EnterpriseWasteInfo wasteInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entname", wasteInfo.getENTNAME());
			map.put("code", wasteInfo.getCODE());//暂时没有对应实体类
			map.put("wasteName", wasteInfo.getWasteName());
			map.put("storageName", wasteInfo.getStorageName());
			map.put("unit",wasteInfo.getUNIT());
			map.put("quantity",wasteInfo.getQUANTITY());
			map.put("enterpriseAttribute",wasteInfo.getEnterpriseAttribute());
			map.put("createdTime", wasteInfo.getCreatedTime());
			map.put("updatetime", "");
			result.add(map);
		}
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
		columnMap.put("title", "企业产废贮存数据表");

		columnMap.put("entname", "企业名称");
		columnMap.put("code", "危废代码");
		columnMap.put("wasteName", "危废俗称");
		columnMap.put("storageName", "贮存仓库名称");
		columnMap.put("unit", "危废重量单位");
		columnMap.put("quantity", "危废产生贮存量");
		columnMap.put("enterpriseAttribute", "产废企业");
		columnMap.put("createdTime", "企业创建时间");
		columnMap.put("updatetime", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
