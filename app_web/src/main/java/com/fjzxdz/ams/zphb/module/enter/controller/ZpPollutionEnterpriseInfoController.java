/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.module.enter.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.core.bean.BeanUtil;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 污染源档案企业信息Controller
 * @author gsq
 * @version 2019-09-29
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/enter/pollutionEnterpriseInfo")
public class ZpPollutionEnterpriseInfoController extends BaseController {
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
	public ModelAndView index(ModelAndView modelAndView) {
		modelAndView.setViewName("/zphb/moudles/enter/pollutionEnterpriseInfoList");
		return modelAndView;
	}
	
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
		pollutionEnterpriseInfoParam.setCodeRegion("350623000000");
		Page<PollutionEnterpriseInfo> page = pollutionEnterpriseInfoService.listByPage(pollutionEnterpriseInfoParam, pageQuery(request));
		return new PageEU<>(page);
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(PollutionEnterpriseInfoParam param, HttpServletResponse response){
		param.setCodeRegion("350623000000");
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

}
