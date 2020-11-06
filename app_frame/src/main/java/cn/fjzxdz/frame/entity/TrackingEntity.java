package cn.fjzxdz.frame.entity;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.util.StringUtils;

import cn.fjzxdz.frame.security.CustomerUserDetail;
import cn.fjzxdz.frame.toolbox.security.SpringSecurityUtils;

@MappedSuperclass
public abstract class TrackingEntity implements AlEntity {
	private static final long serialVersionUID = -4133625311893063750L;
	
	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "org.hibernate.id.UUIDGenerator")
	protected String uuid;

	@Column(name = "create_user")
	private String createUser;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date")
	private Date createDate;

	@Column(name = "update_user")
	private String updateUser;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date")
	protected Date updateDate;
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	@PrePersist
    @PreUpdate
    public void tracking() {
        if (StringUtils.isEmpty(this.getUuid())) {
			Calendar calendar = Calendar.getInstance();
			CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
			this.setCreateDate(calendar.getTime());
			this.setUpdateDate(calendar.getTime());
			if(null!=user){
				this.setCreateUser(user.getUuid());
				this.setUpdateUser(user.getUuid());
			}
		} else {
			Calendar calendar = Calendar.getInstance();
			CustomerUserDetail user = SpringSecurityUtils.getCurrentUser();
			this.setUpdateDate(calendar.getTime());
			if(null!=user){
				this.setUpdateUser(user.getUuid());
			}
		}
        
    }

}
