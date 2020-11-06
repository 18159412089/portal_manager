package com.fjzxdz.ams;


import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.JobDao;
import cn.fjzxdz.frame.dao.sys.RoleDao;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.Role;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class JobTest {

	@Autowired
	private SimpleDao simpleDao;	
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private JobDao jobDao;
	
	
	@Test
	@Transactional
	public void test2() {
//		Job job=new Job();
//		Role role = roleDao.getById("1bc5b77f-5299-4ed3-894e-7ee7a5b58fcc");
//		List<Role> roles = new ArrayList<Role>();
//		roles.add(role);
		
		Job job = jobDao.getById("789453d7-18ab-449b-824e-7c90b9944fa5");
//		job.setRoles(roles);
		simpleDao.delete(job);
		
	}
}
