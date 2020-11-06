package com.fjzxdz.ams.zphb.module.hbdc.service;


import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.pojo.R;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.debriefing.entity.EnvCancellationAccount;
import com.fjzxdz.ams.module.debriefing.param.EnvCancellationAccountParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface ZpEnvCancellationAccountService {

    Page<EnvCancellationAccount> listByPage(EnvCancellationAccountParam param, Page<EnvCancellationAccount> page);

    JSONObject getEcharts(String startTime);

	R getDescript(EnvCancellationAccountParam param);

	/**
	 * @Title:  getDecription
	 * @Description:    根据项目id和项目状态获取描述信息      
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月5日 下午2:50:55
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月5日 下午2:50:55    
	 * @param id
	 * @param status
	 * @param page
     * @return  Page<Map<String,Object>>
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDecription(String id, String status, Page<Map<String, Object>> page);

	/**
	 * @Title:  getDetail
	 * @Description:    获取描述的详细信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月5日 下午3:11:29
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月5日 下午3:11:29    
	 * @param id
	 * @param page
	 * @return  Page<Map<String,Object>> 
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDetail(String id, Page<Map<String, Object>> page);

	/**
	 * @Title:  getDecriptionAll
	 * @Description:    根据任务状态获取所有描述信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月5日 下午3:20:46
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月5日 下午3:20:46    
	 * @param status
	 * @param page
	 * @param request
	 * @return  Page<Map<String,Object>>
	 * @throws 
	 */ 
	Page<Map<String, Object>> getDecriptionAll(String status, Page<Map<String, Object>> page, HttpServletRequest request);

	/**
	 * @Title:  deleteByUuid
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月6日 下午1:29:43
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月6日 下午1:29:43    
	 * @param uuid  void 
	 * @throws 
	 */ 
	void deleteByUuid(String uuid);


}
