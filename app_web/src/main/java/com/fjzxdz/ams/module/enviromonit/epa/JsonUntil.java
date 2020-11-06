package com.fjzxdz.ams.module.enviromonit.epa;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
/**
 * @author LK 
 */
@Service
public class JsonUntil {
/**
   * 读取本地json文件，获取json格式字符串
   * @return
   */
 
	
  public  String getJsonString(String fileName){
	ClassLoader classLoader = JsonUntil.class.getClassLoader();
	URL resource = classLoader.getResource("airData/"+fileName);
	String path = resource.getPath();
    File file = new File(path);
    try {
	      FileReader fileReader = new FileReader(file);
	      Reader reader = new InputStreamReader(new FileInputStream(file),"utf-8");
	      int ch = 0;
	      StringBuffer sb = new StringBuffer();
	      while ((ch = reader.read()) != -1) {
	        sb.append((char) ch);
	      }
	      fileReader.close();
	      reader.close();
	      String jsonString = sb.toString();
	      return jsonString;
    } catch (IOException e) {
    	e.printStackTrace();
    	return null;
    }
  }
}
 