package cn.fjzxdz.frame.toolbox.util;

import cn.fjzxdz.frame.config.AmsProperties;
import cn.fjzxdz.frame.toolbox.web.SpringContextHolder;

/**
 * 验证码工具类
 */
public class KaptchaUtil {

	/**
	 * 获取验证码开关
	 */
	public static Boolean getKaptchaOnOff() {
		return SpringContextHolder.getBean(AmsProperties.class).getKaptchaOpen();
	}
}