package com.fjzxdz.ams.module.enviromonit.water.param;

import com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class UserContcatInfoParam  extends BaseQueryParam{

	private static final long serialVersionUID = 8876863512335811532L;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	private String userName;
	
	private String address;
	
	private String phone;
	
	
	public UserContcatInfoParam() {
		super(UserContcatInfo.class);
		this.clazz = UserContcatInfo.class;
	}
	@Override
	protected void createQueryClauses() {
		addClause("userName",getUserName(), SearchCondition.LIKE);
		addClause("address",getAddress(), SearchCondition.LIKE);
		addClause("phone",getPhone(), SearchCondition.LIKE);
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
