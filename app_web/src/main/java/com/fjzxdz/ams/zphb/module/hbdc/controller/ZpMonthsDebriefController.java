package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.util.CountUtil;
import com.fjzxdz.ams.util.MapUtil;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpMonthsDebriefService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.*;

@Controller
@RequestMapping("/zphb/environment/debrief")
@Secured({ "ROLE_USER" })
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class ZpMonthsDebriefController extends BaseController {

	@Autowired
	private ZpMonthsDebriefService debriefService;

	@RequestMapping("")
	public String index() {
		return "/moudles/debriefing/environmentDebriefingList";
	}
	
	@RequestMapping("/airIndex")
	public ModelAndView index(String pid, ModelAndView modelAndView) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/enviromonit/air/airIndex");
		return modelAndView;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/getSixFactoryQualityZB")
	@ResponseBody
	public List<Map<String, Object>> getSixFactoryQualityZB(String startTime, String endTime, String export, HttpServletRequest request, HttpServletResponse response){
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String start2 = CountUtil.getStartDate(startTime,1);
		String end2 = CountUtil.getEndDate(endTime,1);
		Map<String, Object> map = debriefService.getSixFactoryQualityRate(start, end, start2, end2);
		List<Map<String, Object>> list = new ArrayList<>();
		if(ToolUtil.isNotEmpty(map)) {
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);
			Map<String, Map<String, Object>> map_f = (Map<String, Map<String, Object>>) map.get(start);
			Map<String, Object> map_aqi = map_f.get("AQI");
			list.add(0,map_f.get("二级标准限值"));
			list.add(1,map_f.get(fyear));
			list.add(2,map_f.get("AQI"));
			Map<String, Object> map_zb = new HashMap<>();
			Object total = map_aqi.get("total");
			map_zb.put("CO", CountUtil.getZB(map_aqi.get("CO"),total, "#0.0"));
			map_zb.put("O3", CountUtil.getZB(map_aqi.get("O3"),total, "#0.0"));
			map_zb.put("SO2", CountUtil.getZB(map_aqi.get("SO2"), total, "#0.0"));
			map_zb.put("NO2", CountUtil.getZB(map_aqi.get("NO2"), total, "#0.0"));
			map_zb.put("PM10", CountUtil.getZB(map_aqi.get("PM10"), total, "#0.0"));
			map_zb.put("PM25", CountUtil.getZB( map_aqi.get("PM25"), total,"#0.0"));
			map_zb.put("name", "占比%");
			list.add(map_zb);
			if("yes".equals(request.getParameter("export"))) {
				
				//定义Excel 字段名称
				LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
				String string = "至0";
				String title = startTime + string + endTime.substring(5, 6) +"我市六项指标单项质量指数占比情况";
				columnMap.put("title", title);
				columnMap.put("name", "");
				columnMap.put("SO2", "SO2");
				columnMap.put("NO2", "NO2");
				columnMap.put("PM10", "PM10");
				columnMap.put("PM25", "PM2.5");
				columnMap.put("O3", "O3(90%)");
				columnMap.put("CO", "CO(95%)");
				columnMap.put("total", "空气质量综合指数");
				ExcelExportUtil.exportExcel(response, columnMap, list);
				return null;
			}
			return list;
		}
		return new ArrayList<>();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getSixFactoryQualityZBRemark")
	@ResponseBody
	public Map<String, Object> getSixFactoryQualityZBRemark(String startTime,String endTime){
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String start2 = CountUtil.getStartDate(startTime,1);
		String end2 = CountUtil.getEndDate(endTime,1);
		Map<String, Object> map = debriefService.getSixFactoryQualityRate(start, end, start2, end2);
		List<String> list = new ArrayList<>();
		if(ToolUtil.isNotEmpty(map)) {
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);
			Map<String, Map<String, Object>> map_f = (Map<String, Map<String, Object>>) map.get(start);
			Map<String, Object> map_aqi = map_f.get("AQI");
			Map<String, Double> map_zb = new HashMap<>();
			Object total = map_aqi.get("total");
			map_zb.put("CO", CountUtil.getValue(map_aqi.get("CO"), total));
			map_zb.put("O3", CountUtil.getValue(map_aqi.get("O3"), total));
			map_zb.put("SO2", CountUtil.getValue(map_aqi.get("SO2"), total));
			map_zb.put("NO2", CountUtil.getValue(map_aqi.get("NO2"), total));
			map_zb.put("PM10", CountUtil.getValue(map_aqi.get("PM10"), total));
			map_zb.put("PM25", CountUtil.getValue( map_aqi.get("PM25"), total));
			map_zb = MapUtil.sortByValueDescending(map_zb);
			double temp = 0;
			int i = 0;
			for(Map.Entry<String, Double> entry : map_zb.entrySet()) {
				if(i==2) {
					break;
				}
				i++;
				temp += entry.getValue();
				list.add(entry.getKey());
			}
			Map<String, Object> result = new HashMap<>();
			DecimalFormat df = new DecimalFormat("0.0");
			result.put("value", df.format(temp)+"%");
			result.put("one", list.get(0));
			result.put("two", list.get(1));
			return result;
		}
		return new HashMap<>();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getSixFactoryQualityTB")
	@ResponseBody
	public List<Map<String, Object>> getSixFactoryQualityTB(String startTime,String endTime, String export, HttpServletRequest request, HttpServletResponse response){
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String start2 = CountUtil.getStartDate(startTime,1);
		String end2 = CountUtil.getEndDate(endTime,1);
		Map<String, Object> map = debriefService.getSixFactoryQualityRate(start, end, start2, end2);
		List<Map<String, Object>> list = new ArrayList<>();
		if(ToolUtil.isNotEmpty(map)) {
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);
			Map<String, Map<String, Object>> map_f = (Map<String, Map<String, Object>>) map.get(start);
			Map<String, Map<String, Object>> map_s = (Map<String, Map<String, Object>>) map.get(start2);

			map_f.get(fyear).put("total", map_f.get("AQI").get("total"));
			map_s.get(syear).put("total", map_s.get("AQI").get("total"));
			list.add(0,map_f.get("二级标准限值"));
			list.add(1,map_f.get(fyear));
			list.add(2,map_s.get(syear));
			
			Map<String, Object> map_tb = new HashMap<>();
			map_tb.put("CO", CountUtil.getTB(map_f.get(fyear).get("CO"),map_s.get(syear).get("CO"), "#0.0"));
			map_tb.put("O3", CountUtil.getTB(map_f.get(fyear).get("O3"),map_s.get(syear).get("O3"), "#0.0"));
			map_tb.put("SO2", CountUtil.getTB(map_f.get(fyear).get("SO2"),map_s.get(syear).get("SO2"), "#0.0"));
			map_tb.put("NO2", CountUtil.getTB(map_f.get(fyear).get("NO2"),map_s.get(syear).get("NO2"), "#0.0"));
			map_tb.put("PM10", CountUtil.getTB(map_f.get(fyear).get("PM10"),map_s.get(syear).get("PM10"), "#0.0"));
			map_tb.put("PM25", CountUtil.getTB(map_f.get(fyear).get("PM25"),map_s.get(syear).get("PM25"), "#0.0"));
			map_tb.put("total", CountUtil.getTB(map_f.get(fyear).get("total"),map_s.get(syear).get("total"), "#0.0"));
			map_tb.put("name", "同比%");
			list.add(map_tb);
			if("yes".equals(request.getParameter("export"))) {
				
				//定义Excel 字段名称
				LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
				String string = "至0";
				String title = startTime + string + endTime.substring(5, 6) +"我市六项指标同比变化情况";
				columnMap.put("title", title);
				columnMap.put("name", "");
				columnMap.put("SO2", "SO2");
				columnMap.put("NO2", "NO2");
				columnMap.put("PM10", "PM10");
				columnMap.put("PM25", "PM2.5");
				columnMap.put("O3", "O3(90%)");
				columnMap.put("CO", "CO(95%)");
				columnMap.put("total", "空气质量综合指数");
				ExcelExportUtil.exportExcel(response, columnMap, list);
				return null;
			} else {
				list.add(map_f.get("color"));
			}
			return list;
		}
		return new ArrayList<>();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getSixFactoryQualityTBRemark")
	@ResponseBody
	public Map<String, Object> getSixFactoryQualityTBRemark(String startTime,String endTime){
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String start2 = CountUtil.getStartDate(startTime,1);
		String end2 = CountUtil.getEndDate(endTime,1);
		Map<String, Object> map = debriefService.getSixFactoryQualityRate(start, end, start2, end2);
		List<Map<String, Object>> list = new ArrayList<>();
		if(ToolUtil.isNotEmpty(map)) {
			String fyear=start.substring(0, 4);
			String syear=start2.substring(0, 4);
			Map<String, Map<String, Object>> map_f = (Map<String, Map<String, Object>>) map.get(start);
			Map<String, Map<String, Object>> map_s = (Map<String, Map<String, Object>>) map.get(start2);

			map_f.get(fyear).put("total", map_f.get("AQI").get("total"));
			map_s.get(syear).put("total", map_s.get("AQI").get("total"));
			list.add(0,map_f.get("二级标准限值"));
			list.add(1,map_f.get(fyear));
			list.add(2,map_s.get(syear));
			
			Map<String, Object> map_tb = new HashMap<>();
			map_tb.put("CO", CountUtil.getTB(map_f.get(fyear).get("CO"),map_s.get(syear).get("CO"), "#0.0"));
			map_tb.put("O3", CountUtil.getTB(map_f.get(fyear).get("O3"),map_s.get(syear).get("O3"), "#0.0"));
			map_tb.put("SO2", CountUtil.getTB(map_f.get(fyear).get("SO2"),map_s.get(syear).get("SO2"), "#0.0"));
			map_tb.put("NO2", CountUtil.getTB(map_f.get(fyear).get("NO2"),map_s.get(syear).get("NO2"), "#0.0"));
			map_tb.put("PM10", CountUtil.getTB(map_f.get(fyear).get("PM10"),map_s.get(syear).get("PM10"), "#0.0"));
			map_tb.put("PM25", CountUtil.getTB(map_f.get(fyear).get("PM25"),map_s.get(syear).get("PM25"), "#0.0"));
			map_tb.put("total", CountUtil.getTB(map_f.get(fyear).get("total"),map_s.get(syear).get("total"), "#0.0"));
			map_tb.put("name", "同比%");
			list.add(map_tb);
			
			Map<String, Object> result = new HashMap<>();
			result.put("aqi", map_f.get("AQI").get("total"));
			Double temp = 100 - CountUtil.getValue(map_f.get(fyear).get("total"),map_s.get(syear).get("total"));
			DecimalFormat df = new DecimalFormat("0.0");
			if(temp>0) {
				result.put("value", "下降"+df.format(temp)+"%");
			}else {
				result.put("value", "上升"+df.format(temp)+"%");
			}
			StringBuffer str = new StringBuffer();
			String[] factory = {"CO", "O3", "SO2", "NO2", "PM10", "PM25"};
			for(int i=0;i<factory.length;i++) {
				if(Double.parseDouble(map_f.get("二级标准限值").get(factory[i]).toString()) < 
					Double.parseDouble(map_f.get(fyear).get(factory[i]).toString())) {
					if(str.length()==0) {
						str.append(factory[i]);
					}else {
						str.append("、"+factory[i]);
					}
				}
			}
			result.put("factory", str);
			return result;
		}
		return new HashMap<>();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/getCompareCounty")
	@ResponseBody
	public List<Map<String, Object>> getCompareCounty(String startTime,String endTime, String export, HttpServletRequest request, HttpServletResponse response){
		String start = CountUtil.getStartDate(startTime,0);
		String end = CountUtil.getEndDate(endTime,0);
		String start2 = CountUtil.getStartDate(startTime,1);
		String end2 = CountUtil.getEndDate(endTime,1);
		Map<String, Object> map = debriefService.getCompareCounty(start,end,start2,end2);
		List<Map<String, Object>> list = new ArrayList<>();
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			Map<String, Object> temp = (Map<String, Object>) entry.getValue();
				list.add(temp);
		}
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			Map<String, Object> temp = (Map<String, Object>) entry.getValue();
			if("均值".equals(entry.getKey())) {
				temp.put("totalINDEX", "-");
				temp.put("SO2INDEX", "-");
				temp.put("NO2INDEX", "-");
				temp.put("PM10INDEX", "-");
				temp.put("PM25INDEX", "-");
				temp.put("COINDEX", "-");
				temp.put("O3INDEX", "-");
				list.set(0, temp);
			}else {
				int index = (int) temp.get("totalINDEX");
				list.set(index, temp);
			}
		}
		if("yes".equals(request.getParameter("export"))) {
			//定义Excel 字段名称
			LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
			String string = "至0";
			String title = startTime + string + endTime.substring(5, 6) +"漳州市11个县市区同期对比（综合指数）";
			columnMap.put("title", title);
			columnMap.put("name", "县/区");
			columnMap.put("totalIAQI", "综合指数");
			columnMap.put("totalTB", "同比");
			columnMap.put("totalINDEX", "综合指数排名");
			columnMap.put("SO2C", "SO2浓度");
			columnMap.put("SO2TB", "SO2同比");
			columnMap.put("SO2INDEX", "SO2排名");
			columnMap.put("NO2C", "NO2浓度");
			columnMap.put("NO2TB", "NO2同比");
			columnMap.put("NO2INDEX", "NO2排名");
			columnMap.put("PM10C", "PM10浓度");
			columnMap.put("PM10TB", "PM10同比");
			columnMap.put("PM10INDEX", "PM10排名");
			columnMap.put("PM25C", "PM2.5浓度");
			columnMap.put("PM25TB", "PM2.5同比");
			columnMap.put("PM25INDEX", "PM2.5排名");
			columnMap.put("COC", "CO浓度");
			columnMap.put("COTB", "CO同比");
			columnMap.put("COINDEX", "CO排名");
			columnMap.put("O3C", "O3浓度");
			columnMap.put("O3TB", "O3同比");
			columnMap.put("O3INDEX", "O3排名");
			ExcelExportUtil.exportExcel(response, columnMap, list);
			return null;
		}
		return list;
	}
	
}
