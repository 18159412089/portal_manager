package cn.fjzxdz.frame.dao.log;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;
import cn.fjzxdz.frame.entity.log.OperationLog;

import org.springframework.stereotype.Repository;

@Repository("operationLogDao")
public class OperationLogDao extends PagingDaoSupport<OperationLog> {
}