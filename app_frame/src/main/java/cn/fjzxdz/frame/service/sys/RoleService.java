package cn.fjzxdz.frame.service.sys;

import java.util.List;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.entity.core.RoleParam;


public interface RoleService {

    void save(Role role);

    Role getById(String uuid);

    Page<Role> listByPage(RoleParam param, Page<Role> page);

	List<Role> getRoleList(String roleIds);
}
