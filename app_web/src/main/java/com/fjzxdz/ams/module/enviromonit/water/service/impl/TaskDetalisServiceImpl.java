package com.fjzxdz.ams.module.enviromonit.water.service.impl;


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;
import com.fjzxdz.ams.module.enviromonit.water.dao.TaskDetalisDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.TaskDetalis;
import com.fjzxdz.ams.module.enviromonit.water.param.TaskDetalisParam;
import com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 水环境-应急短信下发-派发任务明细列表
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:11:37
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TaskDetalisServiceImpl implements TaskDetalisService {

    @Autowired
    private TaskDetalisDao taskDetalisDao;

    /**
     * <p>Title: listByPage</p>
     * <p>Description: 水环境-应急短信下发-派发任务明细列表</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService#listByPage(com.fjzxdz.ams.module.enviromonit.water.param.TaskDetalisParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<TaskDetalis> listByPage(TaskDetalisParam param, Page<TaskDetalis> page) {
        Page<TaskDetalis> detailedAssignmentsPage = taskDetalisDao.listByPage(param, page);
        return detailedAssignmentsPage;
    }

    /**
     * <p>Title: getInfoById</p>
     * <p>Description: 水环境-应急短信下发-派发任务明细列表-查看明细</p>
     *
     * @param id
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService#getInfoById(java.lang.String)
     */
    @Override
    public TaskDetalis getInfoById(String id) {
        TaskDetalis taskDetalis = taskDetalisDao.getById(id);

        return taskDetalis;
    }

    /**
     * <p>Title: save</p>
     * <p>Description: 水环境-应急短信下发-水质问题整改任务派发-保存任务  </p>
     *
     * @param taskDetalis
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService#save(com.fjzxdz.ams.module.enviromonit.water.entity.TaskDetalis)
     */
    @Override
    public R save(TaskDetalis taskDetalis) {
        // TODO Auto-generated method stub
        taskDetalis.setUuid(null);
        taskDetalisDao.save(taskDetalis);
        return R.ok();
    }

}
