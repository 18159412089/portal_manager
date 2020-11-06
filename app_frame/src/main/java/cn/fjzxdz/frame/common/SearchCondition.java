package cn.fjzxdz.frame.common;

import org.apache.commons.lang3.StringUtils;

import java.util.Map;



public enum SearchCondition {
    EQ("="), GT(">"), GE(">="), LT("<"), LE("<="),PURE_LIKE(" like "), NULL(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return "(" + fieldName + " is null or " + fieldName + "='')";
        }
    },
    NOTNULL(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return "(" + fieldName + " is not null and " + fieldName + "<>'')";
        }
    },
    BLANK(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return "(" + fieldName + " is null or " + fieldName + "='')";
        }
    },
    LIKE(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return PURE_LIKE.getConditionClause(fieldName, '%' + fieldValue.toString() + '%', params);
        }
    },
    LIKE_R(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return PURE_LIKE.getConditionClause(fieldName, fieldValue.toString() + '%', params);
        }
    },
    DEFAULT(null) {
        public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
            return FieldType.getConditionString(fieldName, fieldValue, params);
        }
    };

    private String operation;

    private SearchCondition(String operation) {
        this.operation = operation;
    }

    public String getConditionClause(String fieldName, Object fieldValue, Map<String, Object> params) {
        return getCompareClause(fieldName, fieldValue, operation, params);
    }

    public String getConditionString(String fieldName, Object fieldValue, Map<String, Object> params) {
        if (!isEmpty(fieldValue)) {
            String clause = getConditionClause(fieldName, fieldValue, params);
            if (!StringUtils.isBlank(clause)) {
                return " and " + clause;
            }
        }
        return "";
    }

    protected String getCompareClause(String fieldName, Object fieldValue, String operation, Map<String, Object> params) {
        FieldType fieldType = FieldType.getFieldType(fieldValue);
        if (FieldType.STRING.equals(fieldType)) {
            if (!fieldValue.toString().contains("'")) {
                return fieldName + operation + "'" + fieldValue + "'";
            }
        }
        String paramName = FieldType.figureParamName(fieldName, params);
        params.put(paramName, fieldType.getSqlValue(fieldValue));
        return fieldName + operation + ":" + paramName;
    }

    protected Boolean isEmpty(Object fieldValue) {
        if (fieldValue != null) {
            return StringUtils.isBlank(fieldValue.toString());
        }
        return true;
    }
}
