package cn.fjzxdz.frame.dao.common;

import cn.fjzxdz.frame.common.AlQuery;
import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.entity.AlEntity;
import cn.fjzxdz.frame.exception.AmsException;
import cn.fjzxdz.frame.exception.ObjectNotFoundException;
import cn.fjzxdz.frame.toolbox.util.ReflectionUtils;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.util.Assert;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 
 * JPA封装DAO类 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 上午8:53:15
 */
public class SimpleDaoSupport<T> implements BaseDao<T> {

    private EntityManager entityManager;

    private Class<T> entityClass;

    SimpleDaoSupport() {
        this.entityClass = ReflectionUtils.getSuperClassGenricType(getClass());
    }

    private Class<T> getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected EntityManager getEntityManager() {
        return entityManager;
    }

    @PersistenceContext(unitName="mainPersistenceUnit")
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    //=============================================CURD================================================================

    @Override
    public void clear() {
        entityManager.clear();
    }

    @Override
    public void flush() {
        entityManager.flush();
    }

    @Override
    public void refresh(Object var1) {
        entityManager.refresh(var1);
    }

    @Override
    public void detach(Object object) {
        getHibernateSession().evict(object);
//        entityManager.detach(entity);
    }

    @Override
    public boolean contains(Object object) {
        return entityManager.contains(object);
    }

    @Override
    public void close() {
        entityManager.close();
    }

    @Override
    public boolean isOpen() {
        return entityManager.isOpen();
    }

    @Override
    public void save(T t) {
        this.entityManager.persist(t);
    }

    @Override
    public void saveBatch(List<T> ts) {
        for (T t : ts) {
            save(t);
        }
    }

    @Override
    public T update(T t) {
        return entityManager.merge(t);
    }

    @Override
    public void updateBatch(List<T> ts) {
        for (T t : ts) {
            update(t);
        }
    }

    @Override
    public void delete(T t) {
        this.entityManager.remove(t);
    }

    @Override
    public void deleteById(Serializable id) {
        this.entityManager.remove(getById(id));
    }

    @Override
    public T getBy(String uniqueField, String value) {
        T findUnique = getUnique("from " + entityClass.getName() + " where " + uniqueField + "=?", value);
        return findUnique;
    }

    @Override
    public T getById(Serializable id) {
        T entity = entityManager.find(entityClass, id);
        if (entity == null) {
            throw new ObjectNotFoundException("recordNotExist");
        }
        return entity;
    }

    @SuppressWarnings({ "unchecked", "hiding" })
	@Override
    public <T> T getUnique(final String hql, final Object... values) {
        return (T) createQuery(hql, values).getSingleResult();
    }

    @SuppressWarnings({ "unchecked", "hiding" })
	@Override
    public <T> T getUniqueByMap(String hql, Map<String, Object> values) {
        return (T) createQuery(hql, values).getSingleResult();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectListAll() {
        return createQuery("select obj from " + entityClass.getName() + " obj").getResultList();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectListAllOrderBy(String orderBy) {
        return createQuery("select obj from " + entityClass.getName() + " obj order by " + orderBy + " asc").getResultList();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectList(final String queryString, Object... params) {
        return createQuery(queryString, params).getResultList();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectList(final String queryString, Map<String, ?> params) {
        return createQuery(queryString, params).getResultList();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectListNative(final String queryString, Object... params) {
        return createNativeQuery(queryString, params).getResultList();
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectListNative(final String queryString, Map<String, ?> params) {
        return createNativeQuery(queryString, params).getResultList();
    }

    @Override
    public List<T> selectListBy(String fieldName, Object value) {
        return selectList("from " + entityClass.getName() + " where " + fieldName + "=?", value);
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> selectListByQueryObj(BaseQueryParam queryObj) {
        Query query = createQuery(queryObj.getQueryString(), queryObj.getParams());
        if (queryObj.getLimitResult() != null) {
            query.setMaxResults(queryObj.getLimitResult());
        }
        return (List<T>) query.getResultList();
    }

    @Override
    public List<T> selectListByModel(AlEntity model) {
        AlQuery query = new AlQuery(model);
        return selectListByQueryObj(query);
    }

    @SuppressWarnings("unchecked")
	public T newEntity() throws AmsException {
        try {
            return (T) ReflectionUtils.getSuperClassGenricType(getClass()).getConstructor().newInstance();
        } catch (Exception e) {
            throw new AmsException(e.getMessage());
        }
    }

    protected DetachedCriteria createDetachedCriteria() {
        return DetachedCriteria.forClass(entityClass);
    }

    protected Session getHibernateSession() {
    	/**
    	 * 获取持久化实现者的引用
    	 */
        return (Session) entityManager.getDelegate();
    }

    protected String getEnityName() {
        return getEntityClass().getSimpleName();
    }

    protected List<T> constructList(String cols, List<Object[]> list) {
        return ReflectionUtils.constructList(entityClass, cols, list);
    }

    protected String getCriteriaClause(String sql) {
        sql = "from " + StringUtils.substringAfter(sql, "from");
        return StringUtils.substringBefore(sql, "order by");
    }

    protected String replaceEntityName(String queryString, boolean isNative) {
    	String matches = ".*from\\s*Entity.*";
        if (queryString.matches(matches)) {
            return queryString.replace("Entity", isNative ? getEntityClass().getAnnotation(Table.class).name() : this.getEnityName());
        }
        return queryString;
    }

    //=============================================封装List查询================================================================

    public Query createQuery(final String queryString, Object... params) {
        return createQuery(queryString, false, params);
    }

    public Query createQuery(final String queryString, Map<String, ?> params) {
        return createQuery(queryString, params, false);
    }

    public Query createNativeQuery(final String queryString, Object... params) {
        return createQuery(queryString, true, params);
    }

    public Query createNativeQuery(final String queryString, Map<String, ?> params) {
        return createQuery(queryString, params, true);
    }

    /**
     * 创建原生SQL查询QUERY实例,指定了返回的实体类型
     * @param queryString
     * @param entityClass
     * @return
     */
    @SuppressWarnings("unchecked")
	public  List<T> createNativeQuery(final String queryString, Class<T> entityClass) {
        Query query =  entityManager.createNativeQuery(queryString,entityClass);
        //执行查询，返回的是实体列表,
        List<T> resultList = query.getResultList();
        return resultList;
    }

    //=============================================私有方法================================================================

    /**
     * 通过多个参数查询
     *
     * @param queryString
     * @param isNative
     * @param params
     * @return
     */
    private Query createQuery(final String queryString, boolean isNative, Object... params) {
        Assert.hasText(queryString, "queryString can not empty");
        Query query;
        if (isNative) {
            query = entityManager.createNativeQuery(queryString);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(i + 1, params[i]);
                }
            }
        } else {
            query = entityManager.createQuery(queryString);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(i, params[i]);
                }
            }
        }
        return query;
    }

    /**
     * 通过map查询
     *
     * @param queryString
     * @param params
     * @param isNative
     * @return
     */
    private Query createQuery(final String queryString, Map<String, ?> params, boolean isNative) {
        Assert.hasText(queryString, "queryString can not empty");
        Query query;
        if (isNative) {
            query = entityManager.createNativeQuery(replaceEntityName(queryString, true));
        } else {
            query = entityManager.createQuery(replaceEntityName(queryString, false));
        }
        if (params != null) {
            for (Map.Entry<String, ?> entry : params.entrySet()) {
                query.setParameter(entry.getKey(), entry.getValue());
            }
        }
        return query;
    }
}
