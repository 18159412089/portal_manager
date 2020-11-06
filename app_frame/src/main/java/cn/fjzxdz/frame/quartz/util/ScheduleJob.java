package cn.fjzxdz.frame.quartz.util;


import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;

import cn.fjzxdz.frame.entity.quartz.ScheduleLog;
import cn.fjzxdz.frame.entity.quartz.ScheduleTask;
import cn.fjzxdz.frame.service.ScheduleLogService;
import cn.fjzxdz.frame.toolbox.kit.BeanKit;


/**
 * 定时任务
 *
 * @author liuyankun
 */
public class ScheduleJob extends QuartzJobBean {

    private Logger logger = LogManager.getLogger(getClass());
    private ExecutorService service = Executors.newSingleThreadExecutor();
    @Autowired
    private ScheduleLogService scheduleLogService;

    @Override
    protected void executeInternal(JobExecutionContext context) {

        ScheduleTask scheduleTask = null;
        try {
            Object object = context.getMergedJobDataMap().get(ScheduleTask.JOB_PARAM_KEY);
			Map<?, ?> map = BeanKit.beanToMap(object);
            scheduleTask = BeanKit.mapToBean(map, ScheduleTask.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //获取spring bean
//        ScheduleLogService scheduleLogService = SpringContextHolder.getBean("scheduleLogService");

        //数据库保存执行记录
        ScheduleLog log = new ScheduleLog();
        log.setJobId(scheduleTask.getUuid());
        log.setBeanName(scheduleTask.getBeanName());
        log.setMethodName(scheduleTask.getMethodName());
        log.setParams(scheduleTask.getParams());

        //任务开始时间
        long startTime = System.currentTimeMillis();

        try {
            //执行任务
            logger.info("任务准备执行，任务ID：" + scheduleTask.getUuid());
            ScheduleRunnable task = new ScheduleRunnable(scheduleTask.getBeanName(),
                    scheduleTask.getMethodName(), scheduleTask.getParams());
            Future<?> future = service.submit(task);

            future.get();

            //任务执行总时长
            long times = System.currentTimeMillis() - startTime;
            log.setTimes((int) times);
            //任务状态    0：成功    1：失败
            log.setStatus(0);

            logger.info("任务执行完毕，任务ID：" + scheduleTask.getUuid() + "  总共耗时：" + times + "毫秒");
        } catch (Exception e) {
            logger.error("任务执行失败，任务ID：" + scheduleTask.getUuid(), e);

            //任务执行总时长
            long times = System.currentTimeMillis() - startTime;
            log.setTimes((int) times);

            //任务状态    0：成功    1：失败
            log.setStatus(1);
            e.printStackTrace();
            log.setError(StringUtils.substring(e.toString(), 0, 2000));
        } finally {
            scheduleLogService.save(log);
        }
    }
}
