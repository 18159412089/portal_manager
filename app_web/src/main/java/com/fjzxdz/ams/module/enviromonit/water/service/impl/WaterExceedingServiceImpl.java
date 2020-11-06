package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterExceedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.*;

/**
 * @author shenliuyuan
 * @title: WaterExceedingServiceImpl
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/6/2610:32
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WaterExceedingServiceImpl implements WaterExceedingService {
    @Autowired
    private SimpleDao simpleDao;

    @Override
    public String daysRatio(String start, String end ,Integer category) {
        //查询区县名称
        String sql1 = "SELECT b.CODE_REGION,b.REGION_NAME,count(*) FROM WT_DAY_REPORT a LEFT JOIN WT_CITY_POINT b on a.POINT_CODE=b.POINT_CODE " +
                "WHERE a.MONITOR_TIME  BETWEEN '" + start + "' AND '" + end + "' AND b.CATEGORY = '"+category+"'  GROUP BY b.CODE_REGION,b.REGION_NAME ";
        //查询具体数据
        String sql2 = "SELECT a.MONITOR_TIME,a.TARGET_QUALITY,a.RESULT_QUALITY,b.CODE_REGION,b.REGION_NAME FROM WT_DAY_REPORT a LEFT JOIN WT_CITY_POINT b on a.POINT_CODE=b.POINT_CODE " +
                "WHERE a.MONITOR_TIME  BETWEEN '" + start + "' AND '" + end + "' AND b.CATEGORY = '"+category+"'";
        Query nativeQuery1 = simpleDao.createNativeQuery(sql1);
        Query nativeQuery2 = simpleDao.createNativeQuery(sql2);
        List<Object[]> list1 = (nativeQuery1.getResultList());
        List<Object[]> list2 = (nativeQuery2.getResultList());
        List<Map<String, Object>> sq1List1 = new ArrayList<>();
        List<Map<String, Object>> sq1List2 = new ArrayList<>();
        //重组超标的数据
        for (Object[] o : list2) {
            int TARGET_QUALITY = choose((String) o[1]);
            int RESULT_QUALITY = choose((String) o[2]);
            if (TARGET_QUALITY < RESULT_QUALITY) {
                Map<String, Object> map = new HashMap<>();
                map.put("MONITOR_TIME", o[0]);
                map.put("TARGET_QUALITY", o[1]);
                map.put("RESULT_QUALITY", o[2]);
                map.put("CODE_REGION", o[3]);
                map.put("REGION_NAME", o[4]);
                sq1List2.add(map);
            }
        }
        //重组区县的信息
        for (Object[] o : list1) {
            Map<String, Object> map = new HashMap<>();
            map.put("CODE_REGION", o[0]);
            map.put("REGION_NAME", o[1]);
            sq1List1.add(map);
        }
        JSONArray json = new JSONArray();
        JSONArray json1 = new JSONArray();
        JSONArray json2 = new JSONArray();
        JSONArray sortJson = new JSONArray();
        Map<String, Integer> sortMap = new TreeMap<>();
        for (Map<String, Object> stringObjectMap : sq1List1) {
            int i = 0;
            for (Map<String, Object> stringObjectMap2 : sq1List2) {
                if (stringObjectMap.get("CODE_REGION").equals(stringObjectMap2.get("CODE_REGION"))) {
                    i++;
                }
            }
            json1.add(stringObjectMap.get("REGION_NAME"));
            json2.add(i);
            sortMap.put((String) stringObjectMap.get("REGION_NAME"), i);
        }
        json.add(json1);
        json.add(json2);
        //排序
        Comparator<Map.Entry<String, Integer>> valueComparator = new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1,
                               Map.Entry<String, Integer> o2) {
                // TODO Auto-generated method stub
                return o2.getValue() - o1.getValue();
            }
        };
        // map转换成list进行排序
        List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(sortMap.entrySet());
        // 排序
        Collections.sort(list, valueComparator);
        // 默认情况下，TreeMap对key进行降序排序
        int j = 1;
        for (Map.Entry<String, Integer> entry : list) {
            JSONObject jo = new JSONObject();
            jo.put("num", j);
            jo.put("name", entry.getKey());
            jo.put("day", entry.getValue());
            jo.put("startEnd", start + "~" + end);
            sortJson.add(jo);
            j++;
        }
        json.add(sortJson);
        return json.toString();
    }

    public int choose(String s) {
        switch (s) {
            case "NONE":
                return 0;
            case "FIRSR":
                return 1;
            case "SECOND":
                return 2;
            case "THIRD":
                return 3;
            case "FOURTH":
                return 4;
            case "FIFTH":
                return 5;
            case "OTHER":
                return 6;
            default:
                return 7;
        }
    }
}
