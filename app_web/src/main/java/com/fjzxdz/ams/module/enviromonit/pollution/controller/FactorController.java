package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.Factor;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.Point;
import com.fjzxdz.ams.module.enviromonit.pollution.service.FactorService;
import com.fjzxdz.ams.module.enviromonit.pollution.service.PointService;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Controller
@RequestMapping("/env/pollution/factor")
public class FactorController extends BaseController {

	@Autowired
	private FactorService factorService;
	@Autowired
	private PointService pointService;

	/**
	 * 查看
	 */
	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		Factor factor;
		try {
			factor = factorService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("factor", factor);
	}

	/**
	 * 查询列名
	 */
	@RequestMapping("/getColumn")
	public String list(@RequestParam(value = "uuid") String uuid, Model model) {

		Point point = pointService.getById(uuid);
		List<Factor> factorList = factorService.getFactorList(point.getCode());
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray2 = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("field", "date");
		jsonObject.put("title", "测试时间");
		jsonObject.put("width", 100);
		jsonArray.put(jsonObject);
		if (factorList != null && factorList.size() > 0) {
			for (Factor factor : factorList) {
				JSONObject tempObject = new JSONObject();
				JSONObject tempObject2 = new JSONObject();
				String temp = "";
				tempObject.put("field", factor.getCode());
				if(!StringUtils.isEmpty(factor.getStandard_upper_limit())  && !"0".equals(factor.getStandard_upper_limit().toString())) {
					if(!StringUtils.isEmpty(factor.getStandard_lower_limit()) && !"0".equals(factor.getStandard_lower_limit().toString())) {
						temp += factor.getStandard_lower_limit() + "-" + factor.getStandard_upper_limit(); 
					} else {
						temp += "≤" + factor.getStandard_upper_limit(); 
					}
				}
				if(!StringUtils.isEmpty(factor.getUnit())) {//单位
					temp += factor.getUnit();
				}
				if(!"".equals(temp)) {
					tempObject.put("title", factor.getName() + "("+temp+")");
				}else {
					tempObject.put("title", factor.getName());
				}
				
				tempObject.put("formatter", "valueFormat");
				tempObject.put("width", 100);
				tempObject2.put("field", factor.getCode());
				tempObject2.put("max", factor.getStandard_upper_limit());
				tempObject2.put("min", factor.getStandard_lower_limit());
				jsonArray.put(tempObject);
				jsonArray2.put(tempObject2);
			}
		}
		JSONObject tempObject = new JSONObject();
		tempObject.put("field", "flow");
		tempObject.put("title", "流量(立方米/每小时)");
		tempObject.put("width", 100);
		jsonArray.put(tempObject);
		if ("废水".equals(point.getType())) {
			JSONObject tempObject2 = new JSONObject();
			tempObject2.put("field", "TotalFlow");
			tempObject2.put("title", "累计流量(千立方米)");
			tempObject2.put("width", 100);
			jsonArray.put(tempObject2);
		}
		// if("废气".equals(point.getType())){
		// JSONObject tempObject2 = new JSONObject();
		// tempObject2.put("field", "flow");
		// tempObject2.put("title", "流量(立方米/每小时)");
		// tempObject2.put("width", 80);
		// jsonArray.put(tempObject2);
		// }
		
		
		model.addAttribute("columns", new JSONArray(jsonArray.toString()));
		model.addAttribute("limit", jsonArray2.toString());
		model.addAttribute("pointUuid", point.getUuid());
		return "/moudles/enviromonit/pollution/dataList";
	}

}
