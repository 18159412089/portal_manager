package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.JedisUtils;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtSectionPointDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionPointParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtSectionPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 手工录入监测数据监测站
 *
 * @Author zhangGQ
 * @Version 1.0
 * @CreateTime 2019年6月5日 下午5:31:10
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtSectionPointServiceImpl implements WtSectionPointService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private WtSectionPointDao wtSectionPointDao;

    /**
     * <p>Title: getPointList</p>
     * <p>Description: 获取站点列表</p>
     *
     * @param type
     * @return
     * @see WtCityPointService#getPointList(int)
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONArray getPointList(int type) {
        String sql = "SELECT UUID,SECTION_CODE,SECTION_NAME,CATEGORY,TARGET_QUALITY,STATUS,IS_PROMOTING,IS_TARGET_PROJECT FROM WT_SECTION_POINT WHERE 1 = 1";
        if (type != 0) {
            sql += " AND CATEGORY=" + type;
        }
        sql += " ORDER BY SECTION_CODE";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            JSONArray array = new JSONArray();
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();
                temp.put("id", point[0]);
                temp.put("sectionCode", point[1]);
                temp.put("sectionName", point[2]);
                temp.put("category", point[3]);
                temp.put("targetQuality", point[4]);
                temp.put("status", point[5]);
                temp.put("isPromoting", point[6]);
                temp.put("isTargetProject", point[7]);
                array.add(temp);
            }
            return array;
        }
        return new JSONArray();
    }

    /**
     * <p>Title: getPointsList</p>
     * <p>Description: 获取站点列表</p>
     *
     * @param type
     * @return
     * @see WtCityPointService#getPointsList(int)
     */
    @Override
    @SuppressWarnings("unchecked")
    public JSONArray getPointsList(int type) {
        List<Object[]> list = null;
        if (type == 0) {
            String sqlstr = "SELECT SECTION_CODE,SECTION_NAME FROM WT_SECTION_POINT  ORDER BY SECTION_CODE";
            list = simpleDao.createNativeQuery(sqlstr).getResultList();
        } else {
            String sqlstr = "SELECT SECTION_CODE,SECTION_NAME FROM WT_SECTION_POINT WHERE  CATEGORY=? ORDER BY SECTION_CODE";
            list = simpleDao.createNativeQuery(sqlstr, type).getResultList();
        }

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

    /**
     * <p>Title: getPointList</p>
     * <p>Description: 获取站点列表</p>
     *
     * @param
     * @return
     * @see WtCityPointService#getPointList(int)
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONObject getPointByCode(String code) {
        Map<String, String> pointMap = new HashMap<>();

        String sql = "SELECT UUID,SECTION_CODE,SECTION_NAME,CATEGORY,TARGET_QUALITY,STATUS,IS_PROMOTING,IS_TARGET_PROJECT FROM WT_SECTION_POINT WHERE 1 = 1";
        sql += " ORDER BY SECTION_CODE";

        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();

                temp.put("id", point[0]);
                temp.put("sectionCode", point[1]);
                temp.put("sectionName", point[2]);
                temp.put("category", point[3]);
                temp.put("targetQuality", point[4]);
                temp.put("status", point[5]);
                temp.put("isPromoting", point[6]);
                temp.put("isTargetProject", point[7]);

                pointMap.put(temp.getString("sectionCode"), temp.toString());
            }
        }
        JedisUtils.setMap(WtSectionPoint.WT_SECTION_POINT_JEDIS_MAP, pointMap, 0);

        JSONObject point = new JSONObject();
        if (pointMap.containsKey(code)) {
            point = JSONObject.parseObject(pointMap.get(code));
        }
        return point;
    }

    /**
     *
     */
    @Override
    public void initRedisData() {
        Map<String, String> pointMap = new HashMap<>();

        if (JedisUtils.exists(WtSectionPoint.WT_SECTION_POINT_JEDIS_MAP)) {
            JedisUtils.del(WtSectionPoint.WT_SECTION_POINT_JEDIS_MAP);
        }

        String sql = "SELECT UUID,SECTION_CODE,SECTION_NAME,CATEGORY,TARGET_QUALITY,STATUS,IS_PROMOTING,IS_TARGET_PROJECT FROM WT_SECTION_POINT WHERE 1 = 1";
        sql += " ORDER BY SECTION_CODE";

        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
        if (ToolUtil.isNotEmpty(list)) {
            for (Object[] point : list) {
                JSONObject temp = new JSONObject();

                temp.put("id", point[0]);
                temp.put("sectionCode", point[1]);
                temp.put("sectionName", point[2]);
                temp.put("category", point[3]);
                temp.put("targetQuality", point[4]);
                temp.put("status", point[5]);
                temp.put("isPromoting", point[6]);
                temp.put("isTargetProject", point[7]);

                pointMap.put(temp.getString("sectionCode"), temp.toString());
            }
        }
        JedisUtils.setMap(WtSectionPoint.WT_SECTION_POINT_JEDIS_MAP, pointMap, 0);
    }

    @Override
    public Page<WtSectionPoint> listByPage(WtSectionPointParam wtSectionPointParam, Page<WtSectionPoint> page) {
        Page<WtSectionPoint> listPage = wtSectionPointDao.listByPage(wtSectionPointParam, page);
        return listPage;
    }
}
