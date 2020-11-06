package com.fjzxdz.ams;


import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.redis.RedisUtils;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class RedisTest {

    @Autowired
    private RedisUtils redisUtils;

    @Test
    public void contextLoads() {
//        User user = new User();
//        user.setEmail("123456@qq.com");
//        redisUtils.set("test:user", user);
//
//        System.out.println(ToStringBuilder.reflectionToString(redisUtils.get("user", User.class)));
    	if(redisUtils.lock("test")) {
    		try {
				Thread.sleep(10000);
			} catch (Exception e) {
				// TODO: handle exception
			}finally {
				redisUtils.releaseLock("test");
			}
    		
    	}
    }

}
