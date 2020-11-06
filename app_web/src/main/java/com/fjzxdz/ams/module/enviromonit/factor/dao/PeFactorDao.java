/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.factor.dao;

import org.springframework.stereotype.Repository;

import com.fjzxdz.ams.module.enviromonit.factor.entity.PeFactor;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;


/**
 * 污染源自动监控点位采集因子DAO接口
 * @author htj
 * @date 2019-02-11
 */
@Repository("peFactor")
public class PeFactorDao extends PagingDaoSupport<PeFactor> {
	
}
