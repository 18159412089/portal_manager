package cn.fjzxdz.frame.license;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author dai
 */
@Configuration
public class LicenseConfig {

    public LicenseConfig() {
        System.out.println("LicenseConfig容器启动初始化。。。");
    }

    @Bean
    public FilterRegistrationBean licenseFilterRegistration() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(new LicenseFilter());
        registration.addUrlPatterns("/*");
        registration.setName("LicenseFilter");
        registration.addInitParameter("exclusions", ".js,.gif,.jpg,.png,.css,.ico,/static/,/license");
        registration.addInitParameter("licensePage", "/license");
        registration.addInitParameter("encode", "UTF-8");
        registration.setOrder(1);
        return registration;
    }

}
