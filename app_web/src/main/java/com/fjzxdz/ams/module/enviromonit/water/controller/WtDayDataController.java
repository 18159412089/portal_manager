package com.fjzxdz.ams.module.enviromonit.water.controller;

import java.text.ParseException;
import java.util.Calendar;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtDayData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtDayDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtDayDataService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.page.PageEU;

/**
 * 
 * 在线水天数据服务
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:32:30
 */
@Controller
@RequestMapping("/enviromonit/water/wtDayData")
@Secured({ "ROLE_USER" })
public class WtDayDataController extends BaseController {

	@Autowired
	private WtDayDataService wtDayDataService;

	/**
	 * 
	 * @Title:  index
	 * @Description:    在线水天数据列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:07:53
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:07:53    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/index")
	public String index() {
		return "/moudles/enviromonit/water/wtDayDataList";
	}
	
	/**
	 * 
	 * @Title:  wtHourDataAnalysis
	 * @Description:     在线水天数据分析
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:08:17
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:08:17    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtDayDataAnalysis")
	public String wtHourDataAnalysis() {
		return "/moudles/enviromonit/water/wtDayDataAnalysis";
	}
	
	/**
	 * 
	 * @Title:  wtPassMonthAnalysis
	 * @Description:     在线水往月环比
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:08:41
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:08:41    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtPassMonthAnalysis")
	public String wtPassMonthAnalysis() {
		return "/moudles/enviromonit/water/wtPassMonthAnalysis";
	}

	/**
	 * 
	 * @Title:  wtPassYearAnalysis
	 * @Description:     在线水往年同比
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:09:17
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:09:17    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtPassYearAnalysis")
	public String wtPassYearAnalysis() {
		return "/moudles/enviromonit/water/wtPassYearAnalysis";
	}
	
	
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<WtDayData> list(WtDayDataParam param, HttpServletRequest request) {
		Page<WtDayData> page = pageQuery(request);
		Page<WtDayData> wtDayDataPage = wtDayDataService.listByPage(param, page);
		return new PageEU<>(wtDayDataPage);
	}

	/**
	 * 
	 * @Title:  getYearList
	 * @Description:    获取年list  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:10:03
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:10:03    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getYearList")
	@ResponseBody
	public JSONArray getYearList(){
		JSONArray result = new JSONArray();
		Calendar date = Calendar.getInstance();
		int year = Integer.parseInt(String.valueOf(date.get(Calendar.YEAR)));
		for(int i=0;i<6;i++) {
			JSONObject temp = new JSONObject();
			temp.put("id", year-i);
			temp.put("text", year-i);
			if(i==0) {
				temp.put("selected", true);
			}
			result.add(temp);
		}
		return result;
	}
	
	/**
	 * 
	 * @Title:  list
	 * @Description:    在线水天数据列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:09:35
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:09:35    
	 * @param param
	 * @param request
	 * @return  PageEU<WtDayData> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<Map<String, Object>> getPageList(WtDayDataParam param, HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtHourDataPage = wtDayDataService.getPageList(param, page);
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
		WtDayDataParam param=new WtDayDataParam();
		String pointName=request.getParameter("pointName");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		param.setPointName(pointName);
		param.setStartTime(startTime);
		param.setEndTime(endTime);
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtHourDataPage = wtDayDataService.getPageList(param, page);
		List<Map<String, Object>> result = wtHourDataPage.getResult();
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "在线水日监测数据");
		columnMap.put("datatime", "监测时间");
		columnMap.put("pointName", "监测站点");
		columnMap.put("w01010", "溶解氧");
		columnMap.put("w01001", "电导率");
		columnMap.put("w01009", "浑浊度");
		columnMap.put("w01014", "高锰酸盐指数");
		columnMap.put("w01003", "氨氮（NH3-N）");
		columnMap.put("w21011", "总磷（以P计）");
		columnMap.put("w21001", "总氮（以氮计）CO(mg/m3)");
		columnMap.put("targetQuality", "目标水质");
		columnMap.put("resultQuality", "测试水质");
		columnMap.put("polluteNames", "超标污染物");
		ExcelExportUtil.exportExcel(response, columnMap, result);
		return null;
	}
	/**
	 * 
	 * @Title:  getPointsDateByDay
	 * @Description:    获取天数据分析   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:11:01
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:11:01    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointsDateByDay")
	@ResponseBody
	public List<Map<String, Object>> getPointsDateByDay(WtDayDataParam param) throws ParseException{
		List<Map<String, Object>> result = wtDayDataService.getPointsDateByDay(param);
		return result;
	}
	
	/**
	 * 
	 * @Title:  getPassMonthAnalysis
	 * @Description:    往月环比数据分析  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:11:30
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:11:30    
	 * @param param
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassMonthAnalysis")
	@ResponseBody
	public Map<String, Object> getPassMonthAnalysis(WtDayDataParam param) throws ParseException{
		
		return wtDayDataService.getPassMonthAnalysis(param);
	}
	
	/**
	 * 
	 * @Title:  getPassYearAnalysis
	 * @Description:    往年同比数据分析
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午4:11:48
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午4:11:48    
	 * @param param
	 * @return
	 * @throws ParseException  Map<String,Object> 
	 * @throws
	 */
	@RequestMapping("/getPassYearAnalysis")
	@ResponseBody
	public Map<String, Object> getPassYearAnalysis(WtDayDataParam param) throws ParseException{
		
		return wtDayDataService.getPassYearAnalysis(param);
	}
}
