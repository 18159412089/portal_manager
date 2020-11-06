package com.fjzxdz.ams.module.enviromonit.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fjzxdz.ams.module.enviromonit.common.service.PeCommonInfoService;

@Component
@Scope("prototype")
@RequestMapping(value="/enterprise/pecommoninfo")
public class PeCommonInfoController {

	@Autowired
	private PeCommonInfoService peCommonInfoService;
	
	@RequestMapping("/getPeCommonInfoList")
	@ResponseBody
	public void getPeCommonInfoList() {
		peCommonInfoService.getPeCommonInfoList();
	}
}
