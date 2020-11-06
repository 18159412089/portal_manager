package cn.fjzxdz.frame.toolbox.support;

import cn.fjzxdz.frame.constant.Const;
import cn.fjzxdz.frame.toolbox.kit.BeanKit;
import cn.fjzxdz.frame.toolbox.kit.CollectionKit;
import cn.fjzxdz.frame.toolbox.kit.StrKit;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * javabean 、 paras映射
 *
 * @author zhuangqian
 */
public class BeanInjector {

    public static final <T> T inject(Class<T> beanClass, HttpServletRequest request) {
        try {
            return BeanKit.mapToBeanIgnoreCase(getParameterMap(request), beanClass);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static final <T> T inject(Class<T> beanClass, String prefix, HttpServletRequest request) {
        try {
            Map<String, Object> map = injectPara(prefix, request);
            return BeanKit.mapToBeanIgnoreCase(map, beanClass);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static final CMap injectMaps(HttpServletRequest request) {
        return CMap.parse(getParameterMap(request));
    }

    public static final CMap injectMaps(String prefix, HttpServletRequest request) {
        Map<String, Object> map = injectPara(prefix, request);
        return CMap.parse(map);
    }

    private static final Map<String, Object> injectPara(String prefix, HttpServletRequest request) {
        Map<String, String[]> paramMap = request.getParameterMap();
        Map<String, Object> map = new HashMap<>();
        String start = prefix.toLowerCase() + ".";
        String[] value = null;
        for (Entry<String, String[]> param : paramMap.entrySet()) {
            if (!param.getKey().toLowerCase().startsWith(start)) {
                continue;
            }
            value = param.getValue();
            Object o = null;
            if (CollectionKit.isNotEmpty(value)) {
                if (value.length > 1) {
                    o = CollectionKit.join(value, ",");
                } else {
                    o = value[0];
                }
            }
            map.put(StrKit.removePrefixIgnoreCase(param.getKey(), start).toLowerCase(), o);
        }
        String versionL = request.getParameter(Const.OPTIMISTIC_LOCK.toLowerCase());
        String versionU = request.getParameter(Const.OPTIMISTIC_LOCK);
        if (StrKit.notBlank(versionL)) {
            map.put(Const.OPTIMISTIC_LOCK.toLowerCase(), ToolUtil.toInt(versionL) + 1);
        } else if (StrKit.notBlank(versionU)) {
            map.put(Const.OPTIMISTIC_LOCK.toLowerCase(), ToolUtil.toInt(versionU) + 1);
        }
        return map;
    }

    private static final Map<String, Object> getParameterMap(HttpServletRequest request) {
        Map<String, String[]> paramMap = request.getParameterMap();
        Map<String, Object> map = new HashMap<>();
        String[] value = null;
        for (Entry<String, String[]> param : paramMap.entrySet()) {
            value = param.getValue();
            Object o = null;
            if (CollectionKit.isNotEmpty(value)) {
                if (value.length > 1) {
                    o = CollectionKit.join(value, ",");
                } else {
                    o = value[0];
                }
            }
            map.put(param.getKey(), o);
        }
        return map;
    }

}
