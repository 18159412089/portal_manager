package cn.fjzxdz.frame.license;

import cn.fjzxdz.frame.license.entity.License;
import cn.hutool.json.JSONUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LicenseFilter extends HttpServlet implements Filter {
    private static Logger logger = LoggerFactory.getLogger(LicenseFilter.class);
    //哪些URL不过滤
    private String[] prefixIignores ;
    private String licensePage;
    private String charset;

    public LicenseFilter() {
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.licensePage = filterConfig.getInitParameter("licensePage");
        this.charset = filterConfig.getInitParameter("encode");
        String ignoresParam = filterConfig.getInitParameter("exclusions");
        if (StringUtils.isNotEmpty(ignoresParam)) {
            prefixIignores = ignoresParam.split(",");
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding(this.charset);
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse)response;
        //检查license是否过期
        if(License.getInstance().isLicenseOk(req) || canIgnore(req)){
            chain.doFilter(request, response);
        }else{
            res.sendRedirect(req.getContextPath()+licensePage);
        }
    }

    private boolean canIgnore(HttpServletRequest request) {
        boolean isExcludedPage = false;
        String url = request.getRequestURI();
        // 判断是否在过滤url之外
        for (String page : prefixIignores) {
            if (url.contains(page)) {
                isExcludedPage = true;
                break;
            }
        }
        return isExcludedPage;
    }


}
