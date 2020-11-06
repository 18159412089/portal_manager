/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.risk.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.risk.dao.RiskBaseInfoDao;
import com.fjzxdz.ams.module.risk.entity.RiskBaseInfo;
import com.fjzxdz.ams.module.risk.param.RiskBaseInfoParam;
import com.fjzxdz.ams.module.risk.service.RiskBaseInfoService;
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
 * 风险源基本信息Controller
 * @author lilongan
 * @version 2019-02-20
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/risk/riskBaseInfo")
@Secured({ "ROLE_USER" })
public class RiskBaseInfoController extends BaseController {
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private RiskBaseInfoDao riskBaseInfoDao;
	@Autowired
	private RiskBaseInfoService riskBaseInfoService;

	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/moudles/" + "risk/riskBaseInfoList";
	}

	/**
	 * 更新或新增
	 * @param riskBaseInfo
	 * @return
	 */
/*	@RequestMapping("/saveRiskBaseInfo")
	@ResponseBody
	public R saveRiskBaseInfo(RiskBaseInfo riskBaseInfo) {
		try {
			riskBaseInfoService.save(riskBaseInfo);
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
/*	@RequestMapping("/deleteRiskBaseInfo")
	@ResponseBody
	public R deleteRiskBaseInfo(@RequestParam(value = "uuid") String uuid) {
		try {
			riskBaseInfoService.delete(uuid);
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
	@RequestMapping("/getRiskBaseInfo")
	@ResponseBody
	public Map<String, Object> getRiskBaseInfo(String uuid) {
		//RiskBaseInfo riskBaseInfo = riskBaseInfoDao.getById(uuid);
		RiskBaseInfo riskBaseInfo = simpleDao.findUnique("from RiskBaseInfo where GUID=?",uuid);
		return BeanUtil.beanToMap(riskBaseInfo,false,true);
	}

	/**
	 * 查询列表
	 * @param riskBaseInfoParam
	 * @param request
	 * @return
	 */
	@RequestMapping("/riskBaseInfoList")
	@ResponseBody
	public PageEU<RiskBaseInfo> riskBaseInfoList(RiskBaseInfoParam riskBaseInfoParam, HttpServletRequest request) {
		Page<RiskBaseInfo> page = riskBaseInfoService.listByPage(riskBaseInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(RiskBaseInfoParam param, HttpServletResponse response){
		List<RiskBaseInfo> lists = riskBaseInfoDao.selectListByQueryObj(param);
		List<Map<String, Object>> result = new LinkedList<>();
		for (RiskBaseInfo baseInfo : lists) {
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("entername", baseInfo.getENTERNAME());
			map.put("fkTrade",baseInfo.getFkTrade());
			map.put("introduction",baseInfo.getINTRODUCTION());
			map.put("corpname",baseInfo.getCORPNAME());
			map.put("telephone",baseInfo.getTELEPHONE());
			map.put("fkRegion",baseInfo.getFkRegion());
			map.put("fkEntercode",baseInfo.getFkEntercode());
			map.put("enteraddress",baseInfo.getENTERADDRESS());
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
		columnMap.put("title", "风险源基本信息数据表");

		columnMap.put("entername", "单位名称");
		columnMap.put("fkTrade", "行业类别");
		columnMap.put("introduction", "简介");
		columnMap.put("corpname", "法人代表");
		columnMap.put("telephone", "联系电话");
		columnMap.put("fkRegion", "行政区划");
		columnMap.put("fkEntercode", "组织结构代码");
		columnMap.put("enteraddress", "地址");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}

}
