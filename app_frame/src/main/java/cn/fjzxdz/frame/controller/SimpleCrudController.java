package cn.fjzxdz.frame.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.dao.common.EntityDao;
import cn.fjzxdz.frame.entity.AlEntity;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.service.PersistenceService;
import cn.fjzxdz.frame.toolbox.page.PageEU;


public class SimpleCrudController<T extends AlEntity> extends BaseController{

    @Autowired
    private PersistenceService persistenceService;
    @Autowired
    private EntityDao entityDao;

    @RequestMapping("/list")
	@ResponseBody
    public PageEU<T> search(T param, HttpServletRequest request) {
    	Page<T> page = pageQuery(request);
		entityDao.findEntityByPage(param, page);
		return new PageEU<>(page);
    }

    @RequestMapping(value = "/saveEntity")
    @ResponseBody
    public R save(T entity) throws Exception {
        try {
        	persistenceService.add(entity);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
    }

    @RequestMapping(value = "/updateEntity")
    @ResponseBody
    public R update(T entity) throws Exception {
        try {
        	persistenceService.update(entity);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
    }

    @RequestMapping(value = "/deleteEntity")
    @ResponseBody
    public R delete(T entity) throws Exception {
        try {
        	persistenceService.delete(entity);
		} catch (Exception e) {
			return R.error(e.getMessage());
		}
		return R.ok();
    }

}
