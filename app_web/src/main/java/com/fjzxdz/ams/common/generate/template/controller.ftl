/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package ${packageName}.${moduleName}.controller${subModuleName};

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.hutool.core.bean.BeanUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.service${subModuleName}.${ClassName}Service;
import ${packageName}.${moduleName}.dao${subModuleName}.${ClassName}Dao;
import ${packageName}.${moduleName}.param${subModuleName}.${ClassName}Param;

/**
 * ${functionName}Controller
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/${urlPrefix}")
@Secured({ "ROLE_ROOT", "ROLE_ADMIN" })
public class ${ClassName}Controller extends BaseController {

	@Autowired
	private ${ClassName}Dao ${className}Dao;
	@Autowired
	private ${ClassName}Service ${className}Service;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/modules/" + "${viewPrefix}List";
	}
	
	/**
	 * 更新或新增
	 * @param ${className}
	 * @return
	 */	
	@RequestMapping("/save${ClassName}")
	@ResponseBody
	public R save${ClassName}(${ClassName} ${className}) {
		try {
			${className}Service.save(${className});
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/delete${ClassName}")
	@ResponseBody
	public R delete${ClassName}(@RequestParam(value = "uuid") String uuid) {
		try {
			${className}Service.delete(uuid);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/get${ClassName}")
	@ResponseBody
	public Map<String, Object> get${ClassName}(@RequestParam(value = "uuid") String uuid) {
		${ClassName} ${className} = ${className}Dao.getById(uuid);
		return BeanUtil.beanToMap(${className},false,true);
	}
	
	/**
	 * 查询列表
	 * @param ${className}
	 * @param request
	 * @return
	 */
	@RequestMapping("/${className}List")
	@ResponseBody
	public PageEU<${ClassName}> ${className}List(${ClassName}Param ${className}Param, HttpServletRequest request) {
		Page<${ClassName}> page = ${className}Service.listByPage(${className}Param, pageQuery(request));
		return new PageEU<>(page);
	}
	
}
