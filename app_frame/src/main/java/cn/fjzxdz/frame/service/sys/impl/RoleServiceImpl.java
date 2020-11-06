package cn.fjzxdz.frame.service.sys.impl;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.sys.RoleDao;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.entity.core.RoleParam;
import cn.fjzxdz.frame.service.sys.RoleService;

@Service
@Transactional(rollbackFor=Exception.class)
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleDao roleDao;

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(RoleServiceImpl.class);

    @Override
    @CacheEvict(value = {"userMenuTree", "userFrontMenuTree"}, allEntries = true)
    public void save(Role role) {
        roleDao.save(role);
    }

    @Override
    public Role getById(String uuid) {
        return roleDao.getById(uuid);
    }

    @Override
    public Page<Role> listByPage(RoleParam param, Page<Role> page) {
        return roleDao.listByPage(param, page);
    }

    /**
     * 获取被选中的角色
     *
     * @param roleIds
     * @return
     */
    @Override
    public List<Role> getRoleList(String roleIds) {
    	if(StringUtils.isEmpty(roleIds)) {
    		return roleDao.selectList("from Role r");
    	}
        return roleDao.selectList("from Role r where r.uuid in (" + roleIds + ")");
    }

}
