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

import com.fjzxdz.ams.module.enviromonit.water.param.WtWeekDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtWeekDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 
 * 在线水周数据
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午5:34:04
 */
@Controller
@RequestMapping("/enviromonit/water/wtWeekData")
@Secured({ "ROLE_USER" })
public class WtWeekDataController extends BaseController {

	@Autowired
	private WtWeekDataService wtWeekDataService;

	@RequestMapping("/index")
	public String index() {
		return "/moudles/enviromonit/water/wtWeekDataList";
	}

	@RequestMapping("/wtWeekDataAnalysis")
	public String wtHourDataAnalysis() {
		return "/moudles/enviromonit/water/wtWeekDataAnalysis";
	}
	
	/**
	 * 
	 * @Title:  getPageList
	 * @Description:    在线周监测数据列表  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午5:01:36
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午5:01:36    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<Map<String, Object>> getPageList(WtWeekDataParam param, HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtHourDataPage = wtWeekDataService.getPageList(param, page);
		return new PageEU<>(wtHourDataPage);
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
		WtWeekDataParam param=new WtWeekDataParam();
		String pointName=request.getParameter("pointName");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		param.setPointName(pointName);
		param.setStartTime(startTime);
		param.setEndTime(endTime);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtHourDataPage = wtWeekDataService.getPageList(param, page);
		List<Map<String, Object>> result = wtHourDataPage.getResult();
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "水环境周监测数据");
		columnMap.put("yearNumber", "年");
		columnMap.put("weekNumber", "周");
		columnMap.put("pointName", "监测站点");
		columnMap.put("w01010" ,"水温");
		columnMap.put("w01001" ,"PH值");
		columnMap.put("w01009" ,"溶解氧");
		columnMap.put("w01014" ,"电导率");
		columnMap.put("w01003" ,"浑浊度");
		columnMap.put("w01019" ,"高锰酸盐指数");
		columnMap.put("w21003" ,"氨氮（NH3-N）");
		columnMap.put("w21011" ,"总磷（以P计）");
		columnMap.put("w21001" ,"总氮（以氮计）");
		columnMap.put("targetQuality" ,"目标水质");
		columnMap.put("resultQuality" ,"测试水质");
		columnMap.put("polluteNames" ,"超标污染物");
		ExcelExportUtil.exportExcel(response, columnMap, result);
		return null;
	}
	
	/**
	 * 
	 * @Title:  getPointsDateByWeek
	 * @Description:    在线周监测数据分析    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午5:01:54
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午5:01:54    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointsDateByWeek")
	@ResponseBody
	public List<Map<String, Object>> getPointsDateByWeek(WtWeekDataParam param) throws ParseException{
		List<Map<String, Object>> result = wtWeekDataService.getPointsDateByWeek(param);
		return result;
	}
	
	/**
	 * 
	 * @Title:  getPassYearAnalysis
	 * @Description:   在线水污染站点往年同比数据分析  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午5:04:05
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午5:04:05    
	 * @param param
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassYearAnalysis")
	@ResponseBody
	public Map<String, Object> getPassYearAnalysis(WtWeekDataParam param) throws ParseException{
		
		return wtWeekDataService.getPassYearAnalysis(param);
	}
}
