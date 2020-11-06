package cn.fjzxdz.frame.service.sys.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.MenuDao;
import cn.fjzxdz.frame.entity.core.Menu;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.service.sys.MenuService;
import cn.fjzxdz.frame.toolbox.node.MenuNode;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import static com.alibaba.fastjson.JSON.toJSON;

@Service
@Transactional(rollbackFor=Exception.class)
public class MenuServiceImpl implements MenuService {

    private static Logger logger = LogManager.getLogger(MenuServiceImpl.class);

    @Autowired
    private MenuDao menuDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    @CacheEvict(value = {"menuTree", "rootMenuTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
    public void save(Menu menu) {
        menuDao.save(menu);
    }

    @Override
    @CacheEvict(value = {"menuTree", "rootMenuTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
    public Menu update(Menu menu) {
        return menuDao.update(menu);
    }

    @Override
    @CacheEvict(value = {"menuTree", "rootMenuTree", "userMenuTree", "userFrontMenuTree"}, allEntries = true)
    public void deleteById(String id) {
        menuDao.deleteById(id);
        simpleDao.createNativeQuery("delete from sys_role_menu where menu='"+id+"'").executeUpdate();
    }

    @Override
    public List<Role> findRoleByUrl(String url) {
        List<Menu> authorities = menuDao.selectListBy("url", url);
        List<Role> roles = new ArrayList<Role>();
        if (null != authorities && authorities.size() > 0) {
            for (Menu menu : authorities) {
            	Set<Role> tempRoles = menu.getRoles();
                if (null != tempRoles && tempRoles.size() > 0) {
                    for (Role role : tempRoles) {
                            roles.add(role);
                    }
                }
            }
        }
        return roles;
    }

    @Override
    public JsonArray getChildren(String id) {
        JsonArray jsonArray = new JsonArray();
        List<Menu> list = simpleDao.find("from Menu m where m.parent.uuid=? order by m.num asc", id);
        if (null != list && list.size() > 0) {
            for (Menu menu : list) {
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("name", menu.getName());
                jsonObject.addProperty("text", menu.getName());
                jsonObject.addProperty("id", menu.getUuid());
                jsonObject.addProperty("parentId", menu.getParent().getUuid());
                jsonObject.addProperty("icon", menu.getIcon());
                jsonObject.addProperty("url", menu.getUrl());
                jsonObject.addProperty("num", menu.getNum());
                if (null != menu.getChildren() && menu.getChildren().size() > 0) {
                    jsonObject.addProperty("state", "closed");
                }
                jsonArray.add(jsonObject);
            }
        }
        return jsonArray;
    }

    @Override
    public JsonArray getTopTwoTree() {
        JsonArray jsonArray = new JsonArray();
        List<Menu> menuList = menuDao.selectList("from Menu m where m.parent ='0'");
        if (ToolUtil.isNotEmpty(menuList)) {
            for (Menu menu : menuList) {
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("id", menu.getUuid());
                jsonObject.addProperty("name", menu.getName());
                jsonObject.addProperty("text", menu.getName());
                jsonObject.addProperty("parentId", "");
                jsonObject.addProperty("icon", menu.getIcon());
                jsonObject.addProperty("url", menu.getUrl());
                jsonObject.addProperty("num", menu.getNum());
                if (null != menu.getChildren() && menu.getChildren().size() > 0) {
                    jsonObject.addProperty("state", "");
                    Set<Menu> list = menu.getChildren();
                    JsonArray jsonArrayTemp = new JsonArray();
                    for (Menu menuTemp : list) {
                        JsonObject jsonObjectTemp = new JsonObject();
                        jsonObjectTemp.addProperty("id", menuTemp.getUuid());
                        jsonObjectTemp.addProperty("name", menuTemp.getName());
                        jsonObjectTemp.addProperty("text", menuTemp.getName());
                        jsonObjectTemp.addProperty("parentId", menuTemp.getUuid());
                        jsonObjectTemp.addProperty("icon", menuTemp.getIcon());
                        jsonObjectTemp.addProperty("url", menuTemp.getUrl());
                        jsonObjectTemp.addProperty("num", menuTemp.getNum());

                        if (null != menuTemp.getChildren() && menuTemp.getChildren().size() > 0) {
                            jsonObjectTemp.addProperty("state", "closed");
                        }
                        jsonArrayTemp.add(jsonObjectTemp);
                    }
                    jsonObject.add("children", jsonArrayTemp);
                } else {
                    jsonObject.addProperty("state", "");
                }
                jsonArray.add(jsonObject);
            }
        }
        return jsonArray;
    }

    @Override
    @SuppressWarnings("rawtypes")
	//@Cacheable(value = {"userMenuTree"}, key = "#p0")
    public JSONArray getIndexMenu(String userId) {
        logger.info("获取普通用户的菜单，用户Id为：" + userId);
    
//        StringBuilder indexMenuSql = new StringBuilder("SELECT" +
//                "  DISTINCT m.uuid," +
//                "  m.pid," +
//                "  m.name," +
//                "  m.levels," +
//                "  m.num," +
//                "  m.url," +
//                "  m.icon" +
//                "   FROM" +
//                "  Menu m "
//                + "where exists (from Role r where m in elements(r.menus) "
//                + "and exists (from Job j where r in elements(j.roles) "
//                + "and exists (from User u where j in elements(u.jobs) and u.uuid='"+userId+"') and j.enable=1 ))");
//        
//        List menuList = menuDao.createQuery(indexMenuSql.toString()).getResultList();

        /*StringBuilder indexMenuSql = new StringBuilder("SELECT" +
                "  DISTINCT m.uuid," +
                "  m.pid," +
                "  m.name," +
                "  m.levels," +
                "  m.num," +
                "  m.url," +
                "  m.icon" +
                "   FROM" +
                "  sys_menu m" +
                "  INNER JOIN sys_role_menu rm ON rm.menu = m.uuid" +
                "  INNER JOIN sys_role r ON rm.role = r.uuid" +
                "   WHERE" +
                "  r.uuid IN (" +
                "    SELECT" +
                "      DISTINCT r.uuid" +
                "    FROM" +
                "      sys_role r" +
                "      LEFT JOIN sys_job_role jr ON jr.role = r.uuid" +
                "      LEFT JOIN sys_job j ON jr.job = j.uuid" +
                "    WHERE" +
                "      j.uuid IN (" +
                "        SELECT" +
                "          j.uuid" +
                "        FROM" +
                "          sys_job j inner join sys_job_user ju on j.uuid=ju.job and ju.user_id='"+userId+"' " +
                "        WHERE" +
                "          j.enable = 1" +
                "      )" +
                "  )");*/
        StringBuilder indexMenuSql = new StringBuilder("SELECT" +
                "  DISTINCT m.uuid id," +
                "  m.pid parent_id," +
                "  m.name," +
                "  m.levels," +
                "  m.num," +
                "  m.url," +
                "  m.icon" +
                "   FROM" +
                "  sys_menu m" +
                "  LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid" +
                "  LEFT JOIN sys_role r ON rm.role = r.uuid" +
                "  LEFT JOIN sys_job_role jr ON jr.role = r.uuid " +
                "  LEFT JOIN sys_job j ON jr.job = j.uuid" +
                "  LEFT JOIN sys_job_user ju ON j.uuid = ju.job" +
                "  WHERE m.levels < 4" +
                "  AND ju. USER_ID = '"+userId+"' " +
                "  AND j. ENABLE = 1");
        List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

        List<MenuNode> menuNodeList = appendMenuNodeTree(menuList);

        return (JSONArray) toJSON(menuNodeList);
    }

    @Override
    @SuppressWarnings("rawtypes")
    ///@Cacheable(value = {"userFrontMenuTree"}, key = "#userId +'-front'")
    public JSONArray getFrontMenu(String userId) {
        logger.info("获取普通用户的前端菜单栏，用户Id为：" + userId);
        StringBuilder indexMenuSql = new StringBuilder("SELECT DISTINCT "
                + "m.uuid id, "
                + "m.pid parent_id, "
                + "m.name, "
                + "m.levels, "
                + "m.num, "
                + "m.url, "
                + "m.icon "
                + "FROM sys_menu m "
                + "LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid "
                + "LEFT JOIN sys_role r ON rm.role = r.uuid "
                + "LEFT JOIN sys_job_role jr ON jr.role = r.uuid "
                + "LEFT JOIN sys_job j ON jr.job = j.uuid "
                + "LEFT JOIN sys_job_user ju ON j.uuid = ju.job "
                + "WHERE m.levels < 4 AND ju. USER_ID = '"+userId+"' "
                + "AND j. ENABLE = 1 AND m.PIDS like '[0],[94aa1f6c-8c06-425f-82c4-ea68a3983cad],%'");
        List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

        List<MenuNode> menuNodeList = appendFrontMenuNodeTree(menuList);

        return (JSONArray) toJSON(menuNodeList);
    }

    @Override
    @SuppressWarnings("rawtypes")
    public JSONArray getFrontSecondAndChileMenu(String userId, String pid) {
        logger.info("获取普通用户的前端菜单栏，用户Id为：" + userId);
        if(ToolUtil.isEmpty(pid)){
            return new JSONArray(0);
        }
        Menu menu = menuDao.getById(pid);
        if(ToolUtil.isNotEmpty(menu)) {
            StringBuilder indexMenuSql = new StringBuilder("SELECT DISTINCT m.uuid id, " +
                    "m.pid  parent_id, " +
                    "m.name, " +
                    "m.levels, " +
                    "m.num," +
                    "m.url," +
                    "m.icon " +
                    "FROM sys_menu m " +
                    "LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid " +
                    "LEFT JOIN sys_role r ON rm.role = r.uuid " +
                    "LEFT JOIN sys_job_role jr ON jr.role = r.uuid " +
                    "LEFT JOIN sys_job j ON jr.job = j.uuid " +
                    "LEFT JOIN sys_job_user ju ON j.uuid = ju.job " +
                    "WHERE m.levels < 5 " +
                    "AND ju.USER_ID = '"+ userId +"' " +
                    "AND j.ENABLE = 1 " +
                    "AND m.TYPE = 1 " +
                    "  AND m.PIDS like '" + menu.getPids()+"[" + pid +"],%'");
            List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

//            List<MenuNode> menuNodeList = appendFrontMenuNodeTree(menuList);
            List<MenuNode> menuNodes = new ArrayList<>();
            if (ToolUtil.isNotEmpty(menuList)) {
                for (Object obj : menuList) {
                    MenuNode menuNode = BeanUtil.toBean(obj,MenuNode.class);
                    menuNode.setLevels(menuNode.getLevels()-1);
                    menuNodes.add(menuNode);
                }
            }
            List<MenuNode> menuNodeList = MenuNode.buildFrontTitle(menuNodes, 2);

            return (JSONArray) toJSON(menuNodeList);
        }
        return new JSONArray();
    }
    
    @Override
    @SuppressWarnings("rawtypes")
    ///@Cacheable(value = {"userFrontMenuTree"}, key = "#userId +'-front'")
    public JSONArray getNewFrontMenu(String userId) {
        logger.info("获取普通用户的前端菜单栏，用户Id为：" + userId);
        StringBuilder indexMenuSql = new StringBuilder(
                "SELECT DISTINCT m.uuid id, m.pid parent_id, m.name, m.levels, m.num, m.url, m.icon, to_char(m.REMARK) remark"
                + " FROM sys_menu m LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid"
                + " LEFT JOIN sys_role r ON rm.role = r.uuid"
                + " LEFT JOIN sys_job_role jr ON jr.role = r.uuid"
                + " LEFT JOIN sys_job j ON jr.job = j.uuid"
                + " LEFT JOIN sys_job_user ju ON j.uuid = ju.job"
                + " WHERE m.pid = (select a.uuid from sys_menu a where a.url = '/index') and m.levels =3"
                + " AND ju. USER_ID = '" + userId + "' AND j. ENABLE = 1"
                + " AND m.PIDS like '[0],[94aa1f6c-8c06-425f-82c4-ea68a3983cad],%' order by num");
        List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

        List<MenuNode> menuNodes = new ArrayList<>();
        if (ToolUtil.isNotEmpty(menuList)) {
            for (Object menu : menuList) {
                MenuNode menuNode = BeanUtil.toBean(menu,MenuNode.class);
                menuNodes.add(menuNode);
            }
        }
        List<MenuNode> menuNodeList = MenuNode.buildFrontTitle(menuNodes, 3);
        
        return (JSONArray) toJSON(menuNodeList);
    }
    
    @Override
    @SuppressWarnings("rawtypes")
    ///@Cacheable(value = {"userSecondMenu"}, key = "#userId +'-' + '#pid'")
    public JSONArray getSecondMenu(String userId, String pid) {
        logger.info("获取普通用户的前端菜单栏，用户Id为：" + userId);
        StringBuilder indexMenuSql = new StringBuilder("SELECT DISTINCT "
                + "m.uuid id, "
                + "m.pid parent_id, "
                + "m.name, "
                + "m.levels, "
                + "m.num, "
                + "m.url, "
                + "m.icon "
                + "FROM sys_menu m "
                + "LEFT JOIN sys_role_menu rm ON rm.menu = m.uuid "
                + "LEFT JOIN sys_role r ON rm.role = r.uuid "
                + "LEFT JOIN sys_job_role jr ON jr.role = r.uuid "
                + "LEFT JOIN sys_job j ON jr.job = j.uuid "
                + "LEFT JOIN sys_job_user ju ON j.uuid = ju.job "
                + "WHERE m.levels < 4 AND ju. USER_ID = '"+userId+"' "
                + "AND j. ENABLE = 1 AND m.PID = '" + pid + "'");
        List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

        List<MenuNode> menuNodes = new ArrayList<>();
        if (ToolUtil.isNotEmpty(menuList)) {
            for (Object menu : menuList) {
                MenuNode menuNode = BeanUtil.toBean(menu,MenuNode.class);
                menuNodes.add(menuNode);
            }
        }
        List<MenuNode> menuNodeList = MenuNode.buildFrontTitle(menuNodes, 3);
        
        return (JSONArray) toJSON(menuNodeList);
    }
    

    @SuppressWarnings("rawtypes")
	@Override
    @Cacheable(value = {"rootMenuTree"})
    public JSONArray getRootMenu() {
        logger.info("获取超级管理员的菜单");
        StringBuilder indexMenuSql = new StringBuilder("SELECT " +
                " m.uuid, " +
                " m.pid, " +
                " m.name, " +
                " m.levels, " +
                " m.num, " +
                " m.url, " +
                " m.icon  " +
                "FROM " +
                " sys_menu m  " +
                "WHERE " +
                "m.uuid = '1bc5b77f-5299-4ed3-894e-7ee7a5b58lyh' UNION " +
                "SELECT " +
                " m.uuid, " +
                " m.pid, " +
                " m.name, " +
                " m.levels, " +
                " m.num, " +
                " m.url, " +
                " m.icon  " +
                "FROM " +
                " sys_menu m  " +
                "WHERE " +
                " m.pids LIKE '%1bc5b77f-5299-4ed3-894e-7ee7a5b58lyh%'");

        List menuList = simpleDao.getNativeQueryList(indexMenuSql.toString());

        List<MenuNode> menuNodeList = appendMenuNodeTree(menuList);

        return (JSONArray) toJSON(menuNodeList);
    }

    @Override
    @Cacheable(value = {"menuTree"}, key = "#id +'-'+ #enable")
    public JSONArray getMenuTree(String id, Integer enable, Integer openIndex) {
        JSONArray jsonArray = new JSONArray();
        JSONObject top = new JSONObject();
        top.put("id", "0");
        top.put("name", "顶级菜单");
        top.put("text", "顶级菜单");
        top.put("parentId", "");
        top.put("state", "");
        List<Menu> firstMenuList;
        Integer index = 1;
        String whereHql ="";
        if (StringUtils.isEmpty(id)) {
            firstMenuList = menuDao.selectList("from Menu m where m.parent ='0'" + whereHql);
        } else {
            firstMenuList = menuDao.selectList("from Menu m where m.uuid=?" + whereHql, id);
        }

        if (ToolUtil.isNotEmpty(firstMenuList)) {
            JSONArray firstChild = new JSONArray();
            for (Menu firstMenu : firstMenuList) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("id", firstMenu.getUuid());
                jsonObject.put("name", firstMenu.getName());
                jsonObject.put("text", firstMenu.getName());
                jsonObject.put("icon", firstMenu.getIcon());
                jsonObject.put("type", firstMenu.getType());
                jsonObject.put("permission", firstMenu.getPermission());
                jsonObject.put("url", firstMenu.getUrl());
                jsonObject.put("num", firstMenu.getNum());
                jsonObject.put("remark", firstMenu.getRemark());
                if (null != firstMenu.getChildren() && firstMenu.getChildren().size() > 0) {
                    List<Menu> menuList = new ArrayList<>();
                    for (Menu menuTemp : firstMenu.getChildren()) {
                        menuList.add(menuTemp);
                    }
                    if (menuList.size() > 0) {
                        if (index < openIndex) {
                            jsonObject.put("state", "");
                        } else {
                            jsonObject.put("state", "closed");
                        }
                        JSONArray jsonArrayTemp = getMenuTreeChildren(firstMenu.getUuid(), menuList, enable, openIndex, index + 1);
                        jsonObject.put("children", jsonArrayTemp);
                    } else {
                        jsonObject.put("state", "");
                    }
                } else {
                    jsonObject.put("state", "");
                }
                firstChild.add(jsonObject);
            }
            top.put("children", firstChild);
        }
        jsonArray.add(top);
        return jsonArray;
    }

    @Override
    public Menu getById(String id) {
        return menuDao.getById(id);
    }

    private JSONArray getMenuTreeChildren(String pUuid, List<Menu> menuList, Integer enable, Integer openIndex, Integer index) {
        JSONArray jsonArray = new JSONArray();
        for (Menu menu : menuList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", menu.getUuid());
            jsonObject.put("name", menu.getName());
            jsonObject.put("text", menu.getName());
            jsonObject.put("parentId", pUuid);
            jsonObject.put("icon", menu.getIcon());
            jsonObject.put("type", menu.getType());
            jsonObject.put("permission", menu.getPermission());
            jsonObject.put("url", menu.getUrl());
            jsonObject.put("num", menu.getNum());
            jsonObject.put("remark", menu.getRemark());
            if (null != menu.getChildren() && menu.getChildren().size() > 0) {
                List<Menu> menuListTemp = new ArrayList<Menu>();
                for (Menu menuTemp : menu.getChildren()) {
                    menuListTemp.add(menuTemp);
                }
                if (menuListTemp.size() > 0) {
                    if (index < openIndex) {
                        jsonObject.put("state", "");
                    } else {
                        jsonObject.put("state", "closed");
                    }
                    JSONArray jsonArrayTemp = getMenuTreeChildren(menu.getUuid(), menuListTemp, enable, openIndex, index + 1);
                    jsonObject.put("children", jsonArrayTemp);
                } else {
                    jsonObject.put("state", "");
                }
            } else {
                jsonObject.put("state", "");
            }
            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }


    @SuppressWarnings("rawtypes")
	private List<MenuNode> appendMenuNodeTree(List menuList) {
        List<MenuNode> menuNodes = new ArrayList<>();
        if (ToolUtil.isNotEmpty(menuList)) {
            for (Object menu : menuList) {

                MenuNode menuNode = BeanUtil.toBean(menu,MenuNode.class);;
//                JSONArray menuJr = (JSONArray) JSONObject.toJSON(menu);
//                System.err.println(menuJr.toString());
//                menuNode.setId(menuJr.get(0).toString());
//                menuNode.setParentId(menuJr.get(1).toString());
//                menuNode.setName(menuJr.get(2).toString());
//                menuNode.setLevels(Convert.toInt(menuJr.get(3)));
//                menuNode.setNum(Convert.toInt(menuJr.get(4)));
//                menuNode.setUrl(menuJr.get(5).toString());
//                menuNode.setIcon(menuJr.get(6).toString());
                menuNodes.add(menuNode);
            }
        }
        return MenuNode.buildTitle(menuNodes);
    }
    
    @SuppressWarnings("rawtypes")
	private List<MenuNode> appendFrontMenuNodeTree(List menuList) {
        List<MenuNode> menuNodes = new ArrayList<>();
        if (ToolUtil.isNotEmpty(menuList)) {
            for (Object menu : menuList) {
                MenuNode menuNode = BeanUtil.toBean(menu,MenuNode.class);
//                JSONArray menuJr = (JSONArray) JSONObject.toJSON(menu);
//                System.err.println(menuJr.toString());
//                menuNode.setId(menuJr.get(0).toString());
//                menuNode.setParentId(menuJr.get(1).toString());
//                menuNode.setName(menuJr.get(2).toString());
//                menuNode.setLevels(Convert.toInt(menuJr.get(3)));
//                menuNode.setNum(Convert.toInt(menuJr.get(4)));
//                menuNode.setUrl(menuJr.get(5).toString());
//                menuNode.setIcon(menuJr.get(6).toString());
                menuNodes.add(menuNode);
            }
        }
        return MenuNode.buildFrontTitle(menuNodes, 2);
    }
}
