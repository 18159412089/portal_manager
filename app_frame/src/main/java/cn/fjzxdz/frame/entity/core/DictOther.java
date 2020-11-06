package cn.fjzxdz.frame.entity.core;

import cn.fjzxdz.frame.entity.TrackingEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * 数据字典实体类，主要用于新增用户需要保存数据，区别于Oracle的Dict
 * @author   gsq
 * @CreateTime 2019-10-18
 */
@Entity
public class DictOther extends TrackingEntity {

    private static final long serialVersionUID = -1769925538835340337L;

    @Column(name = "pid", insertable = false, updatable = false)
    private String pid;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "pid")
    private Dict parent;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
    @OrderBy("num ASC")
    private Set<Dict> children = new HashSet<Dict>(0);

    private String type;

    private String value;

    private Integer num;

    @Lob
    private String remark;

    private Integer enable;

    // ====================================================DTO===========================================================

    public DictOther() {}

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public Dict getParent() {
        return parent;
    }

    public void setParent(Dict parent) {
        this.parent = parent;
    }

    public Set<Dict> getChildren() {
        return children;
    }

    public void setChildren(Set<Dict> children) {
        this.children = children;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "Dict [pid=" + pid + ", parent=" + parent + ", children=" + children + ", type=" + type + ", value="
                + value + ", num=" + num + ", remark=" + remark + ", enable=" + enable + "]";
    }

}
