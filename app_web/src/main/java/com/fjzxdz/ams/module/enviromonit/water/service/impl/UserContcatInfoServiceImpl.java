package com.fjzxdz.ams.module.enviromonit.water.service.impl;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.dao.UserContcatInfoDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo;
import com.fjzxdz.ams.module.enviromonit.water.param.UserContcatInfoParam;
import com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 水环境-应急短信下发-水质问题整改任务派发
 *
 * @Author chenmingdao
 * @Version 1.0
 * @CreateTime 2019年5月9日 下午5:14:08
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class UserContcatInfoServiceImpl implements UserContcatInfoService {
    @Autowired
    private UserContcatInfoDao userContcatInfoDao;

    /**
     * <p>Title: getPageList</p>
     * <p>Description: 水环境-应急短信下发-查询水质问题整改任务派发列表</p>
     *
     * @param param
     * @param page
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService#getPageList(com.fjzxdz.ams.module.enviromonit.water.param.UserContcatInfoParam, cn.fjzxdz.frame.common.Page)
     */
    @Override
    public Page<UserContcatInfo> getPageList(UserContcatInfoParam param, Page<UserContcatInfo> page) {
        return userContcatInfoDao.listByPage(param, page);
    }

    /**
     * <p>Title: saveUser</p>
     * <p>Description: 水环境-应急短信下发-水质问题整改任务派发   -修改用户</p>
     *
     * @param userContcatInfo
     * @return
     * @see com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService#saveUser(com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo)
     */
    @Override
    public UserContcatInfo saveUser(UserContcatInfo userContcatInfo) {
        UserContcatInfo temp = userContcatInfoDao.getById(userContcatInfo.getUuid());
        temp.setUserName(userContcatInfo.getUserName());
        temp.setPhone(userContcatInfo.getPhone());
        temp.setAddress(userContcatInfo.getAddress());
        UserContcatInfo update = userContcatInfoDao.update(temp);
        return update;
    }

    /**
     * <p>Title: delUser</p>
     * <p>Description: 水环境-应急短信下发-水质问题整改任务派发-删除用户  </p>
     *
     * @param uuid
     * @see com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService#delUser(java.lang.String)
     */
    @Override
    public void delUser(String uuid) {
        userContcatInfoDao.deleteById(uuid);
    }

    /**
     * <p>Title: addUser</p>
     * <p>Description: 水环境-应急短信下发-水质问题整改任务派发-添加用户</p>
     *
     * @param userContcatInfo
     * @see com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService#addUser(com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo)
     */
    @Override
    public void addUser(UserContcatInfo userContcatInfo) {
        userContcatInfo.setUuid(null);
        userContcatInfoDao.save(userContcatInfo);
    }

    /**
     * <p>Title: save</p>
     * <p>Description: 水环境-应急短信下发-水质问题整改任务派发-保存文件内容</p>
     *
     * @param result
     * @return
     * @throws Exception
     * @see com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService#save(java.lang.String[][])
     */
    @Override
    public String save(String[][] result) throws Exception {
        List<UserContcatInfo> list = new ArrayList<UserContcatInfo>();
        String message = "";
        boolean flag = true;
        for (int i = 0; i < result.length; i++) {
            String[] row = result[i];
            UserContcatInfo contcatInfo = new UserContcatInfo();
            contcatInfo.setUserName(row[1]);
            contcatInfo.setAddress(row[2]);
            contcatInfo.setPhone(row[3]);
            message = patternValid(contcatInfo);
            if (message.length() != 0) {
                message = "第" + (i + 2) + "行出现错误:（" + message + "）请修改后再导入！";
                flag = false;
                break;
            }
            list.add(contcatInfo);
        }
        if (flag) {
            userContcatInfoDao.saveBatch(list);
        }
        return message;
    }

    /**
     * @param contcatInfo
     * @return String
     * @throws
     * @Title: patternValid
     * @Description: 校验手机号格式，名字长度
     * @CreateBy: chenmingdao
     * @CreateTime: 2019年5月9日 下午5:18:46
     * @UpdateBy: chenmingdao
     * @UpdateTime: 2019年5月9日 下午5:18:46
     */
    public String patternValid(UserContcatInfo contcatInfo) {
        String message = "";
        String regex = "^1[3,5,7,8][0-9]{9}$";
        if (contcatInfo.getPhone().length() != 11) {
            message = "手机号长度应为11位数";
        } else {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(contcatInfo.getPhone());
            boolean isMatch = m.matches();
            if (!isMatch) {
                message = "手机号错误";
            }
        }
        if (contcatInfo.getUserName().length() < 1 || contcatInfo.getUserName().length() > 10) {
            message = "名字长度过长";
        }
        if (contcatInfo.getAddress().length() < 1 || contcatInfo.getAddress().length() > 200) {
            message = "地区长度过长";
        }
        return message;
    }

}
