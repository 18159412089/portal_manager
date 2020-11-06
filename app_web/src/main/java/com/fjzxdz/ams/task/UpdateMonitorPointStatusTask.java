package com.fjzxdz.ams.task;

import cn.fjzxdz.frame.redis.RedisUtils;
import com.fjzxdz.ams.module.enviromonit.hourdata.service.PeConHourDataService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


import java.text.SimpleDateFormat;

@Component
@Configurable
@EnableScheduling
public class UpdateMonitorPointStatusTask {
    private static Logger logger = LogManager.getLogger(UpdateMonitorPointStatusTask.class);
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    @Autowired
    private PeConHourDataService peConHourDataService;
    @Autowired
    private RedisUtils redisUtils;

    @Value("${isOpenPointStatusScheduling}")
    private String isOpenPointStatusScheduling;

    //每15分钟执行一次      更新设备状态
    @Scheduled(cron = "0 */15 * * * ?")
    public void updateMonitorPointStatus() throws Exception {

        if("true".equals(isOpenPointStatusScheduling)) {
                 peConHourDataService.isOverPoint();
        }
    }



}
