package cn.fjzxdz.frame.security;

import org.springframework.security.core.GrantedAuthority;

import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.User;

import java.util.Collection;
/**
 * 
 * 自定义 CustomerUserDetail
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 上午9:00:09
 */
public class CustomerUserDetail extends
        org.springframework.security.core.userdetails.User {
    private static final long serialVersionUID = 1L;
    private String uuid;
    private String name;
    private Dept dept;
    private User user;
    private Job job;

    public CustomerUserDetail(String username, String password,
                              Collection<? extends GrantedAuthority> authorities, String name,
                              String uuid,Dept dept,User user,Job job) {
        super(username, password, authorities);
        this.uuid = uuid;
        this.name = name;
        this.dept = dept;
        this.user=user;
        this.job=job;
    }
    
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

	public void setName(String name) {
        this.name = name;
    }
	
    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Job getJob() {
		return job;
	}

	public void setJob(Job job) {
		this.job = job;
	}
}