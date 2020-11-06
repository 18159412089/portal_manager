package cn.fjzxdz.frame.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.support.spring.FastJsonJsonView;

import cn.fjzxdz.frame.exception.BizExceptionEnum;
import cn.fjzxdz.frame.log.LogRunner;
import cn.fjzxdz.frame.log.factory.LogTaskFactory;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;

/**
 * 全局的的异常拦截器（拦截所有的控制器）（带有@RequestMapping注解的方法上都会拦截）
 *
 */
@ControllerAdvice
@Order(-1)
public class GlobalExceptionHandler {

	/**
	 * 拦截权限异常
	 */
	@ExceptionHandler(AccessDeniedException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	public ModelAndView credentials(RuntimeException e, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		LogRunner.me().executeLog(LogTaskFactory.exceptionLog(SpringSecurityUtils.getCurrentUserUuid(), "权限异常", e));
		e.printStackTrace();
		if (isAjax(request)) {
			return jsonResult(BizExceptionEnum.FORBIDDEN.getCode(), BizExceptionEnum.FORBIDDEN.getMessage());
		} else {
			return normalResult(BizExceptionEnum.FORBIDDEN.getMessage(), "/error/403");
		}
	}

	/**
	 * 拦截没有服务异常
	 */
	@ExceptionHandler(value = NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
		LogRunner.me()
				.executeLog(LogTaskFactory.exceptionLog(SpringSecurityUtils.getCurrentUserUuid(), "您访问的资源不存在", e));
		e.printStackTrace();
		if (isAjax(req)) {
			return jsonResult(BizExceptionEnum.NOT_FOUND_ERROR.getCode(),
					BizExceptionEnum.NOT_FOUND_ERROR.getMessage());
		} else {
			return normalResult(BizExceptionEnum.NOT_FOUND_ERROR.getMessage(), "/error/404");
		}
	}

	/**
	 * 拦截未知的运行时异常
	 */
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public ModelAndView internalServerError(Exception e, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		LogRunner.me()
				.executeLog(LogTaskFactory.exceptionLog(SpringSecurityUtils.getCurrentUserUuid(), "服务器未知运行时异常", e));
		e.printStackTrace();
		if (isAjax(request)) {
			return jsonResult(BizExceptionEnum.SERVER_ERROR.getCode(), BizExceptionEnum.SERVER_ERROR.getMessage());
		} else {
			return normalResult(BizExceptionEnum.SERVER_ERROR.getMessage(), "/error/500");
		}
	}

	/**
	 * 判断是否ajax请求或者Json的请求类型
	 *
	 * @param request 请求对象
	 * @return true:ajax请求 false:非ajax请求
	 */
	private boolean isAjax(HttpServletRequest request) {
		return (request.getHeader("X-Requested-With") != null && "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With")))
				|| (request.getContentType()!=null && request.getContentType().equals(MediaType.APPLICATION_JSON_UTF8_VALUE))
				|| (request.getContentType()!=null && request.getContentType().equals(MediaType.APPLICATION_JSON_VALUE));
	}

	/**
	 * 返回错误页
	 *
	 * @param message 错误信息
	 * @param url     错误页url
	 * @return 模型视图对象
	 */
	private ModelAndView normalResult(String message, String url) {
		Map<String, String> model = new HashMap<String, String>();
		model.put("errorMessage", message);
		return new ModelAndView(url, model);
	}

	/**
	 * 返回错误数据
	 *
	 * @param message 错误信息
	 * @return 模型视图对象
	 */
	private ModelAndView jsonResult(int code, String message) {
		ModelAndView mv = new ModelAndView();
		FastJsonJsonView view = new FastJsonJsonView();
		view.setAttributesMap((JSONObject) JSON.toJSON(new Result(code, message)));
		mv.setView(view);
		return mv;
	}
}
