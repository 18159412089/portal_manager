package com.fjzxdz.ams.module.enviromonit.common.param;

import java.math.BigDecimal;

import com.fjzxdz.ams.module.enviromonit.common.dao.PeCommonInfoDao;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

public class PeCommonInfoParam extends BaseQueryParam{
	
	private static final long serialVersionUID = 1L;
	
	private BigDecimal pluId;
	private String pluCode;
	private String pluName;
	private String outfallType;
	private String unit;

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;
	
	public PeCommonInfoParam() {
		super();
		this.clazz = PeCommonInfoDao.class;
	}
	
	@Override
	protected void createQueryClauses() {
		addClause("pluId", getPluId(), SearchCondition.EQ);
		addClause("pluCode",getPluCode(), SearchCondition.EQ);
		addClause("pluName", getPluName(), SearchCondition.LIKE);
		addClause("outfallType", getOutfallType(), SearchCondition.EQ);
		addClause("unit", getUnit(), SearchCondition.EQ);
		setOrderBy("pluCode asc");
	}


	public BigDecimal getPluId() {
		return pluId;
	}
	public void setPluId(BigDecimal pluId) {
		this.pluId = pluId;
	}
	public String getPluCode() {
		return pluCode;
	}
	public void setPluCode(String pluCode) {
		this.pluCode = pluCode;
	}
	public String getPluName() {
		return pluName;
	}
	public void setPluName(String pluName) {
		this.pluName = pluName;
	}
	public String getOutfallType() {
		return outfallType;
	}
	public void setOutfallType(String outfallType) {
		this.outfallType = outfallType;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	
}
