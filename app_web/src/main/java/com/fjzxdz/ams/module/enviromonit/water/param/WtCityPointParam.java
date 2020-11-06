package com.fjzxdz.ams.module.enviromonit.water.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;

/**
 * @author shenliuyuan
 * @title: WtCityPointParam
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/7/114:37
 */
public class WtCityPointParam extends BaseQueryParam {

    private String pointCode;

    private String pointName;

    private String codeWsystem;

    private String wsystemName;

    private String codeRegion;

    private String regionName;

    private String longitude;

    private String latitude;

    private String pointType;

    private String pointQuality;

    private String status;

    private String remark;

    private String polygon;

    private String lines;

    private String category;

    private String isview;

    @Override
    protected void createQueryClauses() {
        addClause("pointCode",getPointCode(), SearchCondition.LIKE);
        addClause("pointName",getPointName(), SearchCondition.LIKE);
        addClause("codeWsystem",getCodeWsystem(), SearchCondition.LIKE);
        addClause("wsystemName",getWsystemName(), SearchCondition.LIKE);
        addClause("codeRegion",getCodeRegion(), SearchCondition.LIKE);
        addClause("regionName",getRegionName(), SearchCondition.LIKE);
    }

    public String getPointCode() {
        return pointCode;
    }

    public void setPointCode(String pointCode) {
        this.pointCode = pointCode;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getCodeWsystem() {
        return codeWsystem;
    }

    public void setCodeWsystem(String codeWsystem) {
        this.codeWsystem = codeWsystem;
    }

    public String getWsystemName() {
        return wsystemName;
    }

    public void setWsystemName(String wsystemName) {
        this.wsystemName = wsystemName;
    }

    public String getCodeRegion() {
        return codeRegion;
    }

    public void setCodeRegion(String codeRegion) {
        this.codeRegion = codeRegion;
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getPointType() {
        return pointType;
    }

    public void setPointType(String pointType) {
        this.pointType = pointType;
    }

    public String getPointQuality() {
        return pointQuality;
    }

    public void setPointQuality(String pointQuality) {
        this.pointQuality = pointQuality;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getPolygon() {
        return polygon;
    }

    public void setPolygon(String polygon) {
        this.polygon = polygon;
    }

    public String getLines() {
        return lines;
    }

    public void setLines(String lines) {
        this.lines = lines;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getIsview() {
        return isview;
    }

    public void setIsview(String isview) {
        this.isview = isview;
    }
}
