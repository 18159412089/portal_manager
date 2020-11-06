package com.fjzxdz.ams.common.generate.utils;

import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionFactorService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * @author dai
 */
@Component
@Order(value = 1)
public class JedisInitializer implements CommandLineRunner {

    @Autowired
    private WtSectionFactorService wtSectionFactorService;
    @Autowired
    private WtSectionPointService wtSectionPointService;

    @Value("${spring.redis.host}")
    private String redisHost;

    @Value("${spring.redis.port}")
    private int redisPort;

    @Value("${spring.redis.database}")
    private int redisDb;

    public void init() {
        JedisUtils.init(redisHost, redisDb, redisPort);
        
        initRedisData();
    }

    private void initRedisData() {
        wtSectionFactorService.initRedisData();
        wtSectionPointService.initRedisData();
    }

    @Override
    public void run(String... args) throws Exception {
        init();
    }
}