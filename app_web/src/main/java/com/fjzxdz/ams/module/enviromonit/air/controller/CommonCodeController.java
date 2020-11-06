package com.fjzxdz.ams.module.enviromonit.air.controller;

import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.air.entity.CommonCode;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.air.service.CommonCodeService;
import com.google.gson.JsonArray;

import cn.fjzxdz.frame.controller.BaseController;

import java.util.Map;

@Controller
@RequestMapping("/enviromonit/commonCode")
@Secured({ "ROLE_USER" })
public class CommonCodeController extends BaseController {

	@Autowired
	private CommonCodeService commonCodeService;

	@RequestMapping("")
	public String index() {
		return "/moudles/enviromonit/CommonCode";
	}

	@RequestMapping(value = "/getCounty")
	@ResponseBody
	public JSONArray getCounty() {
		JSONArray array = commonCodeService.allCountyByName("漳州市");
		return array;
	}

	@RequestMapping("/getAllTree")
	@ResponseBody
	public String getAllTree(@RequestParam(value = "id", required = false) String id, String code, String name) {
		JsonArray jsonArray;
		if (StringUtils.isEmpty(id)) {
			jsonArray = commonCodeService.getTopTree(code, name);
		} else {
			jsonArray = commonCodeService.getChildren(id);
		}
		return jsonArray.toString();
	}

//	@PreAuthorize("hasAuthority('sys:commoncode:add')")
	@RequestMapping("/save")
	@ResponseBody
	public R save(CommonCode commonCode) {
		return commonCodeService.save(commonCode);
	}

//	@PreAuthorize("hasAuthority('sys:commoncode:delete')")
	@RequestMapping("/del")
	@ResponseBody
	public R del(String id) {
		return commonCodeService.delete(id);
	}

//	@PreAuthorize("hasAuthority('sys:commoncode:edit')")
	@RequestMapping("/get")
	@ResponseBody
	public CommonCode save(String id) {
		if(ToolUtil.isNotEmpty(id)){
			return commonCodeService.get(id);
		}else{
			return new CommonCode();
		}
	}

}
