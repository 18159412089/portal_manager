package cn.fjzxdz.frame.controller.log;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.log.LoginLog;
import cn.fjzxdz.frame.entity.log.LoginLogParam;
import cn.fjzxdz.frame.service.LoginLogService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/loginLog")
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class LoginLogController extends BaseController {

	@Autowired
	private LoginLogService loginLogService;

	@PreAuthorize("hasAuthority('sys:loginLog:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/log/login_log";
	}

	@PreAuthorize("hasAuthority('sys:loginLog:show')")
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<LoginLog> list(LoginLogParam loginLogParam, HttpServletRequest request) {
		Page<LoginLog> page = pageQuery(request);
		Page<LoginLog> userPage = loginLogService.listByPage(loginLogParam, page);
		return new PageEU<>(userPage);
	}
}
