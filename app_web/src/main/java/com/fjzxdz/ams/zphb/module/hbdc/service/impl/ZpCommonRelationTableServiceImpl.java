package com.fjzxdz.ams.zphb.module.hbdc.service.impl;


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.debriefing.dao.CommonRelationTableDao;
import com.fjzxdz.ams.module.debriefing.entity.CommonRelationTable;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;
import com.fjzxdz.ams.zphb.module.hbdc.service.ZpCommonRelationTableService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class ZpCommonRelationTableServiceImpl implements ZpCommonRelationTableService {

    @SuppressWarnings("unused")
    private static Logger logger = LogManager.getLogger(ZpCommonRelationTableServiceImpl.class);

    @Autowired
    private CommonRelationTableDao commonRelationTableDao;

    @Autowired
    private SimpleDao simpleDao;

    @SuppressWarnings("unchecked")
    @Override
    public String save(CommonRelationTable commonRelationTable) {
        String code = commonRelationTable.getCode();
        if ("NUM_OF_ROUND_ZP".equals(commonRelationTable.getRelation())) {
            if (!StringUtils.isEmpty(commonRelationTable.getName())) {
                commonRelationTable.setNum(new BigDecimal(commonRelationTable.getName()));
                commonRelationTable.setName("第" + commonRelationTable.getName() + "轮" + code + "年");
            } else {
                commonRelationTable.setNum((commonRelationTable.getNum()) == null ? new BigDecimal(1) : commonRelationTable.getNum());
                commonRelationTable.setName("第" + commonRelationTable.getNum() + "轮" + (code.indexOf("年") > -1 ? code : code + "年"));
                commonRelationTable.setCode(code.replace("年", ""));
            }
            if (StringUtils.isEmpty(commonRelationTable.getUuid())) {
                commonRelationTable.setUuid(null);
                commonRelationTableDao.save(commonRelationTable);
                return "添加成功";
            } else {
                String sql = "UPDATE ENVIRONMEENT_RECTIFITION t set t.NUM_OF_ROUND_VALUE= ?,t.NUM_OF_ROUND_NAME =? where substr(t.NUM_OF_ROUND_NAME,1,5) =?";
                String name = commonRelationTable.getName().substring(0, 5);
                simpleDao.createNativeQuery(sql, code.replace("年", ""), commonRelationTable.getName().substring(0, 3) + (code.indexOf("年") > -1 ? code : code + "年"), name).executeUpdate();
                commonRelationTableDao.update(commonRelationTable);
            }
        } else {

            String sql = "";

            List<Object[]> list = null;
            List<Object[]> resultList = null;
            if (code == null) {
                sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE NAME = ? and code is null and relation = ?";
                list = simpleDao.createNativeQuery(sql, commonRelationTable.getName(), commonRelationTable.getRelation()).getResultList();
            } else {
                sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE NAME = ? and code = ? and relation = ?";
                list = simpleDao.createNativeQuery(sql, commonRelationTable.getName(),
                        code, commonRelationTable.getRelation()).getResultList();
            }
            if (ToolUtil.isEmpty(commonRelationTable.getUuid())) {

                if (list.size() == 0) {
                    commonRelationTable.setUuid(null);
                    commonRelationTableDao.save(commonRelationTable);
                    return "添加成功";
                } else {
                    return "添加失败。已存在";
                }
            } else {
                if (code == null) {
                    sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE NAME = ? and code is null and relation = ? and uuid = ?";
                    resultList = simpleDao.createNativeQuery(sql, commonRelationTable.getName(), commonRelationTable.getRelation(), commonRelationTable.getUuid()).getResultList();
                } else {
                    sql = "SELECT * FROM COMMON_RELATION_TABLE WHERE NAME = ? and code = ? and relation = ? and uuid = ?";
                    resultList = simpleDao.createNativeQuery(sql, commonRelationTable.getName(),
                            code, commonRelationTable.getRelation(), commonRelationTable.getUuid()).getResultList();
                }
                if (resultList.size() == 1) {
                    CommonRelationTable temp = commonRelationTableDao.getById(commonRelationTable.getUuid());
                    temp.setName(commonRelationTable.getName());
                    commonRelationTableDao.update(temp);

                } else if (list.size() == 0) {
                    CommonRelationTable temp = commonRelationTableDao.getById(commonRelationTable.getUuid());
                    temp.setName(commonRelationTable.getName());
                    commonRelationTableDao.update(temp);
                } else {
                    return "更新失败。已存在";
                }
            }
        }
        return "更新成功";
    }

    @Override
    public List<CommonRelationTable> listNoPage(CommonRelationTableParam param) {
        List<CommonRelationTable> list = commonRelationTableDao.
                selectList("from CommonRelationTable where code=? and relation=? order by updateDate desc nulls last",
                        param.getCode(), param.getRelation());
        if (ToolUtil.isNotEmpty(list))
            return list;
        return new ArrayList<>();
    }

    @Override
    public Page<CommonRelationTable> listByPage(CommonRelationTableParam param, Page<CommonRelationTable> page) {
        return commonRelationTableDao.listByPage(param, page);
    }

    @Override
    public String delete(String uuid) {
        CommonRelationTable relationTable = commonRelationTableDao.getById(uuid);
        if ("NUM_OF_ROUND_ZP".equals(relationTable.getRelation())) {
            String s = simpleDao.createNativeQuery("select count(1) from ENVIRONMEENT_RECTIFITION where mark ='ZP' and  num_of_round_value = ? ", relationTable.getCode()).getResultList().get(0).toString();
            if (Integer.parseInt(s) > 0) {
                return relationTable.getName() + "有内容，请清空内容才能删除";
            } else {
                commonRelationTableDao.deleteById(uuid);
            }

        } else {
            List<Object[]> list = simpleDao.createNativeQuery("select * from ENVIRONMEENT_RECTIFITION where mark ='ZP' and  name=? or describe=? ", uuid, uuid).getResultList();
            if (ToolUtil.isNotEmpty(list)) {
                return "该值被引用，无法删除";
            } else
                commonRelationTableDao.deleteById(uuid);
        }
        return "已删除";
    }

    @Override
    public CommonRelationTable getById(String uuid) {
        return commonRelationTableDao.getById(uuid);
    }


}
