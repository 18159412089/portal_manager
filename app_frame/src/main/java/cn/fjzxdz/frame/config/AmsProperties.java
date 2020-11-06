package cn.fjzxdz.frame.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 工程单独属性的配置
 *
 */
@Component
@ConfigurationProperties(prefix = AmsProperties.PREFIX)
public class AmsProperties {

    public static final String PREFIX = "ams";

    private Boolean kaptchaOpen = false;
    
    public Boolean getKaptchaOpen() {
        return kaptchaOpen;
    }

    public void setKaptchaOpen(Boolean kaptchaOpen) {
        this.kaptchaOpen = kaptchaOpen;
    }
}
