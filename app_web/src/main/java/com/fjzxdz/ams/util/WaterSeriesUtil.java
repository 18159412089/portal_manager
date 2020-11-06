package com.fjzxdz.ams.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;

/**
 * 
 * echarts柱状图显示背景色的util
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午9:20:15
 */
public class WaterSeriesUtil {
	static String[] color= {"#d02032","#2ba4e9","#2ba4e9","#45b97c","#ffff00","#f47920","#d02032"};
	static String[] type = {"劣Ⅴ类","Ⅰ类","Ⅱ类","Ⅲ类","Ⅳ类","Ⅴ类","劣Ⅴ类"};
	/**
	 *  溶解氧
	 */
	static String[] W01009= {"1000","7.5","6","5","3","2","0"};
	/**
	 * 高锰酸盐指数
	 */
	static String[] W01019= {"0","2","4","6","10","15","1000"};
	/**
	 *  氨氮（NH3-N）
	 */
	static String[] W21003= {"0","0.15","0.5","1.0","1.5","2.0","1000"};
	/**
	 *  总磷（以P计）,非湖库
	 */
	static String[] W21011= {"0","0.02","0.1","0.2","0.3","0.4","1000"};
	
	/**
	 * 
	 * @Title:  getSeriesData
	 * @Description:   对xArray再次封装 ，加入阶梯背景色数据。
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:23:50
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:23:50    
	 * @param xArray
	 * @param str
	 * @return  Map<String,Object> 
	 * @throws
	 */
	public static Map<String,Object> getSeriesData(JSONArray xArray,String str) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object> legendBar = new ArrayList<Object>();
		Map<String,Object> numMap = new HashMap<String,Object>();
		numMap.put("W01009", W01009);
		numMap.put("W01019", W01019);
		numMap.put("W21003", W21003);
		numMap.put("W21011", W21011);
		BigDecimal max=new BigDecimal(0);
		BigDecimal min=new BigDecimal(1000);
		
		for(int j=0;j<xArray.size();j++) {
			JSONObject jsonObject=xArray.getJSONObject(j);
			Object[] object = (Object[]) jsonObject.get("data");
			for(int k=0;k<object.length-1;k++) {
				max=getMax(max,StringUtils.nullToString(object[k]));
				min=getMin(min,StringUtils.nullToString(object[k]));
			}
		}
	
		if(numMap.containsKey(str)) {
			String[] nums = (String[]) numMap.get(str);
			//溶解氧
			if("W01009".equals(str)) {
				Map<String, Object> levelData = getLevelNum2(max,min,nums);
				String[] levelList =(String[]) levelData.get("levelList");
				String[] typeList =(String[]) levelData.get("typeList");
				String[] colorList =(String[]) levelData.get("colorList");
				List<String> color=new ArrayList<String>();
				for(int i=levelList.length-1;i>0;i--) {
					JSONObject xObject = new JSONObject();
					xObject.put("name", typeList[i]);
					xObject.put("type", "line");
					xObject.put("animation", false);
					xObject.put("areaStyle", JSONObject.parse("{normal:{}}"));
					xObject.put("lineStyle", JSONObject.parse("{normal:{width:1}}"));
					xObject.put("markArea", JSONObject.parse("{itemStyle:{color:'"+colorList[i]+"'},data:[[{yAxis: '"+levelList[i]+"'},{yAxis: '"+levelList[i-1]+"'}]]}"));
					xArray.add(0,xObject);
					legendBar.add(0,JSONObject.parse("{name:'"+typeList[i]+"',icon : 'bar'}"));
					map.put("min", (String) levelData.get("min"));
					color.add(0,colorList[i]);
				}
				String[] backgroundColor=new String[color.size()];
				map.put("color", color.toArray(backgroundColor));
			}else {
				Map<String, Object> levelData = getLevelNum1(max,min,nums);
				String[] levelList =(String[]) levelData.get("levelList");
				String[] typeList =(String[]) levelData.get("typeList");
				String[] colorList =(String[]) levelData.get("colorList");
				List<String> color=new ArrayList<String>();
				for(int i=0;i<levelList.length-1;i++) {
					BigDecimal top = new BigDecimal(levelList[i].toString());
					BigDecimal next = new BigDecimal(levelList[i+1].toString());
					JSONObject xObject = new JSONObject();
					xObject.put("name", typeList[i+1]);
					xObject.put("type", "line");
					xObject.put("animation", false);
					xObject.put("areaStyle", JSONObject.parse("{normal:{}}"));
					xObject.put("lineStyle", JSONObject.parse("{normal:{width:1}}"));
					xObject.put("markArea", JSONObject.parse("{itemStyle:{color:'"+colorList[i+1]+"'},data:[[{yAxis: '"+top+"'},{yAxis: '"+next+"'}]]}"));
					xArray.add(0,xObject);
					legendBar.add(0,JSONObject.parse("{name:'"+typeList[i+1]+"',icon : 'bar'}"));
					map.put("min", (String) levelData.get("min"));
					color.add(0,colorList[i+1]);
				}
				String[] backgroundColor=new String[color.size()];
				map.put("color", color.toArray(backgroundColor));
			}
		}
		map.put("series", xArray);
		map.put("legendBar", legendBar);	
		return map;
	}
	
	/**
	 * 
	 * @Title:  getMax
	 * @Description:    比较，返回最大值
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:23:32
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:23:32    
	 * @param max
	 * @param value
	 * @return  BigDecimal 
	 * @throws
	 */
	public static BigDecimal getMax(BigDecimal max,String value){
		if(!"".equals(value)) {
			BigDecimal val=new BigDecimal(value);
			if(max.compareTo(val)==-1) {
				return val;
			}
		}
		return max;
	}
	
	/**
	 * 
	 * @Title:  getMin
	 * @Description:    比较，返回最小值 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:23:10
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:23:10    
	 * @param min
	 * @param value
	 * @return  BigDecimal 
	 * @throws
	 */
	public static BigDecimal getMin(BigDecimal min,String value){
		if(!"".equals(value)) {
			BigDecimal val=new BigDecimal(value);
			if(min.compareTo(val)==1) {
				return val;
			}
		}
		return min;
	}
	/**
	 * 
	 * @Title:  getLevelNum1
	 * @Description:    获取阶梯背景色的类别范围，颜色范围， 最小值    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:22:58
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:22:58    
	 * @param max
	 * @param min
	 * @param nums
	 * @return  Map<String,Object> 
	 * @throws
	 */
	public static Map<String,Object> getLevelNum1(BigDecimal max,BigDecimal min,String[] nums) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		List<String> list1=new ArrayList<String>();
		List<String> list2=new ArrayList<String>();
		List<String> list3=new ArrayList<String>();
		list1.add("");
		list2.add("");
		list3.add("");
		boolean flag=true;
		for(int i=0;i<nums.length;i++) {
			BigDecimal num=new BigDecimal(StringUtils.nullToString(nums[i]));
			if(num.compareTo(max)==-1&&num.compareTo(min)==1){
				list1.add(num.toString());
				list2.add(type[i]);
				list3.add(color[i]);
			}else {
				if(flag && num.compareTo(min)<=0) {
					list1.set(0, num.toString());
					list2.set(0, type[i]);
					list3.set(0, color[i]);
					map.put("min", num.toString());
				}else {
					flag=false;
				}
				if(!flag && num.compareTo(max)>=0) {
					list1.add(num.toString());
					list2.add(type[i]);
					list3.add(color[i]);
					break;
				}
			}
		}
		String[] levelList=new String[list1.size()];
		String[] typeList=new String[list1.size()];
		String[] colorList=new String[list1.size()];
		map.put("levelList", list1.toArray(levelList));
		map.put("typeList", list2.toArray(typeList));
		map.put("colorList", list3.toArray(colorList));
		return map;
	}
	/**
	 * 
	 * @Title:  getLevelNum2
	 * @Description:    溶解氧-获取阶梯背景色的类别范围，颜色范围， 最小值   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月10日 上午9:21:35
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月10日 上午9:21:35    
	 * @param max
	 * @param min
	 * @param nums
	 * @return  Map<String,Object> 
	 * @throws
	 */
	public static Map<String,Object> getLevelNum2(BigDecimal max,BigDecimal min,String[] nums) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		List<String> list1=new ArrayList<String>();
		List<String> list2=new ArrayList<String>();
		List<String> list3=new ArrayList<String>();
		list1.add("");
		list2.add("");
		list3.add("");
		boolean flag=true;
		for(int i=0;i<nums.length;i++) {
			BigDecimal num=new BigDecimal(StringUtils.nullToString(nums[i]));
			if(num.compareTo(max)==-1&&num.compareTo(min)==1){
				list1.add(num.toString());
				list2.add(type[i]);
				list3.add(color[i]);
			}else {
				if(flag && num.compareTo(max)>=0) {
					list1.set(0, num.toString());
					list2.set(0, type[i]);
					list3.set(0, color[i]);
				}else {
					flag=false;
				}
				if(!flag && num.compareTo(min)<=0) {
					list1.add(num.toString());
					list2.add(type[i]);
					list3.add(color[i]);
					map.put("min", num.toString());
					break;
				}
			}
		}
		String[] levelList=new String[list1.size()];
		String[] typeList=new String[list1.size()];
		String[] colorList=new String[list1.size()];
		map.put("levelList", list1.toArray(levelList));
		map.put("typeList", list2.toArray(typeList));
		map.put("colorList", list3.toArray(colorList));
		return map;
	}
}
