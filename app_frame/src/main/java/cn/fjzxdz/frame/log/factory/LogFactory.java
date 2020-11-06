package cn.fjzxdz.frame.log.factory;


import cn.fjzxdz.frame.constant.LogSucceed;
import cn.fjzxdz.frame.constant.LogType;
import cn.fjzxdz.frame.entity.log.LoginLog;
import cn.fjzxdz.frame.entity.log.OperationLog;

import java.util.Date;

/**
 * 日志对象创建工厂
 *
 * @author liuyankun
 */
public class LogFactory {

    /**
     * 创建操作日志
     */
    public static OperationLog createOperationLog(LogType logType, String userId, String logname, String clazzName, String methodName, String msg, LogSucceed succeed) {
        OperationLog operationLog = new OperationLog();
        operationLog.setLogtype(logType.getMessage());
        operationLog.setUserid(userId);
        operationLog.setLogname(logname);
        operationLog.setClassname(clazzName);
        operationLog.setMethod(methodName);
        operationLog.setMessage(msg);
        operationLog.setSucceed(succeed.getMessage());
        operationLog.setCreatetime(new Date());
        return operationLog;
    }

    /**
     * 创建登录日志
     */
    public static LoginLog createLoginLog(LogType logType, String userId, String msg, String ip) {
        LoginLog loginLog = new LoginLog();
        loginLog.setLogname(logType.getMessage());
        loginLog.setUserid(userId);
        loginLog.setIp(ip);
        loginLog.setRemark(msg);
        loginLog.setCreatetime(new Date());
        return loginLog;
    }
}
