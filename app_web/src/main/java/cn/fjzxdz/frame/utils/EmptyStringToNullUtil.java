package cn.fjzxdz.frame.utils;

import java.util.Map;

import cn.hutool.core.bean.BeanUtil;

/**
 * EmptyStringToNullUtil use Hutool 4.1.6
 *
 * @author fushixing
 * @time 2018-08-22
 */
public class EmptyStringToNullUtil {

    /**
     * Bean对象""字符串转null
     * @param bean
     * @return
     */
    public static Object emptyStringToNull(Object bean){
        Map<String, Object> objectMap = BeanUtil.beanToMap(bean);
        for (String key : objectMap.keySet()) {
            if (null == objectMap.get(key)||"".equals(String.valueOf(objectMap.get(key)))) {
                objectMap.put(key,null);
            }
        }
        return BeanUtil.mapToBean(objectMap,bean.getClass(),true);
    }
}
