package com.fjzxdz.ams.module.enviromonit.resource.controller;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.exception.AmsException;
import cn.fjzxdz.frame.exception.BizExceptionEnum;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.resource.dao.ResDataDao;
import com.fjzxdz.ams.module.enviromonit.resource.entity.ResData;
import com.fjzxdz.ams.module.enviromonit.resource.service.ResDataService;
import com.fjzxdz.ams.module.enviromonit.water.param.WtHourDataParam;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/env/resource")
public class ResourcePageController extends BaseController {

	@Autowired
	ResDataDao resDataDao;

	@Autowired
	ResDataService resDataService;

	@RequestMapping("/edit")
	public String edit(Model model) {
		return "/moudles/enviromonit/resource/edit";
	}
	@RequestMapping("/service")
	public String service(Model model) {
		return "/moudles/enviromonit/resource/service";
	}
	/**
	 * 新增和修改菜单
	 */
	@RequestMapping(value = "/saveMenu")
	@ResponseBody
	public Map<String, String> saveMenu(@RequestParam(value = "uuid", required = false) String uuid,
										@RequestParam(value = "name") String name, @RequestParam(value = "parent", required = false) String parent,
										@RequestParam(value = "icon") String icon, @RequestParam(value = "url") String url,
										@RequestParam(value = "num") Integer num, @RequestParam(value = "remark", required = false) String remark) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("type", "S");
		try {
			ResData menu = new ResData();
			if (StringUtils.isNotEmpty(uuid)) {
				menu = resDataService.getById(uuid);
			}
			menu.setName(name);
			menu.setPid(parent);
			menu.setIcon(icon);
			menu.setUrl(url);
			menu.setNum(num);
			menu.setRemark(remark);
			ResData parentMenu = new ResData();
			if (StringUtils.isNotEmpty(parent) && !parent.equals("0")) {
				parentMenu = resDataService.getById(parent);
			} else {
				parentMenu.setUuid("0");
			}
			menu.setParent(parentMenu);
			// 设置菜单等级
			menuSetLevelsAndPids(menu);
			resDataService.save(menu);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 查看资源目录
	 */
	@RequestMapping(value = "/getMenu")
	@ResponseBody
	public Map<String, Object> getMenu(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = Maps.newHashMap();
		ResData menu = resDataService.getById(uuid);
		map.put("uuid", menu.getUuid());
		map.put("parent", menu.getParent().getUuid());
		map.put("name", menu.getName());
		map.put("icon", menu.getIcon());
		map.put("num", menu.getNum());
		map.put("url", menu.getUrl());
		map.put("remark", menu.getRemark());
		return map;
	}

	/**
	 * 删除资源目录
	 */
	@RequestMapping(value = "/delMenu")
	@ResponseBody
	public Map<String, String> remove(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("type", "S");
		try {
			// 如果有子资源目录不能删除，只能一级一级删除
			Long childCount = (Long) resDataDao.createQuery("select count(*) from ResData m where m.pid=?", uuid)
					.getSingleResult();
			if (childCount > 0) {
				map.put("type", "E");
				map.put("message", "当前资源目录下面有子资源目录不允许删除！");
			} else {
				resDataService.deleteById(uuid);
			}
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	@RequestMapping("/getAllTree")
	@ResponseBody
	public String getAllTree(@RequestParam(value = "id", required = false) String id) {
		JsonArray jsonArray;
		if (StringUtils.isEmpty(id)) {
			jsonArray = resDataService.getTopTwoTree();
		} else {
			jsonArray = resDataService.getChildren(id);
		}
		return jsonArray.toString();
	}

	@RequestMapping("/getMenuTree")
	@ResponseBody
//	@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
	public String getMenuTree(@RequestParam(value = "id", required = false) String id,
							  @RequestParam(value = "enable", required = false, defaultValue = "2") Integer enable) {
		JSONArray jsonArray = resDataService.getMenuTree(id, enable, 2);
		return jsonArray.toString();
	}

	private void menuSetLevelsAndPids(ResData menu) {
		if (ToolUtil.isEmpty(menu.getPid()) || menu.getPid().equals("0")) {
			menu.setPid("0");
			menu.setPids("[0],");
			menu.setLevels(1);
		} else {
			ResData pMenu = resDataService.getById(menu.getPid());
			menu.setPid(pMenu.getUuid());
			Integer pLevels = pMenu.getLevels();

			// 如果编号和父编号一致会导致无限递归
			if (null != menu.getUuid() && menu.getUuid().equals(menu.getPid())) {
				throw new AmsException(BizExceptionEnum.MENU_PCODE_COINCIDENCE);
			}

			menu.setLevels(pLevels + 1);
			menu.setPids(pMenu.getPids() + "[" + pMenu.getUuid() + "],");
		}
		// 递归给子集重新设置pids级联更新
		Set<ResData> childMenus = menu.getChildren();
		for (ResData child : childMenus) {
			menuSetLevelsAndPids(child);
		}
	}

	@RequestMapping("/getListExport")
	@ResponseBody
	public List<Map<String, Object>> getListExport(
			@RequestParam(value = "enable", required = false, defaultValue = "2") Integer enable,
												   HttpServletRequest request,
												   HttpServletResponse response){
		JSONArray jsonArray = resDataService.getMenuTree(null, enable, 2);
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			getDataMap(jsonArray,list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 导出所有
		return exportEnvironmentNativeWtHourDataExl(response, list);
	}

	/**
	 * 导出Excel
	 * @param response
	 * @param list
	 * @return
	 */
	private List<Map<String, Object>> exportEnvironmentNativeWtHourDataExl(HttpServletResponse response, List<Map<String, Object>> list) {
		//List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		// 定义Excel 字段名称
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "资源目录数据表");
		columnMap.put("name", "资源目录名称");
		columnMap.put("icon", "图标");
		columnMap.put("url", "url");
		columnMap.put("num", "排序");
		columnMap.put("remark", "备注");
		ExcelExportUtil.exportExcel(response, columnMap, list);
		return null;
	}

	private List<Map<String,Object>> getDataMap(JSONArray obj1,List<Map<String,Object>> lists) throws Exception{
		for (int i = 0; i < obj1.size(); i++) {
			Map<String, Object> map = new LinkedHashMap<>();
			map.put("name",obj1.getJSONObject(i).get("name"));
			map.put("icon",obj1.getJSONObject(i).get("icon"));
			map.put("url",obj1.getJSONObject(i).get("url"));
			map.put("num",obj1.getJSONObject(i).get("num"));
			map.put("remark",obj1.getJSONObject(i).get("remark"));
			lists.add(map);
			if(ToolUtil.isNotEmpty(obj1.getJSONObject(i).get("children"))){
				JSONArray children = (JSONArray)obj1.getJSONObject(i).get("children");
				getDataMap(children,lists);
			}
		}
		return lists;
	}

}
