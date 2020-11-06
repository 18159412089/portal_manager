/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package cn.fjzxdz.frame.entity.core;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import cn.fjzxdz.frame.entity.TrackingEntity;

/**
 * 用户信息扩展Entity
 * @author gd
 * @date 2018-09-29
 */
@Entity
@Table(name = "sys_user_info")
public class UserInfo extends TrackingEntity {
	private static final long serialVersionUID = 1L;
	/** 用户id */
	private String userId;
	/** 身份证 */
	private String idCard;
	/** 卡密码 */
	private String cardPassword;
	/** 性别 */
	private String sex;
	/** 邮件 */
	private String email;
	/** 座机号码 */
	private String telephone;
	/** 手机号码 */
	private String mobilephone;
	/** 卡号 */
	private String cardId;
	/** 工号 */
	private String empId;
	/** anychay的Id */
	private String anychatUserId;
	/** head_img_id */
	private String headImgId;
	/** 消息推送客户端ID */
	private String clientId;
	/** 所属单位 */
	private String danweiId;
	/** 所属部门 */
	private String departmentId;
	/** support_audio_video */
	private String supportAudioVideo;
	/** 手势密码 */
	private String gesturePassword;
	/** 用户类型 */
	private String userType;
	/** part_time_job */
	private String partTimeJob;
	/** organization */
	private String organization;
	/** highest_education */
	private String highestEducation;
	/** birthday */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date birthday;
	/** insp_area */
	private String inspArea;
	/** insp_freq */
	private String inspFreq;
	/** training */
	private String training;
	/** check_info */
	private String checkInfo;
	/** 工作牌号 */
	private String workCode;
	private String oldSysDanweiId;
	private String oldSysDepartmentId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getCardPassword() {
		return cardPassword;
	}

	public void setCardPassword(String cardPassword) {
		this.cardPassword = cardPassword;
	}
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getCardId() {
		return cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getAnychatUserId() {
		return anychatUserId;
	}

	public void setAnychatUserId(String anychatUserId) {
		this.anychatUserId = anychatUserId;
	}
	public String getHeadImgId() {
		return headImgId;
	}

	public void setHeadImgId(String headImgId) {
		this.headImgId = headImgId;
	}
	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getDanweiId() {
		return danweiId;
	}

	public void setDanweiId(String danweiId) {
		this.danweiId = danweiId;
	}
	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}
	public String getSupportAudioVideo() {
		return supportAudioVideo;
	}

	public void setSupportAudioVideo(String supportAudioVideo) {
		this.supportAudioVideo = supportAudioVideo;
	}
	public String getGesturePassword() {
		return gesturePassword;
	}

	public void setGesturePassword(String gesturePassword) {
		this.gesturePassword = gesturePassword;
	}
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getPartTimeJob() {
		return partTimeJob;
	}

	public void setPartTimeJob(String partTimeJob) {
		this.partTimeJob = partTimeJob;
	}
	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public String getHighestEducation() {
		return highestEducation;
	}

	public void setHighestEducation(String highestEducation) {
		this.highestEducation = highestEducation;
	}
	public java.util.Date getBirthday() {
		return birthday;
	}

	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}
	public String getInspArea() {
		return inspArea;
	}

	public void setInspArea(String inspArea) {
		this.inspArea = inspArea;
	}
	public String getInspFreq() {
		return inspFreq;
	}

	public void setInspFreq(String inspFreq) {
		this.inspFreq = inspFreq;
	}
	public String getTraining() {
		return training;
	}

	public void setTraining(String training) {
		this.training = training;
	}
	public String getCheckInfo() {
		return checkInfo;
	}

	public void setCheckInfo(String checkInfo) {
		this.checkInfo = checkInfo;
	}

	public String getOldSysDepartmentId() {
		return oldSysDepartmentId;
	}

	public void setOldSysDepartmentId(String oldSysDepartmentId) {
		this.oldSysDepartmentId = oldSysDepartmentId;
	}

	public String getOldSysDanweiId() {
		return oldSysDanweiId;
	}

	public void setOldSysDanweiId(String oldSysDanweiId) {
		this.oldSysDanweiId = oldSysDanweiId;
	}

	public String getWorkCode() {
		return workCode;
	}

	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}
	
}


