/**
 * There are <a href="">福建中兴电子</a> code generation
 */
package com.fjzxdz.ams.zphb.parsingpig.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
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
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.hutool.core.bean.BeanUtil;
import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;

import com.fjzxdz.ams.zphb.parsingpig.entity.ParsingPig;
import com.fjzxdz.ams.zphb.parsingpig.service.ParsingPigService;
import com.fjzxdz.ams.zphb.parsingpig.dao.ParsingPigDao;
import com.fjzxdz.ams.zphb.parsingpig.param.ParsingPigParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * 养殖业管理Controller
 * @author shenlongqin
 * @version 2019-10-14
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/zphb/parsingPig")
public class ParsingPigController extends BaseController {

	@Autowired
	private ParsingPigDao parsingPigDao;
	@Autowired
	private ParsingPigService parsingPigService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "/zphb/moudles/" + "parsingpig/parsingPigList";
	}
	
	/**
	 * 更新或新增
	 * @param parsingPig
	 * @return
	 */	
	@RequestMapping("/saveParsingPig")
	@ResponseBody
	public R saveParsingPig(ParsingPig parsingPig) {
		try {
			parsingPigService.save(parsingPig);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid删除
	 * @param uuid
	 * @return
	 */
	@RequestMapping("/deleteParsingPig")
	@ResponseBody
	public R deleteParsingPig(@RequestParam(value = "id") String id) {
		try {
			parsingPigService.delete(id);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
	}
	
	/**
	 * 按uuid查询，并返回map
	 * @param id
	 * @return
	 */
	@RequestMapping("/getParsingPig")
	@ResponseBody
	public Map<String, Object> getParsingPig(@RequestParam(value = "id") String id) {
		ParsingPig parsingPig = parsingPigDao.getById(id);
		return BeanUtil.beanToMap(parsingPig,false,true);
	}
	
	/**
	 * 查询列表
	 * @param parsingPig
	 * @param request
	 * @return
	 */
	@RequestMapping("/parsingPigList")
	@ResponseBody
	public PageEU<ParsingPig> parsingPigList(ParsingPigParam parsingPigParam, HttpServletRequest request) {
		Page<ParsingPig> page = parsingPigService.listByPage(parsingPigParam, pageQuery(request));
		return new PageEU<>(page);
	}


	/**
	 *
	 * @Title:  importFile
	 * @Description:    导入文件
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
			message = parsingPigService.save(result);
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
	 * @Description:    删除文件缓存
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
	 * @Description:    获取excel文件的内容
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
//				if (StringUtils.isNull(row.getCell(1).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第2列人员名称不能为空！");
//				}if (StringUtils.isNull(row.getCell(2).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第3列地区不能为空！");
//				}if (StringUtils.isNull(row.getCell(3).toString().trim())) {
//					throw new Exception("第"+(rowIndex+1)+"行第4列联系电话不能为空！");
//				}
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
