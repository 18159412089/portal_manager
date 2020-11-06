package com.fjzxdz.ams.zphb.module.enviromonit.air.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.air.dao.CommonCodeDao;
import com.fjzxdz.ams.module.enviromonit.air.entity.CommonCode;
import com.fjzxdz.ams.module.enviromonit.air.service.CommonCodeService;
import com.fjzxdz.ams.zphb.module.enviromonit.air.service.ZpCommonCodeService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class ZpCommonCodeServiceImpl implements ZpCommonCodeService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(ZpCommonCodeServiceImpl.class);

    @Autowired
    private CommonCodeDao commonCodeDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    public JSONArray allCountyByName(String city) {
        List<CommonCode> commonCodes = commonCodeDao.selectList("from CommonCode where parent.name=?", city);
        JSONArray array = new JSONArray();
        for (CommonCode commonCode : commonCodes) {
            JSONObject county = new JSONObject();
            county.put("uuid", commonCode.getId());
            county.put("name", commonCode.getName());
            array.add(county);
        }
        return array;
    }

    @Override
    public JsonArray getChildren(String id) {
        JsonArray jsonArray = new JsonArray();
        List<CommonCode> list = simpleDao.find("from CommonCode c where c.parentId ='" + id + "' order by c.seq asc");
        if (null != list && list.size() > 0) {
            for (CommonCode commonCodeTemp : list) {
                JsonObject jsonObjectTemp = new JsonObject();
                jsonObjectTemp.addProperty("id", commonCodeTemp.getId());
                jsonObjectTemp.addProperty("code", commonCodeTemp.getCode());
                jsonObjectTemp.addProperty("name", commonCodeTemp.getName());
                jsonObjectTemp.addProperty("text", commonCodeTemp.getName());
                jsonObjectTemp.addProperty("status", commonCodeTemp.getStatus());
                jsonObjectTemp.addProperty("seq", commonCodeTemp.getSeq());
                List<CommonCode> list2 = simpleDao
                        .find("from CommonCode c where c.parentId='" + commonCodeTemp.getId() + "' order by c.seq asc");
                if (list2.size() > 0) {
                    jsonObjectTemp.addProperty("state", "closed");
                }
                jsonArray.add(jsonObjectTemp);
            }
        }
        return jsonArray;
    }

    @Override
    public JsonArray getTopTree(String code, String name) {
        String codeString = "";
        String nameString = "";
        if(ToolUtil.isNotEmpty(code)){
            codeString = "and code like '%"+code +"%'";
        }
        if(ToolUtil.isNotEmpty(name)){
            nameString = "and name like '%"+name +"%'";
        }
        String jpql = "from CommonCode c where c.parentId in (select parentId from CommonCode where parentId not in (select id from CommonCode))" +
                codeString + nameString +" order by c.parentId asc,c.seq asc";
        JsonArray jsonArray = new JsonArray();
        List<CommonCode> commonCodeList = simpleDao.find(jpql);

        for (int i = 0; i < commonCodeList.size(); i++) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", commonCodeList.get(i).getId());
            jsonObject.addProperty("code", commonCodeList.get(i).getCode());
            jsonObject.addProperty("name", commonCodeList.get(i).getName());
            jsonObject.addProperty("text", commonCodeList.get(i).getName());
            jsonObject.addProperty("status", commonCodeList.get(i).getStatus());
            jsonObject.addProperty("seq", commonCodeList.get(i).getSeq());
            jsonObject.addProperty("parentId", "");
            jsonObject.addProperty("state", "closed");
            jsonArray.add(jsonObject);

        }
        return jsonArray;
    }

    @Override
    public R save(CommonCode commonCode) {
        try {
            if (ToolUtil.isNotEmpty(commonCode.getId())) {
                CommonCode code = commonCodeDao.getById(commonCode.getId());
                code.setCode(commonCode.getCode());
                code.setName(commonCode.getName());
                code.setParentId(commonCode.getParentId());
                code.setStatus(new BigDecimal(1));
                commonCodeDao.update(code);
            } else {
                List<BigDecimal> list = commonCodeDao.createNativeQuery("select max(id) from common_code").getResultList();
                BigDecimal maxId = list.get(0);
                commonCode.setId(maxId.add(new BigDecimal(1)));
                commonCode.setCreateTime(new Date());
                commonCode.setStatus(new BigDecimal(1));
                commonCodeDao.save(commonCode);
            }
            return R.ok();
        }catch (Exception e){
            return R.error(e.getMessage());
        }
    }

    @Override
    public R delete(String id){
        List<CommonCode> list = simpleDao.find("from CommonCode where id=?", new BigDecimal(id));
        if(list.size()>0){
            commonCodeDao.deleteById(new BigDecimal(id));
            return R.ok();
        }else{
            return R.error("该记录已不存在");
        }
    }

    @Override
    public CommonCode get(String id){
        List<CommonCode> list = simpleDao.find("from CommonCode where id=?", new BigDecimal(id));
        return list.get(0);
    }
}
