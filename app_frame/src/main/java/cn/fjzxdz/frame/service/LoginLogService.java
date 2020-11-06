package cn.fjzxdz.frame.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.log.LoginLog;
import cn.fjzxdz.frame.entity.log.LoginLogParam;

/**
 * 登录日志
 *
 * @author liuyankun
 */
public interface LoginLogService {

    void save(LoginLog loginLog);

    Page<LoginLog> listByPage(LoginLogParam loginLogParam, Page<LoginLog> page);
}
