package com.fjzxdz.ams.common.generate.utils;

import java.io.BufferedReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.sql.Clob;

public class StringUtils extends org.apache.commons.lang3.StringUtils {
	
    private static final String CHARSET_NAME = "UTF-8";
    
    /**
     * 转换为字节数组
     * @param str
     * @return
     */
    public static String toString(byte[] bytes){
    	try {
			return new String(bytes, CHARSET_NAME);
		} catch (UnsupportedEncodingException e) {
			return EMPTY;
		}
    }

    /**
     * 转换为字节数组
     * @param str
     * @return
     */
    public static byte[] getBytes(String str){
    	if (str != null){
    		try {
				return str.getBytes(CHARSET_NAME);
			} catch (UnsupportedEncodingException e) {
				return null;
			}
    	}else{
    		return null;
    	}
    }
    /**
     * 判断字符串是否为空
     * @param str 对象串
     */
    public static boolean isNull(String str){
    	return str == null || "".equals(str);
    }
    
    /**
     * null类型转string
     * @param str 对象串
     */
	public static String nullToString(Object str) {
		if (str == null || str.equals(null) || str.equals("")) {
			return "";
		}
		return str.toString();
	}
    
    /**
     * 生成6位随机数
     */
    public static String genRandom() {
        String a = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        char[] rands = new char[6]; 
        for (int i = 0; i < rands.length; i++) 
        { 
            int rand = (int) (Math.random() * a.length()); 
            rands[i] = a.charAt(rand); 
        } 
        String temp = "";
        for(int i=0;i<rands.length;i++){
        	temp += rands[i];
        }
        
        return temp;
    }
    
    /**
     * CLOB转String
     */
    public static String ClobToString(Clob clob) {
		if (null == clob) {
			return "";
		}
		String reString = "";
		try {
			Reader is = clob.getCharacterStream();// 得到流 
			BufferedReader br = new BufferedReader(is);
			String s = br.readLine();
			StringBuffer sb = new StringBuffer();
			while (s != null) {// 执行循环将字符串全部取出付值给 StringBuffer由StringBuffer转成STRING 
				sb.append(s);
				s = br.readLine();
			}
			reString = sb.toString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return reString;
	}
}
