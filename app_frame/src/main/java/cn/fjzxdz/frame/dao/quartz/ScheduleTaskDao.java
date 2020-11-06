package cn.fjzxdz.frame.dao.quartz;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.quartz.ScheduleTask;

import org.springframework.stereotype.Repository;

@Repository("scheduleTaskDao")
public class ScheduleTaskDao extends PagingDaoSupport<ScheduleTask> {
}