package com.fjzxdz.ams.common;

public class EnumUtil {

	public static<T extends EnumMessage> T getByKey(String key, Class<T> tClass){
        for(T each:tClass.getEnumConstants()){
            if(key.equals(each.getKey())){
                return each;
            }
        }
        return null;
    }
}
