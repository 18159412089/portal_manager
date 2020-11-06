package com.fjzxdz.ams.module.enviromonit.minutedata.entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import cn.fjzxdz.frame.license.utils.CommonUtils;
import cn.fjzxdz.frame.license.utils.Utils;

public class PeConMinuteData {

	private String id;
	private String QN;// 请求编号
	private String PNUM;// 总包号
	private String PNO;// 包序号
	private String ST;// 系统编号
	private String CN;// 命令编号
	private String PW;// 访问密码
	private String MN;//设备唯一标识
	private String Flag;// 通讯标志
	
	private String SystemTime;// 系统时间
	private String QnRtn;// 请求回应代码
	private String Logon;// 登录注册回应代码
	private String ExeRtn;// 执行结果回应代码
	private Integer RtdInterval;// 实时采样数据上报间隔
	private String SBNum;// 设备编号
	private String SBx_RS;// 设备运行状态的实时采样值,其中 ""：设备关，1：设备开。SBx表示设备编号
	private Double SBx_RT;// 设备指定时间内的运行时间,例如:1"".11,单位为小时，且取值范围为""<=n<=24。SBx表示设备编号

	private String AlarmTime;// 超标报警时间
	private String AlarmType;// 报警事件类型
	private String ReportTarget;// 上位机地址标识
	private String BeginTime;// 开始时间
	private String EndTime;// 截止时间
	private String DataTime;// 数据时间信息
	private String ReportTime;// 日数据上报时间信息
	private String DayStdValue;// 噪声白天标准限值
	private String NightStdValue;// 噪声夜晚标准限值
	private Integer OverTime;// 超时时间(单位：秒)
	private Integer ReCount;// 重发次数
	private Integer WarnTime;// 超标报警延迟时间(单位：秒)
	private Integer CTime;// 设备采样时间

	private String positionId;
	private String updateBy;
	private Timestamp updateTime;
	private String updateByAddress;
	private Timestamp createTime;
	private String createBy;
	private String createByAddress;
	private int recordVersion;
	
	private List<PeConMinuteDataDetail> CP;// 数据区

	public PeConMinuteData() {
		this.id = "";
		this.SystemTime = "";
		this.MN = "";
		this.QN = "";
		this.QnRtn = "";
		this.Logon = "";
		this.ExeRtn = "";
		this.RtdInterval = 0;
		this.SBNum = "";
		this.SBx_RS = "";
		this.SBx_RT = 0.0;
		this.AlarmTime = "";
		this.AlarmType = "";
		this.ReportTarget = "";
		this.BeginTime = "";
		this.EndTime = "";
		this.DataTime = "";
		this.ReportTime = "";
		this.DayStdValue = "";
		this.NightStdValue = "";
		this.Flag = "";
		this.PNO = "";
		this.PNUM = "";
		this.PW = "";
		this.OverTime = 0;
		this.ReCount = 0;
		this.WarnTime = 0;
		this.CTime = 0;
		this.CP = new ArrayList<PeConMinuteDataDetail>();

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

	public String getSystemTime() {
		return SystemTime;
	}

	public void setSystemTime(String systemTime) {
		SystemTime = systemTime;
	}
	
	public String getMN() {
		return MN;
	}

	public void setMN(String mN) {
		MN = mN;
	}

	public String getQN() {
		return QN;
	}

	public void setQN(String qN) {
		QN = qN;
	}

	public String getQnRtn() {
		return QnRtn;
	}

	public void setQnRtn(String qnRtn) {
		QnRtn = qnRtn;
	}

	public String getLogon() {
		return Logon;
	}

	public void setLogon(String logon) {
		Logon = logon;
	}

	public String getExeRtn() {
		return ExeRtn;
	}

	public void setExeRtn(String exeRtn) {
		ExeRtn = exeRtn;
	}

	public Integer getRtdInterval() {
		return RtdInterval;
	}

	public void setRtdInterval(String rtdInterval) {
		if(CommonUtils.isInteger(rtdInterval))
			RtdInterval = Integer.valueOf(rtdInterval);
	}

	public String getSBNum() {
		return SBNum;
	}

	public void setSBNum(String sBNum) {
		SBNum = sBNum;
	}

	public String getSBx_RS() {
		return SBx_RS;
	}

	public void setSBx_RS(String SBx_RS) {
		this.SBx_RS = SBx_RS;
	}

	public Double getSBx_RT() {
		return SBx_RT;
	}

	public void setSBx_RT(String SBx_RT) {
		if(CommonUtils.isDouble(SBx_RT))
			this.SBx_RT = Double.parseDouble(SBx_RT);
	}

	public String getAlarmTime() {
		return AlarmTime;
	}

	public void setAlarmTime(String alarmTime) {
		AlarmTime = alarmTime;
	}

	public String getAlarmType() {
		return AlarmType;
	}

	public void setAlarmType(String alarmType) {
		AlarmType = alarmType;
	}

	public String getReportTarget() {
		return ReportTarget;
	}

	public void setReportTarget(String reportTarget) {
		ReportTarget = reportTarget;
	}

	public String getBeginTime() {
		return BeginTime;
	}

	public void setBeginTime(String beginTime) {
		BeginTime = beginTime;
	}

	public String getEndTime() {
		return EndTime;
	}

	public void setEndTime(String endTime) {
		EndTime = endTime;
	}

	public String getDataTime() {
		return this.DataTime;
	}

	public String getDataTimeFormat() {
		String result = "";
		if(!this.DataTime.equals("")){
			String year = this.DataTime.substring(0, 4);
			String month = this.DataTime.substring(4, 6);
			String day = this.DataTime.substring(6, 8);
			String hour = this.DataTime.substring(8,10);
			String minute = this.DataTime.substring(10,12);
			String second = this.DataTime.substring(12);
			
			result = String.format("%s-%s-%s %s:%s:%s", year,month,day,hour,minute,second);
			
		}
		return result;
	}

	public void setDataTime(String dataTime) {
		DataTime = dataTime;
	}

	public String getReportTime() {
		return ReportTime;
	}

	public void setReportTime(String reportTime) {
		ReportTime = reportTime;
	}

	public String getDayStdValue() {
		return DayStdValue;
	}

	public void setDayStdValue(String dayStdValue) {
		DayStdValue = dayStdValue;
	}

	public String getNightStdValue() {
		return NightStdValue;
	}

	public void setNightStdValue(String nightStdValue) {
		NightStdValue = nightStdValue;
	}

	public String getFlag() {
		return Flag;
	}

	public void setFlag(String flag) {
		Flag = flag;
	}

	public String getPNO() {
		return PNO;
	}

	public void setPNO(String pNO) {
		PNO = pNO;
	}

	public String getPNUM() {
		return PNUM;
	}

	public void setPNUM(String pNUM) {
		PNUM = pNUM;
	}

	public String getPW() {
		return PW;
	}

	public void setPW(String pW) {
		PW = pW;
	}

	public Integer getOverTime() {
		return OverTime;
	}

	public void setOverTime(String overTime) {
		if(CommonUtils.isInteger(overTime))
			OverTime = Integer.valueOf(overTime);
	}

	public Integer getReCount() {
		return ReCount;
	}

	public void setReCount(String reCount) {
		if(CommonUtils.isInteger(reCount))
			ReCount = Integer.valueOf(reCount);
	}

	public Integer getWarnTime() {
		return WarnTime;
	}

	public void setWarnTime(String warnTime) {
		if(CommonUtils.isInteger(warnTime))
			WarnTime = Integer.valueOf(warnTime);
	}

	public Integer getCTime() {
		return CTime;
	}

	public void setCTime(String cTime) {
		if(CommonUtils.isInteger(cTime))
			CTime = Integer.valueOf(cTime);
	}

	public List<PeConMinuteDataDetail> getCP() {
		return CP;
	}

	public void setCP(List<PeConMinuteDataDetail> cP) {
		CP = cP;
	}

	public String getST() {
		return ST;
	}

	public void setST(String sT) {
		ST = sT;
	}

	public String getCN() {
		return CN;
	}

	public void setCN(String cN) {
		CN = cN;
	}

	public void setRtdInterval(Integer rtdInterval) {
		RtdInterval = rtdInterval;
	}

	public void setOverTime(Integer overTime) {
		OverTime = overTime;
	}

	public void setReCount(Integer reCount) {
		ReCount = reCount;
	}

	public void setWarnTime(Integer warnTime) {
		WarnTime = warnTime;
	}

	public void setCTime(Integer cTime) {
		CTime = cTime;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

		obj.put("ST", this.ST);
		obj.put("CN", this.CN);
		obj.put("QN", this.QN);
		obj.put("PNO", this.PNO);
		obj.put("PNUM", this.PNUM);
		obj.put("PW", this.PW);
		obj.put("OverTime", this.OverTime);
		obj.put("ReCount", this.ReCount);
		obj.put("WarnTime", this.WarnTime);
		obj.put("CTime", this.CTime);
		obj.put("MN", this.MN);
		obj.put("Flag", this.Flag);
		
		obj.put("SystemTime", this.SystemTime);
		obj.put("QnRtn", this.QnRtn);
		obj.put("Logon", this.Logon);
		obj.put("ExeRtn", this.ExeRtn);
		obj.put("RtdInterval", this.RtdInterval);
		obj.put("SBNum", this.SBNum);
		obj.put("SBx_RS", this.SBx_RS);
		obj.put("SBx_RT", this.SBx_RT);
		obj.put("AlarmTime", this.AlarmTime);
		obj.put("AlarmType", this.AlarmType);
		obj.put("ReportTarget", this.ReportTarget);
		obj.put("BeginTime", this.BeginTime);
		obj.put("EndTime", this.EndTime);
		obj.put("DataTime", this.getDataTimeFormat());
		obj.put("ReportTime", this.ReportTime);
		obj.put("DayStdValue", this.DayStdValue);
		obj.put("NightStdValue", this.NightStdValue);
		
		JSONArray temp = new JSONArray();
		for(int i=0;i<this.getCP().size();i++){
			PeConMinuteDataDetail po = this.getCP().get(i);
			temp.put(po.toJSONObject());
		}
		obj.put("CP", temp);

		obj.put("positionId",this.positionId);
		obj.put("updateBy",this.updateBy);
		obj.put("updateTime",this.updateTime);
		obj.put("updateByAddress",this.updateByAddress);
		obj.put("createTime",this.createTime);
		obj.put("createBy",this.createBy);
		obj.put("createByAddress",this.createByAddress);
		obj.put("recordVersion",this.recordVersion);

		return obj;
	}

	public String toJSONString() {
		JSONObject obj = new JSONObject();

		try {
			obj.put("ST", this.ST);
			obj.put("CN", this.CN);
			obj.put("QN", this.QN);
			obj.put("PNO", this.PNO);
			obj.put("PNUM", this.PNUM);
			obj.put("PW", this.PW);
			obj.put("OverTime", this.OverTime);
			obj.put("ReCount", this.ReCount);
			obj.put("WarnTime", this.WarnTime);
			obj.put("CTime", this.CTime);
			obj.put("MN", this.MN);
			obj.put("Flag", this.Flag);
			
			obj.put("SystemTime", this.SystemTime);
			obj.put("QnRtn", this.QnRtn);
			obj.put("Logon", this.Logon);
			obj.put("ExeRtn", this.ExeRtn);
			obj.put("RtdInterval", this.RtdInterval);
			obj.put("SBNum", this.SBNum);
			obj.put("SBx_RS", this.SBx_RS);
			obj.put("SBx_RT", this.SBx_RT);
			obj.put("AlarmTime", this.AlarmTime);
			obj.put("AlarmType", this.AlarmType);
			obj.put("ReportTarget", this.ReportTarget);
			obj.put("BeginTime", this.BeginTime);
			obj.put("EndTime", this.EndTime);
			obj.put("DataTime", this.getDataTimeFormat());
			obj.put("ReportTime", this.ReportTime);
			obj.put("DayStdValue", this.DayStdValue);
			obj.put("NightStdValue", this.NightStdValue);
			
			JSONArray temp = new JSONArray();
			for(int i=0;i<this.getCP().size();i++){
				PeConMinuteDataDetail po = this.getCP().get(i);
				temp.put(po.toJSONObject());
			}

			obj.put("positionId",this.positionId);
			obj.put("updateBy",this.updateBy);
			obj.put("updateTime",this.updateTime);
			obj.put("updateByAddress",this.updateByAddress);
			obj.put("createTime",this.createTime);
			obj.put("createBy",this.createBy);
			obj.put("createByAddress",this.createByAddress);
			obj.put("recordVersion",this.recordVersion);
			obj.put("CP", temp.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return obj.toString();
	}
}
