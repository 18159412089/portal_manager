package cn.fjzxdz.frame.common;

import cn.fjzxdz.frame.toolbox.util.DateUtil;

import static cn.fjzxdz.frame.common.Constants.SQL_NOT_NULL;
import static cn.fjzxdz.frame.common.Constants.SQL_NULL;

import java.util.Collection;
import java.util.Date;
import java.util.Map;

enum FieldType {

    STRING {
        private SearchCondition fuzzyStrategy;

        @Override
        public String getConditionString(Map<String, Object> params, String fieldName, Object value) {
            String fieldValue = value.toString();
            SearchCondition searchCondition = null;
            if (SQL_NULL.equals(fieldValue)) {
                searchCondition = SearchCondition.NULL;
            } else if (SQL_NOT_NULL.equals(fieldValue)) {
                searchCondition = SearchCondition.NOTNULL;
            } else if (fieldValue.startsWith("*") || fieldValue.endsWith("*")) {
                fieldValue = fieldValue.replaceFirst("^\\*", "%").replaceFirst("\\*$", "%");
                searchCondition = SearchCondition.PURE_LIKE;
            }
            return (searchCondition == null ? getSearchCondition() : searchCondition).getConditionClause(fieldName, fieldValue, params);
        }

        private SearchCondition getSearchCondition() {
            if (fuzzyStrategy == null) {
                try {
                    Class.forName("com.dataweb.domain.Header");
                    fuzzyStrategy = SearchCondition.LIKE;
                } catch (ClassNotFoundException e) {
                    fuzzyStrategy = SearchCondition.EQ;
                }
            }
            return fuzzyStrategy;
        }
    },

    BOOLEAN {
        @Override
        public String getConditionString(Map<String, Object> params, String fieldName, Object fieldValue) {
            return (Boolean) fieldValue ? fieldName + " is true" : fieldName + " is false";
        }
    },

    DATE {
        @Override
        public String getConditionString(Map<String, Object> params, String fieldName, Object fieldValue) {
            String paramName = FieldType.figureParamName(fieldName, params);
            params.put(paramName, this.getSqlValue(fieldValue));
            return fieldName + " = :" + paramName;
        }

        @Override
        public Object getSqlValue(Object fieldValue) {
            return DateUtil.getTheDay((Date) fieldValue);
        }
    },

    COLLECTION {
        @Override
        public String getConditionString(Map<String, Object> params, String fieldName, Object fieldValue) {
            Collection<?> cl = (Collection<?>) fieldValue;
            if (!cl.isEmpty()) {
                String paramName = FieldType.figureParamName(fieldName, params);
                params.put(paramName, fieldValue);
                return fieldName + " in (:" + paramName + ")";
            } else {
                return " 1 <> 1";
            }
        }
    },
    UNKNOW {
        @Override
        public String getConditionString(Map<String, Object> params, String fieldName, Object fieldValue) {
            String paramName = FieldType.figureParamName(fieldName, params);
            params.put(paramName, fieldValue);
            return fieldName + " = :" + paramName;
        }
    };

    public static final FieldType getFieldType(Object fieldValue) {
        if (fieldValue instanceof String) {
            return STRING;
        } else if (fieldValue instanceof Boolean) {
            return BOOLEAN;
        } else if (fieldValue instanceof Date) {
            return DATE;
        } else if (fieldValue instanceof Collection<?>) {
            return COLLECTION;
        }
        return UNKNOW;
    }

    public static String getConditionString(String fieldName, Object fieldValue, Map<String, Object> params) {
        return FieldType.getFieldType(fieldValue).getConditionString(params, fieldName, fieldValue);
    }

    public static String figureParamName(String fieldName, Map<String, Object> params) {
        String paramName = fieldName.replaceAll("\\.", "");
        while (params.keySet().contains(paramName)) {
            paramName += "_";
        }
        return paramName;
    }

    public abstract String getConditionString(Map<String, Object> params, String fieldName, Object fieldValue);

    public Object getSqlValue(Object fieldValue) {
        return fieldValue;
    }

}
