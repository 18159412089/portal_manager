package cn.fjzxdz.frame.service.sys;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.entity.core.UserParam;
import cn.fjzxdz.frame.entity.core.UserReLateInfo;
import cn.fjzxdz.frame.pojo.R;

import java.util.List;

public interface UserService {

    R save(User user);

    R saveUserRelateInfo(UserReLateInfo userReLateInfo);

    User getById(String uuid);

    Page<User> listByPage(UserParam param, Page<User> page);

    R assignJob(String uuid, String[] jobIds);

    R editUserStatus(String uuid,Integer enable);

    R editPwd(String uuid,String newPwd);

    R resetPwd(String uuid);

    List<User> findList(UserParam param);

}
