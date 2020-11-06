/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.risk.dao.RiskBaseUnitInfoDao;
import com.fjzxdz.ams.module.risk.entity.RiskBaseUnitInfo;
import com.fjzxdz.ams.module.risk.param.RiskBaseUnitInfoParam;
import com.fjzxdz.ams.module.risk.service.RiskBaseUnitInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 风险单元基本信息Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/risk/riskBaseUnitInfo")
@Secured({ "ROLE_USER" })
public class RiskBaseUnitInfoController extends BaseController {

	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RiskBaseUnitInfoDao riskBaseUnitInfoDao;
	@Autowired
	private RiskBaseUnitInfoService riskBaseUnitInfoService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "risk/riskBaseUnitInfoList";
	}
	
	/**
	 * 更新或新增
	 * @param riskBaseUnitInfo
	 * @return
	 */	
/*	@RequestMapping("/saveRiskBaseUnitInfo")
	@ResponseBody
	public R saveRiskBaseUnitInfo(RiskBaseUnitInfo riskBaseUnitInfo) {
		try {
			riskBaseUnitInfoService.save(riskBaseUnitInfo);
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
/*	@RequestMapping("/deleteRiskBaseUnitInfo")
	@ResponseBody
	public R deleteRiskBaseUnitInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			riskBaseUnitInfoService.delete(uuid);
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
	@RequestMapping("/getRiskBaseUnitInfo")
	@ResponseBody
	public Map<String, Object> getRiskBaseUnitInfo(String uuid) {
		//RiskBaseUnitInfo riskBaseUnitInfo = riskBaseUnitInfoDao.getById(uuid);
		RiskBaseUnitInfo riskBaseUnitInfo = simpleDao.findUnique("from RiskBaseUnitInfo where ID=?",uuid);
		return BeanUtil.beanToMap(riskBaseUnitInfo,false,true);
	}
	
	/**
	 * 查询列表
	 * @param riskBaseUnitInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riskBaseUnitInfoList")
	@ResponseBody
	public PageEU<RiskBaseUnitInfo> riskBaseUnitInfoList(RiskBaseUnitInfoParam riskBaseUnitInfoParam, HttpServletRequest request) {
		Page<RiskBaseUnitInfo> page = riskBaseUnitInfoService.listByPage(riskBaseUnitInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiskBaseUnitInfoParam param, HttpServletResponse response){
		List<RiskBaseUnitInfo> lists = riskBaseUnitInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiskBaseUnitInfo unitInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("dischargeportname", unitInfo.getDISCHARGEPORTNAME());
			map.put("riskBaseInfoName", ToolUtil.isEmpty(unitInfo.getRiskBaseInfo())?"":unitInfo.getRiskBaseInfo().getENTERNAME());
			map.put("chemistryname",unitInfo.getCHEMISTRYNAME());
			map.put("riskcharacteristicsother", unitInfo.getRISKCHARACTERISTICSOTHER());
			map.put("emergencydevice", unitInfo.getEMERGENCYDEVICE());
			map.put("fkIsfacilities", unitInfo.getFkIsfacilities());
			map.put("seepagecontrolmeasures", unitInfo.getSEEPAGECONTROLMEASURES());
			map.put("fkIsalarmpool", unitInfo.getFkIsalarmpool());
			map.put("chemistrycontent", unitInfo.getCHEMISTRYCONTENT());
			map.put("riskcharacteristicstemperature", unitInfo.getRISKCHARACTERISTICSTEMPERATURE());
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
		columnMap.put("title", "风险单位基本信息数据表");

		columnMap.put("dischargeportname", "风险单元名称");
		columnMap.put("riskBaseInfoName", "企业名称");
		columnMap.put("chemistryname", "主要化学物质名称");
		columnMap.put("riskcharacteristicsother", "风险特征其他");
		columnMap.put("emergencydevice", "泄漏气体紧急处置装置");
		columnMap.put("fkIsfacilities", "是否有污水排放口监控及关闭设施");
		columnMap.put("seepagecontrolmeasures", "防渗具体措施");
		columnMap.put("fkIsalarmpool", "是否有事故应急池：有，无");
		columnMap.put("chemistrycontent", "主要化学物质年现存量（吨）");
		columnMap.put("riskcharacteristicstemperature", "风险特征反应条件高温高压（吨）");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
	
}
