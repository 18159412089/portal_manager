package com.fjzxdz.ams.module.jobSchedule.service;

import com.fjzxdz.ams.module.jobSchedule.entity.CliqueBuild;
import com.fjzxdz.ams.module.jobSchedule.param.CliqueBuildParam;

import cn.fjzxdz.frame.common.Page;

/**
 * 
 * 党建service
 * 
 * @Author caibai
 * @Version 1.0
 * @CreateTime 2019年4月30日 下午3:25:22
 */
public interface CliqueBuildService {
   /**
    * 
    * @Title:  listByPage
    * @Description:    分页查询
    * @CreateBy: caibai
    * @CreateTime: 2019年4月30日 下午3:27:07
    * @UpdateBy: caibai
    * @UpdateTime:  2019年4月30日 下午3:27:07    
    * @param param
    * @param page
    * @return  Page<CliqueBuild> 
    * @throws
    */
    Page<CliqueBuild> listByPage(CliqueBuildParam param, Page<CliqueBuild> page);

   /**
    * 
    * @Title:  save
    * @Description:    保存   
    * @CreateBy: caibai 
    * @CreateTime: 2019年4月30日 下午3:27:53
    * @UpdateBy: caibai 
    * @UpdateTime:  2019年4月30日 下午3:27:53    
    * @param cliqueBuild  void 
    * @throws
    */
    void save(CliqueBuild cliqueBuild);

   /**
    * 
    * @Title:  getById
    * @Description:    根据id查询    
    * @CreateBy: caibai 
    * @CreateTime: 2019年4月30日 下午3:29:47
    * @UpdateBy: caibai 
    * @UpdateTime:  2019年4月30日 下午3:29:47    
    * @param uuid
    * @return  CliqueBuild 
    * @throws
    */
    CliqueBuild getById(String uuid);
/**
 * 
 * @Title:  delete
 * @Description:    根据id删除
 * @CreateBy: caibai 
 * @CreateTime: 2019年4月30日 下午3:30:10
 * @UpdateBy: caibai 
 * @UpdateTime:  2019年4月30日 下午3:30:10    
 * @param uuid  void 
 * @throws
 */
    void delete(String uuid);

}
