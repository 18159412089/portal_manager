package com.fjzxdz.ams;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.repository.UserRepository;
import com.github.wenhao.jpa.Sorts;
import com.github.wenhao.jpa.Specifications;
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

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest
//@Rollback(true)
public class AddQXTest {

	@Autowired
	private SimpleDao simpleDao;

	@SuppressWarnings("deprecation")
	@Test
	@Transactional(rollbackOn = Exception.class)
	public void test1() {
		List<Map<String, Object>> list = simpleDao.getNativeQueryList("select long_value lng, lat_value lat from PE_ENTERPRISE_DATA");
		for (Map map: list){
			String lng = (String) map.get("lng");
			String lat = (String) map.get("lat");
		}

	}
}
