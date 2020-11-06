package cn.fjzxdz.frame.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import cn.fjzxdz.frame.entity.core.User;

public interface UserRepository extends JpaRepository<User, String>,JpaSpecificationExecutor<User> {

}
