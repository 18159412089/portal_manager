package com.fjzxdz.ams;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.github.wenhao.jpa.Sorts;
import com.github.wenhao.jpa.Specifications;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.repository.UserRepository;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class UserTest {

	@Autowired
	private UserDao userDao;
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private UserRepository userRepository;

	@SuppressWarnings("deprecation")
	@Test
	@Transactional
	public void test1() {
		List<User> userList = userRepository.findAll();
		System.out.println("===========" + userList.size());
		Specification<User> specification = Specifications.<User>and().eq(true, "loginname", "lhn", "lhn1")
				.predicate(Specifications.or().eq("loginname", "lhn").eq("loginname", "lhn1").build()).build();
		Sort sort = Sorts.builder().desc("uuid").asc("loginname").build();
		Page<User> findPage = userRepository.findAll(specification, new PageRequest(0, 15, sort));
		System.out.println("=========" + findPage.getTotalPages());
		List<User> list = findPage.getContent();
		System.out.println("=========" + list.size());

	}
}
