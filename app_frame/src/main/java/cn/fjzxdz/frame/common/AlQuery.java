package cn.fjzxdz.frame.common;

import cn.fjzxdz.frame.entity.AlEntity;
import cn.fjzxdz.frame.toolbox.util.ModelDataUtil;

import java.util.HashMap;
import java.util.Map;


public class AlQuery extends BaseQueryParam {
    private static final long serialVersionUID = 1L;

    private Map<String, Object> modelData;

    private Map<String, SearchCondition> conditions = new HashMap<String, SearchCondition>();

    public AlQuery(String entity, Map<String, Object> map) {
        super(entity);
        this.modelData = map;
    }

    public AlQuery(AlEntity model) {
        super(model.getClass().getSimpleName());
        modelData = ModelDataUtil.createModelData(model);
    }

    @SuppressWarnings("rawtypes")
	public AlQuery(AlEntity model, Class entity) {
        super(entity);
        modelData = ModelDataUtil.createModelData(model);
    }

    protected void createQueryClauses() {
        for (String fieldName : modelData.keySet()) {
            addClause(fieldName, modelData.get(fieldName), conditions.get(fieldName));
        }
    }

    public void addCondition(String fieldName, SearchCondition condition) {
        this.conditions.put(fieldName, condition);
    }

    public Map<String, Object> getModelData() {
        return modelData;
    }
}
