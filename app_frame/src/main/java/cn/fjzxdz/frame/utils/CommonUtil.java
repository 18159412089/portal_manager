package cn.fjzxdz.frame.utils;

import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextImpl;

import cn.fjzxdz.frame.security.CustomerUserDetail;

import javax.servlet.http.HttpServletRequest;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CommonUtil {

	/**
	 * 判断是否ajax请求或者Json的请求类型
	 *
	 * @param request 请求对象
	 * @return true:ajax请求 false:非ajax请求
	 */
	public static boolean isAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
				|| MediaType.APPLICATION_JSON_UTF8_VALUE.equals(request.getContentType())
				|| MediaType.APPLICATION_JSON_VALUE.equals(request.getContentType());
	}

	/**
	 * 判断是否请求是否是对外开放API请求，匹配API请求URL规则,请求路径中必须包含"/api/"，目前将ajax的请求也放开
	 * 
	 * @param request
	 * @return
	 */
	public static boolean isApiRequest(HttpServletRequest request) {
		// 匹配API请求URL规则,请求路径中必须包含"/api/"
		Pattern apiPattern = Pattern.compile("/api/");
		String url = request.getRequestURI();
		Matcher m = apiPattern.matcher(url);
		if (m.find() || isAjax(request)) {
			// 目前将ajax的请求也放开
			return true;
		}
		return false;
	}
	
}
