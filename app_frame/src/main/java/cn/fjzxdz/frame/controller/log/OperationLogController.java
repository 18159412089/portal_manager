package cn.fjzxdz.frame.controller.log;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.log.OperationLog;
import cn.fjzxdz.frame.entity.log.OperationLogParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.OperationLogService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/operationLog")
//@Secured({ "ROLE_ADMIN", "ROLE_ROOT" })
public class OperationLogController extends BaseController {

	@Autowired
	private OperationLogService operationLogService;

	@PreAuthorize("hasAuthority('sys:operationLog:show')")
	@RequestMapping("")
	public String index() {
		return "/moudles/log/operate_log";
	}

	@PreAuthorize("hasAuthority('sys:operationLog:show')")
	@RequestMapping("/list")
	@ResponseBody
	public PageEU<OperationLog> list(OperationLogParam operationLogParam, HttpServletRequest request) {
		Page<OperationLog> page = pageQuery(request);
		Page<OperationLog> userPage = operationLogService.listByPage(operationLogParam, page);
		return new PageEU<>(userPage);
	}

	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/detail/{id}")
	@ResponseBody
	public Object detail(@PathVariable String id) {
		OperationLog operationLog;
		try {
			operationLog = operationLogService.getById(id);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("operationLog", operationLog);
	}
}
