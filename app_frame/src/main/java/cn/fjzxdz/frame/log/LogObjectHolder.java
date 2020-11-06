package cn.fjzxdz.frame.log;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import cn.fjzxdz.frame.toolbox.web.SpringContextHolder;

/**
 * 被修改的bean临时存放的地方
 *
 * @author liuyankun
 */
@Component
@Scope(scopeName = WebApplicationContext.SCOPE_SESSION)
public class LogObjectHolder implements Serializable {

	private static final long serialVersionUID = 1L;

	private Object object = null;

	public void set(Object obj) {
		this.object = obj;
	}

	public Object get() {
		return object;
	}

	public static LogObjectHolder me() {
		LogObjectHolder bean = SpringContextHolder.getBean(LogObjectHolder.class);
		return bean;
	}
}