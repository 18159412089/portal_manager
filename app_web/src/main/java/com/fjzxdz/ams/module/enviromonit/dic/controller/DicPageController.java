package com.fjzxdz.ams.module.enviromonit.dic.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.exception.AmsException;
import cn.fjzxdz.frame.exception.BizExceptionEnum;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.resource.dao.ResDataDao;
import com.fjzxdz.ams.module.enviromonit.resource.entity.ResData;
import com.fjzxdz.ams.module.enviromonit.resource.service.ResDataService;
import com.google.common.collect.Maps;
import com.google.gson.JsonArray;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/env/dic")
public class DicPageController extends BaseController {

	@Autowired
	ResDataDao resDataDao;

	@Autowired
	ResDataService resDataService;

	@RequestMapping("/service")
	public String edit(Model model) {
		return "/moudles/enviromonit/dic/service";
	}

}
