package cn.fjzxdz.frame.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.exceptions.JedisException;

import java.util.*;

/**
 * Jedis Cache 工具类
 * @author gsq
 * @version 2019-10-23
 */
public class JedisUtils {
	private static Log logger = LogFactory.getLog(JedisUtils.class);
	private static JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
	private static JedisPool jedisPool = null;
	private static int index = 0;
	
	public static void init(String address,int index,int port){
		jedisPool = new JedisPool(jedisPoolConfig,address,port);
		JedisUtils.index=index;
	}

	/**
	 * 获取资源
	 * @return
	 * @throws JedisException
	 */
	public static Jedis getResource() throws JedisException {
		Jedis jedis = null;
		try {
			jedis = jedisPool.getResource();
			jedis.select(index);
		} catch (JedisException e) {
			logger.warn("getResource.", e);
			returnBrokenResource(jedis);
			throw e;
		}
		return jedis;
	}

	/**
	 * 归还资源
	 * @param jedis
	 */
	public static void returnBrokenResource(Jedis jedis) {
		if (jedis != null) {
			jedisPool.returnBrokenResource(jedis);
		}
	}

	/**
	 * 批量删删除缓存
	 * @param key 键  前后模糊查询用*
	 * @return
	 */
	public static long batchDel(String key) {
		long result = 0;
		Jedis jedis = null;
		try {
			jedis = getResource();
			Set<String> set = jedis.keys(key);
			Iterator<String> it = set.iterator();
			while (it.hasNext()) {
				String keyStr = it.next();
				if (jedis.exists(keyStr)){
					result += jedis.del(keyStr);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			returnResource(jedis);
		}
		return result;
	}

	/**
	 * 释放资源
	 * @param jedis
	 */
	public static void returnResource(Jedis jedis) {
		if (jedis != null) {
			jedisPool.returnResource(jedis);
		}
	}

}

