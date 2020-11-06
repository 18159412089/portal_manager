/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.haz.param;
 

import com.fjzxdz.ams.module.haz.entity.TransferCarinfo;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 危废转移车辆信息Entity
 * @author htj
 * @version 2019-02-20
 */
public class TransferCarinfoParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 车辆方向 */
	private Integer direction;
	/** 车辆所属公司 */
	private String company;
	/** 车辆所在位置描述 */
	private String location;
	/** GPS时间 */
	private java.util.Date time;
	/** 车牌号 */
	private String vno;
	/** GPS信息ID */
	private Integer momId;
	/** 更新时间 */
	private java.util.Date updatetimeRjwa;
	/** 车辆行驶速度 */
	private Integer speed;
	/** 车牌颜色 */
	private String vcolor;
	/** 车辆状态 */
	private String status;
	/** 车辆位置纬度 */
	private Double y;
	/** 车辆位置经度 */
	private Double x;
	/** 车辆类型 */
	private String type;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public TransferCarinfoParam() {
		super(TransferCarinfo.class);
		this.clazz = TransferCarinfo.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("direction", getDirection(), SearchCondition.LIKE);
		addClause("company", getCompany(), SearchCondition.LIKE);
		addClause("location", getLocation(), SearchCondition.LIKE);
		addClause("time", getTime(), SearchCondition.LIKE);
		addClause("vno", getVno(), SearchCondition.LIKE);
		addClause("momId", getMomId(), SearchCondition.LIKE);
		addClause("updatetimeRjwa", getUpdatetimeRjwa(), SearchCondition.LIKE);
		addClause("speed", getSpeed(), SearchCondition.LIKE);
		addClause("vcolor", getVcolor(), SearchCondition.LIKE);
		addClause("status", getStatus(), SearchCondition.LIKE);
		addClause("y", getY(), SearchCondition.LIKE);
		addClause("x", getX(), SearchCondition.LIKE);
		addClause("type", getType(), SearchCondition.LIKE);
		setOrderBy(" UPDATETIME_RJWA desc");
	}
	
	public Integer getDirection() {
		return direction;
	}
	
	public void setDirection(Integer direction) {
		this.direction = direction;
	}
	public String getCompany() {
		return company;
	}
	
	public void setCompany(String company) {
		this.company = company;
	}
	public String getLocation() {
		return location;
	}
	
	public void setLocation(String location) {
		this.location = location;
	}
	public java.util.Date getTime() {
		return time;
	}
	
	public void setTime(java.util.Date time) {
		this.time = time;
	}
	public String getVno() {
		return vno;
	}
	
	public void setVno(String vno) {
		this.vno = vno;
	}
	public Integer getMomId() {
		return momId;
	}
	
	public void setMomId(Integer momId) {
		this.momId = momId;
	}
	public java.util.Date getUpdatetimeRjwa() {
		return updatetimeRjwa;
	}
	
	public void setUpdatetimeRjwa(java.util.Date updatetimeRjwa) {
		this.updatetimeRjwa = updatetimeRjwa;
	}
	public Integer getSpeed() {
		return speed;
	}
	
	public void setSpeed(Integer speed) {
		this.speed = speed;
	}
	public String getVcolor() {
		return vcolor;
	}
	
	public void setVcolor(String vcolor) {
		this.vcolor = vcolor;
	}
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	public Double getY() {
		return y;
	}
	
	public void setY(Double y) {
		this.y = y;
	}
	public Double getX() {
		return x;
	}
	
	public void setX(Double x) {
		this.x = x;
	}
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
}


