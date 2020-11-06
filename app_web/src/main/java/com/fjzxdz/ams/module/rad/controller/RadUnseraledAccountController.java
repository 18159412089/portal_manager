/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.rad.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.rad.dao.RadUnseraledAccountDao;
import com.fjzxdz.ams.module.rad.entity.RadUnseraledAccount;
import com.fjzxdz.ams.module.rad.param.RadUnseraledAccountParam;
import com.fjzxdz.ams.module.rad.service.RadUnseraledAccountService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 非密封台账Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radUnseraledAccount")
@Secured({ "ROLE_USER" })
public class RadUnseraledAccountController extends BaseController {

	@Autowired
	private RadUnseraledAccountDao radUnseraledAccountDao;
	@Autowired
	private RadUnseraledAccountService radUnseraledAccountService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rad/radUnseraledAccountList";
	}
	
	/**
	 * 更新或新增
	 * @param radUnseraledAccount
	 * @return
	 */	
/*	@RequestMapping("/saveRadUnseraledAccount")
	@ResponseBody
	public R saveRadUnseraledAccount(RadUnseraledAccount radUnseraledAccount) {
		try {
			radUnseraledAccountService.save(radUnseraledAccount);
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
/*	@RequestMapping("/deleteRadUnseraledAccount")
	@ResponseBody
	public R deleteRadUnseraledAccount(@RequestParam(value = "uuid") String uuid) {
		try {
			radUnseraledAccountService.delete(uuid);
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
	@RequestMapping("/getRadUnseraledAccount")
	@ResponseBody
	public Map<String, Object> getRadUnseraledAccount(@RequestParam(value = "uuid") String uuid) {
		RadUnseraledAccount radUnseraledAccount = radUnseraledAccountDao.getById(uuid);
		return BeanUtil.beanToMap(radUnseraledAccount,false,true);
	}
	
	/**
	 * 查询列表
	 * @param radUnseraledAccountParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/radUnseraledAccountList")
	@ResponseBody
	public PageEU<RadUnseraledAccount> radUnseraledAccountList(RadUnseraledAccountParam radUnseraledAccountParam, HttpServletRequest request) {
		Page<RadUnseraledAccount> page = radUnseraledAccountService.listByPage(radUnseraledAccountParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 查询列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getRadUnseraledAccountDataListForMap")
	@ResponseBody
	public JSONObject getRadUnseraledAccountDataListForMap(HttpServletRequest request) {
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
			
			JSONArray radUnseraledAccountArray = radUnseraledAccountService.getRadUnseraledAccountDataListForMap(ENTERID,startTime,endTime);
			JSONArray hdArray = new JSONArray();
			for (Object obj : radUnseraledAccountArray) {
				JSONObject jsonObj = new JSONObject(obj);
				
				labelArray.add(jsonObj.get("UPDATETIME_RJWA"));
				hdArray.add(jsonObj.get("HD"));
			}
			String hdJSONStr = String.format("{name:%s, type:'line', stack: %s, data: %s}", "活度","活度",hdArray.toString());
			dataArray.add(JSONUtil.parseObj(hdJSONStr));
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("labelArray", labelArray);
		result.put("dataArray", dataArray);
		
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RadUnseraledAccountParam param, HttpServletResponse response){
		List<RadUnseraledAccount> lists = radUnseraledAccountDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RadUnseraledAccount radUnseraledAccount : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entername", radUnseraledAccount.getRadEnterpriseInfo().getENTERNAME());
			map.put("hsmc", radUnseraledAccount.getHSMC());
			map.put("pc", radUnseraledAccount.getPC());
			map.put("hd",radUnseraledAccount.getHD());
			map.put("ly", radUnseraledAccount.getLY());
			map.put("yt",radUnseraledAccount.getYT());
			map.put("updatetimeRjwa",radUnseraledAccount.getUpdatetimeRjwa());
			map.put("shr", radUnseraledAccount.getSHR());
			map.put("shrq",radUnseraledAccount.getSHRQ());
			map.put("qx", radUnseraledAccount.getQX());
			map.put("xqshr",radUnseraledAccount.getXQSHR());
			map.put("qxshrq",radUnseraledAccount.getQXSHRQ());
			map.put("bz",radUnseraledAccount.getBZ());
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
		columnMap.put("title", "非密封台账数据表");

		columnMap.put("entername", "辐射企业");
		columnMap.put("hsmc", "核素名称");
		columnMap.put("pc", "频次");
		columnMap.put("hd", "活度");
		columnMap.put("ly", "来源");
		columnMap.put("yt", "用途");
		columnMap.put("updatetimeRjwa", "更新时间");
		columnMap.put("shr", "审核人");
		columnMap.put("shrq", "审核日期");
		columnMap.put("qx", "去向");
		columnMap.put("xqshr", "去向审核人");
		columnMap.put("qxshrq", "去向审核日期");
		columnMap.put("bz", "备注");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
