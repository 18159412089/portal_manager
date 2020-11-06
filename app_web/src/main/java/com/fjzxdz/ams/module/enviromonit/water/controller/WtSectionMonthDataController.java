package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.DateUtil;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

import cn.fjzxdz.frame.toolbox.util.UUIDUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.JedisUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionFactor;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthData;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionMonthReport;
import com.fjzxdz.ams.module.enviromonit.water.entity.WtSectionPoint;
import com.fjzxdz.ams.module.enviromonit.water.param.WtSectionMonthDataParam;
import com.fjzxdz.ams.module.enviromonit.water.service.*;
import com.fjzxdz.ams.util.CommonUtil;
import com.fjzxdz.ams.util.ResultUtil;
import com.fjzxdz.ams.util.WaterQualityUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.util.StringUtil;
import org.apache.tomcat.jni.Local;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.temporal.TemporalField;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * 
 * 手动录入监测数据
 * @Author   ZhangGQ
 * @Version   1.0 
 * @CreateTime 2019年4月29日 下午2:12:28
 */
@Controller
@RequestMapping("/enviromonit/water/wtSectionMonthData")
@Secured({ "ROLE_USER" })
public class WtSectionMonthDataController extends BaseController {

    @Autowired
    private WtSectionMonthDataService wtSectionMonthDataService;
    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private WtSectionFactorService wtSectionFactorService;
    @Autowired
    private WtSectionMonthReportService wtSectionMonthReportService;
    @Autowired
    private WtSectionPointService wtSectionPointService;
    @Autowired
    private WtSectionPointBasinService wtSectionPointBasinService;
    
    private  List<String> pollutantList = new ArrayList<>();
    /**
     * 
     * @Title:  index
     * @Description:      在线水小时数据服务页面
     * @CreateBy: chenmingdao 
     * @CreateTime: 2019年4月29日 下午2:27:49
     * @UpdateBy: chenmingdao 
     * @UpdateTime:  2019年4月29日 下午2:27:49    
     * @param modelAndView
     * @param pointCode
     * @param startTime
     * @param endTime
     * @return  ModelAndView 
     * @throws
     */
    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView,String pointCode,String startTime,String endTime) {
        modelAndView.addObject("pointCode", pointCode);
        modelAndView.addObject("startTime", startTime);
        modelAndView.addObject("endTime", endTime);
        modelAndView.setViewName("/moudles/enviromonit/water/wtSectionMonthDataList");
        return modelAndView;
    }

    @RequestMapping("/getWtSectionMonthDataList")
    @ResponseBody
    public PageEU<WtSectionMonthData> getWtSectionMonthDataList(WtSectionMonthDataParam param, HttpServletRequest request){

        Page<WtSectionMonthData> page = pageQuery(request);
        Page<WtSectionMonthData> wtSectionMonthDataPage = wtSectionMonthDataService.listByPage(param, page);

        return new PageEU<>(wtSectionMonthDataPage);
    }
    /**
     *  获取手工监测数据
     * @param request
     * @return
     */
    @RequestMapping("/getWtSectionMonthMonitorDataList")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public JSONObject getWtSectionMonthMonitorDataList(String stationName,String queryMeasureStartTime , String queryMeasureEndTime, HttpServletRequest request){
    	JSONArray monitorDataArr = new JSONArray();
    	int page = 1;
		int pageSize = 10;
		String stationStr  = "" ;
		String timeStr = "";
		if(!StringUtils.isEmpty( stationName)){
			stationStr = "SECTION_CODE = '"+stationName+"'";  
		}else{
			stationStr = "SECTION_CODE is not null ";
		}
		
		if(StringUtils.isNotEmpty((String)request.getParameter("page"))) {
			page = Integer.parseInt((String) request.getParameter("page"));
		} 
		if(StringUtils.isNotEmpty((String)request.getParameter("pageSize"))) {
			pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
		} 
		if(StringUtils.isNotEmpty(queryMeasureStartTime) && StringUtils.isNotEmpty(queryMeasureEndTime)){
			String start = DateUtil.getTime(DateUtil.parseTime(queryMeasureStartTime + "-01 00:00:00"));
			String end =   DateUtil.getTime(DateUtil.parseTime(queryMeasureEndTime + "-31 00:00:00"));
			timeStr ="and DATATIME between   TO_DATE('"+start+"','SYYYY-MM-DD HH24:MI:SS') and  TO_DATE('"+end+"','SYYYY-MM-DD HH24:MI:SS')";
		}

		
        String sectionMonthDataSql = "select SECTION_CODE,SECTION_NAME,CODE_POLLUTE,POLLUTE_NAME,POLLUTE_VALUE,YEAR_NUMBER,MONTH_NUMBER from WT_SECTION_MONTH_DATA  "
        		+ "where "+stationStr+"  "+timeStr+"      order by    YEAR_NUMBER,MONTH_NUMBER desc";
    	List<Object[]> monthDataList = simpleDao.createNativeQuery(sectionMonthDataSql).getResultList();
    	if(monthDataList.size()<0) return null;
    	JSONObject monitorDataObjs =  new JSONObject();
    	for (Object[] obj : monthDataList) {
    		if(hasPollutant(obj[2].toString())){
	    		String key = obj[0].toString()+obj[5].toString()+obj[6].toString();
	    		if (monitorDataObjs.containsKey(key)) {
		    			JSONObject object = monitorDataObjs.getJSONObject(key);
		    			object.getJSONArray("codePollutants").add(obj[2]);
		    			object.getJSONArray("polluteNames").add(obj[3]);
		    			object.getJSONArray("polluteValues").add(obj[4]);
	    		}else{
				        JSONObject monthRow =  new JSONObject();
						monthRow.put("sectionName", obj[1]);
						JSONArray codePollutants =new JSONArray();
						codePollutants.add(obj[2]);
						monthRow.put("codePollutants", codePollutants);
						JSONArray polluteNames = new JSONArray();
						polluteNames.add(obj[3]);
						monthRow.put("polluteNames",polluteNames);
						JSONArray polluteValues = new JSONArray();
						polluteValues.add(obj[4]);
						monthRow.put("polluteValues", polluteValues);
						monthRow.put("dateTime", obj[5].toString()+"年"+obj[6].toString()+"月");
						String monthTemp = obj[6].toString();
						if (Integer.valueOf(obj[6].toString()) <10) {
							monthTemp = "0"+monthTemp;
						}
						monthRow.put("dateTimeOrder", obj[5].toString()+""+monthTemp);
						monitorDataObjs.put(key, monthRow);
			    }
    		}
    		
		}
 
    	Iterator<String> it = monitorDataObjs.keySet().iterator(); 
		while(it.hasNext()){
		// 获得key
			String key = it.next(); 
			JSONObject obj = monitorDataObjs.getJSONObject(key);    
			monitorDataArr.add(obj);
		}
		JSONObject result = new JSONObject();
		result.put("data", monitorDataArr);
		result.put("maxSize", monitorDataArr.size());
		result.put("page", page);
		result.put("pageSize", pageSize);
    	return result;
    }
    
    // 判断是否显示的pollutant因子
    private boolean hasPollutant(String pollutantCode) {
    	boolean hasFlag = false ;
    	if (pollutantList.size() <= 0) {
    		String pollutantsSql = "select CODE_POLLUTE from WT_SECTION_FACTOR WHERE STATE = 1 ";
        	pollutantList =         simpleDao.createNativeQuery(pollutantsSql).getResultList();
		} 
    	hasFlag = pollutantList.contains(pollutantCode) ;
    	return hasFlag;
    }
    
    
    //获取列名
    @RequestMapping("/getSectionWaterLevelColumn")
	@ResponseBody
	public JSONObject getPollutantColumn(){
    	 JSONObject pollutantJsonObject = new JSONObject();
    	 List<Object[]> pollutantColumn = new ArrayList<>();
         String pollutantsSql = "select CODE_POLLUTE ,POLLUTENAME from WT_SECTION_FACTOR WHERE STATE = 1 ";
    	 pollutantColumn = simpleDao.createNativeQuery(pollutantsSql).getResultList();
    	 JSONArray columnNameArr = new JSONArray();
    	 JSONArray columnCodeArr = new JSONArray();
		 for (Object[] objects : pollutantColumn) {
				 columnNameArr.add(objects[1]);
				 columnCodeArr.add(objects[0]);
		 }
		 pollutantJsonObject.put("columnCodes", columnCodeArr);
		 pollutantJsonObject.put("columnNames", columnNameArr);
		 return pollutantJsonObject ;
    }
    
    
     
    
    
    /**
     * 上传文件
     */
    @RequestMapping("/importData")
    @ResponseBody
    public Result uploadFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
            throws Exception {
        String originFilename = multipartFile.getOriginalFilename();
        if (ToolUtil.isNotEmpty(originFilename)) {
            try {
                JSONObject obj = this.processExcelFile(multipartFile);
                List<WtSectionMonthData> dataList = (List<WtSectionMonthData>) obj.get("dataList");
                List<WtSectionMonthReport> reportList = (List<WtSectionMonthReport>) obj.get("reportList");

                wtSectionMonthDataService.batchSaveWtSectionMonthData(dataList);

                //设置月报的平均水质
                this.setAverageQualityForReportList(reportList);

                wtSectionMonthDataService.batchSaveWtSectionMonthData(dataList);
                wtSectionMonthReportService.batchSaveWtSectionMonthReport(reportList);
                wtSectionPointBasinService.batchUpdateWtBasinData(reportList);

            }catch (Exception e){
                e.printStackTrace();
                return ResultUtil.getFailResult(0, e.getMessage());
            }
        }
        return ResultUtil.getOkResult();
    }

    private void setAverageQualityForReportList(List<WtSectionMonthReport> reportList){

        for(int i=0;i<reportList.size();i++){
            WtSectionMonthReport report = reportList.get(i);

            WaterQualityEnum averageQuality = this.getAverageQualityBySectionCode(report.getSectionCode(), report.getYearNumber(), report.getMonthNumber());
            report.setAverageQuality(averageQuality);
        }
    }

    private WaterQualityEnum getAverageQualityBySectionCode(String sectionCode, Integer yearNumber, Integer monthNumber) {
        cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
        List<JSONObject> polluteAverageList = wtSectionMonthDataService.getPolluteValueAverageBySectionCode(sectionCode, yearNumber, monthNumber);
        for (int i=0;i< polluteAverageList.size();i++) {
            JSONObject obj = polluteAverageList.get(i);

            String codePollute = obj.getString("codePollute").toUpperCase();
            String polluteName = obj.getString("polluteName");
            BigDecimal polluteValue = obj.getBigDecimal("polluteValue");

            cn.hutool.json.JSONObject temp = new cn.hutool.json.JSONObject();
            temp.put("codePollute", codePollute);
            temp.put("polluteName", polluteName);
            temp.put("polluteValue", polluteValue);

            dataArray.add(temp);

        }


        //获取站点相关信息，包括目标水质、站点类型等
        String pointType = "0";
        JSONObject pointObj = wtSectionPointService.getPointByCode(sectionCode);
        WaterQualityEnum targetQuality = WaterQualityEnum.THIRD;
        if(pointObj.containsKey("targetQuality")){
            targetQuality = WaterQualityEnum.valueOf(pointObj.getString("targetQuality"));

        }
        cn.hutool.json.JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, pointType, targetQuality);

        return WaterQualityEnum.valueOf(resultQuality.getStr("resultQuality"));
    }

    /**
     * 开始解析Excel文件
     * @param multipartFile
     * @return
     */
    private JSONObject processExcelFile(MultipartFile multipartFile) throws Exception {
        List<WtSectionMonthData> dataList = new ArrayList<>();
        List<WtSectionMonthReport> reportList = new ArrayList<>();

        try{
            //创建HSSFWorkbook对象
            HSSFWorkbook workbook = new HSSFWorkbook(new POIFSFileSystem(multipartFile.getInputStream()));
            //获取一共有多少sheet，然后遍历
            int numberOfSheets = workbook.getNumberOfSheets();
            for (int i = 0; i < numberOfSheets; i++) {
                HSSFSheet sheet = workbook.getSheetAt(i);

                //获取sheet中一共有多少行，遍历行（注意第一行是标题）
                int physicalNumberOfRows = sheet.getPhysicalNumberOfRows();
                List<String> titleList = new ArrayList<String>();
                for (int j = 0; j < physicalNumberOfRows; j++) {
                    Date startTime1 = new Date();
                    HSSFRow row = sheet.getRow(j);

                    //获取每一行有多少单元格，遍历单元格
                    StringBuffer data = new StringBuffer();
                    int physicalNumberOfCells = row.getPhysicalNumberOfCells();
                    //标题行
                    if (j == 0) {
                        for (int k = 0; k < physicalNumberOfCells; k++) {
                            HSSFCell cell = row.getCell(k);
                            Object columnValue = this.getCellValue(cell);
                            titleList.add(String.valueOf(columnValue));
                        }
                    }else {
                        List<WtSectionMonthData> list = this.processExcelRow(titleList, physicalNumberOfCells, row);
                        if(list.size() > 0){
                            WtSectionMonthReport report = this.generateWtSectionMonthReport(list);
                            reportList.add(report);
                            dataList.addAll(list);
                        }
                    }
                }
            }
        }catch (Exception e){
            throw e;
        }
        JSONObject obj = new JSONObject();
        obj.put("dataList",dataList);
        obj.put("reportList", reportList);

        return obj;
    }

    private WtSectionMonthReport generateWtSectionMonthReport(List<WtSectionMonthData> list) {

        cn.hutool.json.JSONArray dataArray = new cn.hutool.json.JSONArray();
        List<String> ids = new ArrayList<String>();
        String sectionCode = "";
        String sectionName = "";
        Integer yearNumber = null;
        Integer monthNumber = null;
        Date datatime = null;
        for(int i=0;i<list.size();i++){
            WtSectionMonthData rs = list.get(i);

            cn.hutool.json.JSONObject temp = new cn.hutool.json.JSONObject();
            temp.put("codePollute", rs.getCodePollute());
            temp.put("polluteName", rs.getPolluteName());
            temp.put("polluteValue", rs.getPolluteValue());

            sectionCode = rs.getSectionCode();
            sectionName = rs.getSectionName();
            yearNumber = rs.getYearNumber();
            monthNumber = rs.getMonthNumber();
            datatime = rs.getDatatime();

            JSONObject factorObj = wtSectionFactorService.getFactorByPolluteCode(rs.getCodePollute());
            if(factorObj.getInteger("state") != null && factorObj.getInteger("state")>0){
                dataArray.add(temp);
            }
        }

        //获取站点相关信息，包括目标水质、站点类型等
        String pointType = "0";
        JSONObject pointObj = wtSectionPointService.getPointByCode(sectionCode);
        WaterQualityEnum targetQuality = WaterQualityEnum.THIRD;
        if(pointObj.containsKey("targetQuality")){
            targetQuality = WaterQualityEnum.valueOf(pointObj.getString("targetQuality"));

        }
        String category = pointObj.getString("category");

        //获取本次水质情况
        cn.hutool.json.JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, pointType, targetQuality);

        //月报对象
        WtSectionMonthReport report = new WtSectionMonthReport();
        report.setAverageQuality(WaterQualityEnum.NONE);
        report.setCategory(category);
        report.setYearNumber(yearNumber);
        report.setMonthNumber(monthNumber);
        report.setLastYearQuality(WaterQualityEnum.NONE);
        report.setResultQuality(WaterQualityEnum.valueOf(resultQuality.getStr("resultQuality")));
        report.setSectionCode(sectionCode);
        report.setSectionName(sectionName);
        report.setStatus(1);
        report.setTargetQuality(targetQuality);
        report.setExcessfactorstr(resultQuality.getJSONArray("excessFactor").toString());

        return report;
    }

    private List<WtSectionMonthData> processExcelRow(List<String> titleList, int physicalNumberOfCells, HSSFRow row) {
        List<WtSectionMonthData> list = new ArrayList<>();

        String sectionCode = null;
        String sectionName = null;
        Integer yearNumber = null;
        Integer monthNumber = null;
        Integer dayNumber = null;
        for (int k = 0; k < physicalNumberOfCells; k++) {
            HSSFCell cell = row.getCell(k);
            Object columnValue = this.getCellValue(cell);

            //开始解析数据行
            String title = titleList.get(k);
            //获取数据库表对应字段名称

            switch (title){
                case "断面编号":
                    //columnName = "SECTION_CODE";
                    sectionCode = String.valueOf(columnValue).replaceAll("(\\.\\d+)?","");
                    break;
                case "断面名称":
                    //columnName = "SECTION_NAME";
                    sectionName = String.valueOf(columnValue);
                    break;
                case "年":
                    //columnName = "YEAR_NUMBER";
                    yearNumber = Double.valueOf(String.valueOf(columnValue)).intValue();
                    break;
                case "月":
                    //columnName = "MONTH_NUMBER";
                    monthNumber = Double.valueOf(String.valueOf(columnValue)).intValue();
                    break;
                case "日":
                    dayNumber = Double.valueOf(String.valueOf(columnValue)).intValue();
                    break;
                default:
                    //开始处理监测数据列
                    String polluteName = title.contains("(") ? title.substring(0, title.indexOf("(")) : title;
                    JSONObject factorObj = wtSectionFactorService.getFactorByName(polluteName);
                    String codePollute = factorObj.getString("codePollute");

                    JSONObject pointObj = wtSectionPointService.getPointByCode(sectionCode);
                    String category = "";
                    if(pointObj.containsKey("category")){
                        category = pointObj.getString("category");
                    }

                    Calendar c = Calendar.getInstance();
                    c.set(Calendar.YEAR, yearNumber);
                    //Java中Calendar的月份是从0开始
                    c.set(Calendar.MONTH, monthNumber-1);
                    c.set(Calendar.DAY_OF_MONTH, dayNumber);
                    c.set(Calendar.HOUR_OF_DAY, 0);
                    c.set(Calendar.MINUTE, 0);
                    c.set(Calendar.SECOND, 0);

                    if(columnValue != null && Double.valueOf(String.valueOf(columnValue))>0){
                        WtSectionMonthData monthData = new WtSectionMonthData();

                        monthData.setCategory(category);
                        monthData.setSectionCode(sectionCode);
                        monthData.setSectionName(sectionName);
                        monthData.setYearNumber(yearNumber);
                        monthData.setMonthNumber(monthNumber);
                        monthData.setCodePollute(codePollute);
                        monthData.setPolluteName(polluteName);
                        monthData.setPolluteValue(BigDecimal.valueOf(Double.valueOf(String.valueOf(columnValue))));
                        monthData.setStatus(BigDecimal.valueOf(0));
                        monthData.setDatatime(c.getTime());

                        list.add(monthData);
                    }
                    break;
            }
        }

        return list;
    }

    private String getColumnNameByTitle(String title) {
        String columnName = "";
        switch (title){
            case "断面编号":
                //columnName = "SECTION_CODE";
                columnName = "sectionCode";
                break;
            case "断面名称":
                //columnName = "SECTION_NAME";
                columnName = "sectionName";
                break;
            case "年":
                //columnName = "YEAR_NUMBER";
                columnName = "yearNumber";
                break;
            case "月":
                //columnName = "MONTH_NUMBER";
                columnName = "monthNumber";
                break;
            case "日":
                columnName = "dayNumber";
                break;
            default:
                columnName = "polluteName";
                break;
        }

        return columnName;
    }

    private Object getCellValue(HSSFCell cell) {
        Object columnValue = null;
        switch (cell.getCellTypeEnum()){
            case _NONE:
                columnValue = "";
                break;
            case STRING:
                columnValue = cell.getStringCellValue();
                break;
            case NUMERIC:
                columnValue = cell.getNumericCellValue();
                break;
            case FORMULA:
                columnValue = cell.getCellFormula();
                break;
            case BLANK:
                break;
            case BOOLEAN:
                columnValue = cell.getBooleanCellValue();
                break;
            case ERROR:
                columnValue = cell.getErrorCellValue();
                break;
            default:
                columnValue = "";
                break;
        }
        return columnValue;
    }
}
