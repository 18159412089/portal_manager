package cn.fjzxdz.frame.modeler.util;

import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.UserEntity;

import cn.fjzxdz.frame.entity.core.User;

public class ActUtils {
	

	public static UserEntity toActivitiUser(User user){
		if (user == null){
			return null;
		}
		UserEntity userEntity = new UserEntity();
		userEntity.setId(user.getLoginname());
		userEntity.setFirstName(user.getName());
		userEntity.setLastName("");
		userEntity.setPassword(user.getPassword());
		userEntity.setEmail(user.getEmail());
		userEntity.setRevision(1);
		return userEntity;
	}
	
	public static GroupEntity toActivitiGroup(Object o){
		Object[] array = (Object[]) o;
		GroupEntity groupEntity = new GroupEntity();
		groupEntity.setId(array[0].toString());
		groupEntity.setName(array[1].toString());
		groupEntity.setType(array[1].toString());
		groupEntity.setRevision(1);
		return groupEntity;
	}
	
}
