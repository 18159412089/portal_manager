package cn.fjzxdz.frame.controller.sys;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.core.Dict;
import cn.fjzxdz.frame.entity.core.DictChildParam;
import cn.fjzxdz.frame.entity.core.DictParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.sys.DictService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/sys/dict")
@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;

	@PreAuthorize("hasAuthority('sys:dict:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/sys/dict";
	}

	@PreAuthorize("hasAnyAuthority('sys:dict:add,sys:dict:edit')")
	@RequestMapping("/saveDict")
	@ResponseBody
	public R saveDict(Dict dict) {
		try {
			if (StringUtils.isEmpty(dict.getUuid())) {
				dict.setUuid(null);
				dict.setEnable(1);
				dictService.save(dict);
			} else {
				Dict object = dictService.getById(dict.getUuid());
				object.setType(dict.getType());
				object.setValue(dict.getValue());
				object.setEnable(dict.getEnable());
				object.setRemark(dict.getRemark());
				dictService.save(object);
			}
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getDictData")
	@ResponseBody
//	@PreAuthorize("hasRole('ROLE_USER')")
	public JSONArray getDictData(@RequestParam(value = "type", required = true) String type) {
		JSONArray jsonArray = dictService.getDictData(type);
		return jsonArray;
	}

	@PreAuthorize("hasAnyAuthority('sys:dict:add,sys:dict:edit')")
	@RequestMapping("/saveChildDict")
	@ResponseBody
	public Map<String, String> saveChildDict(@RequestParam(value = "uuid", required = false) String uuid,
			@RequestParam(value = "pid") String pid, @RequestParam(value = "type") String type,
			@RequestParam(value = "num") Integer num, @RequestParam(value = "value", required = false) String value,
			@RequestParam(value = "remark", required = false) String remark,
			@RequestParam(value = "enable") Integer enable) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Dict dict = new Dict();
			if (StringUtils.isNotEmpty(uuid)) {
				dict = dictService.getById(uuid);
			}
			if (StringUtils.isNotEmpty(pid)) {
				Dict parentdict = dictService.getById(pid);
				if (1 == enable && 0 == parentdict.getEnable()) {
					map.put("type", "E");
					map.put("message", "不允许在禁用父类型下面创建启用状态的子类型！");
					return map;
				}
				dict.setParent(parentdict);
			}
			dict.setType(type);
			dict.setValue(value);
			dict.setNum(num);
			dict.setEnable(enable);
			dict.setRemark(remark);
			dictService.save(dict);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getDict")
	@ResponseBody
	public Map<String, Object> getDict(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = new HashedMap<>();
		Dict dict = dictService.getById(uuid);
		map.put("uuid", dict.getUuid());
		map.put("pid", null != dict.getParent() ? dict.getParent().getUuid() : "");
		map.put("pname", null != dict.getParent() ? dict.getParent().getType() : "");
		map.put("type", dict.getType());
		map.put("enable", dict.getEnable());
		map.put("num", dict.getNum());
		map.put("value", dict.getValue());
		map.put("remark", dict.getRemark());
		return map;
	}

	/**
	 * 删除字典
	 */
	@PreAuthorize("hasAuthority('sys:dict:delete')")
	@RequestMapping(value = "/delDict")
	@ResponseBody
//	@PreAuthorize("hasRole('ROLE_ROOT')")
	public Map<String, String> delDict(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			dictService.delete(uuid);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	@PreAuthorize("hasAuthority('sys:dict:show')")
	@RequestMapping("/list")
	@ResponseBody
//	@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
	public PageEU<Dict> list(DictParam dictParam, HttpServletRequest request) {
		Page<Dict> page = pageQuery(request);
		Page<Dict> dictPage = dictService.listByPage(dictParam, page);
		return new PageEU<>(dictPage);
	}

	@PreAuthorize("hasAuthority('sys:dict:show')")
	@RequestMapping("/clildlist")
	@ResponseBody
	public PageEU<Dict> clildlist(DictChildParam dictChildParam, HttpServletRequest request) {
		Page<Dict> page = pageQuery(request);
		Page<Dict> dictPage = dictService.listByPage(dictChildParam, page);
		return new PageEU<>(dictPage);
	}
	
	/**
     * 按字典Id取字典值
     *
     * @param id
     * @return
     */
    @RequestMapping("/getDictById")
    @ResponseBody
    public Map<String, Object> getDictById(String id) {
        return dictService.getDictById(id);
    }
}
