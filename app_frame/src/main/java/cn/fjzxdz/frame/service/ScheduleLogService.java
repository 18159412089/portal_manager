package cn.fjzxdz.frame.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.quartz.ScheduleLog;
import cn.fjzxdz.frame.entity.quartz.ScheduleLogParam;
import cn.fjzxdz.frame.pojo.R;

/**
 * 定时任务日志
 *
 * @author liuyankun
 */
public interface ScheduleLogService {

    R save(ScheduleLog scheduleLog);

    void delete(String id);

    ScheduleLog getById(String uuid);

    Page<ScheduleLog> listByPage(ScheduleLogParam param, Page<ScheduleLog> page);
}
