package cn.fjzxdz.frame.service.sys;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.JsonArray;

import cn.fjzxdz.frame.entity.core.Menu;
import cn.fjzxdz.frame.entity.core.Role;

import java.util.List;

/**
 * 
 * 菜单接口 
 * @Author   lianhuinan
 * @Version   1.0 
 * @CreateTime 2019年5月15日 上午9:17:28
 */
public interface MenuService {

	/**
	 * 保存菜单
	 * @Title:  save
	 * @Description:    TODO(保存菜单)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年5月15日 上午9:18:31
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年5月15日 上午9:18:31    
	 * @param menu  void 
	 * @throws
	 */
    void save(Menu menu);

    /**
     * 更新菜单
     * @Title:  update
     * @Description:    TODO(更新菜单)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:18:53
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:18:53    
     * @param menu
     * @return  Menu 
     * @throws
     */
    Menu update(Menu menu);

    /**
     * 通过id删除菜单
     * @Title:  deleteById
     * @Description:    TODO(通过id删除菜单)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:19:06
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:19:06    
     * @param id  void 
     * @throws
     */
    void deleteById(String id);

    /**
     * 通过url获取Role数组
     * @Title:  findRoleByUrl
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:19:28
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:19:28    
     * @param url
     * @return  List<Role> 
     * @throws
     */
    List<Role> findRoleByUrl(String url);

    /**
     * 通过id过去子菜单
     * @Title:  getChildren
     * @Description:    TODO(通过id过去子菜单)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:21:50
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:21:50    
     * @param id
     * @return  JsonArray 
     * @throws
     */
    JsonArray getChildren(String id);

    /**
     * 获取菜单两层结构树
     * @Title:  getTopTwoTree
     * @Description:    TODO(获取菜单两层结构树)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:22:21
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:22:21    
     * @return  JsonArray 
     * @throws
     */
    JsonArray getTopTwoTree();

    /**
     * 获取系统管理的菜单列表
     * @Title:  getIndexMenu
     * @Description:    TODO(获取系统管理的菜单列表)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:23:23
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:23:23    
     * @param userId
     * @return  JSONArray 
     * @throws
     */
    JSONArray getIndexMenu(String userId);

    /**
     * 获取内置超级管理员的菜单信息
     * @Title:  getRootMenu
     * @Description:    TODO(获取内置超级管理员的菜单信息)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:23:52
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:23:52    
     * @return  JSONArray 
     * @throws
     */
    JSONArray getRootMenu();

    /**
     * 获取菜单树
     * @Title:  getMenuTree
     * @Description:    TODO(获取菜单树)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:24:24
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:24:24    
     * @param id 菜单节点
     * @param enable 是否启用
     * @param openIndex 打开层级
     * @return  JSONArray 
     * @throws
     */
    JSONArray getMenuTree(String id, Integer enable, Integer openIndex);

    /**
     * 通过id获取菜单
     * @Title:  getById
     * @Description:    TODO(通过id获取菜单)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:26:07
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:26:07    
     * @param id
     * @return  Menu 
     * @throws
     */
    Menu getById(String id);

    /**
     * 根据登录用户获取前端菜单栏
     * @Title:  getFrontMenu
     * @Description:    TODO(根据登录用户获取前端菜单栏)    
     * @CreateBy: lianhuinan 
     * @CreateTime: 2019年5月15日 上午9:26:24
     * @UpdateBy: lianhuinan 
     * @UpdateTime:  2019年5月15日 上午9:26:24    
     * @param userId
     * @return  JSONArray 
     * @throws
     */
	JSONArray getFrontMenu(String userId);

	/**
	 * @Author lianhuinan
	 * @Description //TODO(根据用户登录权限与pids的参数获取子菜单树)
	 * @Date 2019/8/26 0026 10:50
	 * @param userId
	 * @param pids
	 * @return com.alibaba.fastjson.JSONArray
	 * @version 1.0
	 **/
	JSONArray getFrontSecondAndChileMenu(String userId, String pids);

	/**
	 * 
	 * @Title:  getSecondMenu
	 * @Description:    根据一级菜单ID及用户ID获取二级菜单   
	 * @CreateBy: chenbingke 
	 * @CreateTime: 2019年6月27日 上午10:15:41
	 * @UpdateBy: chenbingke 
	 * @UpdateTime:  2019年6月27日 上午10:15:41    
	 * @param userId
	 * @param pid
	 * @return  JSONArray 
	 * @throws
	 */
    JSONArray getSecondMenu(String userId, String pid);

    /**
     * 
     * @Title:  getNewFrontMenu
     * @Description:    根据用户ID获取新的首页菜单
     * @CreateBy: chenbingke 
     * @CreateTime: 2019年7月12日 上午10:13:08
     * @UpdateBy: chenbingke 
     * @UpdateTime:  2019年7月12日 上午10:13:08    
     * @param userId
     * @return  JSONArray 
     * @throws
     */
    JSONArray getNewFrontMenu(String userId);
}
