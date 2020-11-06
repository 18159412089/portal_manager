package com.fjzxdz.ams.apply.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.apply.entity.Apply;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

@Repository("applyDao")
public class ApplyDao extends PagingDaoSupport<Apply> {

}
