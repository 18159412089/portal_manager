package cn.fjzxdz.frame.config;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import cn.fjzxdz.frame.toolbox.util.KaptchaUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

/**
 * FreeMarke配置
 *
 */
@Configuration
public class FreemarkerConfig {

	@Bean
	public FreeMarkerConfigurer freeMarkerConfigurer() {
		FreeMarkerConfigurer configurer = new FreeMarkerConfigurer();
		configurer.setTemplateLoaderPath("classpath:/templates");
		Map<String, Object> variables = new HashMap<>(1);
		variables.put("tool", new ToolUtil());
		variables.put("kaptcha", new KaptchaUtil());
		configurer.setFreemarkerVariables(variables);

		Properties settings = new Properties();
		settings.setProperty("default_encoding", "utf-8");
		settings.setProperty("number_format", "0.##");
		settings.setProperty("auto_import", "/common/common.ftl as al");
		configurer.setFreemarkerSettings(settings);
		return configurer;
	}

}
