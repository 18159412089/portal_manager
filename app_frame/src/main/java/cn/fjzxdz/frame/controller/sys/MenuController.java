package cn.fjzxdz.frame.controller.sys;

import java.util.Map;
import java.util.Set;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Maps;
import com.google.gson.JsonArray;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.sys.MenuDao;
import cn.fjzxdz.frame.entity.core.Menu;
import cn.fjzxdz.frame.exception.AmsException;
import cn.fjzxdz.frame.exception.BizExceptionEnum;
import cn.fjzxdz.frame.service.sys.MenuService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Controller
@RequestMapping("/sys/menu")
public class MenuController extends BaseController {

	@Autowired
	MenuDao menudao;

	@Autowired
	MenuService menuService;

	/**
	 * 跳转到菜单列表列表页面
	 */
	@PreAuthorize("hasAuthority('sys:menu:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/sys/menu";
	}

	/**
	 * 新增和修改菜单
	 */
	@PreAuthorize("hasAnyAuthority('sys:menu:add,sys:menu:edit')")
	@RequestMapping(value = "/saveMenu")
	@ResponseBody
	public Map<String, String> saveMenu(@RequestParam(value = "uuid", required = false) String uuid,
			@RequestParam(value = "name") String name, @RequestParam(value = "parent", required = false) String parent,
			@RequestParam(value = "type") String type, @RequestParam(value = "icon") String icon, @RequestParam(value = "url") String url,
			@RequestParam(value = "num") Integer num, @RequestParam(value = "remark", required = false) String remark,@RequestParam(value = "permission") String permission) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("type", "S");
		try {
			Menu menu = new Menu();
			if (StringUtils.isNotEmpty(uuid)) {
				menu = menuService.getById(uuid);
			}
			menu.setName(name);
			menu.setPid(parent);
			menu.setType(type);
			menu.setIcon(icon);
			menu.setUrl(url);
			menu.setNum(num);
			menu.setRemark(remark);
			menu.setPermission(permission);
			Menu parentMenu = new Menu();
			if (StringUtils.isNotEmpty(parent) && !parent.equals("0")) {
				parentMenu = menuService.getById(parent);
			} else {
				parentMenu.setUuid("0");
			}
			menu.setParent(parentMenu);
			// 设置菜单等级
			menuSetLevelsAndPids(menu);
			menuService.save(menu);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 查看菜单
	 */
	@RequestMapping(value = "/getMenu")
	@ResponseBody
	public Map<String, Object> getMenu(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = Maps.newHashMap();
		Menu menu = menuService.getById(uuid);
		map.put("uuid", menu.getUuid());
		map.put("parent", menu.getParent().getUuid());
		map.put("name", menu.getName());
		map.put("icon", menu.getIcon());
		map.put("num", menu.getNum());
		map.put("url", menu.getUrl());
		map.put("remark", menu.getRemark());
		map.put("type", menu.getType());
		map.put("permission", menu.getPermission());
		return map;
	}

	/**
	 * 删除菜单
	 */
	@PreAuthorize("hasAuthority('sys:menu:delete')")
	@RequestMapping(value = "/delMenu")
	@ResponseBody
	public Map<String, String> remove(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<String, String>();
		map.put("type", "S");
		try {
			// 如果有子菜单不能删除，只能一级一级删除
			Long childCount = (Long) menudao.createQuery("select count(*) from Menu m where m.pid=?", uuid)
					.getSingleResult();
			if (childCount > 0) {
				map.put("type", "E");
				map.put("message", "当前菜单下面有子菜单不允许删除！");
			} else {
				menuService.deleteById(uuid);
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
			jsonArray = menuService.getTopTwoTree();
		} else {
			jsonArray = menuService.getChildren(id);
		}
		return jsonArray.toString();
	}

	@RequestMapping("/getMenuTree")
	@ResponseBody
	public String getMenuTree(@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "enable", required = false, defaultValue = "2") Integer enable) {
		JSONArray jsonArray = menuService.getMenuTree(id, enable, 2);
		return jsonArray.toString();
	}

	@RequestMapping("/getFrontMenu")
	@ResponseBody
	public JSONArray getFrontMenu() {
		JSONArray result = menuService.getFrontMenu(getUserId());
		return result;
	}

	@RequestMapping("/getFrontSecondAndChileMenu")
	@ResponseBody
	public JSONArray getFrontSecondAndChileMenu(String pids) {
		JSONArray result = menuService.getFrontSecondAndChileMenu(getUserId(), pids);
		return result;
	}

	@RequestMapping("/getNewFrontMenu")
    @ResponseBody
    public JSONArray getNewFrontMenu() {
        JSONArray result = menuService.getNewFrontMenu(getUserId());
        return result;
    }
	
	@RequestMapping("/getSecondMenu")
    @ResponseBody
    public JSONArray getSecondMenu(String pid) {
        JSONArray result = menuService.getSecondMenu(getUserId(),pid);
        return result;
    }
	
	private void menuSetLevelsAndPids(Menu menu) {
		if (ToolUtil.isEmpty(menu.getPid()) || menu.getPid().equals("0")) {
			menu.setPid("0");
			menu.setPids("[0],");
			menu.setLevels(1);
		} else {
			Menu pMenu = menuService.getById(menu.getPid());
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
		Set<Menu> childMenus = menu.getChildren();
		for (Menu child : childMenus) {
			menuSetLevelsAndPids(child);
		}
	}
}
