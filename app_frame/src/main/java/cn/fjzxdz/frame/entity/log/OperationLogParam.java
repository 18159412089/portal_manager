package cn.fjzxdz.frame.entity.log;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.commons.lang3.StringUtils;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 
 * OperationLog查询类
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 下午5:37:57
 */
@SuppressWarnings("serial")
public class OperationLogParam extends BaseQueryParam {

	private String beginTime;

	private String endTime;

	private String logName;

	private String logType;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public OperationLogParam() {
		super(OperationLog.class);
		this.clazz = OperationLog.class;
	}

	@Override
	protected void createQueryClauses() {
		if (StringUtils.isNotEmpty(getBeginTime())) {
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				addClause("createtime", sdfTime.parseObject(getBeginTime() + " 00:00:00"), SearchCondition.GE);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (StringUtils.isNotEmpty(getEndTime())) {
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				addClause("createtime", sdfTime.parseObject(getEndTime() + " 23:59:59"), SearchCondition.LE);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		addClause("logname", getLogName(), SearchCondition.LIKE);
		addClause("logtype", getLogType(), SearchCondition.EQ);
		setOrderBy(" createtime desc");
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getLogName() {
		return logName;
	}

	public void setLogName(String logName) {
		this.logName = logName;
	}

	public String getLogType() {
		return logType;
	}

	public void setLogType(String logType) {
		this.logType = logType;
	}
}