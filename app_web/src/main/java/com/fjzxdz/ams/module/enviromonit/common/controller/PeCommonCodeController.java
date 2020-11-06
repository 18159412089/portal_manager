package com.fjzxdz.ams.module.enviromonit.common.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.common.dao.PeCommonCodeDao;
import com.fjzxdz.ams.module.enviromonit.common.entity.PeCommonCode;
import com.fjzxdz.ams.module.enviromonit.common.param.PeCommonCodeParam;
import com.fjzxdz.ams.module.enviromonit.common.service.PeCommonCodeService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.hutool.json.JSONObject;

@Component
@Scope("prototype")
@RequestMapping(value="/enterprise/pecommoncode")
public class PeCommonCodeController extends BaseController{
	@Autowired
	private PeCommonCodeService peCommonCodeService;
	
	@RequestMapping("/getPeCommonCodeList")
	@ResponseBody
	public PageEU<PeCommonCode> getPeCommonCodeList(PeCommonCodeParam peCommonCodeParam, HttpServletRequest request) {
		Page<PeCommonCode> peCommonCode = peCommonCodeService.listByPage(peCommonCodeParam, pageQuery(request));
		
		return new PageEU<>(peCommonCode);
	}
	
	@RequestMapping("/getPeCommonCodeByCode")
	@ResponseBody
	public PeCommonCode getPeCommonCodeByCode(@RequestParam(value="code") String code) {
		PeCommonCode commonCode = peCommonCodeService.getPeCommonCodeByCode(code);
		
		return commonCode;
	}
	
	@RequestMapping("/getPeCommonCode")
	@ResponseBody
	public Map<String, Object> getPeCommonCodeById(@RequestParam(value = "id") String id){
		
		return R.ok().put("peEnterpriseData", peCommonCodeService.getPeCommonCodeById(id));
	}
	
	@RequestMapping("/getPeCommonCodeListByParentId")
	@ResponseBody
	public JSONArray getPeCommonCodeListByParentId(@RequestParam(value="parentId") BigDecimal parentId){
		List<PeCommonCode> list = peCommonCodeService.getPeCommonCodeListByParentId(parentId);
		JSONArray result = new JSONArray();
		for (PeCommonCode peCommonCode : list) {
			JSONObject obj = new JSONObject();
			
			obj.put("id", peCommonCode.getCode());
			obj.put("text", peCommonCode.getName());
			
			result.add(obj);
		}
		return result;
	}
}
