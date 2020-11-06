package cn.fjzxdz.frame.toolbox.support;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import cn.fjzxdz.frame.toolbox.kit.AesKit;

import java.util.Properties;

/**
 * spring参数加密配置
 */
public class EncryptablePropertyPlaceholder extends PropertyPlaceholderConfigurer {

    @Override
    protected void processProperties(ConfigurableListableBeanFactory beanFactory, Properties props) throws BeansException {
        try {
            for (Object key : props.keySet()) {
                if (Convert.toStr(key).contains("encrypt")) {
                    String value = props.getProperty(Convert.toStr(key));
                    if (null != value) {
                        try {
                            String desryptValue = AesKit.decrypt(value);
                            props.setProperty(Convert.toStr(key), desryptValue);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            super.processProperties(beanFactory, props);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BeanInitializationException(e.getMessage());
        }
    }
}
