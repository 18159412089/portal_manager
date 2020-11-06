
package cn.fjzxdz.frame.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回数据
 */
public class R extends HashMap<String, Object> {
    private static final long serialVersionUID = 1L;

    public R() {
        put("type", "S");
        put("message", "success");
    }

    public static R error(String message) {
        R r = new R();
        r.put("type", "E");
        r.put("message", message);
        return r;
    }
    /**
     * 往控制台打堆栈错误
     * @param e
     * @return
     */
    public static R error(Exception e) {
        e.printStackTrace();
        R r = new R();
        r.put("type", "E");
        r.put("message", e.getMessage());
        return r;
    }

    public static R ok(String message) {
        R r = new R();
        r.put("message", message);
        return r;
    }

    public static R ok(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }

    public static R ok() {
        return new R();
    }

    @Override
    public R put(String key, Object value) {
        super.put(key, value);
        return this;
    }
}
