package cn.fjzxdz.frame.entity.log;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;


@SuppressWarnings("serial")
public class LoginLogParam extends BaseQueryParam {

    private String beginTime;

    private String endTime;

    private String logName;

    @SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

    public LoginLogParam() {
        super(LoginLog.class);
        this.clazz = LoginLog.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("createtime", getBeginTime(), SearchCondition.GE);
        addClause("createtime", getEndTime(), SearchCondition.LE);
        addClause("logname", getLogName(), SearchCondition.EQ);
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
}