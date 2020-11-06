package cn.fjzxdz.frame.controller.sys;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import cn.fjzxdz.frame.utils.SynDBSimpleCurdUtil;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.dao.sys.MenuDao;
import cn.fjzxdz.frame.entity.core.Menu;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.entity.core.RoleParam;
import cn.fjzxdz.frame.service.sys.RoleService;
import cn.fjzxdz.frame.toolbox.page.PageEU;

@Controller
@RequestMapping("/sys/role")
//@Secured({"ROLE_ROOT"})
public class RoleController extends BaseController {

    @Autowired
    private MenuDao menuDao;

    @Autowired
    private RoleService roleService;

    @PreAuthorize("hasAuthority('sys:role:show')")
    @RequestMapping("")
//    @Secured({"ROLE_ADMIN", "ROLE_ROOT"})
    public String index() {
        return "/moudles/sys/role";
    }

    /**
     * 新增和修改角色
     */
    @PreAuthorize("hasAnyAuthority('sys:role:add,sys:role:edit')")
    @RequestMapping("/saveRole")
    @ResponseBody
    @CacheEvict(value = {"userMenuTree","userFrontMenuTree"}, allEntries = true)
    public Map<String, String> saveRole(@RequestParam(value = "uuid", required = false) String uuid,
                                        @RequestParam(value = "name") String name,
                                        @RequestParam(value = "code") String code,
                                        @RequestParam(value = "num", required = false) Integer num,
                                        @RequestParam(value = "remark", required = false) String remark) {
        Map<String, String> map = new HashedMap<>();
        map.put("type", "S");
        try {
            Role role = new Role();
            if (StringUtils.isNotEmpty(uuid)) {
                role = roleService.getById(uuid);
            }
            role.setName(name);
            role.setCode(code);
            role.setNum(num);
            role.setRemark(remark);
            roleService.save(role);
        } catch (Exception e) {
            map.put("type", "E");
            map.put("message", e.getMessage());
        }
        return map;
    }

    /**
     * 查看角色
     */
    @PreAuthorize("hasAuthority('sys:role:show')")
    @RequestMapping("/getRole")
    @ResponseBody
//    @Secured({"ROLE_ADMIN", "ROLE_ROOT"})
    public Map<String, Object> getRole(@RequestParam(value = "uuid") String uuid) {
        Map<String, Object> map = new HashedMap<>();
        Role role = roleService.getById(uuid);
        map.put("uuid", role.getUuid());
        map.put("name", role.getName());
        map.put("code", role.getCode());
        map.put("num", role.getNum());
        map.put("remark", role.getRemark());
        return map;
    }

    /**
     * 分配菜单
     */
    @PreAuthorize("hasAuthority('sys:role:menuAssign')")
    @RequestMapping(value = "/menuAssign")
    @ResponseBody
//    @Secured({"ROLE_ADMIN", "ROLE_ROOT"})
    public Map<String, Object> menuAssign(@RequestParam(value = "uuid") String uuid) {
        Map<String, Object> map = new HashedMap<>();
        map.put("type", "S");
        try {
            Role role = roleService.getById(uuid);
            Set<Menu> menus = role.getMenus();
            map.put("data", menus);
        } catch (Exception e) {
            map.put("type", "E");
            map.put("message", e.getMessage());
        }
        return map;
    }

    /**
     * 保存角色和菜单关系
     */
    @PreAuthorize("hasAuthority('sys:role:menuAssign')")
	@RequestMapping(value = "/saveRoleAndMenu")
    @ResponseBody
    @CacheEvict(value = {"userMenuTree","userFrontMenuTree"}, allEntries = true)
    public Map<String, String> saveRoleAndMenu(@RequestParam(value = "uuid")String uuid, 
    		@RequestParam(value = "menuIds") String menuIds) {
        Map<String, String> map = new HashedMap<>();
        map.put("type", "S");
        try {
            Role role = roleService.getById(uuid);
            Set<Menu> menus = new HashSet<Menu>();
            if (menuIds.length() > 0) {
            	List<Menu> result = menuDao.selectList("from Menu m where m.uuid in (" + menuIds + ") ");
                menus = new HashSet<Menu>(result);
            }
            role.setMenus(menus);
            roleService.save(role);
        } catch (Exception e) {
            map.put("type", "E");
            map.put("message", e.getMessage());
        }
        return map;
    }

    /**
     * 查询角色列表
     */
    @PreAuthorize("hasAuthority('sys:role:show')")
    @RequestMapping("/list")
    @ResponseBody
//    @Secured({"ROLE_ADMIN", "ROLE_ROOT"})
    public PageEU<Role> list(RoleParam roleParam, HttpServletRequest request) {
        Page<Role> page = pageQuery(request);
        Page<Role> rolePage = roleService.listByPage(roleParam, page);
        return new PageEU<>(rolePage);
    }
    
    /**
     * 查询角色列表
     */
    @PreAuthorize("hasAuthority('sys:role:show')")
    @RequestMapping("/listnopage")
    @ResponseBody
//    @Secured({"ROLE_ADMIN", "ROLE_ROOT"})
    public Object listnopage(RoleParam roleParam, HttpServletRequest request) {
    	List<Role> roleList = roleService.getRoleList("");
        return roleList;
    }

    @PreAuthorize("hasAuthority('sys:role:show')")
    @RequestMapping("/roleList")
    @ResponseBody
    public Object roleList() {
        try {
            cn.hutool.json.JSONArray reArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.role_select_list", new HashMap<String, Object>());
            return reArray;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Role>();
        }
    }

}
