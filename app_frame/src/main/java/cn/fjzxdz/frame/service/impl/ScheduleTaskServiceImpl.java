package cn.fjzxdz.frame.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.constant.ScheduleStatus;
import cn.fjzxdz.frame.dao.quartz.ScheduleTaskDao;
import cn.fjzxdz.frame.entity.quartz.ScheduleTask;
import cn.fjzxdz.frame.entity.quartz.ScheduleTaskParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.quartz.util.ScheduleUtils;
import cn.fjzxdz.frame.service.ScheduleTaskService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * 定时任务
 *
 * @author liuyankun
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class ScheduleTaskServiceImpl implements ScheduleTaskService {

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ScheduleTaskServiceImpl.class);

    @Autowired
    private ScheduleTaskDao scheduleTaskDao;
    @Autowired
    private Scheduler scheduler;
    @Autowired
    private Environment env;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init() {
    	String hasQuartz = env.getProperty("hasQuartz");
    	if ("Y".equals(hasQuartz)) {
    		List<ScheduleTask> scheduleJobList = scheduleTaskDao.selectListAll();
    		for (ScheduleTask scheduleJob : scheduleJobList) {
    			CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, scheduleJob.getUuid());
    			//如果不存在，则创建
    			if (cronTrigger == null) {
    				ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
    			} else {
    				ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
    			}
    		}
		}
    }

    @Override
    public R save(ScheduleTask scheduleTask) {
        scheduleTask.setUuid(null);
        scheduleTask.setStatus(ScheduleStatus.NORMAL.getValue());
        scheduleTaskDao.save(scheduleTask);

        ScheduleUtils.createScheduleJob(scheduler, scheduleTask);
        return R.ok();
    }

    @Override
    public R update(ScheduleTask scheduleTask) {
        ScheduleTask task = scheduleTaskDao.getById(scheduleTask.getUuid());
        task.setBeanName(scheduleTask.getBeanName());
        task.setMethodName(scheduleTask.getMethodName());
        task.setParams(scheduleTask.getParams());
        task.setCronExpression(scheduleTask.getCronExpression());
        task.setStatus(scheduleTask.getStatus());
        task.setRemark(scheduleTask.getRemark());
        scheduleTaskDao.update(task);
        return R.ok();
    }

    @Override
    public void delete(String id) {
        scheduleTaskDao.deleteById(id);
    }

    @Override
    public ScheduleTask getById(String uuid) {
        return scheduleTaskDao.getById(uuid);
    }

    @Override
    public Page<ScheduleTask> listByPage(ScheduleTaskParam param, Page<ScheduleTask> page) {
        return scheduleTaskDao.listByPage(param, page);
    }

    @Override
    public int updateBatch(String[] jobIds, int status) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < jobIds.length; i++) {
            sb.append("'").append(jobIds[i]).append("'").append(",");
        }

        return scheduleTaskDao
                .createNativeQuery("update schedule_task set status=" + status + " where uuid in(" + ToolUtil.removeSuffix(sb.toString(), ",") + ")")
                .executeUpdate();
    }

    @Override
    public void run(String[] jobIds) {
        for (String jobId : jobIds) {
            ScheduleUtils.run(scheduler, scheduleTaskDao.getById(jobId));
        }
    }

    @Override
    public void pause(String[] jobIds) {
        for (String jobId : jobIds) {
            ScheduleUtils.pauseJob(scheduler, jobId);
        }

        updateBatch(jobIds, ScheduleStatus.PAUSE.getValue());
    }

    @Override
    public void resume(String[] jobIds) {
        for (String jobId : jobIds) {
            ScheduleUtils.resumeJob(scheduler, jobId);
        }

        updateBatch(jobIds, ScheduleStatus.NORMAL.getValue());
    }
}
