/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.module.enviromonit.daydata.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fjzxdz.ams.module.enviromonit.daydata.entity.PeConDayData;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 自动监控日浓度数据Entity
 * @author slq
 * @date 2019-02-12
 */
public class PeConDayDataParam extends BaseQueryParam {
	
	private static final long serialVersionUID = 1L;
	/** 企业ID */
	private String peId;
	/** 点位ID */
	private String outputId;
	/** 监测时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date measureTime;
	/** 因子代码 */
	private String pluCode;
	/** 浓度最小值 */
	private String chromaMin;
	/** 浓度均值 */
	private String chromaAvg;
	/** 浓度最大值 */
	private String chromaMax;
	/** 排放量最小值 */
	private String outputMin;
	/** 排放量均值 */
	private String outputAvg;
	/** 排放量最大值 */
	private String outputMax;
	/** 点位类型 */
	private String outfallType;
	/** 是否监测 */
	private String isMeasure;
	/** 插入时间 */
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private java.util.Date insertTime;
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public PeConDayDataParam() {
		super(PeConDayData.class);
		this.clazz = PeConDayData.class;
	}
	
	/**
	 * 拼接查询条件
	 */
	@Override
	protected void createQueryClauses() {
		addClause("peId", getPeId(), SearchCondition.EQ);
		addClause("outputId", getOutputId(), SearchCondition.EQ);
		addClause("measureTime", getMeasureTime(), SearchCondition.EQ);
		addClause("pluCode", getPluCode(), SearchCondition.EQ);
		addClause("chromaMin", getChromaMin(), SearchCondition.EQ);
		addClause("chromaAvg", getChromaAvg(), SearchCondition.EQ);
		addClause("chromaMax", getChromaMax(), SearchCondition.EQ);
		addClause("outputMin", getOutputMin(), SearchCondition.EQ);
		addClause("outputAvg", getOutputAvg(), SearchCondition.EQ);
		addClause("outputMax", getOutputMax(), SearchCondition.EQ);
		addClause("outfallType", getOutfallType(), SearchCondition.EQ);
		addClause("isMeasure", getIsMeasure(), SearchCondition.EQ);
		addClause("insertTime", getInsertTime(), SearchCondition.EQ);
		setOrderBy(" create_date desc");
	}
	
	public String getPeId() {
		return peId;
	}
	
	public void setPeId(String peId) {
		this.peId = peId;
	}
	public String getOutputId() {
		return outputId;
	}
	
	public void setOutputId(String outputId) {
		this.outputId = outputId;
	}
	public java.util.Date getMeasureTime() {
		return measureTime;
	}
	
	public void setMeasureTime(java.util.Date measureTime) {
		this.measureTime = measureTime;
	}
	public String getPluCode() {
		return pluCode;
	}
	
	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}
	public String getChromaMin() {
		return chromaMin;
	}
	
	public void setChromaMin(String chromaMin) {
		this.chromaMin = chromaMin;
	}
	public String getChromaAvg() {
		return chromaAvg;
	}
	
	public void setChromaAvg(String chromaAvg) {
		this.chromaAvg = chromaAvg;
	}
	public String getChromaMax() {
		return chromaMax;
	}
	
	public void setChromaMax(String chromaMax) {
		this.chromaMax = chromaMax;
	}
	public String getOutputMin() {
		return outputMin;
	}
	
	public void setOutputMin(String outputMin) {
		this.outputMin = outputMin;
	}
	public String getOutputAvg() {
		return outputAvg;
	}
	
	public void setOutputAvg(String outputAvg) {
		this.outputAvg = outputAvg;
	}
	public String getOutputMax() {
		return outputMax;
	}
	
	public void setOutputMax(String outputMax) {
		this.outputMax = outputMax;
	}
	public String getOutfallType() {
		return outfallType;
	}
	
	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}
	public String getIsMeasure() {
		return isMeasure;
	}
	
	public void setIsMeasure(String isMeasure) {
		this.isMeasure = isMeasure;
	}
	public java.util.Date getInsertTime() {
		return insertTime;
	}
	
	public void setInsertTime(java.util.Date insertTime) {
		this.insertTime = insertTime;
	}
	
}


