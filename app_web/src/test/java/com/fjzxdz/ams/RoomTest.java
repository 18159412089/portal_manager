package com.fjzxdz.ams;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.DeptDao;
import cn.fjzxdz.frame.entity.core.Dept;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class RoomTest {

	@Autowired
	private SimpleDao simpleDao;
	
	@Test
	@Transactional
	public void test() {
		List list = simpleDao.find("from InterrogateRoom");
		 System.out.println("========"+list.size());
		
//		Dept dept = new Dept();
//		dept.setName("test");
//		Set<Job> jobs = new HashSet<Job>();
//		Job job = new Job();
//		job.setName("test");
//		job.setSeq("1");
//		job.setDept(dept);
//		jobs.add(job);
//		dept.setJobs(jobs);
//		deptDao.save(dept);
//		System.out.println("222");
	}
}
