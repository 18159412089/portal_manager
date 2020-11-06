package cn.fjzxdz.frame.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * 验证码错误异常
 *
 */
public class InvalidKaptchaException extends AuthenticationException {

	private static final long serialVersionUID = 1L;

	public InvalidKaptchaException(String msg) {
		super(msg);
	}

	public InvalidKaptchaException(String msg, Throwable t) {
		super(msg, t);
	}
}
