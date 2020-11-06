package cn.fjzxdz.frame.service.sys;

import java.util.Map;

import com.alibaba.fastjson.JSONArray;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.core.Dict;
import cn.fjzxdz.frame.entity.core.DictChildParam;
import cn.fjzxdz.frame.entity.core.DictParam;
import cn.fjzxdz.frame.pojo.R;

/**
 * 
 * 字典接口 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 上午9:33:52
 */
public interface DictService {

	/**
	 * 保存字典
	 * @Title:  save
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:34:51
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:34:51    
	 * @param dict
	 * @return  R 
	 * @throws
	 */
	R save(Dict dict);

	/**
	 * 根据id获取字典
	 * @Title:  getById
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:35:18
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:35:18    
	 * @param uuid
	 * @return  Dict 
	 * @throws
	 */
	Dict getById(String uuid);

	/**
	 * 根据id删除字典
	 * @Title:  delete
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:35:42
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:35:42    
	 * @param uuid  void 
	 * @throws
	 */
	void delete(String uuid);

	/**
	 * 字典分页查询
	 * @Title:  listByPage
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:36:09
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:36:09    
	 * @param dictParam
	 * @param page
	 * @return  Page<Dict> 
	 * @throws
	 */
	Page<Dict> listByPage(DictParam dictParam, Page<Dict> page);

	/**
	 * 子字典分页查询
	 * @Title:  listByPage
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:36:50
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:36:50    
	 * @param dictParam
	 * @param page
	 * @return  Page<Dict> 
	 * @throws
	 */
	Page<Dict> listByPage(DictChildParam dictParam, Page<Dict> page);

	/**
	 * 根据type获取子字典
	 * @Title:  getDictData
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:37:30
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:37:30    
	 * @param type
	 * @return  JSONArray 
	 * @throws
	 */
	JSONArray getDictData(String type);

	/**
	 * 根据type，获取子字典的key-value
	 * @Title:  getValueMap
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:38:09
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:38:09    
	 * @param type
	 * @return  Map<String,String> 
	 * @throws
	 */
	Map<String, String> getValueMap(String type);

	/**
	 * 根据type获取value值
	 * @Title:  getValueByType
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:38:50
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:38:50    
	 * @param type
	 * @return  String 
	 * @throws
	 */
	String getValueByType(String type);

	/**
	 * 根据id传出一个key-value
	 * @Title:  getDictById
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:39:24
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:39:24    
	 * @param id
	 * @return  Map<String,Object> 
	 * @throws
	 */
	Map<String, Object> getDictById(String id);

}
