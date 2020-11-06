package com.fjzxdz.ams;

import java.util.HashSet;
import java.util.Set;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.dao.sys.MenuDao;
import cn.fjzxdz.frame.entity.core.Menu;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class MenuTest {

	@Autowired
	private MenuDao menuDao;
	
	@Test
	@Transactional
	public void test() {
		Set<Menu> menus=new HashSet<Menu>();
		Menu menu = new Menu();
		menu.setName("test");
		Menu child = new Menu();
		child.setName("testchild");
		menus.add(child);
		menu.setChildren(menus);
		menuDao.save(menu);
		
		
		
		System.out.println(menus.size());
	}
}
