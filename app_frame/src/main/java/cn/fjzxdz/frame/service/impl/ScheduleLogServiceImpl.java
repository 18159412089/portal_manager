package cn.fjzxdz.frame.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.quartz.ScheduleLogDao;
import cn.fjzxdz.frame.entity.quartz.ScheduleLog;
import cn.fjzxdz.frame.entity.quartz.ScheduleLogParam;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.ScheduleLogService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 定时任务日志
 *
 * @author liuyankun
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class ScheduleLogServiceImpl implements ScheduleLogService {

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(ScheduleLogServiceImpl.class);

    @Autowired
    private ScheduleLogDao scheduleLogDao;


    @Override
    public R save(ScheduleLog scheduleLog) {
        scheduleLogDao.save(scheduleLog);
        return R.ok();
    }

    @Override
    public void delete(String id) {
        scheduleLogDao.deleteById(id);
    }

    @Override
    public ScheduleLog getById(String uuid) {
        return scheduleLogDao.getById(uuid);
    }

    @Override
    public Page<ScheduleLog> listByPage(ScheduleLogParam param, Page<ScheduleLog> page) {
        return scheduleLogDao.listByPage(param, page);
    }
}
