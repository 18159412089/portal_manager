package cn.fjzxdz.frame.dao.log;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.log.LoginLog;

import org.springframework.stereotype.Repository;

@Repository("loginLogDao")
public class LoginLogDao extends PagingDaoSupport<LoginLog> {
}