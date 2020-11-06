package cn.fjzxdz.frame.entity.quartz;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 
 * 定时任务日志查询类 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月16日 上午9:36:24
 */
public class ScheduleLogParam extends BaseQueryParam {

	private static final long serialVersionUID = 1L;

	private String beanName;

	private String methodName;

	private String paramsName;

	private String status;

	@SuppressWarnings({ "unused", "rawtypes" })
	private Class clazz;

	public ScheduleLogParam() {
		super(ScheduleLog.class);
		this.clazz = ScheduleLog.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("bean_name", getBeanName(), SearchCondition.LIKE);
		addClause("method_name", getMethodName(), SearchCondition.LIKE);
		addClause("params", getParamsName(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.EQ);
		setOrderBy(" create_date desc");
	}

	public String getBeanName() {
		return beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getParamsName() {
		return paramsName;
	}

	public void setParamsName(String paramsName) {
		this.paramsName = paramsName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}