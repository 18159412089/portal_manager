/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package ${packageName}.${moduleName}.dao${subModuleName};

import org.springframework.stereotype.Repository;

import cn.fjzxdz.frame.dao.common.PagingDaoSupport;

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};


/**
 * ${functionName}DAO接口
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Repository("${className}")
public class ${ClassName}Dao extends PagingDaoSupport<${ClassName}> {
	
}
