package cn.fjzxdz.frame.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.log.OperationLogDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.entity.log.OperationLog;
import cn.fjzxdz.frame.entity.log.OperationLogParam;
import cn.fjzxdz.frame.service.OperationLogService;
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
 * 操作日志
 *
 * @author liuyankun
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class OperationLogServiceImpl implements OperationLogService {

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(OperationLogServiceImpl.class);

    @Autowired
    private OperationLogDao operationLogDao;

    @Autowired
    private UserDao userDao;


    @Override
    public void save(OperationLog operationLog) {
        operationLogDao.save(operationLog);
    }

    @Override
    public OperationLog getById(String id) {
        return operationLogDao.getById(id);
    }

    @Override
    public Page<OperationLog> listByPage(OperationLogParam operationLogParam, Page<OperationLog> page) {
        Page<OperationLog> operationLogPage = operationLogDao.listByPage(operationLogParam, page);
        List<OperationLog> operationLogList = operationLogPage.getResult();
        if (ToolUtil.isNotEmpty(operationLogList)) {
            Set<String> operationLogSet = new HashSet<>();
            for (OperationLog operationLog : operationLogList) {
                operationLogSet.add("'" + operationLog.getUserid() + "'");
            }
            String uuidS = StringUtils.replaceAll(operationLogSet.toString(), "[\\[\\]]", "");
            List<User> userList = userDao.selectListNative("select u.uuid,u.name from sys_user u where u.uuid in(" + uuidS + ")");
            for (OperationLog operationLog : operationLogList) {
                for (Object user : userList) {
                    JSONArray userJr = (JSONArray) JSONObject.toJSON(user);
                    if (operationLog.getUserid().equals(userJr.get(0))) {
                        operationLog.setUserName(userJr.get(1).toString());
                    }
                }
            }
        }

        return operationLogPage;
    }
}
