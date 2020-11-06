/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package ${packageName}.${moduleName}.param${subModuleName};

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
public class ${ClassName}Param extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	<#list columnList as column>
	<#if column.isNotBaseField>
	<#if column.comments??>/** ${column.comments} */</#if>
	private ${column.javaType} ${column.javaField};
	</#if>
	</#list>
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public ${ClassName}Param() {
		super(${ClassName}.class);
		this.clazz = ${ClassName}.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
	<#list columnList as column>
	<#if column.isNotBaseField>
		addClause("${column.javaField}", get${column.javaField?cap_first }(), SearchCondition.LIKE);
	</#if>
	</#list>
	}
	
	<#list columnList as column>
	<#if column.isNotBaseField>
	public ${column.javaType } get${column.javaField?cap_first }() {
		return ${column.javaField};
	}
	
	public void set${column.javaField?cap_first }(${column.javaType } ${column.javaField?uncap_first }) {
		this.${column.javaField} = ${column.javaField};
	}
	</#if>
	</#list>
	
}


