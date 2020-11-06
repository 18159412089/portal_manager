package com.fjzxdz.ams;

import cn.fjzxdz.frame.config.AtomikosJtaPlatform;
import cn.fjzxdz.frame.config.NoPassSsoFilter;
import cn.fjzxdz.frame.filter.WebSiteMeshFilter;
import com.atomikos.icatch.jta.UserTransactionImp;
import com.atomikos.icatch.jta.UserTransactionManager;
import com.fjzxdz.ams.task.EnvironmentRectifitionTask;
import com.xxl.sso.core.filter.XxlSsoFilter;
import com.xxl.sso.core.util.JedisUtil;
import org.activiti.explorer.servlet.JsonpCallbackFilter;
import org.apache.catalina.connector.Connector;
import org.apache.commons.logging.Log;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.jta.JtaTransactionManager;
import org.springframework.web.filter.HttpPutFormContentFilter;

import javax.transaction.TransactionManager;
import javax.transaction.UserTransaction;
import java.util.HashSet;
import java.util.Locale;

@SpringBootApplication(exclude = {org.activiti.spring.boot.SecurityAutoConfiguration.class})
@EnableTransactionManagement
@ComponentScan({"cn.fjzxdz.frame", "org.activiti.rest", "com.fjzxdz.ams"})
@EntityScan(basePackages = {"cn.fjzxdz.frame", "com.fjzxdz.ams"})
@ServletComponentScan(basePackages = "cn.fjzxdz.frame.listener")
@EnableAsync
public class AmsApplication extends SpringBootServletInitializer {
    private static Logger logger = LogManager.getLogger(AmsApplication.class);
    @Value("${sso_server}")
    private String sso_server;

    @Value("${sso.redis.host}")
    private String redisHost;

    @Value("${sso.redis.port}")
    private String redisPort;

    @Value("${isOpenSSo}")
    private String isOpenSSo;

    @Value("${sso.redis.database}")
    private int redisDb;

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(AmsApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(AmsApplication.class, args);
    }

    @Bean
    public OpenEntityManagerInViewFilter openEntityManagerInViewFilter() {
        return new OpenEntityManagerInViewFilter();
    }

    @Bean
    public JsonpCallbackFilter filter() {
        return new JsonpCallbackFilter();
    }

    @Bean
    public HttpPutFormContentFilter putFormFilter() {
        return new HttpPutFormContentFilter();
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Bean
    public FilterRegistrationBean siteMeshFilter() {
        FilterRegistrationBean fitler = new FilterRegistrationBean();
        WebSiteMeshFilter siteMeshFilter = new WebSiteMeshFilter();
        fitler.setFilter(siteMeshFilter);
        return fitler;
    }

    @Bean
    public MessageSource messageSource() {
        Locale.setDefault(Locale.CHINA);
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.addBasenames("classpath:security_message_zh_CN");
        messageSource.addBasenames("classpath:org/springframework/security/messages_zh_CN");
        return messageSource;
    }

    @Bean(name = "userTransaction")
    public UserTransaction userTransaction() throws Throwable {
        UserTransactionImp userTransactionImp = new UserTransactionImp();
        return userTransactionImp;
    }

    @Bean(name = "atomikosTransactionManager", initMethod = "init", destroyMethod = "close")
    public TransactionManager atomikosTransactionManager() throws Throwable {
        UserTransactionManager userTransactionManager = new UserTransactionManager();
        userTransactionManager.setForceShutdown(false);
        AtomikosJtaPlatform.transactionManager = userTransactionManager;

        return userTransactionManager;
    }

    @Bean(name = "transactionManager")
    @DependsOn({"userTransaction", "atomikosTransactionManager"})
    public PlatformTransactionManager transactionManager() throws Throwable {
        UserTransaction userTransaction = userTransaction();

        AtomikosJtaPlatform.transaction = userTransaction;

        TransactionManager atomikosTransactionManager = atomikosTransactionManager();
        return new JtaTransactionManager(userTransaction, atomikosTransactionManager);
    }


    /**
     * 增加sso
     *
     * @return
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @Bean
    public FilterRegistrationBean filterRegistration() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        JedisUtil.init(redisHost + ":" + redisPort, redisDb);
        HashSet<String> notFilterPagesList = (HashSet<String>) JedisUtil.getObjectValue("notFilterPages");
        if (notFilterPagesList == null) {
            notFilterPagesList = new HashSet<String>();
        }
        notFilterPagesList.add("/license");
        notFilterPagesList.add("/static");
        notFilterPagesList.add("/api");
        JedisUtil.setObjectValue("notFilterPages", notFilterPagesList,0);

        if ("true".equals(isOpenSSo)) {
            registration.setFilter(new XxlSsoFilter());
            registration.addUrlPatterns("/*");
            registration.setName("XxlSsoFilter");
            registration.addInitParameter("sso_server", sso_server);
            registration.addInitParameter("encode", "UTF-8");
            registration.addInitParameter("logoutPath", "/logout");
            registration.setOrder(0);
        } else {
            registration.setFilter(new NoPassSsoFilter());
            registration.setOrder(0);
        }
        return registration;
    }


    @Value("${server.http.port}")
    private int httpPort;
    //配置http
    @Bean
    public ServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory();
        tomcat.addAdditionalTomcatConnectors(createStandardConnector()); // 添加http
        return tomcat;
    }

    private Connector createStandardConnector() {
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setPort(httpPort);
        return connector;
    }

}
