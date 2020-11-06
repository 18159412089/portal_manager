package cn.fjzxdz.frame.dao.sys;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.core.Dept;

import org.springframework.stereotype.Repository;

@Repository("deptDao")
public class DeptDao  extends PagingDaoSupport<Dept> {
}
