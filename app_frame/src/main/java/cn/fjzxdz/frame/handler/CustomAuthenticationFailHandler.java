package cn.fjzxdz.frame.handler;

import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.utils.CommonUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component(value = "customAuthenticationFailHandler")
public class CustomAuthenticationFailHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		if (CommonUtil.isApiRequest(request)) {
			this.returnJson(response, exception);
		} else {
			this.returnErrorPage(request, response, exception);
		}
	}

	private void returnJson(HttpServletResponse response, AuthenticationException exception) throws IOException {
		response.setHeader("Content-Type", "application/json;charset=utf-8");
		response.getWriter().println(JSONUtil.toJsonStr(new Result(ReturnEum.LOGIN_FAIL)));
	}

	private void returnErrorPage(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String strUrl = request.getContextPath() + "/login";
		request.getSession().setAttribute("error", 1);
		request.getSession().setAttribute("message", exception.getLocalizedMessage());
		request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
		// 使用该方法会出现错误
		// request.getRequestDispatcher(strUrl).forward(request, response);
		response.sendRedirect(strUrl);
	}

}