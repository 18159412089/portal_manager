package cn.fjzxdz.frame.aop;

import cn.fjzxdz.frame.log.LogRunner;
import cn.fjzxdz.frame.log.factory.LogTaskFactory;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * 日志记录
 *
 * @author liuyankun
 */
@Aspect
@Component
public class SysLogAop {

    private Logger log = LogManager.getLogger(SysLogAop.class);

    //是否开启操作日志记录  true开启   false关闭
    @Value("${ams.log.operate.open: false}")
    private boolean open;

    @Around("execution(* com.fjzxdz.ams.controller..*(..))")
    public Object recordOperateLog(ProceedingJoinPoint point) throws Throwable {
        if (open) {
            try {
                handle(point);
            } catch (Exception e) {
                log.error("操作日志记录出错!", e);
                CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
                if (null != user) {
                    LogRunner.me().executeLog(LogTaskFactory.exceptionLog(user.getUuid(), "操作日志记录出错!", e));
                }
            }
        }
        Object result = point.proceed();

        return result;
    }

    private void handle(ProceedingJoinPoint point) throws Exception {
        //如果当前用户未登录，不做日志
        CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
        if (null == user) {
            return;
        }

        //获取类名
        String className = point.getTarget().getClass().getName();
        //获取方法名
        Signature sig = point.getSignature();
        MethodSignature msig = (MethodSignature) sig;
        Object target = point.getTarget();
        Method currentMethod = target.getClass().getMethod(msig.getName(), msig.getParameterTypes());
        String methodName = currentMethod.getName();

        LogRunner.me().executeLog(LogTaskFactory.operateLog(user.getUuid(), null, className, methodName));
    }
}