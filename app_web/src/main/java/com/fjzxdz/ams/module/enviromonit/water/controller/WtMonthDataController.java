package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.text.ParseException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.module.enviromonit.water.param.WtMonthDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMonthDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 
 * 数据服务在线水月数据
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午4:58:10
 */
@Controller
@RequestMapping("/enviromonit/water/wtMonthData")
@Secured({ "ROLE_USER" })
public class WtMonthDataController extends BaseController {

	@Autowired
	private WtMonthDataService wtMonthDataService;

	@RequestMapping("/index")
	public String index() {
		return "/moudles/enviromonit/water/wtMonthDataList";
	}

	@RequestMapping("/wtMonthDataAnalysis")
	public String wtMonthDataAnalysis() {
		return "/moudles/enviromonit/water/wtMonthDataAnalysis";
	}
	
	/**
	 * 
	 * @Title:  getPageList
	 * @Description:   在线月监测数据列表  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:58:33
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:58:33    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<Map<String, Object>> getPageList(WtMonthDataParam param, HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtMonthDataPage = wtMonthDataService.getPageList(param, page);
		return new PageEU<>(wtMonthDataPage);
	}

	/*
     * 导出Excel
     * @param response
     * @param list
     * @return
    */
	@RequestMapping("/export")
	@ResponseBody
	public List<Map<String, Object>> export(HttpServletRequest request,HttpServletResponse response){
		WtMonthDataParam param=new WtMonthDataParam();
		String pointName=request.getParameter("pointName");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		param.setPointName(pointName);
		param.setStartTime(startTime);
		param.setEndTime(endTime);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtMonthDataPage = wtMonthDataService.getPageList(param, page);
		List<Map<String, Object>> result = wtMonthDataPage.getResult();
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水环境月监测数据");
		columnMap.put("yearNumber" , "年");
		columnMap.put("monthNumber" , "月");
		columnMap.put("pointName" , "监测站点");
        columnMap.put("w01010" , "水温");
        columnMap.put("w01001" , "PH值");
        columnMap.put("w01009" , "溶解氧");
        columnMap.put("w01014" , "电导率");
        columnMap.put("w01003" , "浑浊度");
        columnMap.put("w01019" , "高锰酸盐指数");
        columnMap.put("w21003" , "氨氮（NH3-N）");
        columnMap.put("w21011" , "总磷（以P计）");
        columnMap.put("w21001" , "总氮（以氮计）");
        columnMap.put("targetQuality" , "目标水质");
        columnMap.put("resultQuality" , "测试水质");
        columnMap.put("polluteNames" , "超标污染物");
		ExcelExportUtil.exportExcel(response, columnMap, result);
		return null;
	}
	
	/**
	 * 
	 * @Title:  getPointsDateByMonth
	 * @Description:   在线月监测数据分析
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:59:26
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:59:26    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointsDateByMonth")
	@ResponseBody
	public List<Map<String, Object>> getPointsDateByMonth(WtMonthDataParam param) throws ParseException{
		List<Map<String, Object>> result = wtMonthDataService.getPointsDateByMonth(param);
		return result;
	}
	
	/**
	 * 
	 * @Title:  getPassYearAnalysis
	 * @Description:    在线水站点污染往年同比数据分析
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:59:57
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:59:57    
	 * @param param
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassYearAnalysis")
	@ResponseBody
	public Map<String, Object> getPassYearAnalysis(WtMonthDataParam param) throws ParseException{
		
		return wtMonthDataService.getPassYearAnalysis(param);
	}
}
