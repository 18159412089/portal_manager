package com.fjzxdz.ams.module.enviromonit.air.param;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

import cn.fjzxdz.frame.toolbox.util.ToolUtil;
/**
 * 
 * 这里描述这个类是做什么业务 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:05:18
 */
public class AirDataParam implements Serializable {

	private static final long serialVersionUID = -8382081155441560703L;

	private String points;
	
	private List<String> pointList;

	private String factors;
	
	private List<String> factorList;
	
	private String startTime;
	
	private String endTime;
	
	private String type;
	
	public void setFactors(String factors) {
		if(ToolUtil.isNotEmpty(factors)) {
			setFactorList(Arrays.asList(factors.split(",")));
		}
		this.factors = factors;
	}
	
	public String getFactors() {
		return factors;
	}
	
	public void setFactorList(List<String> factorList) {
		this.factorList = factorList;
	}
	
	public List<String> getFactorList() {
		return factorList;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getType() {
		return type;
	}
	
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	public String getStartTime() {
		return startTime;
	}
	
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	public String getEndTime() {
		return endTime;
	}
	
	public List<String> getPointList() {
		return pointList;
	}
	
	public void setPointList(List<String> pointList) {
		this.pointList = pointList;
	}
	
	public String getPoints() {
		return points;
	}
	
	public void setPoints(String points) {
		if(ToolUtil.isNotEmpty(points)) {
			setPointList(Arrays.asList(points.split(",")));
		}
		this.points = points;
	}
}
