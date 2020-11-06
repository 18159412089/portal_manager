package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefing;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefingParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentAttachService;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentDebriefingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/zphb/environment/debriefing")
@Secured({ "ROLE_USER" })
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class ZpEnvironmentDebriefingController extends BaseController {

	@Autowired
	private ZpEnvironmentDebriefingService debriefingService;
	
	@Autowired
	private ZpEnvironmentAttachService attachService;

	@Secured({ "ROLE_USER" })
	@RequestMapping("")
	public String index() {
		return "/zphb/moudles/hbdc/environmentDebriefingList";
	}

	@RequestMapping("/show")
	public String show() {
		return "/zphb/moudles/hbdc/environmentDebriefingShow";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageEU<EnvironmentDebriefing> list(EnvironmentDebriefingParam param, HttpServletRequest request) {
		Page<EnvironmentDebriefing> page = pageQuery(request);
		Page<EnvironmentDebriefing> debrifingPage = debriefingService.listByPage(param, page);
		return new PageEU<>(debrifingPage);
	}

	@RequestMapping("/debriefingList")
	@ResponseBody
	public JSONArray debriefingList(EnvironmentDebriefingParam param) {
		List<EnvironmentDebriefing> list = debriefingService.debriefingList(param);
		JSONArray result = new JSONArray();
		for(EnvironmentDebriefing debriefing : list) {
			JSONObject temp = new JSONObject();
			temp.put("uuid", debriefing.getUuid());
			temp.put("latitude", debriefing.getLatitude());
			temp.put("longitude", debriefing.getLongitude());
			temp.put("picture", debriefing.getPicture());
			temp.put("name", debriefing.getName());
			temp.put("status", debriefing.getStatus());
			result.add(temp);
		}
		return result;
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(EnvironmentDebriefing debriefing, @RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		String attach_uuid = null;
		try {
			String originFilename = multipartFile.getOriginalFilename();
			if(ToolUtil.isNotEmpty(originFilename)){
				attach_uuid=attachService.saveToMongoDB(multipartFile.getInputStream(),
						StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
			}
			debriefing.setPicture(attach_uuid);
			
			debriefingService.save(debriefing);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		EnvironmentDebriefing debriefing;
		try {
			debriefing = debriefingService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("result", debriefing);
	}
	
	@RequestMapping(value = "/getDescribe")
	@ResponseBody
	public String getDescribe() {
		String result = debriefingService.getDescribe();
		return result;
	}
}
