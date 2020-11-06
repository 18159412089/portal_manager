package com.fjzxdz.ams.util;

import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @program: portal_manager
 * @className: AirSeriesUtil
 * @description: TODO
 * @author: lianhuinan
 * @create: 2019-09-02 11:24
 * @version: 1.0
 */
public class AirSeriesUtil {
    static String[] color= {"#b8b8b8", "#00e400","yellow","#ff7e00","red","#99004c","#7e0023","#b8b8b8"};
    static String[] type = {"优","良","轻度","中度","重度","严重","暂无数据"};
    /**
     *  AQI
     */
    static String[] aqi= {"0","50","100","150","200","300","400","500"};
    /**
     *  PM2.5
     */
    static String[] A34004= {"0","35","75","115","150","250","350","500"};
    /**
     * pm10
     */
    static String[] A34002= {"0","50","150","6","250","350","420", "500", "600"};
    /**
     *  臭氧8小时
     */
    static String[] A050248= {"0","100","160","215","265","800"};
    /**
     *  臭氧
     */
    static String[] A05024= {"0","160","200","300","400","800","100", "120"};

    /**
     * 二氧化硫
     **/
    static String[] A21026 = {"0", "50", "150", "475", "800", "1600", "2100", "2620"};

    /**
     * 二氧化氮
     **/
    static String[] A21004 = {"0", "40", "80", "180", "280", "565", "750", "940"};

    /**
     * 一氧化碳
     **/
    static String[] A21005 = {"0","2","4","14","24","36","48", "60"};

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
    public static Map<String,Object> getSeriesData(JSONArray xArray, String str) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Object> legendBar = new ArrayList<Object>();
        Map<String,Object> numMap = new HashMap<String,Object>();
        numMap.put("aqi", aqi);
        numMap.put("A050248", A050248);
        numMap.put("A05024", A050248);
        numMap.put("A34002", A34002);
        numMap.put("A34004", A34004);
        numMap.put("A21026", A21026);
        numMap.put("A21005", A21005);
        numMap.put("A21004", A21004);
        BigDecimal max=new BigDecimal(0);
        BigDecimal min=new BigDecimal(1000);

        for(int j=0;j<xArray.size();j++) {
            JSONObject jsonObject=xArray.getJSONObject(j);
            Object[] object = (Object[]) jsonObject.get("data");
            for(int k=0;k<object.length-1;k++) {
                JSONObject temp = new JSONObject(2);
                if (ToolUtil.isNotEmpty(object[k])){
                    try {
                        temp = JSONObject.parseObject(object[k].toString());
                    }catch (JSONException e){
                        e.getMessage();
                    }
                }
                max=getMax(max, ToolUtil.isNotEmpty(temp.get("value"))?temp.get("value").toString():"0");
                min=getMin(min, ToolUtil.isNotEmpty(temp.get("value"))?temp.get("value").toString():"0");
            }
        }

        if(numMap.containsKey(str)) {
            String[] nums = (String[]) numMap.get(str);
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
        map.put("series", xArray);
        map.put("legendBar", legendBar);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取最大值)
     * @Date 2019/9/2 0002 13:49
     * @param max
     * @param value
     * @return java.math.BigDecimal
     * @version 1.0
     **/
    public static BigDecimal getMax(BigDecimal max,String value){
        if(ToolUtil.isNotEmpty(value)) {
            BigDecimal val=new BigDecimal(value);
            if(max.compareTo(val)==-1) {
                return val;
            }
        }
        return max;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO（获取最小值)
     * @Date 2019/9/2 0002 13:50
     * @param min
     * @param value
     * @return java.math.BigDecimal
     * @version 1.0
     **/
    public static BigDecimal getMin(BigDecimal min,String value){
        if(ToolUtil.isNotEmpty(value)) {
            BigDecimal val=new BigDecimal(value);
            if(min.compareTo(val)==1) {
                return val;
            }
        }
        return min;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO（获取该值得区间值）
     * @Date 2019/9/2 0002 13:50
     * @param max
     * @param min
     * @param nums
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
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
}
