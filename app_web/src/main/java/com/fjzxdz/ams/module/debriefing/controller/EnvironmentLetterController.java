package com.fjzxdz.ams.module.debriefing.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.SqlUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.common.generate.utils.LayuiUtil;
import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.common.utils.ExcelExportUtil;
import com.fjzxdz.ams.module.debriefing.dao.EnvironmentLetterDao;
import com.fjzxdz.ams.module.debriefing.entity.EnvironmentLetter;
import com.fjzxdz.ams.module.debriefing.service.EnvironmentLetterService;
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
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 信访件controller实现类 ，总体情况，整改汇总表
 *
 * @author hyl
 * @Version 1.0
 * @CreateTime 2019年10月23日11:00:35
 */
@Controller
@RequestMapping("/environment/letter")
@Secured({"ROLE_USER"})
public class EnvironmentLetterController extends BaseController {
    @Autowired
    private EnvironmentLetterService letterService;
    @Autowired
    private SimpleDao simpleDao;
    @Autowired
    private EnvironmentLetterDao letterDao;

    @RequestMapping("/countPieWrlx")
    @ResponseBody
    public JSONObject getCountPieWrlx(String lc) {
        String userDeptName = getUserDeptName();
        return letterService.countPieWrlx(lc,userDeptName);
    }

    @RequestMapping("/countPieBjzt")
    @ResponseBody
    public JSONObject getCountPieBjzt(String lc, String wrlx) {
        String userDeptName = getUserDeptName();
        return letterService.countPieBjzt(lc, wrlx,userDeptName);
    }

    /**
     * @param file
     * @param request
     * @return cn.fjzxdz.frame.pojo.R
     * @Author hyl
     * @Description //TODO(信访件数据——excel导入)
     * @Date 2019年10月23日11:35:29
     * @version 1.0
     **/
    @RequestMapping("/importFile")
    @ResponseBody
    public R importFile(@RequestParam(name = "xlsxfile") MultipartFile file, HttpServletRequest request)
            throws Exception {
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String prefix = fileName.substring(0, fileName.lastIndexOf("."));
        String message = "";
        File excelFile = null;
        try {
            excelFile = File.createTempFile(prefix, suffix);
            file.transferTo(excelFile);
            List<List<Object>> result = getExcelContent(excelFile);
            message = letterService.save(result);
        } catch (Exception e) {
            return R.error("导入失败：" + e.getMessage());
        } finally {
//            deleteFile(excelFile);
        }
        if (message != "") {
            return R.error("导入失败：" + message);
        }
        return R.ok("导入成功");
    }

    /**
     * @return cn.fjzxdz.frame.pojo.R
     * @Author hyl
     * @Description //TODO(信访件数据——excel导入)
     * @Date 2019年10月23日11:35:29
     * @version 1.0
     **/
    @RequestMapping("")
    @ResponseBody
    public ModelAndView environmentLetter(ModelAndView modelAndView, String pid) {
        modelAndView.setViewName("/moudles/enviromonit/letter/environmentLetter");
        modelAndView.addObject("pid", pid);
        return modelAndView;
    }

    @RequestMapping("/list")
    @ResponseBody
    public ModelAndView list(ModelAndView modelAndView, String pid, String name, String state,String lc) {
        modelAndView.setViewName("/moudles/enviromonit/letter/environmentLetterList");
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("name", name);
        modelAndView.addObject("state", state);
        modelAndView.addObject("lc", lc);
        return modelAndView;
    }

    @RequestMapping("/map")
    @ResponseBody
    public ModelAndView map(ModelAndView modelAndView, String pid, String slbh, String bjzt) {
        modelAndView.setViewName("/moudles/enviromonit/letter/environmentLetterMap");
        modelAndView.addObject("pid", pid);
        modelAndView.addObject("slbh", slbh);
        modelAndView.addObject("bjzt", bjzt);
        return modelAndView;
    }

    /**
     * 统计
     *
     * @param param
     * @return
     */
    @RequestMapping(value = "/getCount")
    @ResponseBody
    public JSONObject getCount(EnvironmentLetter param) {
        String userDeptName = getUserDeptName();
        param.setXzqy(userDeptName);
        JSONObject result = letterService.getCount(param);
        return result;
    }


    /**
     * @param excelFile
     * @return void
     * @Author hyl
     * @Description //TODO(删除临时文件)
     * @Date 2019年10月23日11:35:40
     * @version 1.0
     **/
    private void deleteFile(File... excelFile) {
        if (excelFile == null) {
            return;
        }
        for (File file : excelFile) {
            if (file.exists()) {
                file.delete();
            }
        }
    }

    /**
     * 获取excel内容
     *
     * @param excelFile
     * @return java.util.List<java.util.List < java.lang.Object>>
     * @Author hyl
     * @Description //TODO(获取excel文件的内容)
     * @Date 2019年10月23日11:16:56
     * @version 1.0
     **/
    public List<List<Object>> getExcelContent(File excelFile) throws Exception {
        FileInputStream fileInputStream = null;
        if (excelFile.isFile() && excelFile.exists()) {
            String suffix = excelFile.getName().substring(excelFile.getName().lastIndexOf("."));
            if (".xls".equals(suffix) || ".xlsx".equals(suffix)) {
                fileInputStream = new FileInputStream(excelFile);
            } else {
                throw new Exception("文件类型错误！");
            }
        }

        ExcelReader reader = ExcelUtil.getReader(fileInputStream);
        List<List<Object>> lists = reader.read();

        return lists;
    }

    /**
     * 信访件汇总表查询条件下拉框列表
     *
     * @param type 字段名称
     * @return
     */
    @RequestMapping("/getTypeList")
    @ResponseBody
    public List<Map> getTypeList(String type) {
        String userDeptName = getUserDeptName();
        return letterService.getTypeList(type,userDeptName);
    }

    /**
     * 获取所有的信访件汇总列表
     *
     * @param limit
     * @param page
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/allLetterlist")
    @ResponseBody
    public Map allLetterlist(Integer limit, Integer page, EnvironmentLetter param, HttpServletRequest request, HttpServletResponse response) {
        Page<EnvironmentLetter> page1 = pageQuery(request);
        page1.setLimit(limit);
        page1.setCurrentPage(page - 1);
        StringBuilder sql = new StringBuilder(" SELECT * FROM ENVIRONMENT_LETTER WHERE 1=1 ");
        if (StringUtils.isNotEmpty(param.getSlbh()) && !"null".equals(param.getSlbh())) {
            sql.append(" AND SLBH LIKE ").append(SqlUtil.toSqlStr_like(param.getSlbh()));
        }
        if (StringUtils.isNotEmpty(param.getQtzrdw()) && !"null".equals(param.getQtzrdw())) {
            sql.append(" AND QTZRDW LIKE ").append(SqlUtil.toSqlStr_like(param.getQtzrdw()));
        }
        if (StringUtils.isNotEmpty(param.getWrlx()) && !"null".equals(param.getWrlx())) {
            sql.append(" AND WRLX like ").append(SqlUtil.toSqlStr_like(param.getWrlx()));
        }
        if (StringUtils.isNotEmpty(param.getXzqy()) && !"null".equals(param.getXzqy())) {
            sql.append(" AND XZQY = ").append(SqlUtil.toSqlStr(param.getXzqy()));
        }
        if (StringUtils.isNotEmpty(param.getBjzt()) && !"null".equals(param.getBjzt())) {
            sql.append(" AND BJZT = ").append(SqlUtil.toSqlStr(param.getBjzt()));
        }
        if (StringUtils.isNotEmpty(param.getSfzdj()) && !"null".equals(param.getSfzdj())) {
            sql.append(" AND SFZDJ = ").append(SqlUtil.toSqlStr(param.getSfzdj()));
        }
        if (StringUtils.isNotEmpty(param.getLc()) && !"null".equals(param.getLc())) {
            sql.append(" AND LC = ").append(SqlUtil.toSqlStr(param.getLc()));
        }
        if (StringUtils.isNotEmpty(param.getSfss()) && !"null".equals(param.getSfss())) {
            sql.append(" AND SFSS = ").append(SqlUtil.toSqlStr(param.getSfss()));
        }
        if (StringUtils.isNotEmpty(param.getSfcf()) && !"null".equals(param.getSfcf())) {
            sql.append(" AND SFCF = ").append(SqlUtil.toSqlStr(param.getSfcf()));
        }
        String userDeptName = getUserDeptName();
        //根据登录人员显示对应的信息
        if (StringUtils.isNotEmpty(userDeptName)) {
            sql.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        //关键字查询
        String dcqjclqk = param.getDcqjclqk();
        if (StringUtils.isNotEmpty(dcqjclqk) && !"null".equals(dcqjclqk)) {
            sql.append(" AND ( ");
            sql.append("  JBWTJBQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR DCQJDCHSQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR ZGMBJZGCS LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR DCQJCLQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR ZXZGQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR LXDH LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR WGY LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR WGYSJHM LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR SSWL LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR SFGLJBH LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR LLR LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR YSPXBM LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR YSQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" )");
        }
        sql.append("  ORDER BY UPDATE_DATE DESC ");
        Page<EnvironmentLetter> letterPage = simpleDao.listNativeByPage(sql.toString(), page1);
        if ("yes".equals(request.getParameter("export"))) {
            return exportEnvironmentLetterExl(response, letterPage);
        }
        Map result = new HashMap();
        result.put("count", letterPage.getTotalCount());
        result.put("data", letterPage.getResult());
        return result;
    }

    /**
     * 获取所有的信访件汇总列表
     *
     * @param param
     * @param request
     * @return
     */
    @RequestMapping(value = "/allLetterlistByMap")
    @ResponseBody
    public  PageEU<Map<String, Object>> allLetterlistByMap(EnvironmentLetter param, HttpServletRequest request) {
        Page<Map<String, Object>> page = pageQuery(request);
        StringBuilder sql = new StringBuilder(" SELECT a.*,b.uuid fileuuid,b.pkid,b.picture, b.video,b.PICNAME,b.VEDIONAME FROM ENVIRONMENT_LETTER a left join FILE_ATTACHMENT  b on a.uuid = b.pkid WHERE 1=1 ");
        if (StringUtils.isNotEmpty(param.getUuid()) && !"null".equals(param.getUuid())) {
            sql.append(" AND a.UUID = ").append(SqlUtil.toSqlStr(param.getUuid()));
        }if (StringUtils.isNotEmpty(param.getSlbh()) && !"null".equals(param.getSlbh())) {
            sql.append(" AND SLBH LIKE ").append(SqlUtil.toSqlStr_like(param.getSlbh()));
        }
        if (StringUtils.isNotEmpty(param.getQtzrdw()) && !"null".equals(param.getQtzrdw())) {
            sql.append(" AND QTZRDW LIKE ").append(SqlUtil.toSqlStr_like(param.getQtzrdw()));
        }
        if (StringUtils.isNotEmpty(param.getWrlx()) && !"null".equals(param.getWrlx())) {
            sql.append(" AND WRLX = ").append(SqlUtil.toSqlStr(param.getWrlx()));
        }
        if (StringUtils.isNotEmpty(param.getXzqy()) && !"null".equals(param.getXzqy())) {
            sql.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(param.getXzqy()));
        }
        if (StringUtils.isNotEmpty(param.getBjzt()) && !"null".equals(param.getBjzt())) {
            sql.append(" AND BJZT = ").append(SqlUtil.toSqlStr(param.getBjzt()));
        }
        if (StringUtils.isNotEmpty(param.getSfzdj()) && !"null".equals(param.getSfzdj())) {
            sql.append(" AND SFZDJ = ").append(SqlUtil.toSqlStr(param.getSfzdj()));
        }
        if (StringUtils.isNotEmpty(param.getLc()) && !"null".equals(param.getLc())) {
            sql.append(" AND LC = ").append(SqlUtil.toSqlStr(param.getLc()));
        }
        if (StringUtils.isNotEmpty(param.getSfss()) && !"null".equals(param.getSfss())) {
            sql.append(" AND SFSS = ").append(SqlUtil.toSqlStr(param.getSfss()));
        }
        if (StringUtils.isNotEmpty(param.getSfcf()) && !"null".equals(param.getSfcf())) {
            sql.append(" AND SFCF = ").append(SqlUtil.toSqlStr(param.getSfcf()));
        }
        String userDeptName = getUserDeptName();
        if (StringUtils.isNotEmpty(userDeptName)) {
            sql.append(" AND xzqy like ").append(SqlUtil.toSqlStr_like(userDeptName));
        }
        //关键字查询
        String dcqjclqk = param.getDcqjclqk();
        if (StringUtils.isNotEmpty(dcqjclqk) && !"null".equals(dcqjclqk)) {
            sql.append(" AND ( ");
            sql.append("  JBWTJBQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR DCQJDCHSQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR ZGMBJZGCS LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR DCQJCLQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR ZXZGQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR LXDH LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR WGY LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR WGYSJHM LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR SSWL LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR SFGLJBH LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR LLR LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR YSPXBM LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" OR YSQK LIKE ").append(SqlUtil.toSqlStr_like(dcqjclqk));
            sql.append(" )");
        }
        sql.append("  ORDER BY a.UPDATE_DATE DESC ");
        Page<Map<String, Object>> letterPage = simpleDao.listNativeByPage(sql.toString(), page);
        return new PageEU<>(letterPage);
    }

    /**
     * 导出Excel 全部 信访件 --整改汇总表
     *
     * @param response
     * @param rectifitionPage
     * @return
     */
    private LayuiUtil exportEnvironmentLetterExl(HttpServletResponse response, Page<EnvironmentLetter> rectifitionPage) {
        List<EnvironmentLetter> result = rectifitionPage.getResult();
        // 定义Excel 字段名称
        LinkedHashMap<String, String> columnMap = new LinkedHashMap<>();
        columnMap.put("title", "漳州市环保督察信访件汇总表");
        columnMap.put("yspxbm", "原始排序编码");
        columnMap.put("slbh", "受理编号");
        columnMap.put("jbwtjbqk", "交办问题基本情况");
        columnMap.put("xzqy", "行政区域");
        columnMap.put("wrlx", "污染类型");
        columnMap.put("dcqjdchsqk", "督察期间调查核实情况");
        columnMap.put("sfss", "是否属实");
        columnMap.put("zgmbjzgcs", "整改目标及整改措施");
        columnMap.put("dcqjclqk", "督察期间处理情况");
        columnMap.put("zxzgqk", "最新整改情况");
        columnMap.put("bjzt", "办结状态");
        columnMap.put("zlzg", "责令整改（家次）");
        columnMap.put("fkje", "罚款金额（万元）");
        columnMap.put("sfzdj", "是否重点件");
        columnMap.put("ggssxldqk", "挂钩省市县领导情况");
        columnMap.put("qtzrdw", "牵头责任单位");
        columnMap.put("llr", "联络人");
        columnMap.put("lxdh", "联系电话");
        columnMap.put("sswl", "所属网格");
        columnMap.put("wgy", "网格员");
        columnMap.put("wgysjhm", "网格员手机号码");
        columnMap.put("lc", "轮次");
        columnMap.put("sfcf", "是否重复");
        columnMap.put("sfgljbh", "重复关联件编号");
        columnMap.put("ysqk", "验收情况");
        columnMap.put("hbbh", "合并编号");
        columnMap.put("lacf", "立案处罚（家次）");
        columnMap.put("lazc", "立案侦查（件次）");
        columnMap.put("xsjl", "行政拘留（人次）");
        columnMap.put("xzjl", "刑事拘留（人次）");
        columnMap.put("yt", "约谈（人次）");
        columnMap.put("wz", "问责（人次）");
        columnMap.put("wzqk", "问责情况");
        ExcelExportUtil.exportExcel(response, columnMap, result);
        return null;
    }

    /**
     * /**
     * create by: wudenglin
     * description: 查找办结状态数量按照区县来进行划分;
     * {
     * name: 'Desert',
     * type: 'bar',
     * label: labelOption,
     * data: [150, 232, 201, 154, 190]
     * }
     * create time: 2019/10/23 0023 13:58
     *
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @RequestMapping("/countStateNum")
    @ResponseBody
    public Map<String, Object> countBJZTByXZQY(String type) {
        String userDeptName = getUserDeptName();
        return letterService.countBJZTByXZQY(type,userDeptName);
    }

    @RequestMapping("/countStateNumTest")
    @ResponseBody
    public Map<String, Object> countBJZTByXZQYTest(String type) {
        String userDeptName = getUserDeptName();
        return letterService.countBJZTByXZQYTest(type,userDeptName);
    }

    /**
     * 删除信访件
     *
     * @param uuid
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @Transactional(rollbackFor = Exception.class)
    public R delete(String uuid) {
        letterDao.deleteById(uuid);
        return R.ok("删除成功！");
    }

    /**
     * 新增编辑事件
     * @param letter
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public R save(EnvironmentLetter letter) {
        try {
            String save = letterService.saveLetter(letter);
            return R.ok(save);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }

    }


}
