package cn.fjzxdz.frame.entity.log;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity 
@Table(name = "LOGIN_LOG")
public class LoginLog implements Serializable {
    private static final long serialVersionUID = -1L;

    /**
     * 主键
     */
    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "org.hibernate.id.UUIDGenerator")
    private String uuid;

    /**
     * 日志名称
     */
    private String logname;

    /**
     * 用户ID
     */
    private String userid;

    /**
     * 登录时间
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createtime")
    private Date createtime;

    /**
     * Ip
     */
    private String ip;

    /**
     * 备注
     */
    @Lob
    private String remark;

    //====================================================DTO===========================================================

    @Transient
    private String userName;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getLogname() {
        return logname;
    }

    public void setLogname(String logname) {
        this.logname = logname;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
