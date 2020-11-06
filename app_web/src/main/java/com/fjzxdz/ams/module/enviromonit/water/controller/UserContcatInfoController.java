package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.utils.SendSmsUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enviromonit.pollution.dao.LogSmsDao;
import com.fjzxdz.ams.module.enviromonit.water.entity.TaskDetalis;
import com.fjzxdz.ams.module.enviromonit.water.entity.UserContcatInfo;
import com.fjzxdz.ams.module.enviromonit.water.param.UserContcatInfoParam;
import com.fjzxdz.ams.module.enviromonit.water.service.TaskDetalisService;
import com.fjzxdz.ams.module.enviromonit.water.service.UserContcatInfoService;
import com.fjzxdz.ams.util.LogSms;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 
 * 水环境-应急短信下发-水质问题整改任务派发
 * @Author   chenmingdao
 * @Version   1.0 
 * @CreateTime 2019年5月9日 下午2:57:31
 */
@Controller
@RequestMapping("/enviromonit/water/userContcatInfo")
@Secured({ "ROLE_USER" })
public class UserContcatInfoController extends BaseController {
	@Autowired
	private UserContcatInfoService contcatInfoService;
	@Autowired
	private TaskDetalisService taskDetalisService;
	@Autowired
	private LogSmsDao logSmsDao;

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelAndView, String pid) {
		modelAndView.addObject("pid", pid);
		modelAndView.setViewName("/moudles/enviromonit/water/userContcatInfoDataList");
		return modelAndView;
	}

	/**
	 * 
	 * @Title:  getPageList
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发列表
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:57:47
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:57:47    
	 * @param param
	 * @param request
	 * @return  PageEU<UserContcatInfo> 
	 * @throws
	 */
	@RequestMapping("/getPageList")
	@ResponseBody
	public PageEU<UserContcatInfo> getPageList(UserContcatInfoParam param, HttpServletRequest request) {
		Page<UserContcatInfo> page = pageQuery(request);
		Page<UserContcatInfo> wtHourDataPage = contcatInfoService.getPageList(param, page);
		return new PageEU<>(wtHourDataPage);
	}

	/**
	 * 
	 * @Title:  saveUser
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发   -修改用户
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:58:18
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:58:18    
	 * @param userContcatInfo
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/saveUser")
	@ResponseBody
	public R saveUser(UserContcatInfo userContcatInfo) {
		UserContcatInfo info = contcatInfoService.saveUser(userContcatInfo);
		if (info != null) {
			return R.ok("修改成功");
		}
		return R.error("修改失败");
	}

	/**
	 * 
	 * @Title:  delUser
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发-删除用户  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:58:48
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:58:48    
	 * @param uuid
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/delUser")
	@ResponseBody
	public R delUser(String uuid) {
		try {
			String[] split = uuid.split(",");
			for (int i = 0; i < split.length; i++) {
				contcatInfoService.delUser(split[i]);
			}
		}catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok("删除成功");
	}

	/**
	 * 
	 * @Title:  addUser
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发-添加用户
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:59:03
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:59:03    
	 * @param userContcatInfo
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/addUser")
	@ResponseBody
	public R addUser(UserContcatInfo userContcatInfo) {
		try {
			contcatInfoService.addUser(userContcatInfo);
		}catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok("添加成功");
	}

	/**
	 * 
	 * @Title:  distribute
	 * @Description:   水环境-应急短信下发-水质问题整改任务派发-派发任务  
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:59:19
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:59:19    
	 * @param message
	 * @param phones
	 * @param names
	 * @return  R 
	 * @throws
	 */
	@RequestMapping("/distribute")
	@ResponseBody
	@Transactional
	public R distribute(String message, String phones, String names) {
		
		try{
			String[] phones1 = phones.split(",");
			String[] names1 = names.split(",");
			String temp = "";
			List<LogSms> log = new ArrayList<>();
			for (int i = 0; i < phones1.length; i++) {
				LogSms logSms = new LogSms();
				logSms.setPhone(phones1[i]);
				logSms.setMsg(message);
				logSms.setMark("应急短信下发");
				log.add(logSms);
				SendSmsUtil.sendSms(phones1[i], message);
				temp += names1[i] + "（" + phones1[i] + "），";
			}
			logSmsDao.saveBatch(log);
			TaskDetalis taskDetalis = new TaskDetalis();
			taskDetalis.setUserName(temp.substring(0, temp.length()-1));
			taskDetalis.setContent(message);
			taskDetalisService.save(taskDetalis);
		}catch (Exception e) {
			return R.error(e.getMessage());
		}
		
		return R.ok("派发成功");
	}

	/**
	 * 云平台调度古雷应急演练  短信发送
	 * @param message
	 * @param phones
	 * @param names
	 * @return
	 */
	@RequestMapping("/sendMsg")
	@ResponseBody
	public R sendMsg(String message, String phones, String names) {

		try {
			String[] phones1 = phones.split(",");
			List<LogSms> log = new ArrayList<>();
			for (int i = 0; i < phones1.length; i++) {
				LogSms logSms = new LogSms();
				logSms.setPhone(phones1[i]);
				logSms.setMsg(message);
				logSms.setMark("云平台调度古雷应急演练");
				log.add(logSms);
				SendSmsUtil.sendSms(phones1[i], message);
			}
			logSmsDao.saveBatch(log);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}

		return R.ok("发送成功");
	}



	/**
	 * 
	 * @Title:  importFile
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发-导入文件
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:59:33
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:59:33    
	 * @param file
	 * @param request
	 * @return
	 * @throws Exception  R 
	 * @throws
	 */
	@RequestMapping("/importFile")
	@ResponseBody
	public R importFile(@RequestParam(name = "xlsxfile") MultipartFile file, HttpServletRequest request)
			throws Exception {
		if (file.isEmpty()) {
			throw new Exception("文件不存在！");
		}
		String fileName=file.getOriginalFilename();
		String suffix=fileName.substring(fileName.lastIndexOf("."));
		String prefix=fileName.substring(0,fileName.lastIndexOf("."));
		String message="";
		try {
			File excelFile=File.createTempFile(prefix, suffix);
			file.transferTo(excelFile);
			String[][] result = getExcelContent(excelFile);
			deleteFile(excelFile);
			message = contcatInfoService.save(result);
		}catch (Exception e) {
			return R.error("导入失败："+e.getMessage());
		}
		if(message!="") {
			return R.error("导入失败："+message);
		}
		return R.ok("导入成功");
	}
	
	/**
	 * 
	 * @Title:  deleteFile
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发-删除文件缓存   
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午2:59:55
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午2:59:55    
	 * @param excelFile  void 
	 * @throws
	 */
	private void deleteFile(File... excelFile) {
		for (File file : excelFile) {  
            if (file.exists()) {  
                file.delete();  
            }  
        }  
	}

	/**
	 * 
	 * @Title:  getExcelContent
	 * @Description:    水环境-应急短信下发-水质问题整改任务派发-获取excel文件的内容
	 * @CreateBy: chenmingdao 
	 * @CreateTime: 2019年5月9日 下午3:00:31
	 * @UpdateBy: chenmingdao 
	 * @UpdateTime:  2019年5月9日 下午3:00:31    
	 * @param excelFile
	 * @return
	 * @throws Exception  String[][] 
	 * @throws
	 */
	@SuppressWarnings({ "deprecation", "unused" })
	public String[][] getExcelContent(File excelFile) throws Exception{
		List<String[]> result = new ArrayList<String[]>();
		int rowSize = 0;
		Workbook wb = null;
		FileInputStream fileInputStream = null;
		if (excelFile.isFile() && excelFile.exists()) {
			String suffix = excelFile.getName().substring(excelFile.getName().lastIndexOf("."));
			if(".xls".equals(suffix)) {
				fileInputStream = new FileInputStream(excelFile);
				wb = new HSSFWorkbook(fileInputStream);
			}else if(".xlsx".equals(suffix)) {
				wb =new XSSFWorkbook(excelFile);
			}else {
				throw new Exception("文件类型错误！");
			}
		}
		Cell cell = null;
		//检验excel条数
		HSSFSheet sheet = (HSSFSheet) wb.getSheetAt(0);
		int lrowNum = sheet.getLastRowNum();
		int frowNum = sheet.getFirstRowNum();
		int countTotal = lrowNum + 1 - frowNum;
		if (countTotal <= 1) {
			throw new Exception("文件中的第一个sheet没有记录数，请检查！");
		}
		if (countTotal > 1000) {
			throw new Exception("一次导入的记录数不能大于1000条，请分批进行导入！");
		}
		for (int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
			Sheet st = wb.getSheetAt(sheetIndex);
			// 第一行为标题，不取
			for (int rowIndex = 1; rowIndex <= st.getLastRowNum(); rowIndex++) {
				Row row = st.getRow(rowIndex);
				//判断Excel每一行中的列值是否为空
				Cell cell1 = row.getCell(1);
				if (StringUtils.isNull(row.getCell(1).toString().trim())) {
					throw new Exception("第"+(rowIndex+1)+"行第2列人员名称不能为空！");
				}if (StringUtils.isNull(row.getCell(2).toString().trim())) {
					throw new Exception("第"+(rowIndex+1)+"行第3列地区不能为空！");
				}if (StringUtils.isNull(row.getCell(3).toString().trim())) {
					throw new Exception("第"+(rowIndex+1)+"行第4列联系电话不能为空！");
				}
				if (row == null) {
					continue;
				}
				int tempRowSize = row.getLastCellNum() + 1;
				if (tempRowSize > rowSize) {
					rowSize = tempRowSize;
				}
				String[] values = new String[rowSize];
				Arrays.fill(values, "");
				boolean hasValue = false;
				for (short columnIndex = 0; columnIndex <= row.getLastCellNum(); columnIndex++) {
					String value = "";
					cell = row.getCell(columnIndex);
					if (cell != null) {
						// 注意：一定要设成这个，否则可能会出现乱码
						// cell.setEncoding(HSSFCell.ENCODING_UTF_16);
						switch (cell.getCellType()) {
						case HSSFCell.CELL_TYPE_STRING:
							value = cell.getStringCellValue();
							break;
						case HSSFCell.CELL_TYPE_NUMERIC:
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								Date date = cell.getDateCellValue();
								if (date != null) {
									value = new SimpleDateFormat("yyyy-MM-dd").format(date);
								} else {
									value = "";
								}
							} else {
								value = new DecimalFormat("0").format(cell.getNumericCellValue());
							}
							break;
						case HSSFCell.CELL_TYPE_FORMULA:
							// 导入时如果为公式生成的数据则无值
							if (!"".equals(cell.getStringCellValue())) {
								value = cell.getStringCellValue();
							} else {
								value = cell.getNumericCellValue() + "";
							}
							break;
						case HSSFCell.CELL_TYPE_BLANK:
							break;
						case HSSFCell.CELL_TYPE_ERROR:
							value = "";
							break;
						case HSSFCell.CELL_TYPE_BOOLEAN:
							value = (cell.getBooleanCellValue() == true ? "Y":"N");
							break;
						default:
							value = "";
						}
					}
					values[columnIndex] = value;
					hasValue = true;
				}
				if (hasValue) {
					result.add(values);
				}
			}
		}
		if(fileInputStream!=null) {
			fileInputStream.close();
		}
		wb.close();
		String[][] returnArray = new String[result.size()][rowSize];
		for (int i = 0; i < returnArray.length; i++) {
			returnArray[i] = (String[]) result.get(i);
		}
		return returnArray;
		
	}
}
