package cn.fjzxdz.frame.dao.common;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.entity.AlEntity;

public interface BaseDao<T> {

	/**
	 * 分离所有当前正在被管理的实体
	 */
	void clear();

	/**
	 * 将实体的改变立刻刷新到数据库中
	 */
	void flush();

	/**
	 * Refresh entity
	 */
	void refresh(Object var1);

	/**
	 * detached的Entity不会和数据库中的数据再进行同步
	 */
	void detach(Object var1);

	/**
	 * Check entity是否在EntityManager管理当中
	 */
	boolean contains(Object var1);

	/**
	 * 关闭连接
	 */
	void close();

	/**
	 * 判断当前的实体管理器是否是打开状态
	 */
	boolean isOpen();

	/**
	 * 保存实体
	 */
	void save(T t);

	/**
	 * 批量保存
	 */
	void saveBatch(List<T> ts);

	/**
	 * 更新实体
	 */
	T update(T t);

	/**
	 * 批量更新
	 */
	void updateBatch(List<T> ts);

	/**
	 * 删除实体
	 */
	void delete(T t);

	/**
	 * 根据Id删除单个
	 */
	void deleteById(Serializable id);

	/**
	 * 通过某个唯一字段查找
	 */
	T getBy(String uniqueField, String value);

	/**
	 * 通过唯一主键查找
	 */
	T getById(Serializable id);

	/**
	 * 通过多个参数查找单个
	 */
	@SuppressWarnings("hiding")
	<T> T getUnique(final String hql, final Object... values);

	/**
	 * 通过map查找单个
	 */
	@SuppressWarnings("hiding")
	<T> T getUniqueByMap(String hql, Map<String, Object> values);

	/**
	 * 查询所有的记录
	 */
	List<T> selectListAll();

	/**
	 * 查询所有的记录通过某个字段排序
	 */
	List<T> selectListAllOrderBy(String orderBy);

	/**
	 * 通过多个参数查找符合条件的List
	 */
	List<T> selectList(final String queryString, Object... params);

	/**
	 * 通过Map查询符合条件的List
	 */
	List<T> selectList(final String queryString, Map<String, ?> params);

	/**
	 * 通过多个参数原生查询符合条件的List
	 */
	List<T> selectListNative(final String queryString, Object... params);

	/**
	 * 通过Map原生查询符合条件的List
	 */
	List<T> selectListNative(final String queryString, Map<String, ?> params);

	/**
	 * 通过某个字段查询符合条件的List
	 */
	List<T> selectListBy(String fieldName, Object value);

	/**
	 * 通过封装参数查询List
	 */
	List<T> selectListByQueryObj(BaseQueryParam queryObj);

	/**
	 * 通过封装参数查询List
	 */
	List<T> selectListByModel(AlEntity model);
}
