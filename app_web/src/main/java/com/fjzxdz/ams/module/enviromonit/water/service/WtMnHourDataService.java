package com.fjzxdz.ams.module.enviromonit.water.service;

import cn.fjzxdz.frame.common.Page;
import com.fjzxdz.ams.module.enviromonit.water.entity.PollutionWaterData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtMnHourData;
import com.fjzxdz.ams.module.enviromonit.water.param.WtMnHourDataParam;

import java.text.ParseException;
import java.util.Map;

public interface WtMnHourDataService {

	WtMnHourData getById(String uuid);

	Page<Map<String, Object>> getPageList(WtMnHourDataParam param, Page<Map<String, Object>> page);

	Map<String, Object> getPassYearAnalysis(WtMnHourDataParam param) throws ParseException;

	Map<String, Object> getBasinYearAnalysis(String name,String polluteCode) throws ParseException;

	Map<String, Object> getBasinYearAnalysisTb(String name, String polluteCode);

	Map<String, Object> getBasinYearAnalysisNjdb(String name, int thisYear, int lastYear, String polluteCode);
	/**
	 * 新增修改废水企业信息
	 *
	 * @param pollutionWaterData 污水企业对象
	 * @return
	 */
    void addWasteCompanyInfo(PollutionWaterData pollutionWaterData);
	/**
	 * 修改废水企业信息
	 * @param pollutionWaterData
	 * @return
	 */
	void updateWastCompanyInfo(PollutionWaterData pollutionWaterData);
	/**
	 * 删除废水企业信息
	 *
	 * @param qymc    企业名称
	 * @param wrwname 污染物名称
	 * @param year    年度
	 * @param pfl     排放量
	 * @return
	 */
	void deleteWasteCompanyInfo(String qymc, String wrwname, String year, String pfl);

	/**
	 * @Title:  getBasinYearAnalysisTb
	 * @Description:    TODO(这里用一句话描述这个方法的作用)    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年4月29日 下午4:47:40
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年4月29日 下午4:47:40    
	 * @param name
	 * @param polluteCode
	 * @return  Map<String,Object> 
	 * @throws 
	 */ 

}
