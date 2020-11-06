package cn.fjzxdz.frame.handler;

import cn.fjzxdz.frame.log.LogRunner;
import cn.fjzxdz.frame.log.factory.LogTaskFactory;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.pojo.ReturnEum;
import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.service.sys.UserService;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;
import cn.fjzxdz.frame.utils.CommonUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component(value = "customAuthenticationSuccessHandler")
public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Autowired
	private UserService userService;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
		if (null != user) {
			LogRunner.me().executeLog(LogTaskFactory.loginLog(user.getUuid(), SpringSecurityUtils.getCurrentUserIp()));
		}
		if (CommonUtil.isApiRequest(request)) {
			//更新旧平台loginPositionId
//            try {
//                userService.updateLoginPositionId(user.getUuid());
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
            response.setHeader("Content-Type", "application/json;charset=utf-8");
			response.getWriter().print(JSONUtil.toJsonStr(new Result(ReturnEum.SUCCESS,user)));
			response.getWriter().flush();
		} else {

			super.onAuthenticationSuccess(request, response, authentication);
		}
	}

}