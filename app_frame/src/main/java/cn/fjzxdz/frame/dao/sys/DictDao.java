package cn.fjzxdz.frame.dao.sys;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.core.Dict;

import org.springframework.stereotype.Repository;

@Repository("dictDao")
public class DictDao extends PagingDaoSupport<Dict> {
}
