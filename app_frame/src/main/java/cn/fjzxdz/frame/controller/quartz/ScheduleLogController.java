package cn.fjzxdz.frame.controller.quartz;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.quartz.ScheduleLog;
import cn.fjzxdz.frame.entity.quartz.ScheduleLogParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.ScheduleLogService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/scheduleLog")
//@Secured({"ROLE_ROOT","ROLE_ADMIN"})
public class ScheduleLogController extends BaseController {

    @Autowired
    private ScheduleLogService scheduleLogService;

    /**
     * 跳转到定时任务列表首页
     */
	@PreAuthorize("hasAuthority('sys:scheduleLog:show')")
    @RequestMapping("")
    public String index() {
        return "/moudles/quartz/schedule_log";
    }

    /**
     * 定时任务日志列表
     */
	@PreAuthorize("hasAuthority('sys:scheduleLog:show')")
    @RequestMapping("/list")
    @ResponseBody
    public PageEU<ScheduleLog> list(ScheduleLogParam scheduleLogParam, HttpServletRequest request) {
        Page<ScheduleLog> page = pageQuery(request);
        Page<ScheduleLog> scheduleLogPage = scheduleLogService.listByPage(scheduleLogParam, page);
        return new PageEU<>(scheduleLogPage);
    }

    /**
     * 定时任务日志信息
     */
	@PreAuthorize("hasAuthority('user')")
    @RequestMapping("/info/{logId}")
    @ResponseBody
    public R info(@PathVariable("logId") String logId) {
        ScheduleLog log = scheduleLogService.getById(logId);

        return R.ok().put("log", log);
    }
}
