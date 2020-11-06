package com.fjzxdz.ams.module.enviromonit.water.param;

import java.math.BigDecimal;

import com.alibaba.druid.sql.visitor.functions.Char;
import com.fjzxdz.ams.module.enviromonit.water.entity.WaterAttachment;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

@SuppressWarnings("serial")
public class WaterAttachmentParam extends BaseQueryParam {

	private String pointCode;

	private BigDecimal type;

	private BigDecimal enable;

	private String showDetail;

	private String isShow;
	private String source;//数据来源  0 小流域

	@SuppressWarnings({ "rawtypes", "unused" })
	private Class clazz;

	public WaterAttachmentParam() {
		super(WaterAttachment.class);
		this.clazz = WaterAttachment.class;
	}

	@Override
	protected void createQueryClauses() {
		addClause("pointCode", getPointCode(), SearchCondition.EQ);
		addClause("type", getType(), SearchCondition.EQ);
		addClause("enable", getEnable(), SearchCondition.EQ);
		if ("show".equals(isShowDetail())) {
			addClause("isShow", getIsShow(), SearchCondition.EQ);
		}
		if ("0".equals(getSource())) {
			addClause("source", getSource(), SearchCondition.EQ);
		} else {
			addClause("source", "1", SearchCondition.BLANK);
		}
		setOrderBy(" update_date desc");
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String isShowDetail() {
		return showDetail;
	}

	public void setShowDetail(String showDetail) {
		this.showDetail = showDetail;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public BigDecimal getType() {
		return type;
	}

	public void setType(BigDecimal type) {
		this.type = type;
	}

	public BigDecimal getEnable() {
		return enable;
	}

	public void setEnable(BigDecimal enable) {
		this.enable = enable;
	}

}