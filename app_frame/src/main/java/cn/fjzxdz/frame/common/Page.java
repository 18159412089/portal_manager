package cn.fjzxdz.frame.common;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.Order;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Page<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private static final int DEFAULT_SIZE = 50;

    private static final int FIRST_PAGE = 0;

    private int limit = Page.DEFAULT_SIZE;

    private int offset;

    private int currentPage = FIRST_PAGE;

    private List<T> result = new ArrayList<T>();

    private int totalCount = -1;

    private String sortField;

    private String sortDir;

    private int totalPage = 0;

    public Page() {
    }

    public Page(Map<String, String> params) {
        //分页参数
        if (params.get("page") != null) {
            currentPage = Integer.parseInt(params.get("page"))-1;
        }
        if (params.get("rows") != null) {
            limit = Integer.parseInt(params.get("rows"));
        }
    }

    public int getOffset() {
        if (offset == 0) {
            this.offset = currentPage * limit;
        }
        return offset;
    }

    public void setOffset(int start) {
        this.offset = start;
    }

    public Page(final int pageSize) {
        setLimit(pageSize);
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(final int pageSize) {
        this.limit = pageSize;

        if (pageSize < 1) {
            this.limit = 1;
        }
    }

    public List<T> getResult() {
        return result;
    }

    public void setResult(final List<T> result) {
        this.result = result;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(final int totalCount) {
        this.totalCount = totalCount;
        this.totalPage = this.totalCount / this.limit;
        if (totalCount % limit > 0) {
            this.totalPage++;
        }
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getSortDir() {
        return sortDir;
    }

    public void setSortDir(String sortDir) {
        this.sortDir = sortDir;
    }

    public Order getOrder() {
        if (StringUtils.isBlank(sortField)) {
            sortField = "id";
            return Order.asc(sortField);
        }
        if (StringUtils.isBlank(sortDir) || "ASC".equals(sortDir)) {
            return Order.asc(sortField);
        } else {
            return Order.desc(sortField);
        }
    }

    public String getOrderString() {
        String orderString = "";
        if (StringUtils.isNotBlank(sortField)) {
            orderString = " order by " + sortField;
        }
        if (sortDir != null && !"NONE".equals(sortDir)) {
            orderString = orderString + " " + sortDir;
        }
        return orderString;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public boolean isEmpty() {
        return this.result.isEmpty();
    }

    public boolean isPrevious() {
        return this.currentPage > 0;
    }

    public boolean isNext() {
        return (currentPage + 1) != totalPage && totalPage != 0;
    }

    public int getTotalPage() {
        return totalPage;
    }
}
