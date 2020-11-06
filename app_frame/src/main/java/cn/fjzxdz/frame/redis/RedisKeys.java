package cn.fjzxdz.frame.redis;

/**
 * Redis所有Keys
 *
 * @author liuyankun
 */
public class RedisKeys {

    public static String getSessionKey(String key) {
        return "sessionid:" + key;
    }
}
