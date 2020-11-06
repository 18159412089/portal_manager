package cn.fjzxdz.frame.handler;

import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.utils.CommonUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 
 *如果异常是 AccessDeniedException 且用户是匿名用户，使用 AuthenticationEntryPoint 处理
 *
 */
public class CustomAuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint {

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	// static Pattern apiPattern= Pattern.compile("^/[a-z]v[0-1]/(w|r)/");
	
	public CustomAuthenticationEntryPoint(String loginFormUrl) {
		super(loginFormUrl);
	}

	/**
	 * 转发重定向到登录页面
	 * <p>Title: commence</p>   
	 * <p>Description: </p>   
	 * @param request
	 * @param response
	 * @param authException
	 * @throws IOException
	 * @throws ServletException   
	 * @see org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint#commence(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.security.core.AuthenticationException)
	 */
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {

		String redirectUrl = null;
		// String url = request.getRequestURI();
		// Matcher m=apiPattern.matcher(url);
		// if( m.find()){
		if (CommonUtil.isApiRequest(request)) {
			response.setHeader("Content-Type", "application/json;charset=utf-8");
			response.getWriter().println(JSONUtil.toJsonStr(new Result(ReturnEum.FORBIDDEN)));
			response.getWriter().flush();
		} else {
			if (this.isUseForward()) {
				if (this.isForceHttps() && "http".equals(request.getScheme())) {
					// First redirect the current request to HTTPS.
					// When that request is received, the forward to the login
					// page will be used.
					redirectUrl = buildHttpsRedirectUrlForRequest(request);
				}
				if (redirectUrl == null) {
					String loginForm = determineUrlToUseForThisRequest(request, response, authException);
					RequestDispatcher dispatcher = request.getRequestDispatcher(loginForm);
					dispatcher.forward(request, response);
					return;
				}
			} else {
				// redirect to login page. Use https if forceHttps true
				redirectUrl = buildRedirectUrlToLoginPage(request, response, authException);
			}
			redirectStrategy.sendRedirect(request, response, redirectUrl);
		}

	}

}
