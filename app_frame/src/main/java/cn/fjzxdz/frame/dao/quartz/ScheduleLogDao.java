package cn.fjzxdz.frame.dao.quartz;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.quartz.ScheduleLog;

import org.springframework.stereotype.Repository;

@Repository("scheduleLogDao")
public class ScheduleLogDao extends PagingDaoSupport<ScheduleLog> {
}