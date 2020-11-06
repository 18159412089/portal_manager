package cn.fjzxdz.frame.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.JobDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.JobParam;
import cn.fjzxdz.frame.service.sys.JobService;

@Service
@Transactional(rollbackFor=Exception.class)
public class JobServiceImpl implements JobService {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(JobServiceImpl.class);

	@Autowired
	private JobDao jobDao;
	@Autowired
	private SimpleDao simpleDao;

	@Override
	@CacheEvict(value = { "deptUserTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
	public void save(Job job) {
		jobDao.save(job);
	}

	@Override
	public Job getById(String uuid) {
		return jobDao.getById(uuid);
	}

	@Override
	public Page<Job> listByPage(JobParam param, Page<Job> page) {
		return jobDao.listByPage(param, page);
	}

	/**
	 * 部门集合下的岗位
	 *
	 * @param depts
	 * @return
	 */
	public List<Job> selectDeptAllJobs(List<Dept> depts) {
		List<Job> allJob = new ArrayList<>();
		for (Dept dept : depts) {
			List<Job> temp = simpleDao.find("from Job d where d.dept.uuid=? order by d.seq asc", dept.getUuid());
			allJob.addAll(temp);
		}
		return allJob;
	}

	public List<Job> list(StringBuilder deptUuid) {
		return jobDao.selectListNative("select * from sys_job where dept in (" + deptUuid + ")");
	}

}
