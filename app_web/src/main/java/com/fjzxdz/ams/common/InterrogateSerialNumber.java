package com.fjzxdz.ams.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import cn.fjzxdz.frame.redis.RedisUtils;
import cn.fjzxdz.frame.toolbox.web.SpringContextHolder;

public enum InterrogateSerialNumber {
    ROOM("IR",6,null),//房间
    DEVICE("ID",6,null),//设备
    REGISTRATION("IR","yyyyMMdd",4,1450L),//进出区
    INQUESTINFO("III","yyyyMMdd",4,1450L),//审讯
    POSSESSION("IPOSS","yyyyMMdd",4,1450L)//物品清单
    ;

    private String prefix;//前缀
    private String pattern;//日期格式
    private Integer length;//流水号长度
    private Long expire;//过期时间，单位是分钟

    private InterrogateSerialNumber(String prefix,Integer length,Long expire) {
        this.prefix = prefix;
        this.length = length;
        this.expire = expire;
    }
    
    private InterrogateSerialNumber(String prefix,String pattern,Integer length,Long expire) {
        this.prefix = prefix;
        this.pattern = pattern;
        this.length = length;
        this.expire = expire;
    }

    public String getSerialDateNumber() {
    	RedisUtils redisUtils = (RedisUtils) SpringContextHolder.getBean("redisUtils");
    	SimpleDateFormat COMMON_FORMAT = new SimpleDateFormat(pattern);
    	String key = prefix+COMMON_FORMAT.format(new Date());
    	Long v = redisUtils.incr("serial:"+key, expire);
        return key+StringUtils.leftPad(String.valueOf(v), length, '0');
    }

    public String getSerialNumber() {
    	RedisUtils redisUtils = (RedisUtils) SpringContextHolder.getBean("redisUtils");
    	String key=prefix;
    	Long v = redisUtils.incr("serial:"+key, expire);
        return key+StringUtils.leftPad(String.valueOf(v), length, '0');
    }
}
