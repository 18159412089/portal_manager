package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.json.JSONObject;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.module.enviromonit.water.dao.WtCityPointDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityPointParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 监测站点
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:31:10
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WtCityPointServiceImpl implements WtCityPointService {

    @Autowired
    private SimpleDao simpleDao;

    @Autowired
    private WtCityPointDao wtCityPointDao;

    /**
     * 分页查询
     *
     * @param
     * @param page
     * @return
     */
    public Page<WtCityPoint> listByPage(WtCityPointParam wtCityPointParam, Page<WtCityPoint> page) {
        Page<WtCityPoint> listPage = wtCityPointDao.listByPage(wtCityPointParam, page);
        return listPage;
    }

    /**
     * <p>Title: getPointList</p>
     * <p>Description: 获取站点列表</p>
     *
     * @param type
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService#getPointList(int)
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONArray getPointList(int type) {
        String sql = "SELECT POINT_CODE,POINT_NAME FROM WT_CITY_POINT WHERE STATUS = 1";
        if (type != 0) {
            sql += " AND CATEGORY=" + type;
        }
        sql += " ORDER BY POINT_CODE";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
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
     * <p>Title: getPointListByRegion</p>
     * <p>Description: 级联获取站点列表</p>
     *
     */
    @SuppressWarnings("unchecked")
    @Override
    public JSONArray getPointListByRegion(int type,String regionCode) {
        String sql = "SELECT POINT_CODE,POINT_NAME FROM WT_CITY_POINT WHERE STATUS = 1";
        if (type != 0) {
            sql += " AND CATEGORY=" + type;
        }
        if (regionCode != null && !"".equals(regionCode)) {
            sql += " AND CODE_REGION=" + regionCode;
        }
        sql += " ORDER BY POINT_CODE";
        List<Object[]> list = simpleDao.createNativeQuery(sql).getResultList();
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
     * <p>Title: getPointsList</p>
     * <p>Description: 获取站点列表</p>
     *
     * @param type
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService#getPointsList(int)
     */
    @Override
    @SuppressWarnings("unchecked")
    public JSONArray getPointsList(int type) {
        List<Object[]> list = simpleDao.createNativeQuery("SELECT POINT_CODE,POINT_NAME FROM WT_CITY_POINT WHERE LONGITUDE<>0 AND LATITUDE<>0 AND CATEGORY=? ORDER BY POINT_CODE", type).getResultList();
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
     * 获取站点中的区域
     *
     * @param
     * @return
     */
    @Override
    @SuppressWarnings("unchecked")
    public JSONArray getPointRegionList() {
        List<Object[]> list = simpleDao.createNativeQuery("select DISTINCT  CODE_REGION,REGION_NAME from WT_CITY_POINT where CODE_REGION is not null").getResultList();
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
     * 根据Code和Name查询是否有数据
     * @param wtCityPointParam
     */
    public List<WtCityPoint> findListByCode(WtCityPointParam wtCityPointParam) {
        String sql="SELECT * FROM WT_CITY_POINT a WHERE a.POINT_CODE='"+wtCityPointParam.getPointCode()+"' AND a.POINT_NAME='"+wtCityPointParam.getPointName()+"' AND a.STATUS='1'";
        List<WtCityPoint> list= simpleDao.getNativeQueryList(sql);
        return list;
    }

}
