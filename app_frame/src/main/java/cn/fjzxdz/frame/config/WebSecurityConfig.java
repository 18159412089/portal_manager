package cn.fjzxdz.frame.config;

import cn.fjzxdz.frame.filter.KaptchaCaptchaAuthenticationFilter;
import com.alibaba.druid.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.core.GrantedAuthorityDefaults;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import cn.fjzxdz.frame.handler.CustomAccessDeniedHandler;
import cn.fjzxdz.frame.handler.CustomAuthenticationEntryPoint;
import cn.fjzxdz.frame.handler.CustomAuthenticationFailHandler;
import cn.fjzxdz.frame.handler.CustomAuthenticationFilter;
import cn.fjzxdz.frame.handler.CustomAuthenticationSuccessHandler;
import cn.fjzxdz.frame.handler.CustomLogoutSuccessHandler;
import cn.fjzxdz.frame.security.CustomUserService;
import cn.fjzxdz.frame.toolbox.util.MD5Util;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomAuthenticationFailHandler customAuthenticationFailHandler;

    @Autowired
    private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

    @Value("${isOpenSSo}")
    private String isOpenSSo;
    @Value("${server.index.page:#{null}}")
    private String indexPage;

    @Bean
    UserDetailsService customUserService() { // 注册UserDetailsService 的bean
        return new CustomUserService();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customUserService()).passwordEncoder(new PasswordEncoder() {
            @Override
            public String encode(CharSequence rawPassword) {
                return MD5Util.encode((String) rawPassword);
            }

            @Override
            public boolean matches(CharSequence rawPassword, String encodedPassword) {
                return encodedPassword.equals(MD5Util.encode((String) rawPassword));
            }
        });
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        String LoginUrl="";
        //开放sso单点登录
        if("true".equals(isOpenSSo)) {
            LoginUrl="/autoLogin";
        }else {
            LoginUrl="/login";
            // 验证码和其它校验
            KaptchaCaptchaAuthenticationFilter kaptchaCaptchaAuthenticationFilter = new KaptchaCaptchaAuthenticationFilter();
            kaptchaCaptchaAuthenticationFilter.setAuthenticationManager(authenticationManager());
            kaptchaCaptchaAuthenticationFilter.setAuthenticationFailureHandler(customAuthenticationFailHandler);
            http.addFilterBefore(kaptchaCaptchaAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        }
        http
                .exceptionHandling()
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint(LoginUrl))
                .and().authorizeRequests().antMatchers("/license/**","/static/**","/api/**").permitAll().anyRequest().authenticated().and().formLogin()
                .loginPage(LoginUrl).loginProcessingUrl(LoginUrl)
                .failureHandler(customAuthenticationFailHandler).defaultSuccessUrl(StringUtils.isEmpty(indexPage)?"/index":indexPage)
                .successHandler(customAuthenticationSuccessHandler).permitAll()
                .and().logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler(new CustomLogoutSuccessHandler())
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .and().csrf().disable();
        //设置可以iframe访问(相同域名的界面)
        //http.headers().frameOptions().sameOrigin();
        //支持完全放开的方式
        http.headers().frameOptions().disable();
        // 用重写的Filter替换掉原有的UsernamePasswordAuthenticationFilter
        http.addFilterAt(customAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        // 免登录
        web.ignoring().antMatchers("/kaptcha", "/open/**",
                // swagger2静态页面放开
                "/swagger-ui.html", "/swagger-resources/**", "/v2/**", "/webjars/**");
    }

    // 注册自定义的UsernamePasswordAuthenticationFilter
    @Bean
    CustomAuthenticationFilter customAuthenticationFilter() throws Exception {
        CustomAuthenticationFilter filter = new CustomAuthenticationFilter();
        filter.setAuthenticationSuccessHandler(customAuthenticationSuccessHandler);
        filter.setAuthenticationFailureHandler(customAuthenticationFailHandler);
        filter.setFilterProcessesUrl("/login/mobile");
        // 这句很关键，重用WebSecurityConfigurerAdapter配置的AuthenticationManager，不然要自己组装AuthenticationManager
        filter.setAuthenticationManager(authenticationManagerBean());
        return filter;
    }

    /**
     * 去除角色中role_的前缀
     * 表达式需要.access("hasRole('ADMIN')");
     *
     * @throws Exception
     */
    @Bean
    GrantedAuthorityDefaults grantedAuthorityDefaults() {
        return new GrantedAuthorityDefaults(""); // Remove the ROLE_ prefix
    }
}
