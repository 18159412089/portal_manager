/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rad.dao.RadXRayAccountDao;
import com.fjzxdz.ams.module.rad.entity.RadXRayAccount;
import com.fjzxdz.ams.module.rad.param.RadXRayAccountParam;
import com.fjzxdz.ams.module.rad.service.RadXRayAccountService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 射线装置台账Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radXRayAccount")
@Secured({ "ROLE_USER" })
public class RadXRayAccountController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RadXRayAccountService radXRayAccountService;
	@Autowired
	private RadXRayAccountDao radXRayAccountDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rad/radXRayAccountList";
	}
	
	/**
	 * 更新或新增
	 * @param radXRayAccount
	 * @return
	 */	
/*	@RequestMapping("/saveRadXRayAccount")
	@ResponseBody
	public R saveRadXRayAccount(RadXRayAccount radXRayAccount) {
		try {
			radXRayAccountService.save(radXRayAccount);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
/*	@RequestMapping("/deleteRadXRayAccount")
	@ResponseBody
	public R deleteRadXRayAccount(@RequestParam(value = "uuid") String uuid) {
		try {
			radXRayAccountService.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}*/
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/getRadXRayAccount")
	@ResponseBody
	public Map<String, Object> getRadXRayAccount(String uuid) {
		RadXRayAccount radXRayAccount = simpleDao.findUnique("from RadXRayAccount where PKID=?",uuid);
		return BeanUtil.beanToMap(radXRayAccount,false,true);
	}
	
	/**
	 * 查询列表
	 * @param radXRayAccountParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/radXRayAccountList")
	@ResponseBody
	public PageEU<RadXRayAccount> radXRayAccountList(RadXRayAccountParam radXRayAccountParam, HttpServletRequest request) {
		Page<RadXRayAccount> page = radXRayAccountService.listByPage(radXRayAccountParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 查询列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getRadXRayAccountDataListForMap")
	@ResponseBody
	public JSONObject getRadXRayAccountDataListForMap(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		JSONArray labelArray = new JSONArray();
		JSONArray dataArray = new JSONArray();
		
		String ENTERID = "";
		Timestamp startTime = Utils.getTimestampZero();
		Timestamp endTime = Utils.getTimestamp();
		//获取查询参数
		try {
			if(StringUtils.isNotEmpty((String)request.getParameter("ENTERID"))) {
				ENTERID = (String) request.getParameter("ENTERID");
			}
			if(StringUtils.isNotEmpty((String)request.getParameter("startTime"))) {
				startTime = Utils.getTimestamp(request.getParameter("startTime"));
			}
			if(StringUtils.isNotEmpty((String)request.getParameter("endTime"))) {
				endTime = Utils.getTimestamp(request.getParameter("endTime"));
			}
			
			JSONArray radXRayAccountArray = radXRayAccountService.getRadXRayAccountDataListForMap(ENTERID,startTime,endTime);
			
			JSONArray dyArray = new JSONArray();
			JSONArray dlArray = new JSONArray();
			JSONArray glArray = new JSONArray();
			for (Object obj : radXRayAccountArray) {
				JSONObject jsonObj = new JSONObject(obj);
				
				labelArray.add(jsonObj.get("UPDATETIME_RJWA"));
				dyArray.add(jsonObj.get("DY"));
				dlArray.add(jsonObj.get("DL"));
				glArray.add(jsonObj.get("GL"));
			}
			String dyJSONStr = String.format("{name:%s, type:'line', stack: %s, data: %s}", "电压","电压",dyArray.toString());
			String dlJSONStr = String.format("{name:%s, type:'line', stack: %s, data: %s}", "电流","电流",dlArray.toString());
			String glJSONStr = String.format("{name:%s, type:'line', stack: %s, data: %s}", "功率","功率",glArray.toString());
			
			dataArray.add(JSONUtil.parseObj(dyJSONStr));
			dataArray.add(JSONUtil.parseObj(dlJSONStr));
			dataArray.add(JSONUtil.parseObj(glJSONStr));
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("labelArray", labelArray);
		result.put("dataArray", dataArray);
		
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RadXRayAccountParam param, HttpServletResponse response){
		List<RadXRayAccount> lists = radXRayAccountDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RadXRayAccount radXRayAccount : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entername", radXRayAccount.getRadEnterpriseInfo().getENTERNAME());
			map.put("zzmc",radXRayAccount.getZZMC());
			map.put("zzlx", radXRayAccount.getZZLX());
			map.put("yt",radXRayAccount.getYT());
			map.put("ly", radXRayAccount.getLY());
			map.put("cs",radXRayAccount.getCS());
			map.put("ggxh",radXRayAccount.getGGXH());
			map.put("shr", radXRayAccount.getSHR());
			map.put("sflstz",radXRayAccount.getSFLSTZ());
			map.put("updatetimeRjwa", radXRayAccount.getUpdatetimeRjwa());
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
		columnMap.put("title", "射线装置台账数据表");

		columnMap.put("entername", "辐射企业");
		columnMap.put("zzmc", "装置名称");
		columnMap.put("zzlx", "装置类型");
		columnMap.put("yt", "用途");
		columnMap.put("ly", "来源");
		columnMap.put("cs", "场所");
		columnMap.put("ggxh", "规格型号");
		columnMap.put("shr", "审核人");
		columnMap.put("sflstz", "是否历史台帐");
		columnMap.put("updatetimeRjwa", "更新时间");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
