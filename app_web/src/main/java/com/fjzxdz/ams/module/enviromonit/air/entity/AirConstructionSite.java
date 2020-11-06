package com.fjzxdz.ams.module.enviromonit.air.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 
 * 工地实体
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:00:20
 */
@Entity
@Table(name = "AIR_CONSTRUCTION_SITE")
public class AirConstructionSite implements Serializable {

	private static final long serialVersionUID = -2454884594598168822L;

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "org.hibernate.id.UUIDGenerator")
	private String pkid;

	private String area;

	private String name;

	@Column(name = "BUILT_VALUE")
	private String builtValue;

	private String address;

	private BigDecimal latitude;

	private BigDecimal longitude;

	@Column(name = "MANAGE_ORGANIZATION")
	private String manageOrganization;

	@Column(name = "MANAGER_PEOPER")
	private String managerPeoper;

	@Column(name = "MANAER_PHONE")
	private String manaerPhone;

	@Column(name = "RESPON_ORGANIZATION")
	private String responOrganization;

	@Column(name = "RESPON_PEOPOR")
	private String responPeopor;

	@Column(name = "RESPON_PHONE")
	private String responPhone;

	@Lob
	@Column(name = "STATUS")
	private String status;

	@Lob
	@Column(name = "REMARK")
	private String remark;

	/**
	 * picture
	 */
	@Transient
	private String picture;

	/**
	 * video
	 */
	@Transient
	private String video;


	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getPkid() {
		return pkid;
	}

	public void setPkid(String pkid) {
		this.pkid = pkid;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBuiltValue() {
		return builtValue;
	}

	public void setBuiltValue(String builtValue) {
		this.builtValue = builtValue;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public BigDecimal getLatitude() {
		return latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	public BigDecimal getLongitude() {
		return longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	public String getManageOrganization() {
		return manageOrganization;
	}

	public void setManageOrganization(String manageOrganization) {
		this.manageOrganization = manageOrganization;
	}

	public String getManagerPeoper() {
		return managerPeoper;
	}

	public void setManagerPeoper(String managerPeoper) {
		this.managerPeoper = managerPeoper;
	}

	public String getManaerPhone() {
		return manaerPhone;
	}

	public void setManaerPhone(String manaerPhone) {
		this.manaerPhone = manaerPhone;
	}

	public String getResponOrganization() {
		return responOrganization;
	}

	public void setResponOrganization(String responOrganization) {
		this.responOrganization = responOrganization;
	}

	public String getResponPeopor() {
		return responPeopor;
	}

	public void setResponPeopor(String responPeopor) {
		this.responPeopor = responPeopor;
	}

	public String getResponPhone() {
		return responPhone;
	}

	public void setResponPhone(String responPhone) {
		this.responPhone = responPhone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


}
