package com.fjzxdz.ams.module.enviromonit.pollution.service.impl;

import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enums.PollutionInfoDataWrylxEnum;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.PollutionInfoDataDao;
import com.fjzxdz.ams.module.enviromonit.pollution.entity.PollutionInfoData;
import com.fjzxdz.ams.module.enviromonit.pollution.service.DataService;
import com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo;
import com.fjzxdz.ams.util.PercentileUtil;
import com.fjzxdz.ams.util.PreceedPointInAreaUtil;
import com.fjzxdz.ams.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @program: portal_manager
 * @className: DataServiceImpl
 * @description: TODO(pollutionDataInfo 管理的service操作)
 * @author: lianhuinan
 * @create: 2019-10-10 15:58
 * @version: 1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class DataServiceImpl implements DataService {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private PollutionInfoDataDao pollutionInfoDataDao;

    @Override
    public String save(List<List<Object>> result, String deptPath) throws Exception {
        List<PollutionInfoData> list = new ArrayList<PollutionInfoData>();
        String message = "";
        boolean flag = true;
        for (int i = 2; i < result.size(); i++) {
            List<Object> row = result.get(i);
            PollutionInfoData entity = new PollutionInfoData();
            entity.setQx(row.get(0).toString());
            entity.setWrylx(row.get(1).toString());
            entity.setWryzl(row.get(2).toString());
            entity.setMc(row.get(3).toString());
            entity.setCzwt(row.get(4).toString());
            entity.setZgcs(row.get(5).toString());
            entity.setZlxm(row.get(6).toString());
            entity.setWcmb201912(row.get(7).toString());
            entity.setWcmb202006(row.get(8).toString());
            entity.setWcmb202012(row.get(9).toString());
            entity.setSdzrZrdw(row.get(10).toString());
            entity.setSdzrdwZrrlxfs(row.get(11).toString());
            entity.setBmzrPhzrdw(row.get(12).toString());
            entity.setBmzrdwZrrlxfs(row.get(13).toString());
            entity.setBmzrPhzrdw(row.get(14).toString());
            entity.setPhzrdwZrrlxfs(row.get(15).toString());
            entity.setXz(row.get(16).toString());
            entity.setDz(row.get(17).toString());
            entity.setJd(row.get(18).toString());
            entity.setWd(row.get(19).toString());
            entity.setBz(row.get(20).toString());
//            entity.setEntryDepartment(row.get(21).toString());
            message = patternValid(entity);
            if (message.length() != 0) {
                message = "第" + (i) + "行出现错误:（" + message + "）请修改后再导入！";
                flag = false;
                break;
            }
            entity.setDeptPath(deptPath);
            list.add(entity);
        }
        if (flag) {
            pollutionInfoDataDao.saveBatch(list);
        }
        return message;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(pollutionDataInfo实体数据验证)
     * @Date 2019/10/11 0011 11:19
     * @param entity
     * @return java.lang.String
     * @version 1.0
     **/
    public String patternValid(PollutionInfoData entity) {
        String message = "";
        for (String str : entity.getSdzrdwZrrlxfs().replaceAll("，", ",").split(",")){
            str = str.trim();
            if(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")){
                continue;
            }
            if(!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())){
                message += "属地责任_责任人及联系方式，手机号有误！";
            }
        }
        for (String str : entity.getBmzrdwZrrlxfs().replaceAll("，", ",").split(",")){
            str = str.trim();
            if(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")){
                continue;
            }
            if(!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())){
                message += "部门责任_责任人及联系方式，手机号有误！";
            }
        }
        for (String str : entity.getPhzrdwZrrlxfs().replaceAll("，", ",").split(",")){
            str = str.trim();
            if(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim().equals("")){
                continue;
            }
            if(!ValidatorUtil.isMobile(Pattern.compile("[^0-9]").matcher(str).replaceAll("").trim())){
                message += "部门责任_配合责任人及联系方式，手机号有误！";
            }
        }
        if (PreceedPointInAreaUtil.findBelongQx(entity.getJd(), entity.getWd()).equals("漳州市")) {
            message += "该经纬度超出漳州市范围！";
        }
//        if(ToolUtil.isEmpty(entity.getEntryDepartment())){
//            message += "录入部门不能为空！";
//        }
        return message;
    }
}
