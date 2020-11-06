package cn.fjzxdz.frame.dao.common;

import java.lang.reflect.Field;

import javax.persistence.Id;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.AlEntity;
import cn.fjzxdz.frame.toolbox.util.ReflectionUtils;

@Repository
public class EntityDao extends PagingDaoSupport<AlEntity> {
    @Autowired
    private SimpleDao simpleDao;
    
    public AlEntity loadEntity(AlEntity entity) throws Exception {
        Field field = getIdFields(entity.getClass());
        return simpleDao.load(entity.getClass(), ReflectionUtils.getFieldValue(entity, field));
    }

    @SuppressWarnings("unchecked")
    private Field getIdFields(Class<? extends AlEntity> clazz) throws Exception {
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            Id id = field.getAnnotation(Id.class);
            if (id != null) {
                return field;
            }
        }
        if (clazz.isAssignableFrom(AlEntity.class)) {
            return getIdFields((Class<? extends AlEntity>) clazz.getSuperclass());
        }
        throw new Exception();
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	public void findEntityByPage(AlEntity entity, Page page) {
        listByPage(entity, page);
    }
}
