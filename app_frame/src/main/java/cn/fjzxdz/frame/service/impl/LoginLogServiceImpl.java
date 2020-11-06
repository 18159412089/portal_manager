package cn.fjzxdz.frame.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.log.LoginLogDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.entity.log.LoginLog;
import cn.fjzxdz.frame.entity.log.LoginLogParam;
import cn.fjzxdz.frame.service.LoginLogService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * 登录日志
 *
 * @author liuyankun
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class LoginLogServiceImpl implements LoginLogService {

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(LoginLogServiceImpl.class);

    @Autowired
    private LoginLogDao loginLogDao;

    @Autowired
    private UserDao userDao;


    @Override
    public void save(LoginLog loginLog) {
        loginLogDao.save(loginLog);
    }

    @Override
    public Page<LoginLog> listByPage(LoginLogParam loginLogParam, Page<LoginLog> page) {
        Page<LoginLog> loginLogPage = loginLogDao.listByPage(loginLogParam, page);
        List<LoginLog> loginLogList = loginLogPage.getResult();
        if (ToolUtil.isNotEmpty(loginLogList)) {
            Set<String> loginLogSet = new HashSet<>();
            for (LoginLog loginLog : loginLogList) {
                loginLogSet.add("'" + loginLog.getUserid() + "'");
            }
            String uuidS = StringUtils.replaceAll(loginLogSet.toString(), "[\\[\\]]", "");
            List<User> userList = userDao.selectListNative("select u.uuid,u.name from sys_user u where u.uuid in(" + uuidS + ")");
            for (LoginLog loginLog : loginLogList) {
                for (Object user : userList) {
                    JSONArray userJr = (JSONArray) JSONObject.toJSON(user);
                    if (loginLog.getUserid().equals(userJr.get(0))) {
                        loginLog.setUserName(userJr.get(1).toString());
                    }
                }
            }
        }

        return loginLogPage;
    }
}
