package com.fjzxdz.ams.zphb.module.enter.controller;

import com.fjzxdz.ams.common.generate.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author shenliuyuan
 * @title: 持证矿山Controller
 * @projectName portal_manager
 * @description: TODO
 * @date 2019/9/3016:53
 */
@Controller
@RequestMapping(value = "/zphb/enter/pollutionLicensedMine")
public class ZpPollutionLicensedMineController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 分页查询矿山

     * @return
     */
    @ResponseBody
    @RequestMapping(value = "findPage")
    public Map<String, Object> findPage( String name, HttpServletRequest request){
        int page = 1;
        int pageSize = 10;
        if(org.apache.commons.lang.StringUtils.isNotEmpty((String)request.getParameter("page"))) {
            page = Integer.parseInt((String) request.getParameter("page"));
        }
        if(org.apache.commons.lang.StringUtils.isNotEmpty((String)request.getParameter("pageSize"))) {
            pageSize = Integer.parseInt((String) request.getParameter("pageSize"));
        }
        Integer n=page*pageSize+1;
        Integer s=(page-1)*pageSize;
        String sql="SELECT * FROM ZP_POLLUTION_LICENSED_MINE t";
        if(StringUtils.isNotEmpty(name)){
            sql+=" WHERE t.MC LIKE '%"+name+"%'";
        }
        sql += " order by t.SEQNO ASC";
        String page1="SELECT *  FROM (SELECT tt.*, ROWNUM AS rowno FROM (";
        String page2=") tt WHERE ROWNUM < "+n+") table_alias WHERE table_alias.rowno > "+s+"";
        List<Map<String, Object>> listPage=jdbcTemplate.queryForList(page1+sql+page2);
        List<Map<String, Object>> total=jdbcTemplate.queryForList(sql);
        Map<String, Object> result = new HashMap<>();
        result.put("rows", listPage);
        result.put("total", total.size());
        result.put("pageNo",page);
        result.put("pageSize",pageSize);
        return result;
    }


    /**
     * 查询所有矿山的名称和经纬度
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "findList")
    public List<Map<String, Object>> findList(String name){
        String sql="SELECT t.ID,t.MC,t.JD,t.WD FROM ZP_POLLUTION_LICENSED_MINE t";
        if(StringUtils.isNotEmpty(name)){
            sql+=" WHERE t.MC LIKE '%"+name+"%'";
        }
        List<Map<String, Object>> listPage=jdbcTemplate.queryForList(sql);
        return listPage;
    }

    /**
     * 根据ID查询矿山
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "get")
    public List<Map<String, Object>> get(String id){
        String sql="SELECT * FROM ZP_POLLUTION_LICENSED_MINE t WHERE t.id="+id;
        List<Map<String, Object>> listPage=jdbcTemplate.queryForList(sql);
        return listPage;
    }

    /**
     * 根据矿山总数
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "findTotal")
    public Integer findTotal(){
        String sql="SELECT * FROM ZP_POLLUTION_LICENSED_MINE t ";
        List<Map<String, Object>> listPage=jdbcTemplate.queryForList(sql);
        return listPage.size();
    }

}
