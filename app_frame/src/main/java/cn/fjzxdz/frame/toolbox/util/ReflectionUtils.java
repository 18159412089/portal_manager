package cn.fjzxdz.frame.toolbox.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * The Class ReflectionUtils.
 */
public final class ReflectionUtils {

    /**
     * The logger.
     */
    private static Logger logger = LogManager.getLogger(ReflectionUtils.class);

    /**
     * Instantiates a new reflection utils.
     */
    private ReflectionUtils() {
    }

    /**
     * Gets the field value.
     *
     * @param object    the object
     * @param fieldName the field name
     * @return the field value
     */
    public static Object getFieldValue(final Object object, final String fieldName) {

        Field field = getDeclaredField(object, fieldName);

        if (field == null) {
            throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + object + "]");
        }

        return getFieldValue(object, field);
    }

    public static Object getFieldValue(final Object object, Field field) {
        makeAccessible(field);

        Object result = null;
        try {
            result = field.get(object);
        } catch (IllegalAccessException e) {
            logger.error(e);
        }
        return result;
    }

    /**
     * Sets the field value.
     *
     * @param object    the object
     * @param fieldName the field name
     * @param value     the value
     */
    public static void setFieldValue(final Object object, final String fieldName, final Object value) {
        Field field = getDeclaredField(object, fieldName);

        if (field == null) {
            throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + object + "]");
        }

        makeAccessible(field);

        try {
            field.set(object, value);
        } catch (IllegalAccessException e) {
            logger.error(e);
        }
    }

    /**
     * Invoke method.
     *
     * @param object         the object
     * @param methodName     the method name
     * @param parameterTypes the parameter types
     * @param parameters     the parameters
     * @return the object
     * @throws InvocationTargetException the invocation target exception
     */
    public static Object invokeMethod(final Object object, final String methodName, final Class<?>[] parameterTypes, final Object[] parameters) throws InvocationTargetException {
        Method method = getDeclaredMethod(object, methodName, parameterTypes);
        if (method == null) {
            throw new IllegalArgumentException("Could not find method [" + methodName + "] on target [" + object + "]");
        }

        method.setAccessible(true);

        try {
            return method.invoke(object, parameters);
        } catch (IllegalAccessException e) {
            logger.error(e);
        }

        return null;
    }

    /**
     * Gets the declared field.
     *
     * @param object    the object
     * @param fieldName the field name
     * @return the declared field
     */
    protected static Field getDeclaredField(final Object object, final String fieldName) {
        for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
            try {
                return superClass.getDeclaredField(fieldName);
            } catch (NoSuchFieldException e) {
                logger.error(e.getMessage());
            }
        }
        return null;
    }

    /**
     * Make accessible.
     *
     * @param field the field
     */
    protected static void makeAccessible(final Field field) {
        if (!Modifier.isPublic(field.getModifiers()) || !Modifier.isPublic(field.getDeclaringClass().getModifiers())) {
            field.setAccessible(true);
        }
    }

    /**
     * Gets the declared method.
     *
     * @param object         the object
     * @param methodName     the method name
     * @param parameterTypes the parameter types
     * @return the declared method
     */
    protected static Method getDeclaredMethod(Object object, String methodName, Class<?>[] parameterTypes) {

        for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
            try {
                return superClass.getDeclaredMethod(methodName, parameterTypes);
            } catch (NoSuchMethodException e) {
                logger.error(e);
            }
        }
        return null;
    }

    /**
     * Gets the super class genric type.
     *
     * @param clazz the clazz
     * @param <T>   Generic Class
     * @return the super class genric type
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static <T> Class<T> getSuperClassGenricType(final Class clazz) {
        return getSuperClassGenricType(clazz, 0);
    }

    /**
     * Gets the super class genric type.
     *
     * @param clazz the clazz
     * @param index the index
     * @return the super class genric type
     */
    @SuppressWarnings("rawtypes")
    public static Class getSuperClassGenricType(final Class clazz, final int index) {

        Type genType = clazz.getGenericSuperclass();

        if (!(genType instanceof ParameterizedType)) {
            logger.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
            return Object.class;
        }

        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

        if (index >= params.length || index < 0) {
            logger.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: " + params.length);
            return Object.class;
        }
        if (!(params[index] instanceof Class)) {
            logger.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
            return Object.class;
        }

        return (Class) params[index];
    }

    /**
     * Fetch element property to list.
     *
     * @param collection   the collection
     * @param propertyName the property name
     * @return the list
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static List fetchElementPropertyToList(final Collection collection, final String propertyName) {
        List list = new ArrayList();

        try {
            for (Object obj : collection) {
                list.add(PropertyUtils.getProperty(obj, propertyName));
            }
        } catch (Exception e) {
            convertToUncheckedException(e);
        }

        return list;
    }

    /**
     * Fetch element property to string.
     *
     * @param collection   the collection
     * @param propertyName the property name
     * @param separator    the separator
     * @return the string
     */
    @SuppressWarnings({"rawtypes"})
    public static String fetchElementPropertyToString(final Collection collection, final String propertyName, final String separator) {
        List list = fetchElementPropertyToList(collection, propertyName);
        return StringUtils.join(list, separator);
    }

    /**
     * Convert value.
     *
     * @param value  the value
     * @param toType the to type
     * @return the object
     */
    public static Object convertValue(Object value, Class<?> toType) {
        try {
            DateConverter dc = new DateConverter();
            dc.setUseLocaleFormat(true);
            dc.setPatterns(new String[]{"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"});
            ConvertUtils.register(dc, Date.class);
            return ConvertUtils.convert((String) value, toType);
        } catch (Exception e) {
            throw convertToUncheckedException(e);
        }
    }

    /**
     * Convert to unchecked exception.
     *
     * @param e the e
     * @return the illegal argument exception
     */
    public static IllegalArgumentException convertToUncheckedException(Exception e) {
        if (e instanceof IllegalAccessException || e instanceof IllegalArgumentException || e instanceof NoSuchMethodException) {
            return new IllegalArgumentException("Refelction Exception.", e);
        } else {
            return new IllegalArgumentException(e);
        }
    }

    public static Object setNullBigDecimalToZero(Object obj) {
        Field[] declaredFields = obj.getClass().getDeclaredFields();
        for (Field field : declaredFields) {
            if (field.getType() == BigDecimal.class) {
                try {
                    field.setAccessible(true);
                    field.set(obj, BigDecimal.ZERO);
                    field.setAccessible(false);
                } catch (IllegalArgumentException e) {
                    logger.error(e);
                } catch (IllegalAccessException e) {
                    logger.error(e);
                }
            }
        }
        return obj;
    }

    public static <T> List<T> constructList(Class<T> entityClass, String cols, List<Object[]> list) {
        List<T> resultList = new ArrayList<T>();
        if (list.isEmpty()) {
            return resultList;
        }
        String[] fields = cols.split(",");
        for (Object[] objects : list) {
            try {
                T entity = entityClass.newInstance();
                int i = 0;
                for (String name : fields) {
                    if (name.contains(".")) {
                        name = name.split("\\.")[1].trim();
                    }
                    PropertyUtils.setProperty(entity, name.trim(), objects[i++]);
                }
                resultList.add(entity);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return resultList;
    }

    public static Field[] getAllFields(Object obj) {
        Class<?> cls = obj.getClass();
        List<Field> accum = new LinkedList<Field>();
        while (cls != null) {
            Field[] f = cls.getDeclaredFields();
            for (int i = 0; i < f.length; i++) {
                accum.add(f[i]);
            }
            cls = cls.getSuperclass();
        }
        return (Field[]) accum.toArray(new Field[accum.size()]);
    }

    public static Object createGenricTypeInstance(Class<?> clazz) {
        try {
            return ReflectionUtils.getSuperClassGenricType(clazz).getConstructor().newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void copyNotBlankProperties(Object dest, Object src) throws Exception {
        Map<String, Object> modelData = ModelDataUtil.createModelData(src);
        for (String field : modelData.keySet()) {
            PropertyUtils.setProperty(dest, field, modelData.get(field));
        }
    }
}
