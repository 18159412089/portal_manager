package com.fjzxdz.ams.module.deployball.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
/**
 * 读取配置文件内容
 */
public class DemoUtil {
	
		public static String USERNAME ="username";
		public static String PASSWORD ="password";
		public static String CASIPPORT="cas_ip_port";
		public static String VASIPPORT="vas_Ip_port";
		public static String VMSIPPORT="vms_Ip_port";
		public static String INNERIP="inner_ip";
		public static String INNERCASIPPORT="inner_cas_ip_port";
		public static String INNERVASIPPORT="inner_vas_Ip_port";
		public static String INNERVMSIPPORT="inner_vms_Ip_port";
		
	
	    // 方法二：通过类加载目录getClassLoader()加载属性文件   
	    public static String getPropertyByName(String name) {  
	       String result = "";  
	       // 方法二：通过类加载目录getClassLoader()加载属性文件   
	       InputStream in = DemoUtil.class.getClassLoader().getResourceAsStream("hikdemo.properties");  

	        Properties prop = new Properties();  
	        try {  
	            prop.load(in);  
	            result = prop.getProperty(name).trim();  
           
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	        	return result;  
	    } 
	    
	    
//	    public static void main(String...args){
//	    	System.out.println(DemoUtil.getPropertyByName(DemoUtil.USERNAME));
//	    }
	  
	}


