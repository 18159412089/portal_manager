package com.fjzxdz.ams.module.enviromonit.pollution.param;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import com.fjzxdz.ams.module.enviromonit.pollution.entity.TestData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class TestDataParam extends BaseQueryParam {

	private String mnNumber;
	
	private String test_type;
	
	private String pointUuid;
	
	private String startTime;
	
	private Date start=null;
	
	private String endTime;
	
	private Date end=null;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public TestDataParam() {
		super(TestData.class);
		this.clazz = TestData.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("mnNumber", getMnNumber(), SearchCondition.LIKE);
		addClause("test_type", getTest_type(), SearchCondition.LIKE);
		addClause("uploadTime", this.start, SearchCondition.GE);
		addClause("uploadTime", this.end, SearchCondition.LT);
		setOrderBy(" uploadTime desc");
	}

	public String getMnNumber() {
		return mnNumber;
	}

	public void SetMnNumber(String mnNumber) {
		this.mnNumber = mnNumber;
	}

	public String getTest_type() {
		return test_type;
	}

	public void setTest_type(String test_type) {
		this.test_type = test_type;
	}

	public String getPointUuid() {
		return pointUuid;
	}

	public void setPointUuid(String pointUuid) {
		this.pointUuid = pointUuid;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) throws Exception {
		SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (StringUtils.isNotEmpty(startTime)) {
			start = sdfTime.parse(startTime+ " 00:00:00");
		}
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) throws Exception {
		SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (StringUtils.isNotEmpty(endTime)) {
			end = sdfTime.parse(endTime+ " 23:59:59");
		}
		this.endTime = endTime;
	}
	
	
}