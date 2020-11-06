package cn.fjzxdz.frame.toolbox.util;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.persistence.Transient;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public final class ModelDataUtil {
    private static final Logger LOG = LogManager.getLogger(ModelDataUtil.class);

    private ModelDataUtil() {
    }

    public static Map<String, Object> createModelData(Object obj) {
        Map<String, Object> newMap = new HashMap<String, Object>();
        if (obj == null) {
            return newMap;
        }
        try {
            convertToMap("", obj, newMap);
        } catch (Exception e) {
        }
        if (newMap.containsKey("class")) {
            newMap.remove("class");
        }
        return newMap;
    }

    private static Map<String, Object> convertToMap(String fieldName, Object obj, Map<String, Object> hashMap) {
        Field[] fields = ReflectionUtils.getAllFields(obj);
        for (Field field : fields) {
            try {
                if (!isSpecialField(field, obj)) {
                    Object subObj = ReflectionUtils.getFieldValue(obj, field);
                    if (!isValidFieldValue(subObj)) {
                        continue;
                    }
                    if (!(subObj instanceof Collection<?>)) {
                        if ((field.getType().getName().startsWith("cn.fjzxdz.frame.entity") || field.getType().getName().startsWith("com.fjzxdz.ams")) && field.getType().isAssignableFrom(Enum.class)) {
                            convertToMap(parseFiledName(fieldName, field.getName()), subObj, hashMap);
                        } else {
                            hashMap.put(parseFiledName(fieldName, field.getName()), subObj);
                        }
                    }
                }
            } catch (Exception e) {
                LOG.info(e.getMessage());
            }
        }
        return hashMap;
    }

    private static boolean isValidFieldValue(Object subObj) {
        if (subObj == null) {
            return false;
        }
        if ((subObj instanceof String) && StringUtils.isBlank((String) subObj)) {
            return false;
        }
        return true;
    }

    private static boolean isSpecialField(Field field, Object obj) {
        if (field.isAnnotationPresent(Transient.class)) {
            return true;
        }
        try {
            PropertyUtils.getProperty(obj, field.getName());
        } catch (Exception e) {
            return true;
        }
        return false;
    }

    /**
     * Parses the filed name.
     *
     * @param parentFiled the parent filed
     * @param fieldName   the method name
     * @return the string
     */
    private static String parseFiledName(String parentFiled, String fieldName) {
        if (parentFiled != null && parentFiled != "") {
            fieldName = parentFiled + "." + fieldName;
        }
        return fieldName;
    }
}
