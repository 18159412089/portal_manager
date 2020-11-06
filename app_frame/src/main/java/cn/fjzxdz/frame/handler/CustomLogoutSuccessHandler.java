package cn.fjzxdz.frame.handler;

import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.utils.CommonUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@Component(value = "customLogoutSuccessHandler")
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {
    	if(CommonUtil.isApiRequest(request)){
            response.setHeader("Content-Type", "application/json;charset=utf-8");
            response.getWriter().print(JSONUtil.toJsonStr(new Result(ReturnEum.OK,"退出登录操作成功！")));
            response.getWriter().flush();
    	}else{
    		 SecurityContextHolder.clearContext(); //清空安全上下文
            //response.sendRedirect("/login");
            response.sendRedirect("/autoLogin");
        }
    }
}