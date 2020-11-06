package com.fjzxdz.ams.zphb.module.hbdc.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.debriefing.entity.CommonAttachment;
import com.fjzxdz.ams.module.debriefing.param.CommonAttachmentParam;
import com.fjzxdz.ams.module.debriefing.param.CommonRelationTableParam;

import java.util.List;
import java.util.Map;

/**
 * 
 * 环保督察 具体台账 Service 接口
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月10日 上午10:04:28
 */
public interface ZpStandingBookService {
	
	/**
	 * 
	 * @Title:  getSubClass
	 * @Description:    获取大类对应的小类    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:59:23
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:59:23    
	 * @param type
	 * @return  List<Object[]> 
	 * @throws
	 */
	List<Object[]> getSubClass(String type);
	
	/**
	 * 
	 * @Title:  listByPage
	 * @Description:     获取台账信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:59:30
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:59:30    
	 * @param param
	 * @param page
	 * @return  Page<Map<String,Object>> 
	 * @throws
	 */
	Page<Map<String, Object>> listByPage(CommonRelationTableParam param, Page<Map<String, Object>> page);
	
	/**
	 * 
	 * @Title:  save
	 * @Description:    保存文件信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:59:38
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:59:38    
	 * @param commonAttach  void 
	 * @throws
	 */
	void save(CommonAttachment commonAttach);
	
	/**
	 * 
	 * @Title:  listByPage
	 * @Description:    获取文件信息    
	 * @CreateBy: zhongyunlong 
	 * @CreateTime: 2019年5月10日 上午9:59:48
	 * @UpdateBy: zhongyunlong 
	 * @UpdateTime:  2019年5月10日 上午9:59:48    
	 * @param param
	 * @param page
	 * @return  Page<CommonAttachment> 
	 * @throws
	 */
	Page<CommonAttachment> listByPage(CommonAttachmentParam param, Page<CommonAttachment> page);
}
