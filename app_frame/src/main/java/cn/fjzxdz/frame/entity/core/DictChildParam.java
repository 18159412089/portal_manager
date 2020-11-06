package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class DictChildParam extends BaseQueryParam {

	private static final long serialVersionUID = 4675436948732723121L;

	private String pid;

	private String type;

	private String value;

	private Integer enable;

	private Integer num;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public DictChildParam() {
		super(Dict.class);
		this.clazz = Dict.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("pid", getPid(), SearchCondition.EQ);
		addClause("num", getNum(), SearchCondition.EQ);
		addClause("type", getType(), SearchCondition.LIKE);
		addClause("value", getValue(), SearchCondition.LIKE);
		addClause("enable", getEnable(), SearchCondition.EQ);
		setOrderBy(" num asc");
	}

	public Integer getEnable() {
		return enable;
	}

	public void setEnable(Integer enable) {
		this.enable = enable;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}