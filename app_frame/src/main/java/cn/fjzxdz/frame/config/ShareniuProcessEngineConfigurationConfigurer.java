package cn.fjzxdz.frame.config;
import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.interceptor.SessionFactory;
import org.activiti.engine.impl.persistence.StrongUuidGenerator;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.activiti.spring.boot.ProcessEngineConfigurationConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import cn.fjzxdz.frame.modeler.ext.ActGroupEntityServiceFactory;
import cn.fjzxdz.frame.modeler.ext.ActUserEntityServiceFactory;
@Component
public class ShareniuProcessEngineConfigurationConfigurer implements ProcessEngineConfigurationConfigurer  {
	
	@Bean
    public StrongUuidGenerator getStrongUuidGenerator(){
        return new StrongUuidGenerator();
    }	
	
	public void configure(SpringProcessEngineConfiguration processEngineConfiguration) {
		processEngineConfiguration.setActivityFontName("宋体");
		processEngineConfiguration.setLabelFontName("宋体");
		processEngineConfiguration.setAnnotationFontName("宋体");
		processEngineConfiguration.setIdGenerator(getStrongUuidGenerator());
		processEngineConfiguration.setJobExecutorActivate(false);
		processEngineConfiguration.setHistory("none");
		ActUserEntityServiceFactory userFactory = new ActUserEntityServiceFactory();
		ActGroupEntityServiceFactory groupFactory = new ActGroupEntityServiceFactory();
		List<SessionFactory> customSessionFactories =new ArrayList<SessionFactory>();
		customSessionFactories.add(groupFactory);
		customSessionFactories.add(userFactory);
		processEngineConfiguration.setCustomSessionFactories(customSessionFactories);
	}
}