package com.fjzxdz.ams.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import cn.fjzxdz.frame.redis.RedisUtils;
import cn.fjzxdz.frame.toolbox.web.SpringContextHolder;

public enum SerialNumber {
    SAMPLE("sample","yyyyMMdd",4,1450L),
    CINBOUND("RK","yyyyMMdd",4,1450L),//耗材入库单
    CWRITEOFF("CX","yyyyMMdd",4,1450L),//耗材冲销单
    CINVENTORYPROFIT("PY","yyyyMMdd",4,1450L),//耗材盘盈入库单
    COUTBOUND("CK","yyyyMMdd",4,1450L),//耗材出库单
    CBACKWAREHOURCE("TK","yyyyMMdd",4,1450L),//耗材退库单
    CINVENTORYLOSS("PK","yyyyMMdd",4,1450L),//耗材盘亏出库单
    CREQUISITIO("DB","yyyyMMdd",4,1450L),//耗材调拨单
    ARECEIVE("LY","yyyyMMdd",4,1450L),// 领用单号
    ABORROW("JY","yyyyMMdd",4,1450L),// 借用单号
    AALLOT("DB","yyyyMMdd",4,1450L),// 调拨单号
    AREPAIR("WX","yyyyMMdd",4,1450L),// 维修单号
	ASCRAP("BF","yyyyMMdd",4,1450L),  // 报废单号
    ;

    private String prefix;//前缀
    private String pattern;//日期格式
    private Integer length;//流水号长度
    private Long expire;//过期时间，单位是分钟

    private SerialNumber(String prefix,String pattern,Integer length,Long expire) {
        this.prefix = prefix;
        this.pattern = pattern;
        this.length = length;
        this.expire = expire;
    }

    public String getSerialNumber() {
    	RedisUtils redisUtils = (RedisUtils) SpringContextHolder.getBean("redisUtils");
    	SimpleDateFormat COMMON_FORMAT = new SimpleDateFormat(pattern);
    	String key = prefix+COMMON_FORMAT.format(new Date());
    	Long v = redisUtils.incr("serial:"+key, expire);
        return key+StringUtils.leftPad(String.valueOf(v), length, '0');
    }


}
