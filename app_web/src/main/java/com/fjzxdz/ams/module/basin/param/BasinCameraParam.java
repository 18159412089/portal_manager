/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.basin.param;

import com.fjzxdz.ams.module.basin.entity.BasinCamera;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * 流域监控Entity
 * @author slq
 * @version 2019-03-12
 */
public class BasinCameraParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/**  */
	private String name;
	/**  */
	private String indexCode;
	/**  */
	private String parentIndexCode;
	/**  */
	private String latitude;
	/**  */
	private String longitude;
	/**  */
	private String place;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public BasinCameraParam() {
		super(BasinCamera.class);
		this.clazz = BasinCamera.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("name", getName(), SearchCondition.LIKE);
		addClause("indexCode", getIndexCode(), SearchCondition.LIKE);
		addClause("parentIndexCode", getParentIndexCode(), SearchCondition.LIKE);
		addClause("latitude", getLatitude(), SearchCondition.LIKE);
		addClause("longitude", getLongitude(), SearchCondition.LIKE);
		addClause("place", getPlace(), SearchCondition.LIKE);
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getIndexCode() {
		return indexCode;
	}
	
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}
	public String getParentIndexCode() {
		return parentIndexCode;
	}
	
	public void setParentIndexCode(String parentIndexCode) {
		this.parentIndexCode = parentIndexCode;
	}
	public String getLatitude() {
		return latitude;
	}
	
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getPlace() {
		return place;
	}
	
	public void setPlace(String place) {
		this.place = place;
	}
	
}


