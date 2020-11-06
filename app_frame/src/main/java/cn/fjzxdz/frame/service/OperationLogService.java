package cn.fjzxdz.frame.service;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.log.OperationLog;
import cn.fjzxdz.frame.entity.log.OperationLogParam;

/**
 * 操作日志
 *
 * @author liuyankun
 */
public interface OperationLogService {

    void save(OperationLog operationLog);

    OperationLog getById(String id);

    Page<OperationLog> listByPage(OperationLogParam operationLogParam, Page<OperationLog> page);
}
