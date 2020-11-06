package cn.fjzxdz.frame.entity.core;

public class UserReLateInfo {

	private UserOther user;
	private UserInfo userInfo;
	private JobOther job;
	private Role role;
	private String roleUuids;
	private String portalDepartmentId;
	
	public String getRoleUuids() {
		return roleUuids;
	}

	public void setRoleUuids(String roleUuids) {
		this.roleUuids = roleUuids;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public JobOther getJob() {
		return job;
	}

	public void setJob(JobOther job) {
		this.job = job;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public UserOther getUser() {
		return user;
	}

	public void setUser(UserOther user) {
		this.user = user;
	}

    public String getPortalDepartmentId() {
        return portalDepartmentId;
    }

    public void setPortalDepartmentId(String portalDepartmentId) {
        this.portalDepartmentId = portalDepartmentId;
    }

}
