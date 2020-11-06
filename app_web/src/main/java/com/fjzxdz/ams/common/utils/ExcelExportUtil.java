package com.fjzxdz.ams.common.utils;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Excel导出工具工具
 *
 * @author fushixing
 * @version 2019-03-05
 */
public class ExcelExportUtil {

    /**
     * 按map自定义Bean中需要的属性
     *
     * @param result
     * @param columnMap
     * @return
     */
    public static List genExcelColumn(List result, LinkedHashMap<String, String> columnMap) {
        List rowList = new ArrayList();
        for (Object o : result) {
        	Map<String, String> newColumnMap = new LinkedHashMap<String, String>();
        	if(!(o instanceof Map)) {
        		Map<String, Object> dataMonitorMap = BeanUtil.beanToMap(o);
        		Collection<String> intersection = CollUtil.intersection(dataMonitorMap.keySet(), columnMap.keySet());
        		for (String key : intersection) {
        			String s = String.valueOf(dataMonitorMap.get(key));
        			newColumnMap.put(key, "null".equalsIgnoreCase(s)?"": s);// null==>""
        		}
        	}else {
        		Collection<String> intersection = CollUtil.intersection(((HashMap<String,String>) o).keySet(), columnMap.keySet());
        		for (String key : intersection) {
        			String s = String.valueOf(((HashMap<String,String>) o).get(key));
        			newColumnMap.put(key, "null".equalsIgnoreCase(s)?"": s);// null==>""
        		}
        	}
            rowList.add(newColumnMap);
        }
        return rowList;
    }

    /**
     * 导出Excel
     *
     * @param response
     * @param columnMap
     * @param result
     */
    public static void exportExcel(HttpServletResponse response, LinkedHashMap<String, String> columnMap, List result) {
        try {
            // 通过工具类创建writer，默认创建xls格式
            ExcelWriter writer = ExcelUtil.getWriter(true);
            //writer.setOnlyAlias(true);
            // 合并单元格后的标题行，使用默认标题样式
            writer.merge(columnMap.size() - 2, columnMap.get("title"));
            writer.setHeaderAlias(columnMap);
            // 一次性写出内容，使用默认样式
            writer.write(genExcelColumn(result, columnMap), true);
            //自动宽度
            for (int i = 0; i < columnMap.size(); i++) {
                writer.autoSizeColumn(i);
            }
            //out为OutputStream，需要写出到的目标流
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(String.valueOf(columnMap.get("title")), "UTF-8") + ".xlsx");
            ServletOutputStream out = null;
            out = response.getOutputStream();
            writer.flush(out);
            // 关闭writer，释放内存
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /* 未自定义Bean的
     * genExcelColumnObject
     * @param result
     * @param columnMap
     * @return
     */
    public static List genExcelColumnObject(List result, LinkedHashMap<String, String> columnMap) {
        List rowList = new ArrayList();
        for (Object o : result) {
            Map<String, String> newColumnMap = new LinkedHashMap<String, String>();
            if(!(o instanceof Map)) {
                Map<String, Object> dataMonitorMap = BeanUtil.beanToMap(o);
                Collection<String> intersection = CollUtil.intersection(dataMonitorMap.keySet(), columnMap.keySet());
                for (String key : intersection) {
                    String s = String.valueOf(dataMonitorMap.get(key));
                    newColumnMap.put(key, "null".equalsIgnoreCase(s)?"": s);// null==>""
                }
            }else {
                Collection<String> intersection = CollUtil.intersection(((JSONObject) o).keySet(), columnMap.keySet());
                for (String key : intersection) {
                    String s = String.valueOf(((JSONObject) o).get(key));
                    newColumnMap.put(key, "null".equalsIgnoreCase(s)?"": s);// null==>""
                }
            }
            rowList.add(newColumnMap);
        }
        return rowList;
    }

    /**
     * 导出Excel
     *
     * @param response
     * @param columnMap
     * @param result
     */
    public static void exportExcelObj(HttpServletResponse response, LinkedHashMap<String, String> columnMap, List result) {
        try {
            // 通过工具类创建writer，默认创建xls格式
            ExcelWriter writer = ExcelUtil.getWriter(true);
            //writer.setOnlyAlias(true);
            // 合并单元格后的标题行，使用默认标题样式
            writer.merge(columnMap.size() - 2, columnMap.get("title"));
            writer.setHeaderAlias(columnMap);
            // 一次性写出内容，使用默认样式
            writer.write(genExcelColumnObject(result, columnMap), true);
            //自动宽度
            for (int i = 0; i < columnMap.size(); i++) {
                writer.autoSizeColumn(i);
            }
            //out为OutputStream，需要写出到的目标流
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(String.valueOf(columnMap.get("title")), "UTF-8") + ".xlsx");
            ServletOutputStream out = null;
            out = response.getOutputStream();
            writer.flush(out);
            // 关闭writer，释放内存
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
