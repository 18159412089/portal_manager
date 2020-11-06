package com.fjzxdz.ams.module.enviromonit.controller;

import cn.fjzxdz.frame.constant.TestData;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.utils.CommonUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enums.EnumCounty;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/env/mainPage")
public class MainPageController extends BaseController {

	@RequestMapping("/main.do")
	public ModelAndView water(@RequestParam(value = "type", required = false) String type, String pointCode, String category,
						String startTime, String endTime, String menu, String dataShowSkip, ModelAndView model, String pid) {
		if (StringUtils.isNotEmpty(type)) {
			model.addObject("titleName", getTitleName(type));
			model.addObject("type", type);
			model.addObject("pointCode", pointCode);
			model.addObject("category", category);
			model.addObject("startTime", startTime);
			model.addObject("endTime", endTime);
		} else {
			model.addObject("type", null);
		}
		if(StringUtils.isNotEmpty(dataShowSkip)){//从大屏展示的实时动态数据中点击跳转
			model.addObject("dataShowSkip", dataShowSkip);
		}
		model.addObject("menu",menu);
		model.addObject("pid", pid);
		model.setViewName("/moudles/enviromonit/main");
		return model;
	}

	@RequestMapping("/main2.do")
	public ModelAndView air(@RequestParam(value = "type", required = false) String type,
			String category, String menu, ModelAndView model,String pid) {
		if (StringUtils.isNotEmpty(type)) {
			model.addObject("titleName", getTitleName(type));
			model.addObject("category", category);
			model.addObject("type", type);
		} else {
			model.addObject("type", null);
		}
		model.addObject("menu",menu);
		model.addObject("pid", pid);
		model.setViewName("/moudles/enviromonit/main");
		return model;
	}

	@RequestMapping("/testData.do")
	@ResponseBody
	public String testData(HttpServletRequest request) {
		String typeStr = request.getParameter("type");
		String testData = "";
		switch (typeStr) {
		case "AQI":
			testData = TestData.AQI;
			break;
		case "waterData":
			testData = TestData.waterData;
			break;
		case "HYD":
			testData = TestData.HYD;
			break;
		case "VI":
			testData = TestData.VI;
			break;
		case "HAZ":
			testData = TestData.HAZ;
			break;
		case "AREA":
			testData = TestData.AREA;
			break;
		case "pollutantSource":
			testData = TestData.pollutantSource;
			break;
		case "envResource":
			testData = TestData.envResource;
			break;
		case "envDic":
			testData = TestData.envDic;
			break;
		case "envCommonCode":
			testData = TestData.envCommonCode;
			break;
		case "dataMonitor":
			testData = TestData.dataMonitor;
			break;
		case "addRiverData":
			if(CommonUtil.getCustommerUserDetail(request).getUsername().equals("zz")) {
				testData = TestData.townUser;
			}else {
				String[] username = CommonUtil.getCustommerUserDetailName(request);
			    if(username!=null&&(EnumCounty.getEnumByKey(username[0])!=null||EnumCounty.getEnumByKey(username[1])!=null)) ;
				testData = TestData.updateRiverData;
			}
			break;
		case "BASEINFO":
            testData = TestData.BASE;
            break;
		case "newDataServiceData":
            testData = TestData.newDataServiceData;
            break;
		case "newAirDataService":
            testData = TestData.newAirDataService;
            break;
		case "newWaterDataService":
            testData = TestData.newWaterDataService;
            break;
		default:
			break;
		}
		JSONArray tableData = JSONArray.parseArray(testData);
		return tableData.toString();
	}

	public String getTitleName(String type) {
		String typeStr = type;
		String titleName = "";
		switch (typeStr) {
		case "newAirDataService":
            titleName = "大气环境数据服务";
            break;
		case "newWaterDataService":
            titleName = "水环境数据服务";
            break;
		case "AQI":
			titleName = "空气环境质量";
			break;
		case "waterData":
			titleName = "水环境质量";
			break;
		case "HYD":
			titleName = "水电站";
			break;
		case "VI":
			titleName = "信访投诉";
			break;
		case "HAZ":
			titleName = "固危废管理";
			break;
		case "AREA":
			titleName = "近岸海域";
			break;
		case "pollutantSource":
			titleName = "污染源专题";
			break;
		case "BASEINFO":
			titleName = "基础信息管理";
			break;
		default:
			break;
		}

		return titleName;
	}

}
