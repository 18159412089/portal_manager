package cn.fjzxdz.frame.controller.sys;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import cn.fjzxdz.frame.entity.core.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.sys.UserService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/sys/user")
public class UserController extends BaseController {

	@Autowired
	private UserService userService;

	/**
	 * 跳转到查看用户列表的页面
	 */
    @PreAuthorize("hasAuthority('sys:user:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/sys/user";
	}

	/**
	 * 新增和修改用户
	 */
    @PreAuthorize("hasAnyAuthority('sys:user:add,sys:user:edit')")
	@RequestMapping(value = "/saveUser")
	@ResponseBody
	public R saveUser(User user) {
		R r;
		user.setLogintype(LoginType.SYSTEM);
		try {
			r = userService.save(user);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}

	/**
	 * 查看用户
	 */
	@RequestMapping(value = "/getUser")
	@ResponseBody
	public R getUser(@RequestParam(value = "uuid") String uuid) {
		User user;
		try {
			user = userService.getById(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("user", user);
	}

	/**
	 * 禁用用户/启用用户
	 */
    @PreAuthorize("hasAnyAuthority('sys:user:enable,sys:user:disable')")
	@RequestMapping(value = "/editUserStatus")
	@ResponseBody
	public R editUserStatus(@RequestParam(value = "uuid") String uuid, @RequestParam(value = "enable") Integer enable) {
		R r;
		try {
			r = userService.editUserStatus(uuid, enable);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}

	/**
	 * 修改密码
	 */
    @PreAuthorize("hasAuthority('sys:user:resetPwd')")
	@RequestMapping(value = "/editPwd")
	@ResponseBody
	public R editPwd(@RequestParam(value = "newPwd") String newPwd) {
		R r;
		try {
			r = userService.editPwd(getUserId(), newPwd);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r).put("message", newPwd);
	}

	/**
	 * 重置密码
	 */
    @PreAuthorize("hasAuthority('sys:user:resetPwd')")
	@RequestMapping(value = "/resetPwd")
	@ResponseBody
	public R resetPwd(@RequestParam(value = "uuid") String uuid) {
		R r;
		try {
			r = userService.resetPwd(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}
	
	/**
	 * 分配岗位
	 */
    @PreAuthorize("hasAuthority('sys:user:assignJob')")
	@RequestMapping(value = "/assignJob")
	@ResponseBody
	public R assignJob(@RequestParam(value = "uuid") String uuid) {
		Set<Job> jobs;
		try {
			User user = userService.getById(uuid);
			jobs = user.getJobs();
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("data", jobs);
	}

	/**
	 * 保存用户和岗位关系
	 */
    @PreAuthorize("hasAuthority('sys:user:assignJob')")
	@RequestMapping(value = "/saveUserAndJob")
	@ResponseBody
	public R saveUserAndJob(@RequestParam(value = "uuid") String uuid, @RequestParam(value = "jobIds") String[] jobIds) {
		R r;
		try {
			r = userService.assignJob(uuid, jobIds);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}

	/**
	 * 查询用户列表
	 */
    @PreAuthorize("hasAuthority('sys:user:show')")
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<User> list(UserParam userParam, HttpServletRequest request) {
		Page<User> page = pageQuery(request);
		Page<User> userPage = userService.listByPage(userParam, page);
		return new PageEU<>(userPage);
	}

	/**
	 * 查询用户列表(所有)
	 */
	@PreAuthorize("hasAuthority('sys:user:show')")
	@RequestMapping("/findList")
	@ResponseBody
	public List<User> findList(UserParam userParam) {
		List<User> useList = userService.findList(userParam);
		return useList;
	}

	/**
	 * 新增网格员，存储相关信息
	 * @param userReLateInfo
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('sys:user:add,sys:user:edit')")
	@RequestMapping(value = "/saveUserRelateInfo")
	@ResponseBody
	public R saveUserRelateInfo(UserReLateInfo userReLateInfo) {
		R r;
		try {
			r = userService.saveUserRelateInfo(userReLateInfo);
		} catch (Exception e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
		return R.ok(r);
	}

}
