package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class MenuParam extends BaseQueryParam {

	private static final long serialVersionUID = -3775561167522280151L;

	private String menuName;

	private String level;

	@SuppressWarnings({ "unused", "rawtypes" })
	private Class clazz;

	public MenuParam() {
		super(Menu.class);
		this.clazz = Menu.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("name", getMenuName(), SearchCondition.EQ);
		addClause("levels", getLevel(), SearchCondition.EQ);
		setOrderBy(" num asc");
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
}