package cn.fjzxdz.frame.license.utils;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.JSONObject;

public class CommonUtils {

	/**
	 * 把整个字符串数组的值，赋值给字符串变量
	 * 
	 * @return sb.toString();
	 * **/
	public static String getArr2Str(String[] s) {
		StringBuilder sb = new StringBuilder();

		if (s != null)
			for (int i = 0; i < s.length; i++) {
				sb.append(s[i]);
			}

		return sb.toString();
	}

	/**
	 * list转换成字符串数组
	 * 
	 * @return 字符串数组
	 * **/
	public static String[] list2str(List list) {
		if (list.size() < 1) {
			return null;
		}
		String[] newData = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {

			newData[i] = (String) list.get(i);
		}
		return newData;
	}

	/**
	 * 16进制字符串转换成字节数组
	 * 
	 * @return bytes
	 * **/
	public static byte[] hexToBytes(String hexString) {
		if (hexString == null || hexString.equals("")) {
			return null;
		} else {
			hexString = hexString.toLowerCase();
		}
		int length = hexString.length() / 2;
		char[] hexChars = hexString.toCharArray();
		byte[] bytes = new byte[length];
		String hexDigits = "0123456789abcdef";
		for (int i = 0; i < length; i++) {
			int pos = i * 2; // 两个字符对应一个byte
			int h = hexDigits.indexOf(hexChars[pos]) << 4; // 注1
			int l = hexDigits.indexOf(hexChars[pos + 1]); // 注2
			if (h == -1 || l == -1) { // 非16进制字符
				return null;
			}
			bytes[i] = (byte) (h | l);
		}
		return bytes;
	}

	/**
	 * 字节数组转换成16进制字符串
	 * 
	 * @return string
	 * **/
	public static String bytesToHexString(byte[] src) {
		StringBuilder stringBuilder = new StringBuilder("");
		if (src == null || src.length <= 0) {
			return null;
		}
		for (int i = 0; i < src.length; i++) {
			int v = src[i] & 0xFF;
			String hv = Integer.toHexString(v);
			if (hv.length() < 2) {
				stringBuilder.append(0);
			}
			stringBuilder.append(hv);
		}
		return stringBuilder.toString();
	}

	/**
	 * 将字节数组转换成16进制数据形式打印到控制台
	 * **/
	public static void printHexString(byte[] b) {
		for (int i = 0; i < b.length; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
		}

	}

	public static String toUpperCaseFirst(String s) {
		if (Character.isUpperCase(s.charAt(0)))
			return s;
		else
			return (new StringBuilder())
					.append(Character.toUpperCase(s.charAt(0)))
					.append(s.substring(1)).toString();
	}
	
	public static boolean isInteger(String str){
		Pattern p = Pattern.compile("^[-\\+]?[\\d]*$");
		return p.matcher(str).matches();
	}
	
	public static boolean isDouble(String str){
	    Pattern pattern = Pattern.compile("[0-9]+.+[0-9]+");
	    return pattern.matcher(str).matches();   
	}
	
	public static boolean isNumeric(String str){
	    Pattern pattern = Pattern.compile("[0-9]*");
	    return pattern.matcher(str).matches();   
	}
	
	public static Timestamp parseTimestamp(String dataTimeStr){
		Date result = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		try {
			result = sdf.parse(dataTimeStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new Timestamp(result.getTime());
	}
	
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
	
	public static JSONObject deepMerge(JSONObject source, JSONObject target) throws JSONException {

        
        if (null != target) {//obj2已有json数据
            Iterator<String> sIterator = target.keys();
            while (sIterator.hasNext()) {
                // 获得key
                String key = sIterator.next();
                // 根据key获得value, value也可以是JSONObject,JSONArray,使用对应的参数接收即可
                String value = target.getString(key);
                source.put(key, value);
            }
            //此时obj1中已经包含了自己本身和obj2的所有数据
        }
	    return source;
	}
	
	public final static void main(String[] args){
		try {
			System.out.println(new JSONObject("{caption:\"化学需氧量（CODcr）(mg/l)\",width:100}"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
