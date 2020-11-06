package com.fjzxdz.ams.module.enviromonit.resource.service.impl;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.toolbox.node.MenuNode;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.convert.Convert;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fjzxdz.ams.module.enviromonit.resource.dao.ResDataDao;
import com.fjzxdz.ams.module.enviromonit.resource.entity.ResData;
import com.fjzxdz.ams.module.enviromonit.resource.service.ResDataService;
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
public class ResDataServiceImpl implements ResDataService {

    private static Logger logger = LogManager.getLogger(ResDataServiceImpl.class);

    @Autowired
    private ResDataDao resDataDao;

    @Autowired
    private SimpleDao simpleDao;

    @Override
    @CacheEvict(value = {"resDataTree", "rootResDataTree", "userResDataTree"}, allEntries = true)
    public void save(ResData menu) {
        resDataDao.save(menu);
    }

    @Override
    @CacheEvict(value = {"resDataTree", "rootResDataTree", "userResDataTree"}, allEntries = true)
    public ResData update(ResData menu) {
        return resDataDao.update(menu);
    }

    @Override
    @CacheEvict(value = {"resDataTree", "rootResDataTree", "userResDataTree"}, allEntries = true)
    public void deleteById(String id) {
        resDataDao.deleteById(id);
        //simpleDao.createNativeQuery("delete from sys_role_menu where menu='"+id+"'").executeUpdate();
    }

    @Override
    public List<Role> findRoleByUrl(String url) {
        List<ResData> authorities = resDataDao.selectListBy("url", url);
        List<Role> roles = new ArrayList<Role>();
        if (null != authorities && authorities.size() > 0) {
            for (ResData menu : authorities) {
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
        List<ResData> list = simpleDao.find("from ResData m where m.parent.uuid=? order by m.num asc", id);
        if (null != list && list.size() > 0) {
            for (ResData menu : list) {
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
        List<ResData> menuList = resDataDao.selectList("from ResData m where m.parent ='0'");
        if (ToolUtil.isNotEmpty(menuList)) {
            for (ResData menu : menuList) {
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
                    Set<ResData> list = menu.getChildren();
                    JsonArray jsonArrayTemp = new JsonArray();
                    for (ResData menuTemp : list) {
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
	@Cacheable(value = {"userResDataTree"}, key = "#p0")
    public JSONArray getIndexMenu(String userId) {
        logger.info("获取普通用户的资源目录，用户Id为：" + userId);

        StringBuilder indexMenuSql = new StringBuilder("SELECT" +
                "  DISTINCT m.uuid," +
                "  m.pid," +
                "  m.name," +
                "  m.levels," +
                "  m.num," +
                "  m.url," +
                "  m.icon" +
                "   FROM" +
                "  ResData m "
                + "where exists (from Role r where m in elements(r.menus) "
                + "and exists (from Job j where r in elements(j.roles) "
                + "and exists (from User u where j in elements(u.jobs) and u.uuid='"+userId+"') and j.enable=1 ))");
        
        List menuList = resDataDao.createQuery(indexMenuSql.toString()).getResultList();

        List<MenuNode> menuNodeList = appendMenuNodeTree(menuList);

        return (JSONArray) toJSON(menuNodeList);
    }

    @SuppressWarnings("rawtypes")
	@Override
    @Cacheable(value = {"rootResDataTree"})
    public JSONArray getRootMenu() {
        logger.info("获取超级管理员的资源目录");
        StringBuilder indexMenuSql = new StringBuilder("SELECT " +
                " m.uuid, " +
                " m.pid, " +
                " m.name, " +
                " m.levels, " +
                " m.num, " +
                " m.url, " +
                " m.icon  " +
                "FROM " +
                " res_data m  " +
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
                " res_data m  " +
                "WHERE " +
                " m.pids LIKE '%1bc5b77f-5299-4ed3-894e-7ee7a5b58lyh%'");

        List menuList = simpleDao.createNativeQuery(indexMenuSql.toString()).getResultList();

        List<MenuNode> menuNodeList = appendMenuNodeTree(menuList);

        return (JSONArray) toJSON(menuNodeList);
    }

    @Override
    @Cacheable(value = {"resDataTree"}, key = "#id +'-'+ #enable")
    public JSONArray getMenuTree(String id, Integer enable, Integer openIndex) {
        JSONArray jsonArray = new JSONArray();
        JSONObject top = new JSONObject();
        top.put("id", "0");
        top.put("name", "顶级资源目录");
        top.put("text", "顶级资源目录");
        top.put("parentId", "");
        top.put("state", "");
        List<ResData> firstMenuList;
        Integer index = 1;
        String whereHql ="";
        if (StringUtils.isEmpty(id)) {
            firstMenuList = resDataDao.selectList("from ResData m where m.parent ='0'" + whereHql);
        } else {
            firstMenuList = resDataDao.selectList("from ResData m where m.uuid=?" + whereHql, id);
        }

        if (ToolUtil.isNotEmpty(firstMenuList)) {
            JSONArray firstChild = new JSONArray();
            for (ResData firstMenu : firstMenuList) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("id", firstMenu.getUuid());
                jsonObject.put("name", firstMenu.getName());
                jsonObject.put("text", firstMenu.getName());
                jsonObject.put("icon", firstMenu.getIcon());
                jsonObject.put("url", firstMenu.getUrl());
                jsonObject.put("num", firstMenu.getNum());
                jsonObject.put("remark", firstMenu.getRemark());
                if (null != firstMenu.getChildren() && firstMenu.getChildren().size() > 0) {
                    List<ResData> menuList = new ArrayList<>();
                    for (ResData menuTemp : firstMenu.getChildren()) {
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
    public ResData getById(String id) {
        return resDataDao.getById(id);
    }

    private JSONArray getMenuTreeChildren(String pUuid, List<ResData> menuList, Integer enable, Integer openIndex, Integer index) {
        JSONArray jsonArray = new JSONArray();
        for (ResData menu : menuList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", menu.getUuid());
            jsonObject.put("name", menu.getName());
            jsonObject.put("text", menu.getName());
            jsonObject.put("parentId", pUuid);
            jsonObject.put("icon", menu.getIcon());
            jsonObject.put("url", menu.getUrl());
            jsonObject.put("num", menu.getNum());
            jsonObject.put("remark", menu.getRemark());
            if (null != menu.getChildren() && menu.getChildren().size() > 0) {
                List<ResData> menuListTemp = new ArrayList<ResData>();
                for (ResData menuTemp : menu.getChildren()) {
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
                MenuNode menuNode = new MenuNode();
                JSONArray menuJr = (JSONArray) JSONObject.toJSON(menu);
                menuNode.setId(menuJr.get(0).toString());
                menuNode.setParentId(menuJr.get(1).toString());
                menuNode.setName(menuJr.get(2).toString());
                menuNode.setLevels(Convert.toInt(menuJr.get(3)));
                menuNode.setNum(Convert.toInt(menuJr.get(4)));
                menuNode.setUrl(menuJr.get(5).toString());
                if(ToolUtil.isNotEmpty(menuJr.get(6))) {
                    menuNode.setIcon(menuJr.get(6).toString());
                }
                menuNodes.add(menuNode);
            }
        }
        return MenuNode.buildTitle(menuNodes);
    }
}
