/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.vi.controller;

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
import com.fjzxdz.ams.module.vi.dao.VisitsDao;
import com.fjzxdz.ams.module.vi.entity.Visits;
import com.fjzxdz.ams.module.vi.param.VisitsParam;
import com.fjzxdz.ams.module.vi.service.VisitsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 信访投诉Controller
 * @author htj
 * @version 2019-02-19
 */
@Controller
 
@RequestMapping(value = "/vi/visits")
 
public class VisitsController extends BaseController {

	
	@Autowired
	private VisitsService visitsService;
	@Autowired
	private VisitsDao visitsDao;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "vi/visitsList";
	}
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("/analysis")
	public String analysis() {
		return "/moudles/" + "vi/visitsStatisticalAnalysis";
	}
	
	/**
	 * 更新或新增
	 * @param visits
	 * @return
	 */	
	@RequestMapping("/saveVisits")
	@ResponseBody
	public R saveVisits(Visits visits) {
		try {
			visitsService.save(visits);
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
	@RequestMapping("/deleteVisits")
	@ResponseBody
	public R deleteVisits(@RequestParam(value = "uuid") String uuid) {
		try {
			visitsService.delete(uuid);
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
	@RequestMapping("/getVisits")
	@ResponseBody
	public Map<String, Object> getVisits(@RequestParam(value = "uuid") String uuid) {
		Visits visits = simpleDao.findUnique("from Visits where PETIID=?",uuid);
		return BeanUtil.beanToMap(visits,false,true);
	}
	
	/**
	 * 查询列表
	 * @param visitsParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/visitsList")
	@ResponseBody
	public PageEU<Visits> visitsList(VisitsParam visitsParam, HttpServletRequest request) {
		Page<Visits> page = visitsService.listByPage(visitsParam, pageQuery(request));
		return new PageEU<>(page);
	}
	/**
	 * 各月信访投诉案件数量统计
	 * @param qy 区域
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getVisitsMonNum")
	@ResponseBody
	public Map<String, Object> getVisitsMonNum(String qy,String startTime,String endTime) {
		String time[] = endTime.split("-");//2018-01
		if(time[1].equals("12")||time[1]=="12" ){
			endTime = String.valueOf(Integer.parseInt(time[0])+1)+"-01";
		}
		Map<String, Object> result = new HashMap<>();
		String sql = "SELECT\n" +
				"	SUBSTR (INSERTTIME, 1, 7) AS mon,\n" +
				"	COUNT (*) AS num\n" +
				"FROM\n" +
				"	VI_VISITS\n" +
				"WHERE\n" +
				"	INSERTTIME >= '"+startTime+"'\n" +
				"AND INSERTTIME < '"+endTime+"'\n" +
				"AND POLLUTIONCOUNTY = '"+qy+"' AND ISACCEPT = '1'\n" +
				"GROUP BY\n" +
				"	SUBSTR (INSERTTIME, 1, 7)\n" +
				"ORDER BY mon";
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
	 * 本年与去年同期信访投诉累计结案数量统计
	 * @param qy 区域
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getVisitYearNum")
	@ResponseBody
	public Map<String, Object> getVisitYearNum(String qy,String startTime,String endTime) {
		String time0[] = endTime.split("-");//2018-01
		if(time0[1].equals("12")||time0[1]=="12" ){
			endTime = String.valueOf(Integer.parseInt(time0[0])+1)+"-01";
		}
		String time1[] = startTime.split("-");//2018-01
		String lystartTime = String.valueOf(Integer.parseInt(time1[0])-1)+"-"+time1[1];
		String time2[] = endTime.split("-");//2018-01
		String lyendTime = String.valueOf(Integer.parseInt(time2[0])-1)+"-"+time2[1];
		Map<String, Object> result = new HashMap<>();
		String sql = 
				"SELECT\n" +
						"	(\n" +
						"		SELECT\n" +
						"			COUNT (*) AS num\n" +
						"		FROM\n" +
						"			VI_VISITS\n" +
						"		WHERE\n" +
						"			INSERTTIME >= '"+startTime+"'\n" +
						"		AND INSERTTIME < '"+endTime+"'\n" +
						"		AND POLLUTIONCOUNTY = '"+qy+"'\n" +
						"		AND ISACCEPT = '1'\n" +
						"	) AS tynum,\n" +
						"	(\n" +
						"		SELECT\n" +
						"			COUNT (*) AS num\n" +
						"		FROM\n" +
						"			VI_VISITS\n" +
						"		WHERE\n" +
						"			INSERTTIME >= '"+lystartTime+"'\n" +
						"		AND INSERTTIME < '"+lyendTime+"'\n" +
						"		AND POLLUTIONCOUNTY = '"+qy+"'\n" +
						"		AND ISACCEPT = '1'\n" +
						"	) AS lynum\n" +
						"FROM\n" +
						"	dual";
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
			objs.put("tynum", arr[0]);
			objs.put("lynum", arr[1]);
			array.add(objs);
		}
		result.put("data", array);
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(VisitsParam param, HttpServletResponse response){
		List<Visits> lists = visitsDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (Visits visits : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("lettercode", visits.getLETTERCODE());
			map.put("source", visits.getSOURCE());
			map.put("resourcel", visits.getRESOURCEL());
			map.put("attribute", visits.getATTRIBUTE());
			map.put("petitiontime",visits.getPETITIONTIME());
			map.put("inserttime", visits.getINSERTTIME());
			map.put("pename", visits.getPENAME());
			map.put("peticontent", visits.getPETICONTENT());
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
		columnMap.put("title", "信访投诉数据表");
		columnMap.put("lettercode", "信件编号");
		columnMap.put("source", "来源系统");
		columnMap.put("resourcel", "案件来源");
		columnMap.put("attribute", "案件属性");
		columnMap.put("petitiontime", "办理时间");
		columnMap.put("inserttime", "登记时间");
		columnMap.put("pename", "被举报单位名称");
		columnMap.put("peticontent", "举报内容");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
