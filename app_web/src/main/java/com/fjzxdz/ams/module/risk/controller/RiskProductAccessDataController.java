/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.risk.dao.RiskProductAccessDataDao;
import com.fjzxdz.ams.module.risk.entity.RiskProductAccessData;
import com.fjzxdz.ams.module.risk.param.RiskProductAccessDataParam;
import com.fjzxdz.ams.module.risk.service.RiskProductAccessDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 产品及辅料基本信息Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/risk/riskProductAccessData")
@Secured({ "ROLE_USER" })
public class RiskProductAccessDataController extends BaseController {

	@Autowired
	private RiskProductAccessDataDao riskProductAccessDataDao;
	@Autowired
	private RiskProductAccessDataService riskProductAccessDataService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "risk/riskProductAccessDataList";
	}
	
	/**
	 * 更新或新增
	 * @param riskProductAccessData
	 * @return
	 */	
/*	@RequestMapping("/saveRiskProductAccessData")
	@ResponseBody
	public R saveRiskProductAccessData(RiskProductAccessData riskProductAccessData) {
		try {
			riskProductAccessDataService.save(riskProductAccessData);
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
/*	@RequestMapping("/deleteRiskProductAccessData")
	@ResponseBody
	public R deleteRiskProductAccessData(@RequestParam(value = "uuid") String uuid) {
		try {
			riskProductAccessDataService.delete(uuid);
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
	@RequestMapping("/getRiskProductAccessData")
	@ResponseBody
	public Map<String, Object> getRiskProductAccessData(@RequestParam(value = "uuid") String uuid) {
		RiskProductAccessData riskProductAccessData = riskProductAccessDataDao.getById(uuid);
		return BeanUtil.beanToMap(riskProductAccessData,false,true);
	}
	
	/**
	 * 查询列表
	 * @param riskProductAccessDataParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riskProductAccessDataList")
	@ResponseBody
	public PageEU<RiskProductAccessData> riskProductAccessDataList(RiskProductAccessDataParam riskProductAccessDataParam, HttpServletRequest request) {
		Page<RiskProductAccessData> page = riskProductAccessDataService.listByPage(riskProductAccessDataParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiskProductAccessDataParam param, HttpServletResponse response){
		List<RiskProductAccessData> lists = riskProductAccessDataDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiskProductAccessData accessData : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("productsname", accessData.getPRODUCTSNAME());
			map.put("enterName", accessData.getRiskBaseInfo().getENTERNAME());
			map.put("actuallyproduce", accessData.getACTUALLYPRODUCE());
			map.put("designcapacity", accessData.getDESIGNCAPACITY());
			map.put("cas", accessData.getCAS());
			map.put("materialsname", accessData.getMATERIALSNAME());
			map.put("submittedtime", accessData.getSUBMITTEDTIME());
			map.put("fkTransportmode", accessData.getFkTransportmode());
			map.put("updatetime", accessData.getUPDATETIME());
			map.put("consumption", accessData.getCONSUMPTION());
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
		columnMap.put("title", "产品及辅料基本信息数据表");

		columnMap.put("productsname", "产品名称");
		columnMap.put("enterName", "企业名称");
		columnMap.put("actuallyproduce", "实际年生产量（吨）");
		columnMap.put("designcapacity", "设计年产量（吨）");
		columnMap.put("cas", "CAS号");
		columnMap.put("materialsname", "原辅料名称");
		columnMap.put("submittedtime", "申请时间");
		columnMap.put("fkTransportmode", "运输方式");
		columnMap.put("updatetime", "更新时间");
		columnMap.put("consumption", "原辅料年贮存量（吨）");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}
}
