package cn.fjzxdz.frame.dao.common;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.common.SelfResultTransformer;
import cn.fjzxdz.frame.exception.ObjectNotFoundException;
import cn.fjzxdz.frame.toolbox.support.Convert;
import cn.hutool.core.bean.BeanUtil;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class SimpleDao {

	private EntityManager entityManager;

	@PersistenceContext(unitName="mainPersistenceUnit")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void add(Object model) {
		this.entityManager.persist(model);
	}

	public <T> T update(T entity) {
		return entityManager.merge(entity);
	}

	public void delete(Object model) {
		this.entityManager.remove(model);
	}

	public <T> T get(Class<T> entityClass, Object primaryKey) {
		return entityManager.find(entityClass, primaryKey);
	}

	public <T> T load(Class<T> entityClass, Object primaryKey) {
		try {
			T find = entityManager.find(entityClass, primaryKey);
			return find;
		} catch (EntityNotFoundException e) {
			throw new ObjectNotFoundException();
		}
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> getAll(Class<T> entityClass) {
		return this.entityManager.createQuery("select obj from " + entityClass.getName() + " obj").getResultList();
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> getAll(Class<T> entityClass, String orderBy) {
		return this.entityManager
				.createQuery("select obj from " + entityClass.getName() + " obj order by " + orderBy + " asc")
				.getResultList();
	}

	public Query createQuery(final String queryString, Map<String, ?> params) {
		Assert.hasText(queryString, "queryString can not empty");
		Query query = null;
		query = entityManager.createQuery(queryString);
		if (params != null) {
			for (Map.Entry<String, ?> entry : params.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}
		return query;
	}

	protected Query createQuery(final String queryString, Object... params) {
		return createQuery(queryString, false, params);
	}

	public Query createNativeQuery(final String queryString, Object... params) {
		return createQuery(queryString, true, params);
	}

	/**
	 * 注意对实体类和查询字段的一致性需要保持一致
	 * @param queryString
	 * @param entityClass
	 * @param <T>
	 * @return
	 */
	public <T> List<T> createNativeQuery(final String queryString, Class<T> entityClass) {
		Query nativeQuery = entityManager.createNativeQuery(queryString, entityClass);
		return nativeQuery.getResultList();
	}

	/**
	 * 获取查询列表
	 * @param queryStr
	 * @param <T>
	 * @return 返回的是list<map>对象
	 */

	public <T> List<T> getNativeQueryList(final String queryStr) {
		Session session = entityManager.unwrap(Session.class);
		NativeQuery<T> query = session.createNativeQuery(queryStr);
		// 将结果转化为 Map<tableKey, keyValue>
		query.setResultTransformer(new SelfResultTransformer());
		List<T> result = query.getResultList();
		return result;
	}

	/**
	 * 获取查询列表
	 * @param queryStr
	 * @param <T>
	 * @return 返回的是list<Entity>对象
	 */
	public <T> List<T> getNativeQueryList(final String queryStr,Class<T>  entityClass) {
		Session session = entityManager.unwrap(Session.class);
		NativeQuery<T> query = session.createNativeQuery(queryStr);
		// 将结果转化为实体类
		//需要注意的.
		//  (1)这种转换实体类很严格,必须连属性名字要和数据库字段高度一致，不灵活,不采用这种方式，直接使用工具类转化，字段不受限制
		//  (2)实体类可以比表字段少一些字段.
		//所以改成工具类的方式来转换
		//query.setResultTransformer(new AliasToBeanResultTransformer(entityClass));
		// 将结果转化为 Map<tableKey, keyValue>
		query.setResultTransformer(new SelfResultTransformer());
		List<T> tmpResult = query.getResultList();
		List<T> result = new ArrayList<>();
		for(Object object:tmpResult){
			result.add(BeanUtil.toBean(object,entityClass));
		}
		return result;
	}

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
					query.setParameter(i + 0, params[i]);
				}
			}
		}
		return query;
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> find(final String queryString, Object... params) {
		Query query = null;
		query = entityManager.createQuery(queryString);
		if (params != null && params.length > 0) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i + 0, params[i]);
			}
		}
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	protected <X> X findUnique(String hql, Map<String, Object> values) {
		return (X) createQuery(hql, values).getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public <X> X findUnique(final String hql, final Object... values) {
		return (X) createQuery(hql, values).getSingleResult();
	}

	public <T> T loadBy(Class<T> entityClass, String uniqueField, String value) {
		T findUnique = findUnique("from " + entityClass.getName() + " where " + uniqueField + "=?", value);
		return findUnique;
	}

	public <T> List<T> findBy(Class<T> entityClass, String fieldName, Object value) {
		return find("from " + entityClass.getName() + " where " + fieldName + "=?", value);
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	public <T> Page<T> listNativeByPage(String queryStr, Page<T> page) {
		queryStr += page.getOrderString();

		Session session = entityManager.unwrap(Session.class);
		NativeQuery<T> query = session.createNativeQuery(queryStr);
		// 将结果转化为 Map<tableKey, keyValue>
		query.setResultTransformer(new SelfResultTransformer());
	

		Integer totalCount = countSqlResult(queryStr).intValue();
		page.setTotalCount(totalCount);
		if (totalCount == 0) {
			return page;
		}
		setPageParameter(query, page);
		List<T> result = query.getResultList();
		page.setResult(result);
		return page;
	}

	/**
	 * 获取查询记录
	 *
	 * @param sql
	 * @param values
	 * @return
	 */
	protected Long countSqlResult(final String sql) {

		String countHql = "select count(*) from (" + sql + ") count";

		try {
			return Convert.toLong(createNativeQuery(countHql).getSingleResult());
		} catch (NoResultException e) {
			return 0L;
		} catch (Exception e) {
			throw new RuntimeException("sql can't be auto count, sql is:" + countHql, e);
		}
	}
	/**
	 * 获取查询记录
	 *
	 * @param sql
	 * @param values
	 * @return
	 */
	public Long getCountSqlResult(final String sql) {
		String countHql = "select count(*) from (" + sql + ") count";
		try {
			return Convert.toLong(createNativeQuery(countHql).getSingleResult());
		} catch (NoResultException e) {
			return 0L;
		} catch (Exception e) {
			throw new RuntimeException("sql can't be auto count, sql is:" + countHql, e);
		}
	}

	/**
	 * 设置分页参数
	 * 
	 * @param <T>
	 *
	 * @param q
	 * @param page
	 * @return
	 */
	protected <T> void setPageParameter(final Query q, final Page<T> page) {
		q.setFirstResult(page.getOffset());
		q.setMaxResults(page.getLimit());
	}
}
