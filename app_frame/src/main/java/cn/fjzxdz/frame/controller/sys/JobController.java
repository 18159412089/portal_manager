package cn.fjzxdz.frame.controller.sys;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.alibaba.fastjson.JSONObject;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.sys.JobDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.JobParam;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.service.sys.JobService;
import cn.fjzxdz.frame.service.sys.RoleService;
import cn.fjzxdz.frame.service.sys.UserService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/sys/job")
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class JobController extends BaseController {

	@Autowired
	private JobService jobService;
	@Autowired
	private DeptService deptService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	@Autowired
	private JobDao jobDao;

	@PreAuthorize("hasAuthority('sys:job:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/sys/job";
	}

	@PreAuthorize("hasAuthority('sys:job:show')")
	@SuppressWarnings("rawtypes")
	@RequestMapping("/listUser")
	@ResponseBody
	public JSONArray listUser(@RequestParam(value = "jobId", required = true) String jobId) {
		JSONArray jsonArray = new JSONArray();

		String sql = "select u.name as uname,u.enable from User u "
				+ "where exists (from Job j where u in elements(j.users) and  j.uuid=?) "
				+ "ORDER BY u.enable DESC";

		List result = jobDao.createQuery(sql, jobId).getResultList();

		if (null != result && result.size() > 0) {
			for (Object object : result) {
				Object[] arr = (Object[]) object;
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("userName", arr[0]);
				jsonObject.put("enable", arr[1]);
				jsonArray.add(jsonObject);
			}
		}
		return jsonArray;
	}

	/**
	 * 新增和修改岗位
	 */
	@PreAuthorize("hasAnyAuthority('sys:job:add,sys:job:edit')")
	@RequestMapping("/saveJob")
	@ResponseBody
	public Map<String, String> saveJob(@RequestParam(value = "uuid", required = false) String uuid,
			@RequestParam(value = "name") String name, @RequestParam(value = "dept") String dept,
			@RequestParam(value = "seq", required = false) String seq,
			@RequestParam(value = "remark", required = false) String remark) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Job job;
			if (StringUtils.isNotEmpty(uuid)) {
				job = jobService.getById(uuid);
			} else {
				job = new Job();
				job.setEnable(1);
			}
			job.setName(name);
			job.setSeq(seq);
			job.setRemark(remark);
			if (StringUtils.isNotEmpty(dept)) {
				Dept parentDept = deptService.getDeptByUuid(dept);
				if (0 == parentDept.getEnable()) {
					map.put("type", "E");
					map.put("message", "不允许在禁用部门下面创建启用状态的岗位！");
					return map;
				}
				job.setDept(parentDept);
			}
			jobService.save(job);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 查看岗位
	 */
	@RequestMapping("/getJob")
	@ResponseBody
	public Map<String, Object> getJob(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = new HashedMap<>();
		Job job = jobService.getById(uuid);
		map.put("uuid", job.getUuid());
		map.put("name", job.getName());
		map.put("enable", job.getEnable());
		map.put("seq", job.getSeq());
		map.put("deptName", job.getDeptName());
		map.put("remark", job.getRemark());
		map.put("dept", null != job.getDept() ? job.getDept().getUuid() : "");
		return map;
	}

	/**
	 * 禁用岗位/启用岗位
	 */
	@PreAuthorize("hasAnyAuthority('sys:job:enable,sys:job:diable')")
	@RequestMapping(value = "/editJobStatus")
	@ResponseBody
	public Map<String, Object> editJobStatus(@RequestParam(value = "uuid") String uuid,
			@RequestParam(value = "enable") Integer enable) {
		Job job = jobService.getById(uuid);
		if (null != job) {
			if (enable == 0) { // 禁用岗位时去掉中间关系
				Set<User> users = job.getUsers();
				if (null != users && users.size() > 0) {
					for (User user : users) {
						if (1 == user.getEnable()) {
							return R.error("当前岗位下有未禁用的人员，不允许禁用！");
						}
					}
				}
				job.setUsers(null);
			}
			if (1 == enable && 0 == job.getDept().getEnable()) {
				return R.error("不允许在禁用部门下面启用岗位！");
			}
			job.setEnable(enable);
			jobService.save(job);
		} else {
			return R.error("数据库中没有该记录");
		}
		return R.ok();
	}

	/**
	 * 分配角色
	 */
	@PreAuthorize("hasAuthority('sys:job:roleAssign')")
	@RequestMapping(value = "/roleAssign")
	@ResponseBody
	public Map<String, Object> roleAssign(@RequestParam(value = "uuid") String uuid) {
		Map<String, Object> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Job job = jobService.getById(uuid);
			Set<Role> roles = job.getRoles();
			map.put("data", roles);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 保存角色和岗位关系
	 */
	@PreAuthorize("hasAuthority('sys:job:roleAssign')")
	@RequestMapping(value = "/saveRoleAndJob")
	@ResponseBody
	public Map<String, String> saveRoleAndJob(@RequestParam(value = "uuid") String uuid,
			@RequestParam(value = "roleIds") String roleIds) {
		Map<String, String> map = new HashedMap<>();
		map.put("type", "S");
		try {
			Job job = jobService.getById(uuid);
			List<Role> roles = new ArrayList<Role>();
			if (roleIds.length() > 0) {
				roles = roleService.getRoleList(roleIds);
			}
			Set<Role> roleSet = new HashSet<Role>(roles);
			job.setRoles(roleSet);
			jobService.save(job);
		} catch (Exception e) {
			map.put("type", "E");
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 查询岗位列表
	 */
	@PreAuthorize("hasAuthority('sys:job:show')")
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<Job> list(JobParam jobParam, HttpServletRequest request) {
		Page<Job> page = pageQuery(request);
		Page<Job> jobPage = jobService.listByPage(jobParam, page);
		return new PageEU<>(jobPage);
	}

	/**
	 * 查询岗位列表
	 */
	@PreAuthorize("hasAuthority('sys:job:show')")
	@RequestMapping("/userNotAssignList")
	@ResponseBody
	public PageEU<Job> userNotAssignList(JobParam jobParam, String userId, HttpServletRequest request) {
		User user = userService.getById(userId);
		Set<Job> jobs = user.getJobs();
		List<String> jobIds = new ArrayList<>();
		for(Job job : jobs){
            jobIds.add(job.getUuid());
		}
		Page<Job> page = pageQuery(request);
		//oracle使用NOT IN语句时，后面跟着的括号中不能为空字符串，必须要有值（空格也可以）
		if(jobIds.size()>0){
            jobParam.addNativeClause("uuid not in ('" + StringUtils.join(jobIds, "','") + "')");
        }
		Page<Job> jobPage = jobService.listByPage(jobParam, page);
		return new PageEU<>(jobPage);
	}
	
	/**
	 * 查询岗位列表
	 */
	@PreAuthorize("hasAuthority('sys:job:show')")
	@RequestMapping("/listNotAssign")
	@ResponseBody
	public PageEU<Job> listNotAssign(JobParam jobParam, HttpServletRequest request) {
		Page<Job> page = pageQuery(request);
		jobParam.addNativeClause(" and uuid not in (select job from JobUser)");
		Page<Job> jobPage = jobService.listByPage(jobParam, page);
		return new PageEU<>(jobPage);
	}
}
