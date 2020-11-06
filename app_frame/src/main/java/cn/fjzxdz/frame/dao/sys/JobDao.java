package cn.fjzxdz.frame.dao.sys;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.core.Job;

import org.springframework.stereotype.Repository;

@Repository("jobDao")
public class JobDao extends PagingDaoSupport<Job> {
}
