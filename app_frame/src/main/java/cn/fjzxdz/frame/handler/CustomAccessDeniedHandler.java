package cn.fjzxdz.frame.handler;

import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.utils.CommonUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 
 * 如果异常是 AccessDeniedException 且用户不是匿名用户，如果否则交给 AccessDeniedHandler 处理
 *
 */
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// 如果是ajax请求
		if (CommonUtil.isApiRequest(httpServletRequest)) {
			httpServletResponse.setHeader("Content-Type", "application/json;charset=utf-8");
			httpServletResponse.getWriter().println(JSONUtil.toJsonStr(new Result(ReturnEum.FORBIDDEN)));
			httpServletResponse.getWriter().flush();
			return;
		} else if (!httpServletResponse.isCommitted()) {
			if (clientErrorPage != null) {
				// Put exception into request scope (perhaps of use to a view)
				httpServletRequest.setAttribute(WebAttributes.ACCESS_DENIED_403, accessDeniedException);
				// Set the 403 status code.
				httpServletResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
				// forward to error page.
				RequestDispatcher dispatcher = httpServletRequest.getRequestDispatcher(clientErrorPage);
				dispatcher.forward(httpServletRequest, httpServletResponse);
			} else {
				httpServletResponse.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedException.getMessage());
			}
		}

	}

	private String clientErrorPage;

	public void setClientErrorPage(String clientErrorPage) {

		if ((clientErrorPage != null) && !clientErrorPage.startsWith("/")) {
			throw new IllegalArgumentException("errorPage must begin with '/'");
		}
		this.clientErrorPage = clientErrorPage;
	}

}
