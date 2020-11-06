package com.fjzxdz.ams.module.enviromonit.poc;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
@Configuration
public class PocConfig {
    @Value("${poc.identify.url}")
    private String identifyUrl;
    @Value("${poc.identify.account}")
    private String identifyAccount;
    @Value("${poc.identify.password}")
    private String identifyPassword;
    @Value("${poc.dispatch.account}")
    private String dispatchAccount;
    @Value("${poc.dispatch.password}")
    private String dispatchPassword;
    @Value("${poc.dispatch.planpassword}")
    private String plaintextPassword;
    @Value("${poc.identify.hostip}")
    private String identifyHostip;

    public String getIdentifyUrl() {
        return identifyUrl;
    }

    public void setIdentifyUrl(String identifyUrl) {
        this.identifyUrl = identifyUrl;
    }

    public String getIdentifyAccount() {
        return identifyAccount;
    }

    public void setIdentifyAccount(String identifyAccount) {
        this.identifyAccount = identifyAccount;
    }

    public String getIdentifyPassword() {
        return identifyPassword;
    }

    public void setIdentifyPassword(String identifyPassword) {
        this.identifyPassword = identifyPassword;
    }

    public String getDispatchAccount() {
        return dispatchAccount;
    }

    public void setDispatchAccount(String dispatchAccount) {
        this.dispatchAccount = dispatchAccount;
    }

    public String getDispatchPassword() {
        return dispatchPassword;
    }

    public void setDispatchPassword(String dispatchPassword) {
        this.dispatchPassword = dispatchPassword;
    }

    public String getPlaintextPassword() {
        return plaintextPassword;
    }

    public void setPlaintextPassword(String plaintextPassword) {
        this.plaintextPassword = plaintextPassword;
    }

    public String getIdentifyHostip() {
        return identifyHostip;
    }

    public void setIdentifyHostip(String identifyHostip) {
        this.identifyHostip = identifyHostip;
    }


}
