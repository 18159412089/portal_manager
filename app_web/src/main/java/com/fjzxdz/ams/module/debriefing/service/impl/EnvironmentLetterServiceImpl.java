package com.fjzxdz.ams.module.debriefing.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentLetterDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentLetter;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentLetterService;
import com.fjzxdz.ams.util.ValidatorUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.util.*;
import java.util.regex.Pattern;

/**
 * 
 * 信访件service实现类
 *
 * @author hyl
 * @Version 1.0
 * @CreateTime 2019年10月23日10:58:53
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class EnvironmentLetterServiceImpl implements EnvironmentLetterService {
    @Autowired
    SimpleDao simpleDao;

    @Override
    public Map<String, Object> countBJZTByXZQY(String type, String userDeptName) {
        StringBuilder sqlBuilder = new StringBuilder();
        List<Map<String, Object>> nativeQueryList;
        Map<String, Object> dataMap2 = new HashMap<>();
        sqlBuilder.append("select xzqy from ENVIRONMENT_LETTER where 1=1 ");
        if (com.fjzxdz.ams.common.generate.utils.StringUtils.isNotEmpty(userDeptName)) {
            sqlBuilder.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        sqlBuilder.append("  group by xzqy ");
        Query nativeQuery = simpleDao.createNativeQuery(sqlBuilder.toString());
        List<String> xzqyList = nativeQuery.getResultList();
        String[] legendData = {"阶段性办结", "已办结", "已销号"};
        List<String> jdxbjList = new ArrayList<>();
        List<String> ybjList = new ArrayList<>();
        List<String> yxhList = new ArrayList<>();
        List<String> xzqyListNew = new ArrayList<>();
        for (String xzqy : xzqyList) {
            sqlBuilder = new StringBuilder();
            sqlBuilder.append("select count(*) count, BJZT from ENVIRONMENT_LETTER where xzqy='");
            sqlBuilder.append(xzqy);
            sqlBuilder.append("'");
            if (StringUtils.isNotBlank(type)) {
                sqlBuilder.append("and lc like '%");
                sqlBuilder.append(type);
                sqlBuilder.append("%'");
            }
            sqlBuilder.append(" group by BJZT");
            List<String> datalist = new ArrayList();
            datalist.add("阶段性办结");
            datalist.add("已办结");
            datalist.add("已销号");
            nativeQueryList = simpleDao.getNativeQueryList(sqlBuilder.toString());
            for (Map<String, Object> dataMap : nativeQueryList) {
                if (dataMap.get("bjzt").toString().equals("阶段性办结")) {
                    jdxbjList.add(dataMap.get("count").toString());
                } else if (dataMap.get("bjzt").toString().equals("已办结")) {
                    ybjList.add(dataMap.get("count").toString());
                } else if (dataMap.get("bjzt").toString().equals("已销号")) {
                    yxhList.add(dataMap.get("count").toString());
                }
                datalist.remove(dataMap.get("bjzt").toString());
            }
            for (String data : datalist) {
                if (data.equals("阶段性办结")) {
                    jdxbjList.add("0");
                } else if (data.equals("已办结")) {
                    ybjList.add("0");
                } else if (data.equals("已销号")) {
                    yxhList.add("0");
                }
            }

            if ("福建省漳州市".equals(xzqy)) {
                xzqy = "漳州市";
                xzqyListNew.add(xzqy);
            } else {
                xzqy = xzqy.substring(6);
                xzqyListNew.add(xzqy);
            }
        }
        dataMap2.put("xzqyList", xzqyList);
        dataMap2.put("xList", xzqyListNew);
        dataMap2.put("yxh", yxhList);
        dataMap2.put("jdxbj", jdxbjList);
        dataMap2.put("ybj", ybjList);
        dataMap2.put("legendData", legendData);
        return dataMap2;
    }

    @Override
    public Map<String, Object> countBJZTByXZQYTest(String type, String userDeptName) {
        StringBuilder sqlBuilder = new StringBuilder();
        Map<String, Object> dataMap2 = new HashMap<>();
        sqlBuilder.append("select count(*) count,bjzt,xzqy from ENVIRONMENT_LETTER ");
        if (StringUtils.isNotBlank(type)) {
            sqlBuilder.append("where  lc like '%");
            sqlBuilder.append(type);
            sqlBuilder.append("%'");
        } if (com.fjzxdz.ams.common.generate.utils.StringUtils.isNotEmpty(userDeptName)) {
            sqlBuilder.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        sqlBuilder.append("group by bjzt,xzqy order by XZQY");
        List<Map<String, Object>> nativeQueryList = simpleDao.getNativeQueryList(sqlBuilder.toString());
        Set<String> setList = new HashSet<>();
        for (Map<String, Object> dataMap : nativeQueryList) {
            setList.add(dataMap.get("xzqy").toString());
        }
        List<String> xzqyList = new ArrayList<>(setList);
        Map<String, Object> xzqyMap = new HashMap<>();
        List<Integer> jdxbjList = new ArrayList<>();//每个阶段的数据数组;
        List<Integer> ybjList = new ArrayList<>();
        List<Integer> yxhList = new ArrayList<>();
        for (int i = 0; i < xzqyList.size(); i++) {
            xzqyMap.put(xzqyList.get(i), i);
            jdxbjList.add(0);
            ybjList.add(0);
            yxhList.add(0);
        }
        for (Map<String, Object> dataMap : nativeQueryList) {
            if (dataMap.get("bjzt").toString().equals("阶段性办结")) {
                jdxbjList.set(Integer.valueOf(xzqyMap.get(dataMap.get("xzqy")).toString()),Integer.valueOf(dataMap.get("count").toString()));
            } else if (dataMap.get("bjzt").toString().equals("已办结")) {
                ybjList.set(Integer.valueOf(xzqyMap.get(dataMap.get("xzqy")).toString()),Integer.valueOf(dataMap.get("count").toString()));
            } else if (dataMap.get("bjzt").toString().equals("已销号")) {
                yxhList.set(Integer.valueOf(xzqyMap.get(dataMap.get("xzqy")).toString()),Integer.valueOf(dataMap.get("count").toString()));
            }
        }
        String[] legendData = {"阶段性办结", "已办结", "已销号"};
        dataMap2.put("xzqyList", xzqyList);
        dataMap2.put("xList", xzqyList);
        dataMap2.put("yxh", yxhList);
        dataMap2.put("jdxbj", jdxbjList);
        dataMap2.put("ybj", ybjList);
        dataMap2.put("legendData",Arrays.asList(legendData) );
        return dataMap2;
    }

    @Autowired
    private EnvironmentLetterDao letterDao;

    @Override
    public JSONObject countPieWrlx(String lc, String userDeptName){
        JSONObject result = new JSONObject(2);
        StringBuilder sql = new StringBuilder("  select wrlx,count(1) count from ENVIRONMENT_LETTER ");
        sql.append(" where lc like '%"+ lc +"%' ");
        if (com.fjzxdz.ams.common.generate.utils.StringUtils.isNotEmpty(userDeptName)) {
            sql.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        sql.append(" group by WRLX ");
        List<Map> list = simpleDao.getNativeQueryList(sql.toString());
        List legends = new ArrayList(list.size());
        JSONArray data = new JSONArray(list.size());

        Map<String, Integer> resultMap = new HashMap<>();
        for(Map map : list) {
            if (ToolUtil.isNotEmpty(map.get("wrlx"))) {
                String[] wrlxs = map.get("wrlx").toString().replaceAll("，", ",").split(",");
                for (String wrlx : wrlxs) {
                    if (resultMap.containsKey(wrlx)) {
                        resultMap.put(wrlx, resultMap.get(wrlx) + Integer.valueOf(map.get("count").toString()));
                    } else {
                        resultMap.put(wrlx, Integer.valueOf(map.get("count").toString()));
                    }
                }
            }
        }

        for (Map.Entry<String, Integer> entry : resultMap.entrySet()) {
            legends.add(entry.getKey());
            JSONObject temp = new JSONObject();
            temp.put("value", entry.getValue());
            temp.put("name", entry.getKey());
            data.add(temp);
        }
        if (StringUtils.isNotEmpty(userDeptName)) {
            result.put("qx", userDeptName);
        }
        result.put("legend", legends);
        result.put("data", data);
        return result;
    }

    @Override
    public JSONObject countPieBjzt(String lc, String wrlx, String userDeptName){
        JSONObject result = new JSONObject(2);
        StringBuilder sql = new StringBuilder("  select BJZT bjzt,count(1) count from ENVIRONMENT_LETTER ");
        sql.append(" where lc like '%"+ lc +"%' and wrlx like '%"+ wrlx +"%' ");
        if (com.fjzxdz.ams.common.generate.utils.StringUtils.isNotEmpty(userDeptName)) {
            sql.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        sql.append(" group by bjzt ");
        List<Map> list = simpleDao.getNativeQueryList(sql.toString());
        List legends = new ArrayList(list.size());
        JSONArray data = new JSONArray(list.size());
        for (Map map : list){
            legends.add(map.get("bjzt"));
            JSONObject temp = new JSONObject();
            temp.put("value", map.get("count"));
            temp.put("name", map.get("bjzt"));
            data.add(temp);
        }
        result.put("legend", legends);
        result.put("data", data);
        return result;
    }

    @Override
    public String save(List<List<Object>> result) throws Exception {
        List<EnvironmentLetter> list = new ArrayList<>();
        String message = "";
        boolean flag = true;
        for (int i = 1; i < result.size(); i++) {
            List<Object> row = result.get(i);
            EnvironmentLetter entity = new EnvironmentLetter();
            entity.setYspxbm(row.get(0).toString().trim());
            entity.setSlbh(row.get(1).toString().trim());
            entity.setHbbh(row.get(2).toString().trim());
            entity.setJbwtjbqk(row.get(3).toString().trim());
            entity.setXzqy(row.get(4).toString().trim());
            entity.setWrlx(row.get(5).toString().trim());
            entity.setDcqjdchsqk(row.get(6).toString().trim());
            entity.setSfss(row.get(7).toString().trim());
            entity.setZgmbjzgcs(row.get(8).toString().trim());
            entity.setDcqjclqk(row.get(9).toString().trim());
            entity.setZxzgqk(row.get(10).toString().trim());
            entity.setBjzt(row.get(11).toString().trim());
            entity.setZlzg(row.get(12).toString().trim());
            entity.setLacf(row.get(13).toString().trim());
            entity.setFkje(row.get(14).toString().trim());
            entity.setLazc(row.get(15).toString().trim());
            entity.setXzjl(row.get(16).toString().trim());
            entity.setXsjl(row.get(17).toString().trim());
            entity.setYt(row.get(18).toString().trim());
            entity.setWz(row.get(19).toString().trim());
            entity.setWzqk(row.get(20).toString().trim());
            entity.setSfzdj(row.get(21).toString().trim());
            entity.setGgssxldqk(row.get(22).toString().trim());
            entity.setQtzrdw(row.get(23).toString().trim());
            entity.setLlr(row.get(24).toString().trim());
            entity.setLxdh(row.get(25).toString().trim());
            entity.setSswl(row.get(26).toString().trim());
            entity.setWgy(row.get(27).toString().trim());
            entity.setWgysjhm(row.get(28).toString().trim());
            entity.setLc(row.get(29).toString().trim());
            entity.setSfcf(row.get(30).toString().trim());
            entity.setSfgljbh(row.get(31).toString().trim());
            entity.setYsqk(row.get(32).toString().trim());
            String jd = row.get(33).toString().trim();
            String wd = row.get(34).toString().trim();
//            String[] split = jwd.replaceAll("，", ",").split(",");
            entity.setWd(wd);
            entity.setJd(jd);
//            message = patternValid(entity);
//            if (message.length() != 0) {
//                message = "第" + (i) + "行出现错误:（" + message + "）请修改后再导入！";
//                flag = false;
//                break;
//            }
            /*for (String str : entity.getWrlx().replaceAll("，", ",").split(",")) {
                EnvironmentLetter target = new EnvironmentLetter();
                str = str.trim();
                BeanUtil.copyProperties(entity, target, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
                target.setWrlx(str);

            }*/
            list.add(entity);
        }
        if (flag) {
            letterDao.saveBatch(list);
        }
        return message;
    }

    /**
     * @param entity
     * @return java.lang.String
     * @Author hyl
     * @Description //TODO(EnvironmentLetter实体数据验证)
     * @Date 2019年10月23日11:27:16
     * @version 1.0
     **/
    public String patternValid(EnvironmentLetter entity) {
        String message = "";
        for (String str : entity.getLxdh().replaceAll("，", ",").split(",")) {
            str = str.trim();
            if (Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")) {
                continue;
            }
            if (!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
                message += "联系方式，手机号有误！";
            }
        }
        for (String str : entity.getWgysjhm().replaceAll("，", ",").split(",")) {
            str = str.trim();
            if (Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")) {
                continue;
            }
            if (!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())) {
                message += "网格员手机号码格式有误！";
            }
        }
        return message;
    }

    /**
     * 信访件汇总表查询条件下拉框列表
     * @param type 字段名称
     * @param userDeptName
     * @return
     */
    @Override
    public List<Map> getTypeList(String type, String userDeptName) {
        StringBuilder sql = new StringBuilder(" SELECT DISTINCT ").append(type);
        sql.append(" FROM ENVIRONMENT_LETTER WHERE   ").append(type).append(" IS NOT NULL  ");
        if (com.fjzxdz.ams.common.generate.utils.StringUtils.isNotEmpty(userDeptName)) {
            sql.append(" AND XZQY LIKE ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        sql.append(" ORDER BY ").append(type);
        List<Map> numList = simpleDao.getNativeQueryList(sql.toString());
        return numList;
    }


    @Override
    public JSONObject getCount(EnvironmentLetter param) {
        JSONObject jsonObject = new JSONObject();
        StringBuilder sql = new StringBuilder(" SELECT BJZT,count(1) total FROM (select distinct yspxbm,slbh,BJZT from ENVIRONMENT_LETTER where 1=1 ");
        if (StringUtils.isNotEmpty(param.getLc())) {
            sql.append(" and lc like ").append(SqlUtil.toSqlStr_like(param.getLc()));
        }
        String xzqy = param.getXzqy();
        if (StringUtils.isNotEmpty(xzqy)) {
            sql.append(" and xzqy like ").append(SqlUtil.toSqlStr_like(xzqy));
        }
        sql.append(" ) group by BJZT ");
        List<Map> resultList = simpleDao.getNativeQueryList(sql.toString());
        int sum = 0;
        if (ToolUtil.isNotEmpty(resultList)) {
            for (Map map : resultList) {
                jsonObject.put(MapUtils.getString(map, "bjzt", ""), MapUtils.getString(map, "total", "0"));
                sum += Integer.valueOf(MapUtils.getString(map, "total", "0"));
            }
        }
        if (StringUtils.isNotEmpty(xzqy)) {
            jsonObject.put("qx", xzqy);
        }
        jsonObject.put("size", sum);
        return jsonObject;
    }

    /**
     * 新增编辑事件
     * @param letter
     * @return
     */
    @Override
    public String saveLetter(EnvironmentLetter letter) {
        if(ToolUtil.isEmpty(letter.getUuid())) {
            letter.setUuid(null);
            letterDao.save(letter);
        }else {
            EnvironmentLetter temp = letterDao.getById(letter.getUuid());
            BeanUtil.copyProperties(letter, temp, CopyOptions.create().setIgnoreCase(true).setIgnoreNullValue(true));
            letterDao.update(temp);
        }
        return "操作成功！";
    }
}

