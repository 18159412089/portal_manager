package com.fjzxdz.ams.module.enviromonit.air.param;

import cn.fjzxdz.frame.common.BaseQueryParam;
import cn.fjzxdz.frame.common.SearchCondition;
/**
 * 
 * 这里描述这个类是做什么业务 
 * @Author   zhongyunlong
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午5:05:18
 */
public class AirConstructionSiteParam extends BaseQueryParam {

	private static final long serialVersionUID = -8382081155441560703L;
	
	private String name;

	private String area;

	@Override
    protected void createQueryClauses() {
        addClause("name", getName(), SearchCondition.LIKE);
        if(area != null){
        	addClause("area", getArea(), SearchCondition.LIKE);
		}
        setOrderBy(" pkid desc");
    }
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
}
