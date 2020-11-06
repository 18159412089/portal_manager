package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.service.WtMonthMonitorPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 监控站点
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:39:49
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtMonthMonitorPointServiceImpl implements WtMonthMonitorPointService {
    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getMonitorPointList</p>
     * <p>Description:获取监控站点    </p>
     *
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtMonthMonitorPointService#getMonitorPointList()
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONArray getMonitorPointList() {
        List<Object[]> list = simpleDao.createNativeQuery(
                "SELECT MONITOR_CODE,MONITOR_NAME FROM WT_BASIN_MONITOR WHERE LONGITUDE<>0 AND LATITUDE<>0 AND MONITOR_CODE IS NOT NULL ORDER BY MONITOR_CODE DESC").getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray array = new JSONArray();
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point[0]);
                temp.put("text", point[1]);
                array.add(temp);
            }
            return array;
        }
        return new JSONArray();
    }
}
