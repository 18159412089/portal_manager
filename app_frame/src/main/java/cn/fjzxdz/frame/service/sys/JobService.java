package cn.fjzxdz.frame.service.sys;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.JobParam;


public interface JobService {

    void save(Job job);

    Job getById(String uuid);

    Page<Job> listByPage(JobParam param, Page<Job> page);

}
