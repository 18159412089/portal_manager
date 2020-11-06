package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 
 * 用户查询类 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月16日 上午11:08:35
 */
@SuppressWarnings("serial")
public class UserParam extends BaseQueryParam {

	private String loginname;

	private String name;

	private String phone;

	private Integer sex;

	private Integer enable;

	private LoginType logintype;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public UserParam() {
		super(User.class);
		this.clazz = User.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("loginname", getLoginname(), SearchCondition.LIKE);
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("phone", getPhone(), SearchCondition.LIKE);
		addClause("sex", getSex(), SearchCondition.EQ);
		addClause("enable", getEnable(), SearchCondition.EQ);
		addClause("logintype", getLogintype(), SearchCondition.EQ);
		setOrderBy(" create_date desc");
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getEnable() {
		return enable;
	}

	public void setEnable(Integer enable) {
		this.enable = enable;
	}

	public LoginType getLogintype() {
		return logintype;
	}

	public void setLogintype(LoginType logintype) {
		this.logintype = logintype;
	}

}