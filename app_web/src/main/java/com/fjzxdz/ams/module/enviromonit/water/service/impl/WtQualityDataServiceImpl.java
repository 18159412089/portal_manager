package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.service.WtQualityDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class WtQualityDataServiceImpl implements WtQualityDataService {
    @Autowired
    SimpleDao simpleDao;

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 水质月检测数据统计列表   </p>
     *
     * @param year
     * @param pointName
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtQualityDataService#getPageList(java.lang.String, java.lang.String, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<Map<String, Object>> getPageList(String year, String pointName, Page<Map<String, Object>> page) {
        String where = "where 1=1 AND BASIN_CODE IS NOT NULL";
        if (StringUtils.isBlank(year)) {
            where += " AND YEAR_NUMBER =" + DateUtil.getYear();
        }
        if (StringUtils.isNotBlank(year)) {
            where += " AND YEAR_NUMBER=" + year;
        }
        if (StringUtils.isNotBlank(pointName)) {
            where += " AND BASIN_NAME in (" + toSqlStr(pointName) + ")";
        }
        String sql = "SELECT * FROM WT_BASIN_MONTH_DATA " + where + " ORDER BY YEAR_NUMBER,MONTH_NUMBER DESC";
        Page<Map<String, Object>> byPage = simpleDao.listNativeByPage(sql, page);
        List<Map<String, Object>> result = byPage.getResult();
        Map<String, Integer> dataMap = new HashMap<>();
        dataMap.put("-", 0);
        dataMap.put("null", 0);
        dataMap.put("Ⅰ", 1);
        dataMap.put("Ⅱ", 2);
        dataMap.put("Ⅲ", 3);
        dataMap.put("Ⅳ", 4);
        dataMap.put("Ⅴ", 5);
        dataMap.put("Ⅴ", 6);
        dataMap.put("劣Ⅴ", 7);
        String andanLevel = "";
        String resultQuality = "";
        String targetQuality = "";
        String bodLevel = "";
        String rjyLevel = "";
        String zlLevel = "";
        String phLevel = "";
        for (int i = 0; i < result.size(); i++) {
            Map<String, Object> map = result.get(i);
            JSONArray polluteCodes = new JSONArray();
            targetQuality = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("targetQuality"))).getKey();
            andanLevel = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("andanLevel"))).getKey();
            resultQuality = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("resultQuality"))).getKey();
            bodLevel = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("bodLevel"))).getKey();
            rjyLevel = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("rjyLevel"))).getKey();
            zlLevel = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("zlLevel"))).getKey();
            phLevel = WaterQualityEnum.valueOf(StringUtils.nullToString(map.get("phLevel"))).getKey();
            map.put("targetQuality", targetQuality);
            map.put("resultQuality", resultQuality);
            map.put("andanLevel", andanLevel);
            map.put("bodLevel", bodLevel);
            map.put("rjyLevel", rjyLevel);
            map.put("zlLevel", zlLevel);
            map.put("phLevel", phLevel);
            if (dataMap.get(targetQuality) < dataMap.get(andanLevel)) {
                polluteCodes.add("andanValue");
            }
            if (dataMap.get(targetQuality) < dataMap.get(bodLevel)) {
                polluteCodes.add("bodValue");
            }
            if (dataMap.get(targetQuality) < dataMap.get(rjyLevel)) {
                polluteCodes.add("rjyValue");
            }
            if (dataMap.get(targetQuality) < dataMap.get(zlLevel)) {
                polluteCodes.add("zlLevel");
            }
            if (dataMap.get(targetQuality) < dataMap.get(phLevel)) {
                polluteCodes.add("phValue");
            }
            map.put("polluteCodes", polluteCodes);
            result.set(i, map);
        }
        byPage.setResult(result);
        return byPage;
    }

    public String toSqlStr(String str) {
        String sqlStr = null;
        if (ToolUtil.isNotEmpty(str)) {
            String[] strs = str.split(",");
            sqlStr = "'" + StringUtils.join(strs, "','") + "'";
        }
        return sqlStr;
    }

}
