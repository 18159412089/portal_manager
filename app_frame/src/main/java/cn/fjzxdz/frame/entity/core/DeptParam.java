package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;


public class DeptParam extends BaseQueryParam {

    private static final long serialVersionUID = -3775561167522280151L;

    private String deptName;

    private String remark;

    @SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

    public DeptParam() {
        super(Dept.class);
        this.clazz = Dept.class;
    }

    @Override
    protected void createQueryClauses() {
        addClause("name", getDeptName(), SearchCondition.EQ);
        addClause("levels", getRemark(), SearchCondition.LIKE);
        addNativeClause(" and enable=1");
        setOrderBy(" name asc");
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}