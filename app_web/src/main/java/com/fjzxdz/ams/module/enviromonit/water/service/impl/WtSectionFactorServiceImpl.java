package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.JedisUtils;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionFactor;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionFactorService;
import com.xxl.sso.core.util.JedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 手工录入监测数据 监测因子
 *
 * @Author ZhangGQ
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:31:10
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtSectionFactorServiceImpl implements WtSectionFactorService {

    @Autowired
    private SimpleDao simpleDao;

    /**
     * <p>Title: getPointList</p>
     * <p>Description: 获取因子列表</p>
     *
     * @return
     * @see WtCityPointService#getPointList(int)
     */
    @Override
    public JSONArray getFactorList() {
        String sql = "SELECT UUID,POINT_CODE, CODE_POLLUTE, POLLUTENAME, UNIT, RATE, STATE FROM WT_SECTION_FACTOR WHERE 1 = 1";

        sql += " ORDER BY POINT_CODE";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray array = new JSONArray();
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point[0]);
                temp.put("pointCode", point[1]);
                temp.put("codePollute", point[2]);
                temp.put("polluteName", point[3]);
                temp.put("unit", point[4]);
                temp.put("rate", point[5]);
                temp.put("state", point[6]);
                array.add(temp);
            }
            return array;
        }
        return new JSONArray();
    }

    @Override
    public JSONObject getFactorByName(String polluteName) {
        Map<String, String> factorMap = new HashMap<String, String>();

        if (JedisUtil.exists(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS)) {
            factorMap = JedisUtils.getMap(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS);
        } else {
            String sql = "SELECT UUID,POINT_CODE, CODE_POLLUTE, POLLUTENAME, UNIT, RATE,STATE FROM WT_SECTION_FACTOR WHERE 1 = 1";
            sql += " ORDER BY POINT_CODE";

            List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
            if (ToolUtil.isNotEmpty(list)) {
                for (Object[] point : list) {
                    JSONObject temp = new JSONObject();
                    temp.put("id", point[0]);
                    temp.put("pointCode", point[1]);
                    temp.put("codePollute", String.valueOf(point[2]).toUpperCase());
                    temp.put("polluteName", point[3]);
                    temp.put("unit", point[4]);
                    temp.put("rate", point[5]);
                    temp.put("state", point[6]);

                    //key为因子编码
                    factorMap.put(temp.getString("codePollute"), temp.toString());
                    //key为因子名称
                    factorMap.put(temp.getString("polluteName"), temp.toString());
                    //key为因子UUID
                    factorMap.put(temp.getString("id"), temp.toString());
                }
                JedisUtils.setMap(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS, factorMap, 0);
            }
        }

        JSONObject factorObj = new JSONObject();
        if (factorMap.containsKey(polluteName)) {
            factorObj = JSONObject.parseObject(factorMap.get(polluteName));
        }
        return factorObj;
    }

    @Override
    public JSONObject getFactorByPolluteCode(String codePollute) {
        Map<String, String> factorMap = new HashMap<String, String>();

        if (JedisUtil.exists(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS)) {
            factorMap = JedisUtils.getMap(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS);
        } else {
            String sql = "SELECT UUID,POINT_CODE, CODE_POLLUTE, POLLUTENAME, UNIT, RATE,STATE FROM WT_SECTION_FACTOR WHERE 1 = 1";
            sql += " ORDER BY POINT_CODE";

            List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
            if (ToolUtil.isNotEmpty(list)) {
                for (Object[] point : list) {
                    JSONObject temp = new JSONObject();
                    temp.put("id", point[0]);
                    temp.put("pointCode", point[1]);
                    temp.put("codePollute", point[2]);
                    temp.put("polluteName", point[3]);
                    temp.put("unit", point[4]);
                    temp.put("rate", point[5]);
                    temp.put("state", point[6]);

                    //key为因子编码
                    factorMap.put(temp.getString("codePollute"), temp.toString());
                    //key为因子名称
                    factorMap.put(temp.getString("polluteName"), temp.toString());
                    //key为因子UUID
                    factorMap.put(temp.getString("id"), temp.toString());
                }
                JedisUtils.setMap(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS, factorMap, 0);
            }
        }

        JSONObject factorObj = new JSONObject();
        if (factorMap.containsKey(codePollute)) {
            factorObj = JSONObject.parseObject(factorMap.get(codePollute));
        }
        return factorObj;
    }

    /**
     * 初始化Redis中的因子数据
     */
    @Override
    public void initRedisData() {
        Map<String, String> factorMap = new HashMap<String, String>();

        if (JedisUtils.exists(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS)) {
            JedisUtils.del(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS);
        }

        String sql = "SELECT UUID,POINT_CODE, CODE_POLLUTE, POLLUTENAME, UNIT, RATE,STATE FROM WT_SECTION_FACTOR WHERE 1 = 1";
        sql += " ORDER BY POINT_CODE";

        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point[0]);
                temp.put("pointCode", point[1]);
                temp.put("codePollute", point[2]);
                temp.put("polluteName", point[3]);
                temp.put("unit", point[4]);
                temp.put("rate", point[5]);
                temp.put("state", point[6]);

                //key为因子编码
                factorMap.put(temp.getString("codePollute"), temp.toString());
                //key为因子名称
                factorMap.put(temp.getString("polluteName"), temp.toString());
                //key为因子UUID
                factorMap.put(temp.getString("id"), temp.toString());
            }
            JedisUtils.setMap(WtSectionFactor.WT_SECTION_FACTOR_MAP_FROM_JEDIS, factorMap, 0);
        }
    }
}
