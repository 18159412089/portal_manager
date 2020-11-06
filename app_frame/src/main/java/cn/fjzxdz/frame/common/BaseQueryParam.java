package cn.fjzxdz.frame.common;

import org.apache.commons.lang3.StringUtils;

import cn.fjzxdz.frame.entity.AlEntity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaseQueryParam implements AlEntity {
    private static final long serialVersionUID = 1L;

    private Map<String, Object> params = new HashMap<String, Object>();

    protected String entity = "Entity";

    private List<Object> clauses = new ArrayList<Object>();

    private Integer limitResult;

    private String groupBy;

    private String orderBy;

    private String queryString;

    private String whereClause;

    public BaseQueryParam() {
    }

    public BaseQueryParam(String entity) {
        this.entity = entity;
    }

    @SuppressWarnings("rawtypes")
	public BaseQueryParam(Class clazz) {
        this.entity = null != clazz ? clazz.getSimpleName() : entity;
    }

    public String getQueryString() {
        if (queryString == null) {
            getWhereClause();
            String[] clauseStrs = new String[]{"from " + entity, "", "", ""};
            clauseStrs[1] = getCluaseString("where", whereClause);
            clauseStrs[2] = getCluaseString("group by", groupBy);
            clauseStrs[3] = getCluaseString("order by", orderBy);
            queryString = StringUtils.join(clauseStrs, " ");
        }
        return queryString;
    }

    private String getCluaseString(String clauseName, String value) {
        if (StringUtils.isNotBlank(value)) {
            return clauseName + " " + value;
        }
        return "";
    }

    public String getWhereClause() {
        if (whereClause == null) {
            this.createQueryClauses();
            whereClause = StringUtils.join(clauses, " ").trim().replaceAll("^and ", "").replaceAll("\\s+", " ");
        }
        return whereClause;
    }

    protected void createQueryClauses() {
    }

    public void addNativeClause(String clause) {
        clauses.add(clause);
    }

    /**
     * @param fieldName  The fieldname of entity, which mapping to the table
     * @param fieldValue The fieldValue for fieldname
     * @return
     */
    public BaseQueryParam addClause(String fieldName, Object fieldValue) {
        return this.addClause(fieldName, fieldValue, SearchCondition.DEFAULT);
    }

    public BaseQueryParam addClause(String fieldName, Object fieldValue, SearchCondition condition) {
        condition = condition == null ? SearchCondition.DEFAULT : condition;
        clauses.add(condition.getConditionString(fieldName, fieldValue, params));
        return this;
    }

    public BaseQueryParam addBlankClause(String fieldName, String fieldValue) {
        if ("_blank".equals(fieldValue)) {
            return addClause(fieldName, fieldValue, SearchCondition.BLANK);
        } else {
            return addClause(fieldName, fieldValue, SearchCondition.EQ);
        }
    }

    public void addCalusesFrom(BaseQueryParam query) {
        query.getWhereClause();
        this.clauses.addAll(query.clauses);
        this.params.putAll(query.getParams());
    }
    
    public Map<String, Object> getParams() {
        return params;
    }

    public Integer getLimitResult() {
        return limitResult;
    }

    public void setLimitResult(Integer limitResult) {
        this.limitResult = limitResult;
    }

    public String getGroupBy() {
        return groupBy;
    }

    public void setGroupBy(String groupBy) {
        this.groupBy = groupBy;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

}
