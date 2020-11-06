package com.fjzxdz.ams.util;

import java.lang.reflect.Method;

/**
 * @ClassName CommonUtils
 * @Description TODO
 * @Author ZhangGQ
 * @Date 2019/6/5 0005 下午 5:37
 * @Version 1.0
 */
public class CommonUtil {


    /**
     * 判断给定类中是否存在方法
     * @param methodName
     * @param clazz
     * @return
     */
    public final static boolean isExistMethod(String methodName, Class<?> clazz) {
        boolean result = false;
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            if(methodName.equals(method.getName())){
                result = true;
                break;
            }
        }
        return result;
    }

    public static String toUpperCaseFirst(String s) {
        if (Character.isUpperCase(s.charAt(0))){
            return s;
        }else{
            return (new StringBuilder())
                    .append(Character.toUpperCase(s.charAt(0)))
                    .append(s.substring(1)).toString();
        }
    }

    public static void main(String[] args){
        String name = "溶解氧(mg/l)";
    }
}
