package cn.fjzxdz.frame.filter;

import java.io.BufferedReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.fjzxdz.frame.utils.CommonUtil;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.google.gson.Gson;

import cn.fjzxdz.frame.handler.AuthenticationBean;

/**
 * AuthenticationFilter that supports rest login(json login) and form login.
 * 
 * @author chenhuanming
 */
public class CustomAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	@SuppressWarnings("finally")
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {

		// attempt Authentication when Content-Type is json
		if (CommonUtil.isApiRequest(request)) {

//			if (!request.getMethod().equals("POST")) {
//				throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
//			}

			UsernamePasswordAuthenticationToken authRequest = null;
			try {
				BufferedReader reader = request.getReader();
				reader = request.getReader();
				Gson gson = new Gson();
				AuthenticationBean authenticationBean = gson.fromJson(reader, AuthenticationBean.class);
				authRequest = new UsernamePasswordAuthenticationToken(authenticationBean.getUsername(),
						authenticationBean.getPassword());
			} catch (Exception e) {
				System.out.println(e.getMessage());
				authRequest = new UsernamePasswordAuthenticationToken("", "");
				throw new InternalAuthenticationServiceException("Failed to parse authentication request body");
			} finally {
				setDetails(request, authRequest);
				return this.getAuthenticationManager().authenticate(authRequest);
			}
		}

		// transmit it to UsernamePasswordAuthenticationFilter
		else {
			return super.attemptAuthentication(request, response);
		}
	}
}
