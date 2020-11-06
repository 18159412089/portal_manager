package cn.fjzxdz.frame.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.quartz.ScheduleTask;
import cn.fjzxdz.frame.entity.quartz.ScheduleTaskParam;
import cn.fjzxdz.frame.pojo.R;

/**
 * 定时任务
 *
 * @author liuyankun
 */
public interface ScheduleTaskService {

    R save(ScheduleTask scheduleTask);

    R update(ScheduleTask scheduleTask);

    void delete(String id);

    ScheduleTask getById(String uuid);

    Page<ScheduleTask> listByPage(ScheduleTaskParam param, Page<ScheduleTask> page);

    /**
     * 批量更新定时任务状态
     */
    int updateBatch(String[] jobIds, int status);

    /**
     * 立即执行
     */
    void run(String[] jobIds);

    /**
     * 暂停运行
     */
    void pause(String[] jobIds);

    /**
     * 恢复运行
     */
    void resume(String[] jobIds);
}
