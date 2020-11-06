package com.fjzxdz.ams.module.enviromonit.pollution.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.EnvCompany;
import com.fjzxdz.ams.module.enviromonit.pollution.param.EnvCompanyParam;
import com.fjzxdz.ams.module.enviromonit.pollution.service.EnvCompanyService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/env/pollution")
public class EnvCompanyController extends BaseController{

	@Autowired
	private EnvCompanyService envCompanyCenterService;
	
	@RequestMapping("/companyList.do")
	public String index() {
		return "/moudles/enviromonit/pollution/companyList";
	}
	
	
	/**
	 * 查看
	 */
	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		EnvCompany envCompany;
		try {
			envCompany = envCompanyCenterService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("envCompany", envCompany);
	}
	
	/**
	 * 查询列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<EnvCompany> list(EnvCompanyParam envCompanyparam, HttpServletRequest request) {
		Page<EnvCompany> page = pageQuery(request);
		Page<EnvCompany> envCompanyPage = envCompanyCenterService.listByPage(envCompanyparam, page);
		return new PageEU<>(envCompanyPage);
	}
	
}
