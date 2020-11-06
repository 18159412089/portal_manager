package com.fjzxdz.ams.module.enviromonit.air.param;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.commons.lang3.StringUtils;

import com.fjzxdz.ams.module.enviromonit.air.entity.AirHourData;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
/**
 * 
 * 空气小时数据参数类 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:11:32
 */
public class AirHourDataParam extends BaseQueryParam {

	
	private static final long serialVersionUID = -8382081155441560703L;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	private String monitorTime;
	private String pointName;
	private String pointCode;
	private String codeRegion;
	private String polluteName;
	private String startTime;
	private String endTime;
	private String pointType;
	private String flag;
	private String exportExl;
	private String exportTitle;

	public AirHourDataParam() {
		super(AirHourData.class);
		this.clazz = AirHourData.class;
	}

	@Override
	protected void createQueryClauses() {
		if (StringUtils.isNotEmpty(getMonitorTime())) {
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				addClause("monitorTime", sdfTime.parseObject(getMonitorTime() + " 00:00:00"), SearchCondition.GE);
				addClause("monitorTime", sdfTime.parseObject(getMonitorTime() + " 23:59:59"), SearchCondition.LE);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		addClause("pointName", getPointName(), SearchCondition.LIKE);
		addClause("polluteName", getPolluteName(), SearchCondition.LIKE);
	}

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getExportTitle() {
		return exportTitle;
	}

	public void setExportTitle(String exportTitle) {
		this.exportTitle = exportTitle;
	}

	public String getExportExl() {
		return exportExl;
	}

	public void setExportExl(String exportExl) {
		this.exportExl = exportExl;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getCodeRegion() {
		return codeRegion;
	}

	public void setCodeRegion(String codeRegion) {
		this.codeRegion = codeRegion;
	}

	public String getMonitorTime() {
		return monitorTime;
	}

	public void setMonitorTime(String monitorTime) {
		this.monitorTime = monitorTime;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPolluteName() {
		return polluteName;
	}

	public void setPolluteName(String polluteName) {
		this.polluteName = polluteName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
