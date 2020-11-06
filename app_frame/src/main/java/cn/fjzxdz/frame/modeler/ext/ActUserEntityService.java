package cn.fjzxdz.frame.modeler.ext;

import java.util.List;

import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.activiti.engine.impl.persistence.entity.UserEntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.UserDao;
import cn.fjzxdz.frame.modeler.util.ActUtils;

@Service
public class ActUserEntityService extends UserEntityManager {
	@Autowired
	private SimpleDao simpleDao;
	@Autowired
	private UserDao userDao;

	public UserEntity findUserById(String userId) {
		return ActUtils.toActivitiUser(userDao.getById(userId));
	}

	@SuppressWarnings("rawtypes")
	public List<Group> findGroupsByUser(String userId) {
		List<Group> list = Lists.newArrayList();
		List result = simpleDao.createNativeQuery(
				"select r.uuid,r.name from sys_role r inner join sys_job_role jr on r.uuid=jr.role inner join sys_job j on jr.job=j.uuid inner join sys_job_user ju on j.uuid=ju.job and ju.user_id=? ",
				userId).getResultList();
		if (null != result && result.size() > 0) {
			for (Object o : result) {
				list.add(ActUtils.toActivitiGroup(o));
			}
		}
		return list;
	}

}