package com.fjzxdz.ams.module.enviromonit.pollution.param;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class TestDataParam2 extends BaseQueryParam {

	private String mnNumber;
	
	private String test_type;
	
	private String startTime;
	
	private Date start;
	
	private String endTime;
	
	private Date end;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public TestDataParam2() {
		super(TestData.class);
		this.clazz = TestData.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("mnNumber", getMnNumber(), SearchCondition.LIKE);
		addClause("test_type", getTest_type(), SearchCondition.LIKE);
		addClause("uploadTime", getStart(), SearchCondition.GE);
		addClause("uploadTime", getEnd(), SearchCondition.LT);
		setOrderBy(" uploadTime asc");
	}

	public Date getStart() {
		return start;
	}
	
	public void setStart(Date start) {
		this.start = start;
	}
	
	public Date getEnd() {
		return end;
	}
	
	public void setEnd(Date end) {
		this.end = end;
	}
	
	public String getMnNumber() {
		return mnNumber;
	}

	public void setMnNumber(String mnNumber) {
		this.mnNumber = mnNumber;
	}

	public String getTest_type() {
		return test_type;
	}

	public void setTest_type(String test_type) {
		this.test_type = test_type;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) throws Exception {
		this.startTime=startTime;
		if (StringUtils.isNotEmpty(startTime)) {
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = sdfTime.parse(startTime+ " 00:00:00");
			setStart(date);
		}
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) throws Exception {
		this.endTime=endTime;
		if (StringUtils.isNotEmpty(endTime)) {
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = sdfTime.parse(endTime+ " 23:59:59");
			setEnd(date);
		}
	}
}