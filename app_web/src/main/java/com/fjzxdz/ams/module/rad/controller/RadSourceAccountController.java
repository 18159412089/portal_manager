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
import com.fjzxdz.ams.module.rad.dao.RadSourceAccountDao;
import com.fjzxdz.ams.module.rad.entity.RadSourceAccount;
import com.fjzxdz.ams.module.rad.param.RadSourceAccountParam;
import com.fjzxdz.ams.module.rad.service.RadSourceAccountService;
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
 * 放射源台账Controller
 * @author lilongan
 * @version 2019-02-19
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/rad/radSourceAccount")
@Secured({ "ROLE_USER" })
public class RadSourceAccountController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RadSourceAccountService radSourceAccountService;
	@Autowired
	private RadSourceAccountDao radSourceAccountDao;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "rad/radSourceAccountList";
	}
	
	/**
	 * 更新或新增
	 * @param radSourceAccount
	 * @return
	 */	
/*	@RequestMapping("/saveRadSourceAccount")
	@ResponseBody
	public R saveRadSourceAccount(RadSourceAccount radSourceAccount) {
		try {
			radSourceAccountService.save(radSourceAccount);
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
/*	@RequestMapping("/deleteRadSourceAccount")
	@ResponseBody
	public R deleteRadSourceAccount(@RequestParam(value = "uuid") String uuid) {
		try {
			radSourceAccountService.delete(uuid);
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
	@RequestMapping("/getRadSourceAccount")
	@ResponseBody
	public Map<String, Object> getRadSourceAccount(@RequestParam(value = "uuid") String uuid) {
		RadSourceAccount radSourceAccount = simpleDao.findUnique("from RadSourceAccount where PKID=?",uuid);
		return BeanUtil.beanToMap(radSourceAccount,false,true);
	}
	
	/**
	 * 查询列表
	 * @param radSourceAccountParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/radSourceAccountList")
	@ResponseBody
	public PageEU<RadSourceAccount> radSourceAccountList(RadSourceAccountParam radSourceAccountParam, HttpServletRequest request) {
		Page<RadSourceAccount> page = radSourceAccountService.listByPage(radSourceAccountParam, pageQuery(request));
		return new PageEU<>(page);
	}
	
	/**
	 * 查询列表
	 * @param request
	 * @return
	 */
	@RequestMapping("/getRadSourceAccountDataListForMap")
	@ResponseBody
	public JSONObject getRadSourceAccountDataListForMap(HttpServletRequest request) {
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
			
			JSONArray radSourceAccountArray = radSourceAccountService.getRadSourceAccountDataListForMap(ENTERID,startTime,endTime);
			JSONArray cchdArray = new JSONArray();
			for (Object obj : radSourceAccountArray) {
				JSONObject jsonObj = new JSONObject(obj);
				
				labelArray.add(jsonObj.get("UPDATETIME_RJWA"));
				cchdArray.add(jsonObj.get("CCHD"));
			}
			String cchdJSONStr = String.format("{name:%s, type:'line', stack: %s, data: %s}", "出厂活度","出厂活度",cchdArray.toString());
			dataArray.add(JSONUtil.parseObj(cchdJSONStr));
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("labelArray", labelArray);
		result.put("dataArray", dataArray);
		
		return result;
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RadSourceAccountParam param, HttpServletResponse response){
		List<RadSourceAccount> lists = radSourceAccountDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RadSourceAccount radSourceAccount : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entername", radSourceAccount.getRadEnterpriseInfo().getENTERNAME());
			map.put("bh", radSourceAccount.getBH());
			map.put("hsmc",radSourceAccount.getHSMC());
			map.put("fsybm", radSourceAccount.getFSYBM());
			map.put("fsylb",radSourceAccount.getFSYLB());
			map.put("fsyyt",radSourceAccount.getFSYYT());
			map.put("ly", radSourceAccount.getLY());
			map.put("cs", radSourceAccount.getCS());
			map.put("cchd", radSourceAccount.getCCHD());
			map.put("sflstz",radSourceAccount.getSFLSTZ());
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
		columnMap.put("title", "放射源台账数据表");

		columnMap.put("entername", "辐射企业");
		columnMap.put("bh", "标号");
		columnMap.put("hsmc", "核素名称");
		columnMap.put("fsybm", "放射源编码");
		columnMap.put("fsylb", "放射源类别");
		columnMap.put("fsyyt", "放射源用途");
		columnMap.put("ly", "来源");
		columnMap.put("cs", "场所");
		columnMap.put("cchd", "出厂活度");
		columnMap.put("sflstz", "是否历史台帐");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
