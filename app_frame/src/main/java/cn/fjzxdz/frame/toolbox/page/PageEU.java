package cn.fjzxdz.frame.toolbox.page;


import java.io.Serializable;
import java.util.List;

import cn.fjzxdz.frame.common.Page;

/**
 * 分页结果的封装(for easyui datagrid)
 *
 * @author liuyankun
 */
public class PageEU<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    // 结果集
    private List<T> rows;

    // 总数
    private long total;

    public PageEU(Page<T> page) {
        this.rows = page.getResult();
        this.total = page.getTotalCount();
    }

    public PageEU(List<T> list) {
    	this.rows=list;
    	this.total=list.size();
    }
    
    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }
}
