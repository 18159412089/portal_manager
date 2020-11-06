package cn.fjzxdz.frame.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 视频属性的配置
 *
 */
@Component
@ConfigurationProperties(prefix = RTCProperties.PREFIX)
public class RTCProperties {
    public static final String PREFIX = "rtc";
    private String appid;
    private String uid;
    private String zpUid;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getZpUid() {
        return zpUid;
    }

    public void setZpUid(String zpUid) {
        this.zpUid = zpUid;
    }
}
