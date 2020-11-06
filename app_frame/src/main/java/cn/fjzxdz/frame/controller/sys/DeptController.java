package cn.fjzxdz.frame.controller.sys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.fjzxdz.frame.utils.SynDBSimpleCurdUtil;
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
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonArray;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.sys.DeptDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Controller
@RequestMapping("/sys/dept")
public class DeptController extends BaseController {

	@Autowired
	private DeptDao deptDao;

	@Autowired
	private DeptService deptService;

    @PreAuthorize("hasAuthority('sys:dept:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/sys/dept";
	}

    @PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getDept")
	@ResponseBody
	public JSONObject getDept(@RequestParam(value = "uuid", required = true) String uuid) {
		JSONObject jsonObject = new JSONObject();
		Dept dept = deptService.getDeptByUuid(uuid);
		jsonObject.put("uuid", dept.getUuid());
		jsonObject.put("name", dept.getName());
		jsonObject.put("parent", null != dept.getParent() ? dept.getParent().getUuid() : "");
		jsonObject.put("enable", dept.getEnable());
		jsonObject.put("num", dept.getNum());
		jsonObject.put("remark", null != dept.getRemark() ? dept.getRemark() : "");
		jsonObject.put("leaderids", null != dept.getLeaderids() ? dept.getLeaderids() : "");
		jsonObject.put("leadernames", null != dept.getLeadernames() ? dept.getLeadernames() : "");
		return jsonObject;
	}

    @PreAuthorize("hasAuthority('user')")
	@SuppressWarnings("rawtypes")
	@RequestMapping("/listJobAndUser")
	@ResponseBody
	public JSONArray listJobAndUser(@RequestParam(value = "deptId", required = true) String deptId) {
		JSONArray jsonArray = new JSONArray();
		String sql = "select j.name as uname,j.enable from Job j  "
				+ "where exists (from Dept d where j in elements(d.jobs) and  d.uuid=? ) " + "order by j.enable desc";
		List result = deptDao.createQuery(sql, deptId).getResultList();
		if (null != result && result.size() > 0) {
			for (Object object : result) {
				Object[] arr = (Object[]) object;
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("jobName", arr[0]);
				jsonObject.put("enable", arr[1]);
				jsonArray.add(jsonObject);
			}
		}

		return jsonArray;
	}

    @PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getDeptTree")
	@ResponseBody
	public String getDeptTree(@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "enable", required = false, defaultValue = "2") Integer enable) {
		JSONArray jsonArray = deptService.getDeptTree(id, enable, 2);
		return jsonArray.toString();
	}

	/**
	 * 跨库获取网格数据
	 * @param id 上级uuid
	 * @param enable 是否禁用
	 */
	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getSynDeptTree")
	@ResponseBody
	public String getSynDeptTree(
			@RequestParam(value="id", required=false) String id,
			@RequestParam(value="enable") Integer enable) {
		try {
			cn.hutool.json.JSONArray reArray = deptService.getSynDeptTree(id, enable);
			return reArray.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

    @PreAuthorize("hasAuthority('user')")
	@RequestMapping("/getDeptUserTree")
	@ResponseBody
	public String getDeptUserTree(@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "enable", required = false, defaultValue = "2") Integer enable) {
		JSONArray jsonArray = deptService.getDeptUserTree(id, enable, 2);
		return jsonArray.toString();
	}

    @PreAuthorize("hasAnyAuthority('sys:dept:add,sys:dept:edit')")
	@RequestMapping("/saveDept")
	@ResponseBody
	public Map<String, String> saveDept(@RequestParam(value = "uuid", required = false) String uuid,
			@RequestParam(value = "name", required = true) String name,
			@RequestParam(value = "parent", required = false) String parent,
			@RequestParam(value = "num", required = false) Integer num,
			@RequestParam(value = "remark", required = false) String remark,
			@RequestParam(value = "leadernames", required = false) String leadernames,
			@RequestParam(value = "leaderids", required = false) String leaderids) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Dept dept = new Dept();
			if (StringUtils.isNotEmpty(uuid)) {
				dept = deptService.getDeptByUuid(uuid);
				if (0 == dept.getEnable()) {
					Set<Dept> list = dept.getChildren();
					if (null != list & list.size() > 0) {
						for (Dept deptTemp : list) {
							if (1 == deptTemp.getEnable()) {
								map.put("type", "E");
								map.put("message", "还有子部门是启用状态，不允许禁用！");
								return map;
							}
						}
					}
				}
				if (dept.getName()!=name) {
					deptService.changeDeptName(uuid, dept.getName(), name);
				}
				if (dept.getPid()!=parent) {
					deptService.changeDeptPid(uuid, dept.getPidpath(),dept.getPidpath().replace(dept.getPid(), parent),
							dept.getPnamepath(),dept.getPnamepath().replace(dept.getName(), name));
				}
			} else {
				dept.setEnable(1);
			}
			dept.setName(name);
			dept.setNum(num);
			dept.setRemark(remark);
			dept.setLeaderids(leaderids);
			dept.setLeadernames(leadernames);
			if (StringUtils.isNotEmpty(parent)) {
				Dept parentDept = deptService.getDeptByUuid(parent);
				if (0 == parentDept.getEnable()) {
					map.put("type", "E");
					map.put("message", "不允许在禁用部门下面创建启用状态的部门！");
					return map;
				}
				dept.setParent(parentDept);
				if (!ToolUtil.isEmpty(uuid)) {
					dept.setPidpath(parentDept.getPidpath()+"/"+uuid);
				}else {
					dept.setPidpath(parentDept.getPidpath());
				}
				dept.setPnamepath(parentDept.getPnamepath()+"/"+name);
			}
			if(StringUtils.isNotEmpty(uuid)) {
				deptService.save(dept);
			}else {
				deptService.save2(dept);
			}
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

    @PreAuthorize("hasAuthority('sys:dept:show')")
	@RequestMapping("/getChildren")
	@ResponseBody
	public String getChildren(@RequestParam(value = "id", required = false) String id) {
		JsonArray jsonArray = deptService.getChildren(id);
		return jsonArray.toString();
	}

    @PreAuthorize("hasAuthority('sys:dept:show')")
	@RequestMapping("/getAllTree")
	@ResponseBody
	public String getAllTree(@RequestParam(value = "id", required = false) String id) {
		JsonArray jsonArray;
		if (StringUtils.isEmpty(id)) {
			jsonArray = deptService.getTopTwoTree();
		} else {
			jsonArray = deptService.getChildren(id);
		}
		return jsonArray.toString();
	}

    @PreAuthorize("hasAuthority('sys:dept:show')")
	@RequestMapping("/getTreeByEnable")
	@ResponseBody
	public String getTreeByEnable(@RequestParam(value = "id", required = false) String id) {
		JsonArray jsonArray;
		if (StringUtils.isEmpty(id)) {
			jsonArray = deptService.getTopTwoTreeByEnable(1);
		} else {
			jsonArray = deptService.getChildrenByEnable(id,1);
		}
		return jsonArray.toString();
	}

	/**
	 * 禁用部门
	 */
    @PreAuthorize("hasAnyAuthority('sys:dept:disable')")
	@RequestMapping(value = "/disableDept")
	@ResponseBody
	public Map<String, String> disableDept(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Dept dept = deptService.getById(uuid);
			if (null != dept) {
				Set<Dept> depts = dept.getChildren();
				if (null != depts && depts.size() > 0) {
					for (Dept d : depts) {
						if (1 == d.getEnable()) {
							map.put("type", "E");
							map.put("message", "当前部门下有未禁用的子部门，不允许禁用！");
							return map;
						}
					}
				}
				Set<Job> jobs = dept.getJobs();
				if (null != jobs && jobs.size() > 0) {
					for (Job j : jobs) {
						if (1 == j.getEnable()) {
							map.put("type", "E");
							map.put("message", "当前部门下有未禁用的岗位，不允许禁用！");
							return map;
						}
					}
				}
				dept.setEnable(0);
				deptService.save(dept);

			} else {
				map.put("type", "E");
				map.put("message", "数据库中没有该记录");
			}
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 启用部门
	 */
    @PreAuthorize("hasAnyAuthority('sys:dept:enable')")
	@RequestMapping(value = "/enableDept")
	@ResponseBody
	public Map<String, String> enableDept(@RequestParam(value = "uuid") String uuid) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Dept dept = deptService.getById(uuid);
			if (null != dept) {
				Dept parentDept = dept.getParent();
				if (null != parentDept && 0 == parentDept.getEnable()) {
					map.put("type", "E");
					map.put("message", "不允许在禁用部门下面启用部门！");
					return map;
				}
				dept.setEnable(1);
				deptService.save(dept);
			} else {
				map.put("type", "E");
				map.put("message", "数据库中没有该记录");
			}
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

}
