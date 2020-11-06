package cn.fjzxdz.frame.config;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import java.io.IOException;

/**
 * 放行，过滤器不经过ssoserver
 * @author Administrator
 *
 */
public class NoPassSsoFilter extends HttpServlet implements Filter {
	private static final long serialVersionUID = 1L;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        chain.doFilter(request, response);
        return;
    }

}
