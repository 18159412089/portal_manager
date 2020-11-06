package com.fjzxdz.ams.module.debriefing.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fjzxdz.ams.module.debriefing.entity.EnvironmentAttach;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentDebriefDetails;
import com.fjzxdz.ams.module.debriefing.param.EnvironmentDebriefDetailsParam;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentAttachService;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentDebriefDetailsService;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Controller
@RequestMapping("/environment/debrief/details")
@Secured({ "ROLE_USER" })
public class EnvironmentDebriefDetailsController extends BaseController {

	@Autowired
	private EnvironmentDebriefDetailsService detailsService;
	
	@Autowired
	private EnvironmentAttachService attachService;

	@RequestMapping("")
	public String index(String uuid, Model model) {
		model.addAttribute("debriefing", uuid);
		return "/moudles/debriefing/environmentDebriefDetailsList";
	}

	@RequestMapping(value = "/getByDebriefing")
	@ResponseBody
	public Map<String, Object> getByDebriefing(@RequestParam(value = "debriefing") String debriefing) {
		Map<String, Object> result = detailsService.getByDebriefing(debriefing);
		return result;
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageEU<EnvironmentDebriefDetails> list(String debriefing1,EnvironmentDebriefDetailsParam param, HttpServletRequest request) {
		Page<EnvironmentDebriefDetails> page = pageQuery(request);
		Page<EnvironmentDebriefDetails> detailsPage = detailsService.listByPage(param, page);
		return new PageEU<>(detailsPage);
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(EnvironmentDebriefDetails details,@RequestParam("file") MultipartFile[] multipartFiles, HttpServletRequest request) {
		try {
			StringBuffer attach_uuid = new StringBuffer();
			 //批量上传
			if(ToolUtil.isNotEmpty(multipartFiles[0].getOriginalFilename())) {
				for(int i = 0;i<multipartFiles.length;i++)
				{  
					String originFilename = multipartFiles[i].getOriginalFilename();
					String attach=attachService.saveToMongoDB(multipartFiles[i].getInputStream(),
							StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
					if(i==0) {
						attach_uuid.append(attach);
					}else {
						attach_uuid.append(",").append(attach);
					}
				}
				details.setVideo(attach_uuid.toString());
			}else {
				details.setVideo(null);
			}
			
			detailsService.save(details);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 单文件添加上传
	 * @param uuid
	 * @param multipartFile
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/updateOnlyFile")
	@ResponseBody
	public R updateOnlyFile(String uuid,@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		try {
			EnvironmentDebriefDetails details = detailsService.getById(uuid);
	        String originFilename = multipartFile.getOriginalFilename();
	        String attach=attachService.saveToMongoDB(multipartFile.getInputStream(),
	        			StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
			if(ToolUtil.isNotEmpty(details.getVideo())) {
				details.setVideo(details.getVideo()+","+attach);
			}else {
				details.setVideo(attach);
			}
			detailsService.save(details);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		EnvironmentDebriefDetails details;
		try {
			details = detailsService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("result", details);
	}
	
	@RequestMapping(value = "/getAttachList")
	@ResponseBody
	public List<Map<String,Object>> getAttachList(@RequestParam(value = "uuid") String uuid) {
		EnvironmentDebriefDetails details;
		List<Map<String,Object>> list = new ArrayList<>();
		details = detailsService.getById(uuid);
		String[] attachs = details.getVideo().split(",");
		List<String> attachList = Arrays.asList(attachs);
		for(String string : attachList) {
			EnvironmentAttach attach = attachService.getAttach(string);
			Map<String, Object> temp = new HashMap<>();
			temp.put("mongoid",attach.getMongoid());
			temp.put("uuid",details.getUuid());
			temp.put("name",attach.getName());
			list.add(temp);
		}
		return list;
	}
	
	@RequestMapping(value = "/getAttachListByDebriefing")
	@ResponseBody
	public List<Map<String,Object>> getAttachListByDebriefing(@RequestParam(value = "debriefing") String debriefing) {
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String, Object> map = detailsService.getByDebriefing(debriefing);
		String[] attachs = map.get("video").toString().split(",");
		List<String> attachList = Arrays.asList(attachs);
		for(String string : attachList) {
			EnvironmentAttach attach = attachService.getAttach(string);
			Map<String, Object> temp = new HashMap<>();
			temp.put("mongoid",attach.getMongoid());
			temp.put("uuid",map.get("uuid"));
			temp.put("name",attach.getName());
			list.add(temp);
		}
		return list;
	}
}
