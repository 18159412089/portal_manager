package cn.fjzxdz.frame.dao.sys;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.core.Role;

import org.springframework.stereotype.Repository;

@Repository("roleDao")
public class RoleDao extends PagingDaoSupport<Role> {
}
