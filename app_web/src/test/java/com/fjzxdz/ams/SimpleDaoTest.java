package com.fjzxdz.ams;

import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class SimpleDaoTest {
	@Autowired
	private SimpleDao simpleDao;

	// @SuppressWarnings("rawtypes")
	// @Test
	// @Transactional
	// public void contextLoads() {
	// List<User> us = simpleDao.find("from User u where u.loginname=?","admin");
	// System.out.println("========"+us.size());
	// List list = simpleDao.createNativeQuery("select name from user where
	// loginname=?","admin").getResultList();
	// System.out.println("========"+list.size());
	// System.out.println("========="+list.get(0).toString());
	//
	// User u = new User();
	// u.setLoginname("fffffffffff");
	// u.setName("aaaaaaa");
	// u.setPassword("dddddddddddd");
	// simpleDao.add(u);
	//
	// }

	@Test
	public void listNativeByPage() {
		// Page<User> page = pageQuery(request);
		Page<Map<String, Object>> page = new Page<>();
		System.out.println("========");
		Page<Map<String, Object>> maPage = simpleDao
				.listNativeByPage("select r.name as roleName,m.* from sys_role r" + " inner join sys_role_menu rm "
						+ " on r.uuid = rm.role" + " inner join sys_menu m" + " on m.uuid = rm.menu", page);
		System.out.println("========" + maPage.getCurrentPage());

	}

}
