package com.fjzxdz.ams;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.entity.core.UserParam;
import cn.fjzxdz.frame.service.sys.UserService;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class PageTest {
	@Autowired
	private UserService userService;

	@Test
	@Transactional
	public void contextLoads() {
		UserParam param = new UserParam();
		param.setLoginname("admin");
		Page<User> page = new Page<User>();
		userService.listByPage(param, page);
		System.out.println("========="+page.getResult().size());
	}

}
