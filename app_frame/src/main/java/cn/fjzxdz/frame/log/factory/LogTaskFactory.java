package cn.fjzxdz.frame.log.factory;


import cn.fjzxdz.frame.constant.LogSucceed;
import cn.fjzxdz.frame.constant.LogType;
import cn.fjzxdz.frame.entity.log.LoginLog;
import cn.fjzxdz.frame.entity.log.OperationLog;
import cn.fjzxdz.frame.service.LoginLogService;
import cn.fjzxdz.frame.service.OperationLogService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.fjzxdz.frame.toolbox.web.SpringContextHolder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.TimerTask;

/**
 * 日志操作任务创建工厂
 *
 * @author liuyankun
 */
public class LogTaskFactory {

    private static Logger logger = LogManager.getLogger(LogManager.class);

    private static LoginLogService loginLogService = SpringContextHolder.getBean(LoginLogService.class);

    private static OperationLogService operationLogService = SpringContextHolder.getBean(OperationLogService.class);


    public static TimerTask loginLog(final String userId, final String ip) {
        return new TimerTask() {
            @Override
            public void run() {
                try {
                    LoginLog loginLog = LogFactory.createLoginLog(LogType.LOGIN, userId, null, ip);
                    loginLogService.save(loginLog);
                } catch (Exception e) {
                    logger.error("创建登录日志异常!", e);
                }
            }
        };
    }

    public static TimerTask loginLog(final String username, final String msg, final String ip) {
        return new TimerTask() {
            @Override
            public void run() {
                LoginLog loginLog = LogFactory.createLoginLog(
                        LogType.LOGIN_FAIL, null, "账号:" + username + "," + msg, ip);
                try {
                    loginLogService.save(loginLog);
                } catch (Exception e) {
                    logger.error("创建登录失败异常!", e);
                }
            }
        };
    }

    public static TimerTask exitLog(final String userId, final String ip) {
        return new TimerTask() {
            @Override
            public void run() {
                LoginLog loginLog = LogFactory.createLoginLog(LogType.EXIT, userId, null, ip);
                try {
                    loginLogService.save(loginLog);
                } catch (Exception e) {
                    logger.error("创建退出日志异常!", e);
                }
            }
        };
    }

    public static TimerTask operateLog(final String userId,final String logname, final String clazzName, final String methodName) {
        return new TimerTask() {
            @Override
            public void run() {
                OperationLog operationLog = LogFactory.createOperationLog(
                        LogType.BUSSINESS, userId, logname, clazzName, methodName, null, LogSucceed.SUCCESS);
                try {
                    operationLogService.save(operationLog);
                } catch (Exception e) {
                    logger.error("创建操作日志异常!", e);
                }
            }
        };
    }

    public static TimerTask exceptionLog(final String userId,final String logname, final Exception exception) {
        return new TimerTask() {
            @Override
            public void run() {
                String msg = ToolUtil.getExceptionMsg(exception);
                OperationLog operationLog = LogFactory.createOperationLog(
                        LogType.EXCEPTION, userId, logname, null, null, msg, LogSucceed.FAIL);
                try {
                    operationLogService.save(operationLog);
                } catch (Exception e) {
                    logger.error("创建异常日志异常!", e);
                }
            }
        };
    }
}
