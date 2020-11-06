package cn.fjzxdz.frame.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextImpl;

import cn.fjzxdz.frame.security.CustomerUserDetail;

public class CommonUtil {

	private static final String CustomerUserDetail = null;
	/**
	 * 判断是否ajax请求或者Json的请求类型
	 *
	 * @param request
	 *            请求对象
	 * @return true:ajax请求 false:非ajax请求
	 */
	public static boolean isAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
				|| MediaType.APPLICATION_JSON_UTF8_VALUE.equals(request.getContentType())
				|| MediaType.APPLICATION_JSON_VALUE.equals(request.getContentType());
	}

	/**
	 * 判断是否请求是否是对外开放API请求，匹配API请求URL规则,请求路径中必须包含"/api/"，目前将ajax的请求也放开
	 * @param request
	 * @return
	 */
	public static boolean isApiRequest(HttpServletRequest request) {
		//匹配API请求URL规则,请求路径中必须包含"/api/"
		Pattern apiPattern = Pattern.compile("/api/");
		String url = request.getRequestURI();
		Matcher m = apiPattern.matcher(url);
		if (m.find() || isAjax(request)) {
			//目前将ajax的请求也放开
			return true;
		}
		return false;
	}
	/**
	 * 获取登录用户的用户名称和uui
	 */
	public static CustomerUserDetail getCustommerUserDetail(HttpServletRequest request) {
		SecurityContextImpl securityContextImpl = (SecurityContextImpl) request.getSession()
				.getAttribute("SPRING_SECURITY_CONTEXT");
		return (CustomerUserDetail) securityContextImpl.getAuthentication().getPrincipal();
	}

	/**
	 * 获取登录用户的用户名称 由名称获取后缀或前缀 登录修改小河流域信息时使用
	 */
	public static String[] getCustommerUserDetailName(HttpServletRequest request) {
		SecurityContextImpl securityContextImpl = (SecurityContextImpl) request.getSession()
				.getAttribute("SPRING_SECURITY_CONTEXT");
		CustomerUserDetail cust = (CustomerUserDetail) securityContextImpl.getAuthentication().getPrincipal();
		if (cust != null && cust.getUsername() != null) {
			String[] split = cust.getUsername().split("_");
			return split.length == 2 ? split : null;
		}
		return null;
	}

}
