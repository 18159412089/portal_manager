package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class DictParam extends BaseQueryParam {

	private static final long serialVersionUID = 5563966780765347837L;

	private String pid;

	private String dictName;

	private String type;

	private String value;

	private Integer num;

	private Integer enable;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public DictParam() {
		super(Dict.class);
		this.clazz = Dict.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("pid", getPid(), SearchCondition.NULL);
		addClause("type", getType(), SearchCondition.LIKE);
		// addClause("name", getDictName(), SearchCondition.LIKE);
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

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public String getType() {
		return type;
	}

	public void setType(String Type) {
		this.type = Type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}