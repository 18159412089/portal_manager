package cn.fjzxdz.frame.dao.common;

import cn.fjzxdz.frame.common.AlQuery;
import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.entity.AlEntity;

import javax.persistence.NoResultException;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;


public class PagingDaoSupport<T> extends SimpleDaoSupport<T> {


    public Page<T> listByPage(BaseQueryParam query, Page<T> page) {
        return listByPage(query.getQueryString(), query.getParams(), page);
    }
    
    public Page<T> listByPage(AlEntity model, Page<T> page) {
        return listByPage(new AlQuery(model), page);
    }

    public Page<T> listByPage(Map<String, Object> map, Page<T> page) {
        return listByPage(new AlQuery(getEnityName(), map), page);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	public Page<T> listByPage(String queryStr, Page<T> page, Object... params) {
        queryStr += page.getOrderString();

        Query q = createQuery(queryStr, params);

        Integer totalCount = countHqlResult(queryStr, params).intValue();
        page.setTotalCount(totalCount);
        if (totalCount == 0) {
            return page;
        }
        setPageParameter(q, page);
        List result = q.getResultList();
        page.setResult(result);
        return page;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	public Page<T> listByPage(String queryStr, Map<String, Object> params, Page<T> page) {
        queryStr += page.getOrderString();

        Query q = createQuery(queryStr, params);

        Integer totalCount = countHqlResult(queryStr, params).intValue();
        page.setTotalCount(totalCount);
        if (totalCount == 0) {
            return page;
        }
        setPageParameter(q, page);
        List result = q.getResultList();
        page.setResult(result);
        return page;
    }

    /**
     * 设置分页参数
     *
     * @param q
     * @param page
     * @return
     */
    protected void setPageParameter(final Query q, final Page<T> page) {
        q.setFirstResult(page.getOffset());
        q.setMaxResults(page.getLimit());
    }

    /**
     * 获取查询记录
     *
     * @param hql
     * @param values
     * @return
     */
    protected Long countHqlResult(final String hql, final Object... values) {
        String fromHql = hql;
        String countHql = "select count(*) ";
        if(fromHql.contains("distinct")||fromHql.contains("DISTINCT")) {
        	fromHql = fromHql.replaceAll("DISTINCT", "distinct");
        	countHql="select count(distinct "+StringUtils.substringBefore(StringUtils.substringAfter(fromHql, "distinct"),"from")+")"+" from "+StringUtils.substringAfter(fromHql, "from");
        }else {
        	fromHql = getCriteriaClause(fromHql);
        	countHql += fromHql;
        }
        try {
            return getUnique(countHql, values);
        } catch (NoResultException e) {
            return 0L;
        } catch (Exception e) {
            throw new RuntimeException("hql can't be auto count, hql is:" + countHql, e);
        }
    }

    /**
     * 获取查询记录
     *
     * @param hql
     * @param values
     * @return
     */
    protected Long countHqlResult(final String hql, final Map<String, Object> values) {
    	String fromHql = hql;
        String countHql = "select count(*) ";
        if(fromHql.contains("distinct")||fromHql.contains("DISTINCT")) {
        	fromHql = fromHql.replaceAll("DISTINCT", "distinct");
        	countHql="select count(distinct "+StringUtils.substringBefore(StringUtils.substringAfter(fromHql, "distinct"),"from")+")"+" from "+StringUtils.substringAfter(fromHql, "from");
        }else {
        	fromHql = getCriteriaClause(fromHql);
        	countHql += fromHql;
        }
        try {
            return getUniqueByMap(countHql, values);
        } catch (NoResultException e) {
            return 0L;
        } catch (Exception e) {
            throw new RuntimeException("hql can't be auto count, hql is:" + countHql, e);
        }
    }
}
