package com.fjzxdz.ams.module.enviromonit.minutedata.entity;

import java.sql.Timestamp;

import org.json.JSONObject;

import cn.fjzxdz.frame.license.utils.CommonUtils;
import cn.fjzxdz.frame.license.utils.Utils;

public class PeConMinuteDataDetail {

	private String id;
	private String deviceDataId;
	private String PolId;// 污染物的编号
	private Double P_Rtd;// 污染物实时采样数据
	private Double P_Min;// 污染物指定时间内最小值
	private Double P_Avg;// 污染物指定时间内平均值
	private Double P_Max;// 污染物指定时间内最大值
	private Double P_ZsRtd;// 污染物实时采样折算数据
	private Double P_ZsMin;// 污染物指定时间内最小折算值
	private Double P_ZsAvg;// 污染物指定时间内平均折算值
	private Double P_ZsMax;// 污染物指定时间内最大折算值
	private String P_Flag;// 监测污染物实时数据标记
	private Double P_Cou;// 污染物指定时间内累计值
							// 表示设备编号
	private Double P_Ala;// 污染物报警期间内采样值
	private Double P_UpValue;// 污染物报警上限值
	private Double P_LowValue;// 污染物报警下限值
	private Double P_Data;// 噪声监测历史数据
	private Double P_DayData;// 噪声昼间历史数据
	private Double P_NightData;// 噪声夜间历史数据

	private String positionId;
	private String updateBy;
	private Timestamp updateTime;
	private String updateByAddress;
	private Timestamp createTime;
	private String createBy;
	private String createByAddress;
	private int recordVersion;

	public PeConMinuteDataDetail() {
		this.id = "";
		this.deviceDataId = "";
		this.PolId = "";
		this.P_Rtd = 0.0;
		this.P_Min = 0.0;
		this.P_Avg = 0.0;
		this.P_Max = 0.0;
		this.P_ZsRtd = 0.0;
		this.P_ZsMin = 0.0;
		this.P_ZsAvg = 0.0;
		this.P_ZsMax = 0.0;
		this.P_Flag = "";
		this.P_Cou = 0.0;
		this.P_Ala = 0.0;
		this.P_UpValue = 0.0;
		this.P_LowValue = 0.0;
		this.P_Data = 0.0;
		this.P_DayData = 0.0;
		this.P_NightData = 0.0;

		Timestamp now = Utils.getTimestamp();
		this.positionId = "";
		this.updateBy = "";
		this.updateTime = now;
		this.updateByAddress = "";
		this.createTime = now;
		this.createBy = "";
		this.createByAddress = "";
		this.recordVersion = 0;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDeviceDataId() {
		return deviceDataId;
	}

	public void setDeviceDataId(String deviceDataId) {
		this.deviceDataId = deviceDataId;
	}

	public String getPolId() {
		return PolId;
	}

	public void setPolId(String polId) {
		PolId = polId;
	}

	public void setP_Rtd(Double p_Rtd) {
		P_Rtd = p_Rtd;
	}

	public void setP_Min(Double p_Min) {
		P_Min = p_Min;
	}

	public void setP_Avg(Double p_Avg) {
		P_Avg = p_Avg;
	}

	public void setP_Max(Double p_Max) {
		P_Max = p_Max;
	}

	public void setP_ZsRtd(Double p_ZsRtd) {
		P_ZsRtd = p_ZsRtd;
	}

	public void setP_ZsMin(Double p_ZsMin) {
		P_ZsMin = p_ZsMin;
	}

	public void setP_ZsAvg(Double p_ZsAvg) {
		P_ZsAvg = p_ZsAvg;
	}

	public void setP_ZsMax(Double p_ZsMax) {
		P_ZsMax = p_ZsMax;
	}

	public void setP_Cou(Double p_Cou) {
		P_Cou = p_Cou;
	}

	public void setP_Ala(Double p_Ala) {
		P_Ala = p_Ala;
	}

	public void setP_UpValue(Double p_UpValue) {
		P_UpValue = p_UpValue;
	}

	public void setP_LowValue(Double p_LowValue) {
		P_LowValue = p_LowValue;
	}

	public void setP_Data(Double p_Data) {
		P_Data = p_Data;
	}

	public void setP_DayData(Double p_DayData) {
		P_DayData = p_DayData;
	}

	public void setP_NightData(Double p_NightData) {
		P_NightData = p_NightData;
	}

	public Double getP_Rtd() {
		return P_Rtd;
	}

	public void setP_Rtd(String p_Rtd) {
		if (CommonUtils.isDouble(p_Rtd))
			P_Rtd = Double.valueOf(p_Rtd);
	}

	public Double getP_Min() {
		return P_Min;
	}

	public void setP_Min(String p_Min) {
		if (CommonUtils.isDouble(p_Min))
			P_Min = Double.valueOf(p_Min);
	}

	public Double getP_Avg() {
		return P_Avg;
	}

	public void setP_Avg(String p_Avg) {
		if (CommonUtils.isDouble(p_Avg))
			P_Avg = Double.valueOf(p_Avg);
	}

	public Double getP_Max() {
		return P_Max;
	}

	public void setP_Max(String p_Max) {
		if (CommonUtils.isDouble(p_Max))
			P_Max = Double.valueOf(p_Max);
	}

	public Double getP_ZsRtd() {
		return P_ZsRtd;
	}

	public void setP_ZsRtd(String p_ZsRtd) {
		if (CommonUtils.isDouble(p_ZsRtd))
			P_ZsRtd = Double.valueOf(p_ZsRtd);
	}

	public Double getP_ZsMin() {
		return P_ZsMin;
	}

	public void setP_ZsMin(String p_ZsMin) {
		if (CommonUtils.isDouble(p_ZsMin))
			P_ZsMin = Double.valueOf(p_ZsMin);
	}

	public Double getP_ZsAvg() {
		return P_ZsAvg;
	}

	public void setP_ZsAvg(String p_ZsAvg) {
		if (CommonUtils.isDouble(p_ZsAvg))
			P_ZsAvg = Double.valueOf(p_ZsAvg);
	}

	public Double getP_ZsMax() {
		return P_ZsMax;
	}

	public void setP_ZsMax(String p_ZsMax) {
		if (CommonUtils.isDouble(p_ZsMax))
			P_ZsMax = Double.valueOf(p_ZsMax);
	}

	public String getP_Flag() {
		return P_Flag;
	}

	public void setP_Flag(String p_Flag) {
		P_Flag = p_Flag;
	}

	public Double getP_Cou() {
		return P_Cou;
	}

	public void setP_Cou(String p_Cou) {
		if (CommonUtils.isDouble(p_Cou))
			P_Cou = Double.valueOf(p_Cou);
	}

	public Double getP_Ala() {
		return P_Ala;
	}

	public void setP_Ala(String p_Ala) {
		if (CommonUtils.isDouble(p_Ala))
			P_Ala = Double.valueOf(p_Ala);
	}

	public Double getP_UpValue() {
		return P_UpValue;
	}

	public void setP_UpValue(String p_UpValue) {
		if (CommonUtils.isDouble(p_UpValue))
			P_UpValue = Double.valueOf(p_UpValue);
	}

	public Double getP_LowValue() {
		return P_LowValue;
	}

	public void setP_LowValue(String p_LowValue) {
		if (CommonUtils.isDouble(p_LowValue))
			P_LowValue = Double.valueOf(p_LowValue);
	}

	public Double getP_Data() {
		return P_Data;
	}

	public void setP_Data(String p_Data) {
		if (CommonUtils.isDouble(p_Data))
			P_Data = Double.valueOf(p_Data);
	}

	public Double getP_DayData() {
		return P_DayData;
	}

	public void setP_DayData(String p_DayData) {
		if (CommonUtils.isDouble(p_DayData))
			P_DayData = Double.valueOf(p_DayData);
	}

	public Double getP_NightData() {
		return P_NightData;
	}

	public void setP_NightData(String p_NightData) {
		if (CommonUtils.isDouble(p_NightData))
			P_NightData = Double.valueOf(p_NightData);
	}

	public String getPositionId() {
		return positionId;
	}

	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateByAddress() {
		return updateByAddress;
	}

	public void setUpdateByAddress(String updateByAddress) {
		this.updateByAddress = updateByAddress;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getCreateByAddress() {
		return createByAddress;
	}

	public void setCreateByAddress(String createByAddress) {
		this.createByAddress = createByAddress;
	}

	public int getRecordVersion() {
		return recordVersion;
	}

	public void setRecordVersion(int recordVersion) {
		this.recordVersion = recordVersion;
	}

	public JSONObject toJSONObject() throws Exception {
		JSONObject obj = new JSONObject();

		obj.put("id", this.id);
		obj.put("deviceDataId", this.deviceDataId);
		obj.put("PolId", this.PolId);
		obj.put("P_Rtd", this.P_Rtd);
		obj.put("P_Min", this.P_Min);
		obj.put("P_Avg", this.P_Avg);
		obj.put("P_Max", this.P_Max);
		obj.put("P_ZsRtd", this.P_ZsRtd);
		obj.put("P_ZsMin", this.P_ZsMin);
		obj.put("P_ZsAvg", this.P_ZsAvg);
		obj.put("P_ZsMax", this.P_ZsMax);
		obj.put("P_Flag", this.P_Flag);
		obj.put("P_Cou", this.P_Cou);
		obj.put("P_Ala", this.P_Ala);
		obj.put("P_UpValue", this.P_UpValue);
		obj.put("P_LowValue", this.P_LowValue);
		obj.put("P_Data", this.P_Data);
		obj.put("P_DayData", this.P_DayData);
		obj.put("P_NightData", this.P_NightData);

		obj.put("positionId", this.positionId);
		obj.put("updateBy", this.updateBy);
		obj.put("updateTime", this.updateTime);
		obj.put("updateByAddress", this.updateByAddress);
		obj.put("createTime", this.createTime);
		obj.put("createBy", this.createBy);
		obj.put("createByAddress", this.createByAddress);
		obj.put("recordVersion", this.recordVersion);

		return obj;
	}

	public String toJSONString() {
		JSONObject obj = new JSONObject();

		try {
			obj.put("id", this.id);
			obj.put("deviceDataId", this.deviceDataId);
			obj.put("PolId", this.PolId);
			obj.put("P_Rtd", this.P_Rtd);
			obj.put("P_Min", this.P_Min);
			obj.put("P_Avg", this.P_Avg);
			obj.put("P_Max", this.P_Max);
			obj.put("P_ZsRtd", this.P_ZsRtd);
			obj.put("P_ZsMin", this.P_ZsMin);
			obj.put("P_ZsAvg", this.P_ZsAvg);
			obj.put("P_ZsMax", this.P_ZsMax);
			obj.put("P_Flag", this.P_Flag);
			obj.put("P_Cou", this.P_Cou);
			obj.put("P_Ala", this.P_Ala);
			obj.put("P_UpValue", this.P_UpValue);
			obj.put("P_LowValue", this.P_LowValue);
			obj.put("P_Data", this.P_Data);
			obj.put("P_DayData", this.P_DayData);
			obj.put("P_NightData", this.P_NightData);

			obj.put("positionId", this.positionId);
			obj.put("updateBy", this.updateBy);
			obj.put("updateTime", this.updateTime);
			obj.put("updateByAddress", this.updateByAddress);
			obj.put("createTime", this.createTime);
			obj.put("createBy", this.createBy);
			obj.put("createByAddress", this.createByAddress);
			obj.put("recordVersion", this.recordVersion);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return obj.toString();
	}
}
