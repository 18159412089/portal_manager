/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package ${packageName}.${moduleName}.entity${subModuleName};

import javax.persistence.Entity;
import javax.persistence.Table;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Entity
@Table(name = "${tableName}")
public class ${ClassName} extends TrackingEntity {
	
	private static final long serialVersionUID = 1L;
	<#list columnList as column>
	<#if column.isNotBaseField>
	<#if column.comments??>/** ${column.comments} */</#if>
	private ${column.javaType} ${column.javaField};
	</#if>
	</#list>
	
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


