/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enter.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.CellParam;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.common.utils.ExcelImport;
import com.fjzxdz.ams.module.enter.dao.PollutionEnterpriseInfoDao;
import com.fjzxdz.ams.module.enter.entity.PollutionEnterpriseInfo;
import com.fjzxdz.ams.module.enter.param.PollutionEnterpriseInfoParam;
import com.fjzxdz.ams.module.enter.service.PollutionEnterpriseInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 污染源档案企业信息Controller
 * @author lilongan
 * @version 2019-02-26
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/enter/pollutionEnterpriseInfo")
public class PollutionEnterpriseInfoController extends BaseController {
	@Autowired
	private PollutionEnterpriseInfoDao pollutionEnterpriseInfoDao;
	@Autowired
	private PollutionEnterpriseInfoService pollutionEnterpriseInfoService;
	@Autowired
	private SimpleDao simpleDao;
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView index(String pid, ModelAndView modelAndView) {
		modelAndView.addObject("pid",pid);
		modelAndView.setViewName("/moudles/enter/pollutionEnterpriseInfoList");
		return modelAndView;
	}

	/**
	 * 跳转页面(数据整合工具导入和上面页面是相同的)
	 * @return
	 */
	@RequestMapping("index")
	public String index1() {
		return "/moudles/enter/pollutionEnterpriseInfoList1";
	}
	
	/**
	 * 更新或新增
	 * @param pollutionEnterpriseInfo
	 * @return
	 */	
/*	@RequestMapping("/savePollutionEnterpriseInfo")
	@ResponseBody
	public R savePollutionEnterpriseInfo(PollutionEnterpriseInfo pollutionEnterpriseInfo) {
		try {
			pollutionEnterpriseInfoService.save(pollutionEnterpriseInfo);
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
/*	@RequestMapping("/deletePollutionEnterpriseInfo")
	@ResponseBody
	public R deletePollutionEnterpriseInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			pollutionEnterpriseInfoService.delete(uuid);
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
	@RequestMapping("/getPollutionEnterpriseInfo")
	@ResponseBody
	public Map<String, Object> getPollutionEnterpriseInfo(String uuid) {
		PollutionEnterpriseInfo pollutionEnterpriseInfo = simpleDao.findUnique("from PollutionEnterpriseInfo where STANDENTERID=?",uuid);
		return BeanUtil.beanToMap(pollutionEnterpriseInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param pollutionEnterpriseInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/pollutionEnterpriseInfoList")
	@ResponseBody
	public PageEU<PollutionEnterpriseInfo> pollutionEnterpriseInfoList(PollutionEnterpriseInfoParam pollutionEnterpriseInfoParam, HttpServletRequest request) {
		Page<PollutionEnterpriseInfo> page = pollutionEnterpriseInfoService.listByPage(pollutionEnterpriseInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}


	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(PollutionEnterpriseInfoParam param, HttpServletResponse response){
		List<PollutionEnterpriseInfo> lists=pollutionEnterpriseInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (PollutionEnterpriseInfo pollutionEnterpriseInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entercode", pollutionEnterpriseInfo.getEntercode());
			map.put("entername", pollutionEnterpriseInfo.getEntername());
			map.put("companyname", pollutionEnterpriseInfo.getCompanyname());
			map.put("codeEntertype", pollutionEnterpriseInfo.getCodeEntertype());
			map.put("codeRegistertype", pollutionEnterpriseInfo.getCodeRegistertype());
			map.put("trade", pollutionEnterpriseInfo.getTrade());
			map.put("codeTrade", pollutionEnterpriseInfo.getCodeTrade());
			map.put("enteraddress", pollutionEnterpriseInfo.getEnteraddress());
			map.put("wsystem", pollutionEnterpriseInfo.getWsystem());
			result.add(map);
		}
		return exportPollutionEnterpriseInfoDataExl(response, result);
	}

	/*
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportPollutionEnterpriseInfoDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "污染源企业信息数据表");
		columnMap.put("entercode", "污染源编码");
		columnMap.put("entername", "标准污染源名称");
		columnMap.put("companyname", "企业名称");
		columnMap.put("codeEntertype", "企业类型");
		columnMap.put("codeRegistertype", "登记注册类型");
		columnMap.put("trade", "所属行业");
		columnMap.put("codeTrade", "行业代码");
		columnMap.put("enteraddress", "企业地址");
		columnMap.put("wsystem", "所属流域");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}

	/*
	 * 导出Excel模板
	 * @param response
	 * @param list
	 * @return
	 */
	@RequestMapping("/getListExportTemplate")
	@ResponseBody
	public void getListExportTemplate(PollutionEnterpriseInfoParam param, HttpServletResponse response){
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "污染源企业信息数据表");
		columnMap.put("entercode", "污染源编码");
		columnMap.put("entername", "标准污染源名称");
		columnMap.put("companyname", "企业名称");
		columnMap.put("codeEntertype", "企业类型");
		columnMap.put("codeRegistertype", "登记注册类型");
		columnMap.put("trade", "所属行业");
		columnMap.put("codeTrade", "行业代码");
		columnMap.put("enteraddress", "企业地址");
		columnMap.put("wsystem", "所属流域");
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("entercode", "");
		tempMap.put("entername", "");
		tempMap.put("companyname", "");
		tempMap.put("codeEntertype", "");
		tempMap.put("codeRegistertype", "");
		tempMap.put("trade", "");
		tempMap.put("codeTrade", "");
		tempMap.put("enteraddress", "");
		tempMap.put("wsystem", "");
		result.add(tempMap);
		ExcelExportUtil.exportExcel(response, columnMap, result);
	}
	/**
	 * 从web导入excel
	 * @param file
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/import")
	public R importByWeb(MultipartFile file) throws Exception {
		try {
			List<CellParam> cellParams = new ArrayList<>();
			cellParams.add(new CellParam("entercode"));
			cellParams.add(new CellParam("entername"));
			cellParams.add(new CellParam("companyname"));
			cellParams.add(new CellParam("codeEntertype"));
			cellParams.add(new CellParam("codeRegistertype"));
			cellParams.add(new CellParam("trade"));
			cellParams.add(new CellParam("codeTrade"));
			cellParams.add(new CellParam("enteraddress"));
			cellParams.add(new CellParam("wsystem"));
			ExcelImport excelImport = new ExcelImport(PollutionEnterpriseInfo.class, cellParams);
			List<PollutionEnterpriseInfo> list = excelImport.importExcel(file.getInputStream());
			for (PollutionEnterpriseInfo bean:list){
				pollutionEnterpriseInfoService.insert(bean);
			}
			return R.ok();
		}catch (Exception e){
			e.printStackTrace();
			return R.error("系统错误");
		}

	}

	@RequestMapping("/getEnterType")
	@ResponseBody
	public JSONArray getEnterType(){
		List<Map> list = simpleDao.getNativeQueryList("select CODE_ENTERTYPE type from POLLUTION_ENTERPRISE_INFO group by CODE_ENTERTYPE");
		if(ToolUtil.isNotEmpty(list)){
			JSONArray result = new JSONArray(list.size());
			for (Map map : list){
				if(ToolUtil.isNotEmpty(map.get("type"))){
					JSONObject temp = new JSONObject(2);
					temp.put("name", map.get("type"));
					temp.put("id", map.get("type"));
					result.add(temp);
				}
			}
			return result;
		}
		return new JSONArray(0);
	}

	@RequestMapping("/getWsystem")
	@ResponseBody
	public JSONArray getWsystem(){
		List<Map> list = simpleDao.getNativeQueryList("select WSYSTEM type from POLLUTION_ENTERPRISE_INFO group by WSYSTEM");
		if(ToolUtil.isNotEmpty(list)){
			JSONArray result = new JSONArray(list.size());
			for (Map map : list){
				if(ToolUtil.isNotEmpty(map.get("type"))){
					JSONObject temp = new JSONObject(2);
					temp.put("name", map.get("type"));
					temp.put("id", map.get("type"));
					result.add(temp);
				}
			}
			return result;
		}
		return new JSONArray(0);
	}

}
