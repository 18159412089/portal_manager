package com.fjzxdz.ams.zphb.module.hbdc.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpCommonRelationTableService;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpEnvironmentAttachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/zphb/environment/commonRelationTable")
@Secured({ "ROLE_USER" })
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class ZpCommonRelationTableController extends BaseController {

	@Autowired
	private ZpCommonRelationTableService commonRelationTableService;
	
	@Autowired
	private ZpEnvironmentAttachService attachService;

	@RequestMapping("/listNotPage")
	@ResponseBody
	public JSONArray listNotPage(CommonRelationTableParam param) {
		List<CommonRelationTable> list = commonRelationTableService.listNoPage(param);
		JSONArray jsonArray = new JSONArray();
		for(CommonRelationTable relationTable : list) {
			JSONObject temp = new JSONObject();
			temp.put("id", relationTable.getUuid());
			temp.put("name", relationTable.getName());
			jsonArray.add(temp);
		}
		return jsonArray;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<CommonRelationTable> list(CommonRelationTableParam param, HttpServletRequest request) {
		Page<CommonRelationTable> page = pageQuery(request);
		Page<CommonRelationTable> pages = commonRelationTableService.listByPage(param, page);
		return new PageEU<>(pages);
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public R save(CommonRelationTable relationTable) {
		String message ="操作失败！";
		try {
			message = commonRelationTableService.save(relationTable);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		if (message.indexOf("失败")>-1) {
			return R.error(message);
		}
		return R.ok(message);
	}

	@RequestMapping(value = "/del")
	@ResponseBody
	public R del(String uuid) {
		String result = commonRelationTableService.delete(uuid);
		return R.ok(result);
	}

	@RequestMapping(value = "/get")
	@ResponseBody
	public R get(@RequestParam(value = "uuid") String uuid) {
		CommonRelationTable relationTable;
		try {
			relationTable = commonRelationTableService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("result", relationTable);
	}
	
}
