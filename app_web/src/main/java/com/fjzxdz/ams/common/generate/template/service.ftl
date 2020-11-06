/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package ${packageName}.${moduleName}.service${subModuleName};

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.SimpleDao;

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.dao${subModuleName}.${ClassName}Dao;
import ${packageName}.${moduleName}.param${subModuleName}.${ClassName}Param;

/**
 * ${functionName}Service
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Component
@Transactional(rollbackFor=Exception.class)
public class ${ClassName}Service {

	@SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(${ClassName}Service.class);

	@Autowired
	private ${ClassName}Dao ${className}Dao;
	@Autowired
	private SimpleDao simpleDao;
	
	/**
	 * 分页查询
	 * @param ${className}
	 * @param page
	 * @return
	 */
	public Page<${ClassName}> listByPage(${ClassName}Param ${className}Param, Page<${ClassName}> page) {
		Page<${ClassName}> listPage = ${className}Dao.listByPage(${className}Param, page);
		return listPage;
	}
	
	/**
	 * 更新或新增
	 * @param ${className}
	 */
	public void save(${ClassName} ${className}) {
		if (StringUtils.isNotEmpty(${className}.getUuid())) {
			${className}Dao.update(${className});
		}else{
			${className}.setUuid(null);
			${className}Dao.save(${className});
		}
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 */
	public void delete(String uuid) {
		${className}Dao.deleteById(uuid);
	}
	
}
