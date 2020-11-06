package cn.fjzxdz.frame.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.google.code.kaptcha.Constants;

import cn.fjzxdz.frame.exception.InvalidKaptchaException;
import cn.fjzxdz.frame.toolbox.util.KaptchaUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

public class KaptchaCaptchaAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {

		// 验证验证码是否正确
		if (KaptchaUtil.getKaptchaOnOff()) {
			String kaptcha = request.getParameter("kaptcha").trim();
			String code = (String) request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
			logger.info("开始校验验证码，生成的验证码为：" + code + " ，输入的验证码为：" + kaptcha);

			if (ToolUtil.isEmpty(kaptcha))
				throw new InvalidKaptchaException(messages.getMessage("LoginAuthentication.captchaInvalid",
						"请输入验证码"));
			if (!kaptcha.equalsIgnoreCase(code)) {
				throw new InvalidKaptchaException(messages.getMessage("LoginAuthentication.captchaNotEquals",
						"验证码错误"));
			}
		}
		return super.attemptAuthentication(request, response);
	}

}
