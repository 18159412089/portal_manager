package cn.fjzxdz.frame.quartz.task;


import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.service.sys.UserService;

/**
 * 测试定时任务(演示Demo，可删除)
 * <p>
 * testTask为spring bean的名称
 */
@Component("testTask")
public class TestTask {

    private static Logger logger = LogManager.getLogger(TestTask.class);

    @Autowired
    private Environment env;
    @Autowired
    private UserService userService;


    @Transactional(rollbackOn=Exception.class)
    public void test(String params) {
        logger.info("我是带参数的test方法，正在被执行，参数为：" + params);

        try {
            Thread.sleep(1000L);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        User user = userService.getById("1bc5b77f-5299-4ed3-894e-7ee7a5b58fca");
        System.out.println(user.toString());

    }


    public void test2() {
    	String endpoint = env.getProperty("env.sync.endpoint");
        String url = env.getProperty("main.datasource.url");
        String user = env.getProperty("main.datasource.user");
        String pass = env.getProperty("main.datasource.password");
        logger.info("我是不带参数的test2方法，正在被执行");
    }
}
