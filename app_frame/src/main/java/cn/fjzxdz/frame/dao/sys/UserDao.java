package cn.fjzxdz.frame.dao.sys;

import org.springframework.stereotype.Repository;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.core.User;


@Repository("userDao")
public class UserDao extends PagingDaoSupport<User> {
}
