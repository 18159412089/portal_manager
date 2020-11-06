/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.common.generate;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.DefaultResourceLoader;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.Console;
import cn.hutool.core.util.StrUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 代码生成工具
 * @author fushixing
 * @version 2018-07-23
 */
public class Generate {
	/**
	 * 是否启用生成工具
	 */
	private static Boolean isEnable = true;
	/**
	 * 主要提供基本功能模块代码生成。 后期main方法的参数可以搭个页面传值 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		// ========== ↓↓↓↓↓↓ 执行前请修改参数，谨慎执行。↓↓↓↓↓↓ ====================
		// 目录生成结构：{packageName}/{moduleName}/{dao,entity,service,web}/{subModuleName}/{className}
		HashMap<String, String> genSchemeMap = new HashMap<String, String>(20);
		// packageName 包名，这里如果更改包名
		genSchemeMap.put("packageName", "com.fjzxdz.ams.modules");
		// 模块名，例：sys
		genSchemeMap.put("moduleName", "sys");
		// 子模块名（可选）
		genSchemeMap.put("subModuleName", "");
		// 类名，例：user
		genSchemeMap.put("className", "sysCost1");
		// 表名，例：sys_Cost
		genSchemeMap.put("tableName", "sys_Cost1");
		// 类作者，例：fushixing
		genSchemeMap.put("classAuthor", "fushixing");
		// 功能名，例：用户
		genSchemeMap.put("functionName", "成本");
		// 调用生成方法
		generateCode(genSchemeMap);
		// ========== ↑↑↑↑↑↑ 执行前请修改参数，谨慎执行。↑↑↑↑↑↑ ====================
	}
	
	/**
	 * 代码生成工具入口, 主要提供基本功能模块代码生成。 
	 * @param genSchemeMap 生成参数Map
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public static void generateCode(HashMap<String, String> genSchemeMap) throws Exception{
		Console.log("==========Generate Start==========");
		if (!isEnable){
			Console.log("请启用代码生成工具，设置参数：isEnable = true");
			return;
		}
		
		if (StringUtils.isBlank(genSchemeMap.get("moduleName")) || StringUtils.isBlank(genSchemeMap.get("moduleName")) 
				|| StringUtils.isBlank(genSchemeMap.get("className")) || StringUtils.isBlank(genSchemeMap.get("functionName"))){
			Console.log("参数设置错误：包名、模块名、类名、功能名不能为空。");
			return;
		}
		// 获取文件分隔符
		String separator = File.separator;
		// 获取工程路径
		File projectPath = new DefaultResourceLoader().getResource("").getFile();
		while(!new File(projectPath.getPath()+separator+"src"+separator+"main").exists()){
			projectPath = projectPath.getParentFile();
		}
		Console.log("Project Path: {}", projectPath);
		// 模板文件路径
		String tplPath = StringUtils.replace(projectPath+"/src/main/java/com/fjzxdz/ams/common/generate/template", "/", separator);
		Console.log("Template Path: {}", tplPath);
		// Java文件路径
		String javaPath = StringUtils.replaceEach(projectPath+"/src/main/java/"+StringUtils.lowerCase(genSchemeMap.get("packageName")), 
				new String[]{"/", "."}, new String[]{separator, separator});
		Console.log("Java Path: {}", javaPath);
		// 视图文件路径
		String viewPath = StringUtils.replace(projectPath+"/src/main/resources/templates/", "/", separator);
		Console.log("View Path: {}", viewPath);
		// 代码模板配置
		Configuration cfg = new Configuration();
		cfg.setDefaultEncoding("UTF-8");
		cfg.setDirectoryForTemplateLoading(new File(tplPath));
		// 定义模板变量
		Map<String, Object> model = GenUtils.getDataModel(genSchemeMap);
		// loop模板路径下的所有模板文件
		List<File> loopFiles = FileUtil.loopFiles(tplPath);
		// 带后缀文件名
		String fileName = "";
		// 不带后缀文件名
		String fileMainName = "";
		// 首字母大写不带后缀文件名
		String upperFirstFileName = "";
		String filePath = "";
		// 代码复用，减少重复代码
		for (Iterator<File> iterator = loopFiles.iterator(); iterator.hasNext();) {
			File file = (File) iterator.next();
			fileName = file.getName();
			fileMainName = FileUtil.mainName(file);
			upperFirstFileName = "entity.ftl".equals(fileName)?"":StrUtil.upperFirst(fileMainName);
			Template template = cfg.getTemplate(fileName);
			String content = FreeMarkers.renderTemplate(template, model);
			// 页面文件与java文件路径不一样
			if(!"viewList.ftl".equals(fileName)){
				filePath = javaPath
						+ separator
						+ model.get("moduleName")
						+ separator
						+ fileMainName
						+ separator
						+ StringUtils.lowerCase(genSchemeMap.get("subModuleName")) + separator
						+ model.get("ClassName") + upperFirstFileName + ".java";
			}else{
				filePath = viewPath
						+ separator
						+ StringUtils.substringAfterLast( genSchemeMap.get("packageName"), ".")
						+ separator
						+ model.get("moduleName")
						+ separator
						+ StringUtils.lowerCase(genSchemeMap .get("subModuleName")) + separator
						+ model.get("className") + "List.ftl";
			}
			GenUtils.writeFile(content, filePath);
			Console.log(fileMainName+": {}", filePath);
		}
		Console.log("==========Generate Success==========");
	}
}
