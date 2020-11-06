package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import com.alibaba.fastjson.JSONArray;
import com.fjzxdz.ams.common.generate.utils.LayuiUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityHourData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtCityPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityHourDataParam;
import com.fjzxdz.ams.module.enviromonit.water.param.WtCityPointParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourDataService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityHourReportService;
import com.fjzxdz.ams.module.enviromonit.water.service.WtCityPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;

/**
 *     
 * 水环境小时数据
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午3:37:33
 */
@Controller
@RequestMapping("/enviromonit/water/wtCityHourData")
@Secured({ "ROLE_USER" })
public class WtCityHourDataController extends BaseController {
	
	@Autowired
	private WtCityHourDataService wtCityHourDataService;
	@Autowired
	private WtCityHourReportService reportService;
	@Autowired
	private WtCityPointService wtCityPointService;
	//用于存储导入的失败数据
	private static Map<String,List<String>> map=new HashMap<>();
	/**
	 * 
	 * @Title:  index
	 * @Description:    数据服务-水环境自建站点数据列表 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:38:09
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:38:09    
	 * @param modelAndView
	 * @param pointCode
	 * @param startTime
	 * @param endTime
	 * @return  ModelAndView 
	 * @throws
	 */
	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView,String pointCode,String startTime,String endTime,String pid) {
		modelAndView.addObject("pointCode", pointCode);
		modelAndView.addObject("startTime", startTime);
		modelAndView.addObject("endTime", endTime);
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/enviromonit/water/wtCityHourDataList");
		return modelAndView;
	}
	
    
	/**
	 * 
	 * @Title:  wtMnYearDataList
	 * @Description:    数据服务-水质分析排名
	 * @CreateBy: htj 
	 * @CreateTime: 2019年6月29日  
	 * @UpdateBy: htj 
	 * @UpdateTime:  2019年5月29日 
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtRankingQualityData")
	public String wtRankingQualityData() {
		return "/moudles/enviromonit/water/wtRankingQualityData";
	}
	
	
	/**
	 * 
	 * @Title:  wtMnYearDataList
	 * @Description:    数据服务-国家水质年监测结果数据    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:39:07
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:39:07    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtYearQualityDataList")
	public String wtMnYearDataList() {
		return "/moudles/enviromonit/water/wtYearQualityDataList";
	}
	/**
	 * 
	 * @Title:  wtMonthQualityDataList
	 * @Description:    数据服务-地表水断面采测分离水质评    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:43:53
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:43:53    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtMonthQualityDataList")
	public String wtMonthQualityDataList() {
		return "/moudles/enviromonit/water/wtMonthQualityDataList";
	}
	
	
	
	/**
	 * 
	 * @Title:  wtMonthQualityDataList
	 * @Description:    数据服务-水质分析同比
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:43:53
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:43:53    
	 * @return  String 
	 * @throws
	 */
	@RequestMapping("/wtYearToYearDataList")
	public String wtYearToYearDataList() {
		return "/enviromonit/newDataService/index52";
	}
	
	
	/**
	 * 
	 * @Title:  getPollutes
	 * @Description:    获取污染物因子的列表    
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:44:40
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:44:40    
	 * @return  JSONArray 
	 * @throws
	 */
	@RequestMapping("/getPollutes")
	@ResponseBody
	public JSONArray getPollutes(){
		String json = "[{'key':'W01010','text':'水温'},{'key':'W01001','text':'PH值'},"
				+ "{'key':'W01009','text':'溶解氧'},{'key':'W01014','text':'电导率'},{'key':'W01003','text':'浑浊度'},"
				+ "{'key':'W01019','text':'高锰酸盐指数'},{'key':'W21003','text':'氨氮（NH3-N）'},{'key':'W21011','text':'总磷（以P计）'},"
				+ "{'key':'W21001','text':'总氮（以氮计）'}]";
		return JSONArray.parseArray(json);
	}
	
	/**
	 * 
	 * @Title:  getPageList
	 * @Description:    数据服务-水环境自建站点数据列表 
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:46:19
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:46:19    
	 * @param param
	 * @param request
	 * @return  PageEU<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<Map<String, Object>> getPageList(WtCityHourDataParam param, HttpServletRequest request){
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> wtCityHourDataPage = wtCityHourDataService.getPageList(param, page);
		return new PageEU<>(wtCityHourDataPage);
	}
	
	/**
	 * 
	 * @Title:  getPointsDateByHour
	 * @Description:    数据服务-水环境自建站点数据分析  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:50:41
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:50:41    
	 * @param param
	 * @return
	 * @throws ParseException  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getPointsDateByHour")
	@ResponseBody
	public List<Map<String, Object>> getPointsDateByHour(WtCityHourDataParam param) throws ParseException{
		List<Map<String, Object>> result = wtCityHourDataService.getPointsDateByHour(param);
		return result;
	}
	
	/**
	 * 
	 * @Title:  getPointsDateByHour
	 * @Description:    数据服务-水质分析  统计图
	 * @CreateBy: htj 
	 * @CreateTime: 2019年6月26日 下午3:50:41
	 * @UpdateBy: htj 
	 * @UpdateTime:  2019年6月26日 下午3:50:41    
	 * @param
	 * @return
	 * @throws ParseException
	 * @throws
	 */
	@RequestMapping("/getRankingQualityDataByTime")
	@ResponseBody
	public   JSONObject getRankingQualityDataByTime(String regionCode, String startTime, String endTime,String category, String type) throws ParseException{
 		JSONObject jObject = new JSONObject(); 
		JSONArray nameArr = new JSONArray(); 
		JSONArray levelNameArr = new JSONArray(); 
		JSONArray levelNumArr  = new JSONArray(); 
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataByTime(regionCode,startTime,endTime, category, type);
		Collections.sort(result, new Comparator<Map<String,Object>>(){  
            public int compare(Map<String,Object> o1,Map<String,Object> o2){  
                return  (int)o1.get("reslutQualityNum")>(int)o2.get("reslutQualityNum")?1:( (int)o1.get("reslutQualityNum")==(int)o2.get("reslutQualityNum")?0:-1);
            }  
        }); 
		for(int i = 0 ; i < result.size() ; i++){
			nameArr.add(result.get(i).get("pointName"));
			levelNumArr.add(result.get(i).get("reslutQualityNum"));
			levelNameArr.add(result.get(i).get("reslutQuality"));
		}
		jObject.put("names", nameArr);
		jObject.put("levelNames", levelNameArr);
		jObject.put("levelNums", levelNumArr);
		 return jObject;
	}
	/**
	 * 
	 * @Title:  getPointsDateByHour
	 * @Description:    数据服务-水质分析  表单
	 * @CreateBy: htj 
	 * @CreateTime: 2019年6月26日 下午3:50:41
	 * @UpdateBy: htj 
	 * @UpdateTime:  2019年6月26日 下午3:50:41    
	 * @param
	 * @return
	 * @throws ParseException
	 * @throwsString 
	 */
	@RequestMapping("/getRankingQualityDataByTimeForm")
	@ResponseBody
	public   List<Map<String, Object>>  getRankingQualityDataByTimeForm(String regionCode , String startTime, String endTime,String category, String type) throws ParseException{
	
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataByTime(regionCode,startTime,endTime, category, type);
		Collections.sort(result, new Comparator<Map<String,Object>>(){  
            public int compare(Map<String,Object> o1,Map<String,Object> o2){  
                return  (int)o1.get("reslutQualityNum")>(int)o2.get("reslutQualityNum")?1:( (int)o1.get("reslutQualityNum")==(int)o2.get("reslutQualityNum")?0:-1);
            }  
        }); 
		return   result   ;
	}
	
	

	
	
	/**
	 * 获取前3名 ，后3名数据 水质分析
	 * @param regionCode 区域
	 * @param startTime  开始时间
	 * @param endTime    结束时间
	 * @param category   国控省控级别
	 * @param type       hour  day  month year  
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/getTopLast3RankingQualityDataByTime")
	@ResponseBody
	public   JSONObject getTopLast3RankingQualityDataByTime(String regionCode , String startTime, String endTime,String category, String type) throws ParseException{
		JSONObject jsonObject = new JSONObject();
		int num = 3 ;
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataByTime(regionCode,startTime,endTime, category, type);
		Collections.sort(result, new Comparator<Map<String,Object>>(){  
            public int compare(Map<String,Object> o1,Map<String,Object> o2){  
                return  (int)o1.get("reslutQualityNum")>(int)o2.get("reslutQualityNum")?1:( (int)o1.get("reslutQualityNum")==(int)o2.get("reslutQualityNum")?0:-1);
            }  
        });
		JSONArray top3Array = new JSONArray();
		JSONArray last3Array = new JSONArray();
		for(int i = 0; i<result.size();  i++){
			JSONObject rankObject = new JSONObject();
		     	if (i < num) {
		     		rankObject.put("pointName", result.get(i).get("pointName"));
		     		rankObject.put("reslutQuality", result.get(i).get("reslutQuality"));
		     		rankObject.put("overPollutant", result.get(i).get("overPollutant"));
		     		top3Array.add(rankObject);
				}else{
					break;
				}
		}
		int  lastNum = result.size() -3  ;
		if(lastNum < 0){
			 lastNum = 0;
		 } 
		for(int i = result.size()-1 ; i >=lastNum;  i--){
			JSONObject rankObject = new JSONObject();
		    rankObject.put("pointName", result.get(i).get("pointName"));
     		rankObject.put("reslutQuality", result.get(i).get("reslutQuality"));
     		rankObject.put("overPollutant", result.get(i).get("overPollutant"));
     		last3Array.add(rankObject);
		 }
		jsonObject.put("top3", top3Array);
		jsonObject.put("last3", last3Array);
		return   jsonObject   ;
	}
	

	
	/**
	 * 
	 * @Title:   
	 * @Description:    数据服务-均值表单
	 * @CreateBy: htj 
	 * @CreateTime: 2019年6月26日 下午3:50:41
	 * @UpdateBy: htj 
	 * @UpdateTime:  2019年6月26日 下午3:50:41    
	 * @param
	 * @return
	 * @throws ParseException
	 * @throws
	 */
	@RequestMapping("/getAvgPollutantDataByTimeForm")
	@ResponseBody
	public   List<Map<String, Object>>  getAvgPollutantDataByTimeForm(String regionCode , String startTime, String endTime,String category, String type,String pollutantCode,int flag) throws ParseException{
	
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataForPollutant(regionCode,startTime,endTime, category, type,pollutantCode,flag);
		if(result.size() >0) {
			Collections.sort(result, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> o1, Map<String, Object> o2) {
					return (float) o1.get("avgValue") > (float) o2.get("avgValue") ? 1 : ((float) o1.get("avgValue") == (float) o2.get("avgValue") ? 0 : -1);
				}
			});
		}
		return   result  ;
	}
	
	
	
    /**
     * 均值排名
    * @param regionCode 区域
	 * @param startTime  开始时间
	 * @param endTime    结束时间
	 * @param category   国控省控级别
	 * @param type       hour  day  month year  
     * @param pollutantCode   所选中的污染物因子
     * @return 
     * @throws ParseException
     */
	@RequestMapping("/getRankingQualityDataForPollutant")
	@ResponseBody
	public   JSONObject getRankingQualityDataForPollutant(String regionCode, String startTime, String endTime,String category, String type ,String pollutantCode,int flag) throws ParseException{
 		JSONObject jObject = new JSONObject(); 
		JSONArray nameArr = new JSONArray(); 
		JSONArray avgValueArr = new JSONArray(); 
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataForPollutant(regionCode, startTime, endTime, category, type, pollutantCode,flag);

		if(result.size() >0) {
			Collections.sort(result, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> o1, Map<String, Object> o2) {
					return (float) o1.get("avgValue") > (float) o2.get("avgValue") ? 1 : ((float) o1.get("avgValue") == (float) o2.get("avgValue") ? 0 : -1);
				}
			});
			for (int i = 0; i < result.size(); i++) {
				nameArr.add(result.get(i).get("pointName"));
				avgValueArr.add(result.get(i).get("avgValue"));
			}
			jObject.put("names", nameArr);
			jObject.put("avgValues", avgValueArr);
		}
		 return jObject;
	}
	
	/**
	 * 获取前3名 ，后3名数据 均值排名 按区域
	 * @param regionCode 区域
	 * @param startTime  开始时间
	 * @param endTime    结束时间
	 * @param category   国控省控级别
	 * @param type       hour  day  month year  
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/getTopLast3AvgQualityDataByTime")
	@ResponseBody
	public   JSONObject getTopLast3AvgQualityDataByTime(String regionCode , String startTime, String endTime,String category, String type, String pollutantCode,int flag) throws ParseException{
		JSONObject jObject = new JSONObject();  
		int num = 3 ;
		List<Map<String, Object>> result = wtCityHourDataService.getRankingQualityDataForPollutant(regionCode, startTime, endTime, category, type, pollutantCode, flag);
	   if(result.size() >0) {
		   Collections.sort(result, new Comparator<Map<String, Object>>() {
			   public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				   return (float) o1.get("avgValue") > (float) o2.get("avgValue") ? 1 : ((float) o1.get("avgValue") == (float) o2.get("avgValue") ? 0 : -1);
			   }
		   });
		   JSONArray top3Array = new JSONArray();
		   JSONArray last3Array = new JSONArray();
		   for (int i = 0; i < result.size(); i++) {
			   JSONObject rankObject = new JSONObject();
			   if (i < num) {
				   rankObject.put("pointName", result.get(i).get("pointName"));
				   rankObject.put("avgValue", result.get(i).get("avgValue"));
				   top3Array.add(rankObject);
			   } else {
				   break;
			   }
		   }
		   int lastNum = result.size() - 3;
		   if (lastNum < 0) {
			   lastNum = 0;
		   }
		   for (int i = result.size() - 1; i >= lastNum; i--) {
			   JSONObject rankObject = new JSONObject();
			   rankObject.put("pointName", result.get(i).get("pointName"));
			   rankObject.put("avgValue", result.get(i).get("avgValue"));
			   last3Array.add(rankObject);
		   }
		   jObject.put("top3", top3Array);
		   jObject.put("last3", last3Array);
	   }
		return   jObject   ;
	}
	 
 
	@RequestMapping("/wtYearOnYearCompareResult")
	@ResponseBody
	public  cn.hutool.json.JSONObject  wtYearOnYearCompareResult(String pointCodes , String currentTime, String lastTime  , String type) throws  Exception{
		  return   wtCityHourDataService.getWtYearToYearDataResultByTime(pointCodes, currentTime, lastTime, type);
	}
	
	
	
	
	/**
	 * 同比 监测站因子分析
	 * @param pointCodes 站点列表
	 * @param currentTime 当前时间
	 * @param lastTime    去年时间
	 * @param type        时间类型  天 月 年
	 * @param pollutantCode 因子列表
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/wtYearOnYearCompare")
	@ResponseBody
	public  cn.hutool.json.JSONObject  wtYearOnYearCompare(String pointCodes , String currentTime, String lastTime  , String type,String pollutantCode) throws ParseException{
		 cn.hutool.json.JSONObject  yyCompareDatas =  new JSONObject() ;  
		 cn.hutool.json.JSONObject  tempYYCompareDatas = null ;
		 cn.hutool.json.JSONArray   monitorTimeArr = InitDateTime(type);
		 tempYYCompareDatas = wtCityHourDataService.getWtYearToYearDataByTime(pointCodes,pollutantCode,currentTime,lastTime, type);
		   String [] pointCodeArr = pointCodes.split(",");
		  for (int i = 0; i < pointCodeArr.length; i++) {
			     cn.hutool.json.JSONObject  pointDatas =  new JSONObject() ;  
			     cn.hutool.json.JSONArray   currentTimeMonitorValArr = new  cn.hutool.json.JSONArray();
				 cn.hutool.json.JSONArray   lastTimeMonitorValArr = new  cn.hutool.json.JSONArray();
				 String pointCode = pointCodeArr[i].replace("'","");
				 if (! tempYYCompareDatas.containsKey(pointCode) ) {
					   continue;
				 }
				 JSONObject pointObj 	 = tempYYCompareDatas.getJSONObject( pointCode);
				 JSONObject pollutantObj = pointObj.getJSONObject(pollutantCode);
				 for(int j = 0;j<pollutantObj.getJSONArray("monitorTimes").size();j++){
					  String[] monitorArr = pollutantObj.getJSONArray("monitorTimes").get(j).toString().split(" ");
					  String pollutantData =  pollutantObj.getJSONArray("pollutantDatas").get(j).toString();
					  classifyMonitorVal( type ,currentTime , monitorTimeArr,monitorArr ,pollutantData , currentTimeMonitorValArr, lastTimeMonitorValArr) ;
					  
				   } 
				 pointDatas.put("pointCode", pointObj.getStr("pointCode"));
				 pointDatas.put("pointName", pointObj.getStr("pointName"));
				 pointDatas.put("codePollute",pollutantObj.getStr("codePollute"));
				 pointDatas.put("polluteName",pollutantObj.getStr("polluteName"));
				 pointDatas.put("monitorTimeArr",monitorTimeArr);
				 pointDatas.put("currentTimemonitorValArr", currentTimeMonitorValArr);
				 pointDatas.put("lastTimemonitorValArr",   lastTimeMonitorValArr);
				 yyCompareDatas.put(pointDatas.getStr("pointCode").toString(),pointDatas);
		 }
		 return   yyCompareDatas  ;
	}
	
	//根据type 填充 当前时间arr,过去时间arr
	public void classifyMonitorVal(String type ,String currentTime ,cn.hutool.json.JSONArray  monitorTimeArr,  String[]  monitorArr , String pollutantData ,  cn.hutool.json.JSONArray currentTimeMonitorValArr,  cn.hutool.json.JSONArray lastTimeMonitorValArr){
		 switch (type) {
			case "DAY":
				if( monitorArr[0].contains(currentTime)){
					   if( monitorTimeArr.contains(monitorArr[1])){
						   currentTimeMonitorValArr.add(pollutantData);
					   }else{
						   currentTimeMonitorValArr.add(" ");
					   }
				   }else{
					   if( monitorTimeArr.contains(monitorArr[1])){
					       lastTimeMonitorValArr.add(pollutantData); 
					   }else{
						   lastTimeMonitorValArr.add(" ");
					   }
				   };
			 break;
			case "MONTH":
				currentTime = currentTime.split("-")[0] ;
				monitorArr = monitorArr[0].toString().split("-");
				if( monitorArr[0].contains(currentTime)){
					   if( monitorTimeArr.contains(monitorArr[2])){
						   currentTimeMonitorValArr.add(pollutantData);
					   }else{
						   currentTimeMonitorValArr.add(" ");
					   }
				   }else{
					   if( monitorTimeArr.contains(monitorArr[2])){
					       lastTimeMonitorValArr.add(pollutantData); 
					   }else{
						   lastTimeMonitorValArr.add(" ");
					   }
				   };
				 break;
			case "YEAR":
				currentTime = currentTime.split("-")[0] ;
				monitorArr = monitorArr[0].toString().split("-");
				if( monitorArr[0].contains(currentTime)){
					   if( monitorTimeArr.contains(monitorArr[1])){
						   currentTimeMonitorValArr.add(pollutantData);
					   }else{
						   currentTimeMonitorValArr.add(" ");
					   }
				   }else{
					   if( monitorTimeArr.contains(monitorArr[1])){
					       lastTimeMonitorValArr.add(pollutantData); 
					   }else{
						   lastTimeMonitorValArr.add(" ");
					   }
				   };
				 break;
	
			default:
				break;
		}
		
	}
	
	
	/**
	 * 初始化时间
	 * @param type
	 */
	public cn.hutool.json.JSONArray  InitDateTime(String type){
		cn.hutool.json.JSONArray timeJsonArray = new cn.hutool.json.JSONArray();
	    switch (type) {
		case "MONTH":
			   for (int i = 1; i <=31; i++) {
				 if(i < 10){
					 timeJsonArray.add("0"+i);
				 }else{
					 timeJsonArray.add(""+i+"");
				 }
			 }
			break;
		case "DAY":
			 for (int i = 0; i < 24; i++) {
				 if(i < 10){
					 timeJsonArray.add("0"+i);
				 }else{
					 timeJsonArray.add(""+i+"");
				 }
			 }
			break;
		case "YEAR":
			   for (int i = 1; i <=12; i++) {
				 if(i < 10){
					 timeJsonArray.add("0"+i);
				 }else{
					 timeJsonArray.add(""+i+"");
				 }
			 }
			break;
		default:
			break;
		}
	    return timeJsonArray;
	}
	
	
	
	 
	
	
	
	/**
	 * 
	 * @Title:  getYearDataQuality
	 * @Description:    数据服务-国家水质年监测结果数据      
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:51:01
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:51:01    
	 * @param queryYear
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getYearDataQuality")
	@ResponseBody
	public List<Map<String, Object>> getYearDataQuality(String queryYear){
		return wtCityHourDataService.getYearDataQuality(queryYear,"");
	}
	/**
	 * 
	 * @Title:  getMonthDataQuality
	 * @Description:    数据服务-地表水断面采测分离水质评        
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:51:05
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:51:05    
	 * @param yearMonth
	 * @return  List<Map<String,Object>> 
	 * @throws
	 */
	@RequestMapping("/getMonthDataQuality")
	@ResponseBody
	public List<Map<String, Object>> getMonthDataQuality(String yearMonth){
		return wtCityHourDataService.getMonthDataQuality(yearMonth);
	}

	@RequestMapping("/getGkSkShowData")
	@ResponseBody
	public R getGkSkShowData(String year) {
		Map map = new HashMap();
		// 漳州生态云水环境汇总栏
		JSONArray countMonitorSituation = reportService.countMonitorSituation();
		map.put("total", countMonitorSituation);
		//国考省考断面年目标管理、考核目标等
		Map assinMap = reportService.wtData(year);
		map.put("assinMap", assinMap);
		return R.ok(map);
	}

	@RequestMapping("/getDetailList4Month")
	@ResponseBody
	public LayuiUtil getDetailList4Month(String pointCode, String flag) {
		Map parmMap = new HashMap();
		parmMap.put("pointCode", pointCode);
		List<Object> detailList4Month = reportService.getDetailList4Months(flag, parmMap);
		return LayuiUtil.data(detailList4Month.size(), detailList4Month);
	}

	/**
	 * @param param
	 * @param request
	 * @return PageEU<Map < String, Object>>
	 * @throws
	 * @Title: list
	 * @Description: 省手工-水基础资料
	 * @CreateBy: shenliuyuan
	 */
	@RequestMapping("/findList")
	@ResponseBody
	public PageEU<Map<String, Object>> findList(WtCityHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
		Page<Map<String, Object>> page = pageQuery(request);
		Page<Map<String, Object>> airDataPage = wtCityHourDataService.findList(param, page,response);
		if (ToolUtil.isEmpty(airDataPage)) return null;
		return new PageEU<>(airDataPage);
	}

	/**
	 * @param param
	 * @param request
	 * @return PageEU<Map < String, Object>>
	 * @throws
	 * @Title: list
	 * @Description: 省手工-水基础（国考模板导出）
	 * @CreateBy: shenliuyuan
	 */
	@RequestMapping("/downloadTemplate2")
	@ResponseBody
	public void downloadTemplate2(WtCityHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "省手工-水基础资料");
		columnMap.put("pointCode", "断面编码");
		columnMap.put("pointName", "断面名称");
		columnMap.put("datatime", "时间");
		columnMap.put("val1", "PH");
		columnMap.put("val2", "溶解氧");
		columnMap.put("val3", "高锰酸盐指数");
		columnMap.put("val4", "化学需氧量");
		columnMap.put("val5", "五日生化需氧量");
		columnMap.put("val6", "氨氮");
		columnMap.put("val7", "总磷");
		columnMap.put("val8", "铜");
		columnMap.put("val9", "锌");
		columnMap.put("val10", "氟化物");
		columnMap.put("val11", "硒");
		columnMap.put("val12", "砷");
		columnMap.put("val13", "汞");
		columnMap.put("val14", "镉");
		columnMap.put("val15", "六价铬");
		columnMap.put("val16", "铅");
		columnMap.put("val17", "氰化物");
		columnMap.put("val18", "阴离子表面活性剂");
		columnMap.put("val19", "硫化物");
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("pointCode", "A350600_0001");
		tempMap.put("pointName", "华安西陂");
		tempMap.put("datatime", "2019-8-11 00:00:00");
		tempMap.put("val1", "1");
		tempMap.put("val2", "2");
		tempMap.put("val3", "3");
		tempMap.put("val4", "4");
		tempMap.put("val5", "5");
		tempMap.put("val6", "6");
		tempMap.put("val7", "7");
		tempMap.put("val8", "8");
		tempMap.put("val9", "9");
		tempMap.put("val10", "10");
		tempMap.put("val11", "11");
		tempMap.put("val12", "12");
		tempMap.put("val13", "13");
		tempMap.put("val14", "14");
		tempMap.put("val15", "15");
		tempMap.put("val16", "16");
		tempMap.put("val17", "17");
		tempMap.put("val18", "18");
		tempMap.put("val19", "19");
		result.add(tempMap);
		ExcelExportUtil.exportExcel(response, columnMap, result);
	}

	/**
	 * @param param
	 * @param request
	 * @return PageEU<Map < String, Object>>
	 * @throws
	 * @Title: list
	 * @Description: 省手工-水基础（省考模板导出）
	 * @CreateBy: shenliuyuan
	 */
	@RequestMapping("/downloadTemplate")
	@ResponseBody
	public void downloadTemplate(WtCityHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "省手工-水基础资料");
		columnMap.put("pointCode", "断面编码");
		columnMap.put("pointName", "断面名称");
		columnMap.put("datatime", "时间");
		columnMap.put("val1", "PH");
		columnMap.put("val2", "溶解氧");
		columnMap.put("val3", "高锰酸盐指数");
		columnMap.put("val4", "化学需氧量");
		columnMap.put("val5", "五日生化需氧量");
		columnMap.put("val6", "氨氮");
		columnMap.put("val7", "总磷");
		columnMap.put("val8", "铜");
		columnMap.put("val9", "锌");
		columnMap.put("val10", "氟化物");
		columnMap.put("val11", "硒");
		columnMap.put("val12", "砷");
		columnMap.put("val13", "汞");
		columnMap.put("val14", "镉");
		columnMap.put("val15", "六价铬");
		columnMap.put("val16", "铅");
		columnMap.put("val17", "氰化物");
		columnMap.put("val18", "阴离子表面活性剂");
		columnMap.put("val19", "硫化物");
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> tempMap = new HashMap<>();
		tempMap.put("pointCode", "06900005");
		tempMap.put("pointName", "南靖上洋");
		tempMap.put("datatime", "2019-8-11 00:00:00");
		tempMap.put("val1", "1");
		tempMap.put("val2", "2");
		tempMap.put("val3", "3");
		tempMap.put("val4", "4");
		tempMap.put("val5", "5");
		tempMap.put("val6", "6");
		tempMap.put("val7", "7");
		tempMap.put("val8", "8");
		tempMap.put("val9", "9");
		tempMap.put("val10", "10");
		tempMap.put("val11", "11");
		tempMap.put("val12", "12");
		tempMap.put("val13", "13");
		tempMap.put("val14", "14");
		tempMap.put("val15", "15");
		tempMap.put("val16", "16");
		tempMap.put("val17", "17");
		tempMap.put("val18", "18");
		tempMap.put("val19", "19");
		result.add(tempMap);
		ExcelExportUtil.exportExcel(response, columnMap, result);
	}

	/**
	 * @param param
	 * @param request
	 * @return PageEU<Map < String, Object>>
	 * @throws
	 * @Title: list
	 * @Description: 省手工-水基础（数据导出）
	 * @CreateBy: shenliuyuan
	 */
	@RequestMapping("/exportData")
	@ResponseBody
	public void exportData(WtCityHourDataParam param, HttpServletRequest request, HttpServletResponse response) {
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		if (param.getType() == 0) {
			columnMap.put("title", "省接口-水基础资料");
		} else if (param.getType() == 1) {
			columnMap.put("title", "省手工-水基础资料");
		} else if (param.getType() == 2) {
			columnMap.put("title", "省自建-水基础资料");
		}
		columnMap.put("pointCode", "断面编码");
		columnMap.put("pointName", "断面名称");
		columnMap.put("datatime", "时间");
		columnMap.put("val1", "PH");
		columnMap.put("val2", "溶解氧");
		columnMap.put("val3", "高锰酸盐指数");
		columnMap.put("val4", "化学需氧量");
		columnMap.put("val5", "五日生化需氧量");
		columnMap.put("val6", "氨氮");
		columnMap.put("val7", "总磷");
		columnMap.put("val8", "铜");
		columnMap.put("val9", "锌");
		columnMap.put("val10", "氟化物");
		columnMap.put("val11", "硒");
		columnMap.put("val12", "砷");
		columnMap.put("val13", "汞");
		columnMap.put("val14", "镉");
		columnMap.put("val15", "六价铬");
		columnMap.put("val16", "铅");
		columnMap.put("val17", "氰化物");
		columnMap.put("val18", "阴离子表面活性剂");
		columnMap.put("val19", "硫化物");
		/*columnMap.put("result", "结果");*/
		List<Map<String, Object>> result=wtCityHourDataService.exportData(param);
		/*for (Map<String, Object> stringObjectMap : result) {
			stringObjectMap.put("result","-");
		}*/
		ExcelExportUtil.exportExcel(response, columnMap, result);
	}
	@RequestMapping("/importData")
	@ResponseBody
	public R importData(MultipartFile file) throws Exception{
		try {
			map.clear();
			ExcelReader reader = ExcelUtil.getReader(file.getInputStream());
			List<List<Object>> readAll = reader.read();
			List<String> wtCityPointList = new ArrayList<>();
			int success=0;
			int fail=0;
			for (int i = 2; i < readAll.size(); i++) {
				List<Object> list = readAll.get(i);
				String data0=list.get(0)+"";
				String data1=list.get(1)+"";
				boolean flag=isCode(data0, data1);
				if(!flag){
					fail++;
					wtCityPointList.add(data0);
					continue;
				}
				Date data2 = null;
				if(list.get(2) instanceof java.lang.String){
					String s=(String)list.get(2);
					data2 = DateUtil.parse(s, "yyyy-MM-dd HH:mm:ss");
				}else if(list.get(2) instanceof java.util.Date){
					data2=(Date)list.get(2);
				}
				String val1=list.get(3)+"";
				String val2=list.get(4)+"";
				String val3=list.get(5)+"";
				String val4=list.get(6)+"";
				String val5=list.get(7)+"";
				String val6=list.get(8)+"";
				String val7=list.get(9)+"";
				String val8=list.get(10)+"";
				String val9=list.get(11)+"";
				String val10=list.get(12)+"";
				String val11=list.get(13)+"";
				String val12=list.get(14)+"";
				String val13=list.get(15)+"";
				String val14=list.get(16)+"";
				String val15=list.get(17)+"";
				String val16=list.get(18)+"";
				String val17=list.get(19)+"";
				String val18=list.get(20)+"";
				String val19=list.get(21)+"";
				if(flag&&data2!=null){
					//PH
					if (StringUtils.isNotEmpty(val1)&&!val1.equals("0")){
						test(data0,data2,"W01001",data1,"pH 值",val1);
					}
					//溶解氧
					if (StringUtils.isNotEmpty(val2)&&!val2.equals("0")){
						test(data0,data2,"W01009",data1,"溶解氧",val2);
					}
					//高锰酸盐指数
					if (StringUtils.isNotEmpty(val3)&&!val3.equals("0")){
						test(data0,data2,"W01019",data1,"高锰酸盐指数",val3);
					}
					//化学需氧量COD
					if (StringUtils.isNotEmpty(val4)&&!val4.equals("0")){
						test(data0,data2,"W01018",data1,"化学需氧量COD",val4);
					}
					//五日生化需氧量
					if (StringUtils.isNotEmpty(val5)&&!val5.equals("0")){
						test(data0,data2,"W01017",data1,"五日生化需氧量",val5);
					}
					//氨氮
					if (StringUtils.isNotEmpty(val6)&&!val6.equals("0")){
						test(data0,data2,"W21003",data1,"氨氮",val6);
					}
					//总磷
					if (StringUtils.isNotEmpty(val7)&&!val7.equals("0")){
						test(data0,data2,"W21011",data1,"总磷",val7);
					}
					//铜
					if (StringUtils.isNotEmpty(val8)&&!val8.equals("0")){
						test2(data0,data2,"",data1,"铜",val8);
					}
					//锌
					if (StringUtils.isNotEmpty(val9)&&!val9.equals("0")){
						test2(data0,data2,"",data1,"锌",val9);
					}
					//氟化物（以F-计）
					if (StringUtils.isNotEmpty(val10)&&!val10.equals("0")){
						test(data0,data2,"W21017",data1,"氟化物（以F-计）",val10);
					}
					//硒
					if (StringUtils.isNotEmpty(val11)&&!val11.equals("0")){
						test2(data0,data2,"",data1,"硒",val11);
					}
					//砷
					if (StringUtils.isNotEmpty(val12)&&!val12.equals("0")){
						test2(data0,data2,"",data1,"砷",val12);
					}
					//汞
					if (StringUtils.isNotEmpty(val13)&&!val13.equals("0")){
						test2(data0,data2,"",data1,"汞",val13);
					}
					//镉
					if (StringUtils.isNotEmpty(val14)&&!val14.equals("0")){
						test2(data0,data2,"",data1,"镉",val14);
					}
					//六价铬
					if (StringUtils.isNotEmpty(val15)&&!val15.equals("0")){
						test2(data0,data2,"",data1,"六价铬",val15);
					}
					//总铅
					if (StringUtils.isNotEmpty(val16)&&!val16.equals("0")){
						test(data0,data2,"W20120",data1,"总铅",val16);
					}
					//氰化物
					if (StringUtils.isNotEmpty(val17)&&!val17.equals("0")){
						test2(data0,data2,"",data1,"氰化物",val17);
					}
					//阴离子表面活性剂
					if (StringUtils.isNotEmpty(val18)&&!val18.equals("0")){
						test2(data0,data2,"",data1,"阴离子表面活性剂",val18);
					}
					//硫化物
					if (StringUtils.isNotEmpty(val19)&&!val19.equals("0")){
						test2(data0,data2,"",data1,"硫化物",val19);
					}
				}
				success++;
			}
			map.put("failList", wtCityPointList);
			R result=new R();
			result.put("status", 0);
			result.put("msg", "导入成功"+success+"条，失败"+fail+"条");
			result.put("data", wtCityPointList.size());
			return result;
		}catch (Exception e){
			e.printStackTrace();
			R result=new R();
			result.put("status", 1);
			result.put("msg", "导入失败,请检查格式是否正确");
			return result;
		}
	}

	public void test(String pointCode,Date dateTime,String codePollute,String pointName,String paramname,String datavalue){
		WtCityHourData wtCityHourData=new WtCityHourData();
		wtCityHourData.setPointCode(pointCode);
		wtCityHourData.setDatatime(dateTime);
		wtCityHourData.setCodePollute(codePollute);
		List<Map<String, Object>> list1=wtCityHourDataService.getDataByCode(wtCityHourData);
		wtCityHourData.setParamname(paramname);
		wtCityHourData.setPointName(pointName);
		wtCityHourData.setDatavalue(datavalue);
		wtCityHourData.setStatus(new BigDecimal("1"));
		wtCityHourData.setType(1);
		if (list1.size()==0){
			wtCityHourData.setUuid(IdUtil.randomUUID());
			wtCityHourDataService.insertData(wtCityHourData);
		}else{
			wtCityHourData.setUuid((String)list1.get(0).get("uuid"));
			wtCityHourDataService.updateData(wtCityHourData);
		}
	}

	public void test2(String pointCode,Date dateTime,String codePollute,String pointName,String paramname,String datavalue){
		WtCityHourData wtCityHourData=new WtCityHourData();
		wtCityHourData.setPointCode(pointCode);
		wtCityHourData.setDatatime(dateTime);
		wtCityHourData.setParamname(paramname);
		List<Map<String, Object>> list1=wtCityHourDataService.getDataByName(wtCityHourData);
		wtCityHourData.setPointName(pointName);
		wtCityHourData.setDatavalue(datavalue);
		wtCityHourData.setStatus(new BigDecimal("1"));
		wtCityHourData.setType(1);
		if (list1.size()==0){
			wtCityHourData.setUuid(IdUtil.randomUUID());
			wtCityHourDataService.insertData(wtCityHourData);
		}else{
			wtCityHourData.setUuid((String)list1.get(0).get("uuid"));
			wtCityHourDataService.updateData(wtCityHourData);
		}
	}

	/**
	 * 判断断面编码和断面名称是否正确
	 * @return
	 */
	public boolean isCode(String code,String name){
		WtCityPointParam wtCityPointParam=new WtCityPointParam();
		wtCityPointParam.setPointCode(code);
		wtCityPointParam.setPointName(name);
		List<WtCityPoint> list =wtCityPointService.findListByCode(wtCityPointParam);
		if (list.size()!=0){
			return true;
		}return false;
	}

	/*
	 * 导入失败名单
	 * @param response
	 * @param list
	 * @return
	 */
	@RequestMapping("/exportFailList")
	@ResponseBody
	public void exportFailList(HttpServletResponse response){
		LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
		columnMap.put("title", "导入失败名单");
		columnMap.put("id", "序号");
		columnMap.put("code", "站点编码");
		columnMap.put("reason","失败原因");
		List<Map<String, Object>> result = new ArrayList<>();
		List<String> list = map.get("failList");
		int i=1;
		for (String string : list) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("id", i);
			tempMap.put("code", string);
			tempMap.put("reason", "站点编码和名称不存在");
			result.add(tempMap);
			i++;
		}
		map.clear();
		ExcelExportUtil.exportExcel(response, columnMap, result);
	}

}
