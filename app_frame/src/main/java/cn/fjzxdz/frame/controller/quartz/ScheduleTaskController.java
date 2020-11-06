package cn.fjzxdz.frame.controller.quartz;

import java.sql.Clob;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.quartz.ScheduleTask;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.ScheduleTaskService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/schedule")
//@Secured({ "ROLE_ROOT" })
public class ScheduleTaskController extends BaseController {

	@Autowired
	private ScheduleTaskService scheduleTaskService;

	@Autowired
	private SimpleDao simpleDao;
	@Autowired
    private Environment env;

	/**
	 * 跳转到定时任务列表首页
	 */
	@PreAuthorize("hasAuthority('sys:schedule:show')")
	@RequestMapping("")
//	@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
	public String index(Model model) {
		String hasQuartz = env.getProperty("hasQuartz");
		model.addAttribute("hasQuartz", hasQuartz);
		return "/moudles/quartz/schedule_task";
	}

	/**
	 * 定时任务列表
	 */
	@PreAuthorize("hasAuthority('sys:schedule:show')")
	@RequestMapping("/list")
	@ResponseBody
//	@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
	public PageEU<Map<String, Object>> list(@RequestParam(value = "beanName", required = false) String beanName,
			@RequestParam(value = "status", required = false) String status, HttpServletRequest request) {
		Page<Map<String, Object>> page = pageQuery(request);
		StringBuilder queryStr = new StringBuilder(
				"select s.*,q.START_TIME,q.PREV_FIRE_TIME,q.NEXT_FIRE_TIME,q.TRIGGER_TYPE from schedule_task s ")
						.append(" left join qrtz_triggers q ").append(" on 'TASK_'||s.uuid = q.TRIGGER_NAME")
						.append(" where 1=1 ");

		if (StringUtils.isNotEmpty(beanName)) {
			queryStr.append(" and s.bean_name like '%" + beanName + "%'");
		}
		if (StringUtils.isNotEmpty(status)) {
			queryStr.append(" and s.status = '" + status + "'");
		}
//		queryStr.append(" order by create_date desc");
		Page<Map<String, Object>> scheduleTaskPage = simpleDao.listNativeByPage(queryStr.toString(), page);
		for(Map<String, Object> data:scheduleTaskPage.getResult()){
            for(String key:data.keySet()){
                if(data.get(key) instanceof Clob){
                    Clob clob  = (Clob) data.get(key);
                    try {
                        data.put(key, clob.getSubString((long)1,(int)clob.length()));
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
		return new PageEU<>(scheduleTaskPage);
	}

	/**
	 * 定时任务信息
	 */
	@PreAuthorize("hasAuthority('user')")
	@RequestMapping("/info/{jobId}")
	@ResponseBody
	public R info(@PathVariable("jobId") String jobId) {
		ScheduleTask schedule;
		try {
			schedule = scheduleTaskService.getById(jobId);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok().put("schedule", schedule);
	}

	/**
	 * 保存定时任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:save')")
	@RequestMapping("/saveTask")
	@ResponseBody
	public R saveTask(ScheduleTask scheduleJob) {
		try {
			scheduleTaskService.save(scheduleJob);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 修改定时任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:edit')")
	@RequestMapping("/updateTask")
	@ResponseBody
	public R updateTask(ScheduleTask scheduleJob) {
		try {
			scheduleTaskService.update(scheduleJob);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}

	/**
	 * 删除定时任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:delete')")
	@RequestMapping("/removeTask")
	@ResponseBody
	public R removeTask(String jobId) {
		try {
			scheduleTaskService.delete(jobId);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}

		return R.ok();
	}

	/**
	 * 暂停定时任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:pause')")
	@RequestMapping("/pause")
	@ResponseBody
//	@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
	public R pause(String[] jobIds) {
		try {
			scheduleTaskService.pause(jobIds);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}

		return R.ok();
	}

	/**
	 * 恢复定时任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:resume')")
	@RequestMapping("/resume")
	@ResponseBody
//	@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
	public R resume(String[] jobIds) {
		try {
			scheduleTaskService.resume(jobIds);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}

		return R.ok();
	}

	/**
	 * 立即执行任务
	 */
	@PreAuthorize("hasAuthority('sys:schedule:runOne')")
	@RequestMapping("/runOnce")
	@ResponseBody
//	@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
	public R runOnce(String[] jobIds) {
		try {
			scheduleTaskService.run(jobIds);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}

		return R.ok();
	}
}
