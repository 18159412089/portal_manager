package cn.fjzxdz.frame.service.sys.impl;

import java.util.*;

import cn.fjzxdz.frame.utils.SynDBSimpleCurdUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.DeptDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.service.sys.DeptService;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@Service
@Transactional(rollbackFor=Exception.class)
public class DeptServiceImpl implements DeptService {

    @SuppressWarnings("unused")
	private static Logger logger = LogManager.getLogger(DeptServiceImpl.class);

    @Autowired
    private DeptDao deptDao;

    @Autowired
    private SimpleDao simpleDao;
    
    @Override
    public List<Dept> getDeptByUserId(String userId) {
        List list = deptDao.createNativeQuery("SELECT dt.* FROM sys_dept dt \n" +
                " LEFT JOIN  sys_job j ON j.dept = dt.uuid\n" +
                " left join sys_job_user ju on j.uuid = ju.job\n" +
                " WHERE ju.USER_ID='" + userId + "' and dt.ENABLE = 1", Dept.class);
        return list;
    }

    @Override
    public JsonArray getChildren(String id) {
        JsonArray jsonArray = new JsonArray();
        List<Dept> list = simpleDao.find("from Dept d where d.parent.uuid=? order by d.num asc", id);
        if (null != list && list.size() > 0) {
            for (Dept dept : list) {
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("name", dept.getName());
                jsonObject.addProperty("text", dept.getName());
                jsonObject.addProperty("id", dept.getUuid());
                jsonObject.addProperty("parentId", dept.getParent().getUuid());
                jsonObject.addProperty("enable", dept.getEnable());
                jsonObject.addProperty("leadernames", dept.getLeadernames());
                jsonObject.addProperty("leaderids", dept.getLeaderids());
                if (null != dept.getChildren() && dept.getChildren().size() > 0) {
                    jsonObject.addProperty("state", "closed");
                }
                jsonArray.add(jsonObject);
            }
        }
        return jsonArray;
    }

    @Override
    public JsonArray getChildrenByEnable(String id, int enable) {
        JsonArray jsonArray = new JsonArray();
        List<Dept> list = simpleDao.find("from Dept d where d.parent.uuid=? and ENABLE = ? order by d.num asc", id,enable);
        if (null != list && list.size() > 0) {
            for (Dept dept : list) {
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("name", dept.getName());
                jsonObject.addProperty("text", dept.getName());
                jsonObject.addProperty("id", dept.getUuid());
                jsonObject.addProperty("parentId", dept.getParent().getUuid());
                jsonObject.addProperty("enable", dept.getEnable());
                jsonObject.addProperty("leadernames", dept.getLeadernames());
                jsonObject.addProperty("leaderids", dept.getLeaderids());
                if (null != dept.getChildren() && dept.getChildren().size() > 0) {
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
        Dept dept = simpleDao.findUnique("from Dept d where d.parent is null or d.parent =''");
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("id", dept.getUuid());
        jsonObject.addProperty("name", dept.getName());
        jsonObject.addProperty("enable", dept.getEnable());
        jsonObject.addProperty("text", dept.getName());
        jsonObject.addProperty("leadernames", dept.getLeadernames());
        jsonObject.addProperty("leaderids", dept.getLeaderids());
        jsonObject.addProperty("parentId", "");
        if (null != dept.getChildren() && dept.getChildren().size() > 0) {
            jsonObject.addProperty("state", "");
            Set<Dept> list = dept.getChildren();
            JsonArray jsonArrayTemp = new JsonArray();
            for (Dept deptTemp : list) {
                JsonObject jsonObjectTemp = new JsonObject();
                jsonObjectTemp.addProperty("id", deptTemp.getUuid());
                jsonObjectTemp.addProperty("name", deptTemp.getName());
                jsonObjectTemp.addProperty("enable", deptTemp.getEnable());
                jsonObjectTemp.addProperty("text", deptTemp.getName());
                jsonObjectTemp.addProperty("leadernames", deptTemp.getLeadernames());
                jsonObjectTemp.addProperty("leaderids", deptTemp.getLeaderids());
                jsonObjectTemp.addProperty("parentId", dept.getUuid());
                if (null != deptTemp.getChildren() && deptTemp.getChildren().size() > 0) {
                    jsonObjectTemp.addProperty("state", "closed");
                }
                jsonArrayTemp.add(jsonObjectTemp);
            }
            jsonObject.add("children", jsonArrayTemp);
        } else {
            jsonObject.addProperty("state", "");
        }
        jsonArray.add(jsonObject);
        return jsonArray;
    }

    @Override
    public JsonArray getTopTwoTreeByEnable(int enable) {
        JsonArray jsonArray = new JsonArray();
        Dept dept = simpleDao.findUnique("from Dept d where d.parent is null or d.parent ='' and ENABLE = ?",enable);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("id", dept.getUuid());
        jsonObject.addProperty("name", dept.getName());
        jsonObject.addProperty("enable", dept.getEnable());
        jsonObject.addProperty("text", dept.getName());
        jsonObject.addProperty("leadernames", dept.getLeadernames());
        jsonObject.addProperty("leaderids", dept.getLeaderids());
        jsonObject.addProperty("parentId", "");
        if (null != dept.getChildren() && dept.getChildren().size() > 0) {
            jsonObject.addProperty("state", "");
            Set<Dept> list = dept.getChildren();
            JsonArray jsonArrayTemp = new JsonArray();
            for (Dept deptTemp : list) {
            	if(deptTemp.getEnable()==enable) {
            		JsonObject jsonObjectTemp = new JsonObject();
            		jsonObjectTemp.addProperty("id", deptTemp.getUuid());
            		jsonObjectTemp.addProperty("name", deptTemp.getName());
            		jsonObjectTemp.addProperty("enable", deptTemp.getEnable());
            		jsonObjectTemp.addProperty("text", deptTemp.getName());
            		jsonObjectTemp.addProperty("leadernames", deptTemp.getLeadernames());
            		jsonObjectTemp.addProperty("leaderids", deptTemp.getLeaderids());
            		jsonObjectTemp.addProperty("parentId", dept.getUuid());
            		if (null != deptTemp.getChildren() && deptTemp.getChildren().size() > 0) {
            			jsonObjectTemp.addProperty("state", "closed");
            		}
            		jsonArrayTemp.add(jsonObjectTemp);
            	}
            }
            jsonObject.add("children", jsonArrayTemp);
        } else {
            jsonObject.addProperty("state", "");
        }
        jsonArray.add(jsonObject);
        return jsonArray;
    }


    @Override
    public Dept getDeptByUuid(String uuid) {
        return deptDao.getById(uuid);
    }

    @Override
    @CacheEvict(value = {"deptTree","deptUserTree"}, allEntries = true)
    public void save2(Dept dept) {
        deptDao.save(dept);
    	dept.setPidpath(dept.getPidpath()+"/"+dept.getUuid());
    	deptDao.save(dept);
    }
    
    @Override
    @CacheEvict(value = {"deptTree","deptUserTree"}, allEntries = true)
    public void save(Dept dept) {
        deptDao.save(dept);
    }

    public Dept getById(String uuid) {
        return deptDao.getById(uuid);
    }

    @Override
    @Cacheable(value = {"deptTree"}, key = "#id +'-'+ #enable")
    public JSONArray getDeptTree(String id, Integer enable, Integer openIndex) {
        JSONArray jsonArray = new JSONArray();
        Dept dept = null;
        Integer index = 1;
        String whereHql = (1 == enable ? " and d.enable=1" : "");
        if (StringUtils.isEmpty(id)) {
            dept = simpleDao.findUnique("from Dept d where d.parent is null or d.parent =''" + whereHql);
        } else {
            dept = simpleDao.findUnique("from Dept d where d.uuid=?" + whereHql, id);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", dept.getUuid());
        jsonObject.put("name", dept.getName());
        jsonObject.put("text", dept.getName());
        jsonObject.put("parentId", "");
        if (null != dept.getChildren() && dept.getChildren().size() > 0) {
            List<Dept> deptList = new ArrayList<Dept>();
            for (Dept deptTemp : dept.getChildren()) {
                if (1 == enable) {
                    if (1 == deptTemp.getEnable()) {
                        deptList.add(deptTemp);
                    }
                } else {
                    deptList.add(deptTemp);
                }
            }
            if (deptList.size() > 0) {
                if (index < openIndex) {
                    jsonObject.put("state", "");
                } else {
                    jsonObject.put("state", "closed");
                }
                JSONArray jsonArrayTemp = getDeptTreeChildren(dept.getUuid(), deptList, enable, openIndex, index + 1);
                jsonObject.put("children", jsonArrayTemp);
            } else {
                jsonObject.put("state", "");
            }
        } else {
            jsonObject.put("state", "");
        }
        jsonArray.add(jsonObject);
        return jsonArray;
    }

    /**
     * 跨库获取网格数据
     * @param id 上级uuid
     * @param enable 是否禁用
     * @return
     * @throws Exception
     */
    @Override
    public cn.hutool.json.JSONArray getSynDeptTree(String id, Integer enable) throws Exception {
        cn.hutool.json.JSONArray allReArray = new cn.hutool.json.JSONArray();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        String where = "";
        if(enable==1){
            where += "enable=1 and ";
        }
        if(StringUtils.isEmpty(id)){
            where += "(pid is null or pid='')";
        }else{
            where += "(pid='"+id+"')";
        }
        paramMap.put("where", where);
        cn.hutool.json.JSONArray jsonArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.dept_select_list", paramMap);
        for(int i=0;i<jsonArray.size();i++){
            cn.hutool.json.JSONObject object = new cn.hutool.json.JSONObject();
            cn.hutool.json.JSONObject obj = jsonArray.getJSONObject(i);
            object.put("id", obj.getStr("uuid"));
            object.put("name", obj.getStr("name"));
            object.put("text", obj.getStr("name"));
            object.put("parentId", obj.getStr("pid"));

            if(StringUtils.isEmpty(id)){
                if(!StringUtils.isEmpty(obj.getStr("uuid"))){
                    cn.hutool.json.JSONArray childArray = getSynDeptTree(obj.getStr("uuid"), enable);
                    if(childArray.size()>0){
                        object.put("children", childArray);
                    }
                }
            }else{
                String childWhere = "";
                if(enable==1){
                    childWhere += "enable=1 and ";
                }
                childWhere += "(pid='"+obj.getStr("uuid")+"')";
                Map<String, Object> childParamMap = new HashMap<String, Object>();
                childParamMap.put("where", childWhere);
                cn.hutool.json.JSONArray childArray = SynDBSimpleCurdUtil.findBySQL("sso", "sso.dept_select_list", childParamMap);
                if(childArray.size()>0){
                    object.put("state", "closed");
                }
            }
            allReArray.add(object);
        }
        return allReArray;
    }

    private JSONArray getDeptTreeChildren(String pUuid, List<Dept> deptList, Integer enable, Integer openIndex, Integer index) {
        JSONArray jsonArray = new JSONArray();
        for (Dept dept : deptList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", dept.getUuid());
            jsonObject.put("name", dept.getName());
            jsonObject.put("text", dept.getName());
            jsonObject.put("parentId", pUuid);
            if (null != dept.getChildren() && dept.getChildren().size() > 0) {
                List<Dept> deptListTemp = new ArrayList<Dept>();
                for (Dept deptTemp : dept.getChildren()) {
                    if (1 == enable) {
                        if (1 == deptTemp.getEnable()) {
                            deptListTemp.add(deptTemp);
                        }
                    } else {
                        deptListTemp.add(deptTemp);
                    }
                }
                if (deptListTemp.size() > 0) {
                    if (index < openIndex) {
                        jsonObject.put("state", "");
                    } else {
                        jsonObject.put("state", "closed");
                    }
                    JSONArray jsonArrayTemp = getDeptTreeChildren(dept.getUuid(), deptListTemp, enable, openIndex, index + 1);
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
	@Override
    @Cacheable(value = {"deptUserTree"}, key = "#id +'-'+ #enable")
    public JSONArray getDeptUserTree(String id, Integer enable, Integer openIndex) {
        JSONArray jsonArray = new JSONArray();
        Dept dept = null;
        Integer index = 1;
        String whereHql = (1 == enable ? " and d.enable=1" : "");
        if (StringUtils.isEmpty(id)) {
            dept = simpleDao.findUnique("from Dept d where d.parent is null or d.parent =''" + whereHql);
        } else {
            dept = simpleDao.findUnique("from Dept d where d.uuid=?" + whereHql, id);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", dept.getUuid());
        jsonObject.put("name", dept.getName());
        jsonObject.put("text", dept.getName());
        jsonObject.put("type", "d");
        jsonObject.put("parentId", "");
        String userQuerySql="select u.uuid,u.name,'u' as t from sys_user u inner join sys_job_user ju on u.uuid=ju.user_ID inner join sys_job j on ju.job=j.uuid inner join sys_dept d on j.dept=d.uuid and d.uuid=?";
        if(1 == enable) {
        	userQuerySql="select u.uuid,u.name,'u' as t from sys_user u inner join sys_job_user ju on u.uuid=ju.user_ID inner join sys_job j on ju.job=j.uuid and j.enable=1 inner join sys_dept d on j.dept=d.uuid and d.enable=1 and d.uuid=? where u.enable=1";
        }
        List userlist =simpleDao.createNativeQuery(userQuerySql, dept.getUuid()).getResultList();
        if(null!=userlist&&userlist.size()>0) {
        	if (index < openIndex) {
                jsonObject.put("state", "");
            } else {
                jsonObject.put("state", "closed");
            }
        	JSONArray jsonArrayTemp = new JSONArray();
        	for (Object object : userlist) {
        		Object[] array = (Object[]) object;
        		JSONObject userObject = new JSONObject();
        		userObject.put("id", array[0]);
        		userObject.put("name", array[1]);
        		userObject.put("text", array[1]);
        		userObject.put("type", array[2]);
        		userObject.put("parentId", dept.getUuid());
        		jsonArrayTemp.add(userObject);
			}
        	jsonObject.put("children", jsonArrayTemp);
        }
        
        if (null != dept.getChildren() && dept.getChildren().size() > 0) {
            List<Dept> deptList = new ArrayList<Dept>();
            for (Dept deptTemp : dept.getChildren()) {
                if (1 == enable) {
                    if (1 == deptTemp.getEnable()) {
                        deptList.add(deptTemp);
                    }
                } else {
                    deptList.add(deptTemp);
                }
            }
            if (deptList.size() > 0) {
                if (index < openIndex) {
                    jsonObject.put("state", "");
                } else {
                    jsonObject.put("state", "closed");
                }
                JSONArray jsonArrayTemp = getDeptUserTreeChildren(dept.getUuid(), deptList, enable, openIndex, index + 1);
                if(null!=userlist&&userlist.size()>0) {
                	JSONArray tempArray = jsonObject.getJSONArray("children");
                	tempArray.addAll(jsonArrayTemp);
                	jsonObject.put("children", tempArray);
                }else {
                	jsonObject.put("children", jsonArrayTemp);
                }
            } else {
                jsonObject.put("state", "");
            }
        } else {
            jsonObject.put("state", "");
        }
        jsonArray.add(jsonObject);
        return jsonArray;
    }

    @SuppressWarnings("rawtypes")
	private JSONArray getDeptUserTreeChildren(String pUuid, List<Dept> deptList, Integer enable, Integer openIndex, Integer index) {
        JSONArray jsonArray = new JSONArray();
        for (Dept dept : deptList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", dept.getUuid());
            jsonObject.put("name", dept.getName());
            jsonObject.put("text", dept.getName());
            jsonObject.put("parentId", pUuid);
            jsonObject.put("type", "d");
            
			String userQuerySql = "select u.uuid,u.name,'u' from sys_user u "
					+ "inner join sys_job_user ju on u.uuid=ju.user_id " + "inner join sys_job j on ju.job=j.uuid "
					+ "inner join sys_dept d on j.dept=d.uuid and d.uuid=?";
            if(1 == enable) {           	
            	userQuerySql="select u.uuid,u.name,'u' from sys_user u "
            			+ "inner join sys_job_user ju on u.uuid=ju.user_id "
            			+ "inner join sys_job j on ju.job=j.uuid and j.enable=1 "
            			+ "inner join sys_dept d on j.dept=d.uuid and d.enable=1 and d.uuid=? "
            			+ "where u.enable=1";
            }
            List userlist =simpleDao.createNativeQuery(userQuerySql, dept.getUuid()).getResultList();
            if(null!=userlist&&userlist.size()>0) {
            	if (index < openIndex) {
                    jsonObject.put("state", "");
                } else {
                    jsonObject.put("state", "closed");
                }
            	JSONArray jsonArrayTemp = new JSONArray();
            	for (Object object : userlist) {
            		Object[] array = (Object[]) object;
            		JSONObject userObject = new JSONObject();
            		userObject.put("id", array[0]);
            		userObject.put("name", array[1]);
            		userObject.put("text", array[1]);
            		userObject.put("type", array[2]);
            		userObject.put("parentId", dept.getUuid());
            		jsonArrayTemp.add(userObject);
    			}
            	jsonObject.put("children", jsonArrayTemp);
            }
            if (null != dept.getChildren() && dept.getChildren().size() > 0) {
                List<Dept> deptListTemp = new ArrayList<Dept>();
                for (Dept deptTemp : dept.getChildren()) {
                    if (1 == enable) {
                        if (1 == deptTemp.getEnable()) {
                            deptListTemp.add(deptTemp);
                        }
                    } else {
                        deptListTemp.add(deptTemp);
                    }
                }
                if (deptListTemp.size() > 0) {
                    if (index < openIndex) {
                        jsonObject.put("state", "");
                    } else {
                        jsonObject.put("state", "closed");
                    }
                    JSONArray jsonArrayTemp = getDeptUserTreeChildren(dept.getUuid(), deptListTemp, enable, openIndex, index + 1);
                    if(null!=userlist&&userlist.size()>0) {
                    	JSONArray tempArray = jsonObject.getJSONArray("children");
                    	tempArray.addAll(jsonArrayTemp);
                    	jsonObject.put("children", tempArray);
                    }else {
                    	jsonObject.put("children", jsonArrayTemp);
                    }
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

	/**
	 * 获取部门下的子部门uuid
	 * @param allDept
	 * @return
	 */
	@Override
	public StringBuilder selectChindrenDeptUuid(List<Dept> allDept) {
		StringBuilder deptUuid = new StringBuilder();
		if (ToolUtil.isNotEmpty(allDept) && allDept.size() > 0) {
			for (int i = 0; i < allDept.size(); i++) {
				if (ToolUtil.isNotEmpty(allDept.get(i))) {
					if (i == (allDept.size() - 1)) {
						deptUuid.append("'").append(allDept.get(i).getUuid()).append("'");
					} else {
						deptUuid.append("'").append(allDept.get(i).getUuid()).append("'").append(",");
					}
				}
			}
		}
		return deptUuid;
	}

	/**
	 * 部门下的子部门（包含该部门）
	 * @param deptid
	 * @return
	 */
	@Override
	public List<Dept> selectChindrenDept(String deptid) {
		List<Dept> allDept=new ArrayList<Dept>();
		Dept dept=(Dept) deptDao.getBy("uuid", deptid);
		System.out.println("");
		if(dept.getChildren() != null && dept.getChildren().size() > 0) {
			allDept.add(dept);
			Set<Dept> childrenDepts=dept.getChildren();
			List<Dept> temp=new ArrayList<Dept>();
			for(Dept childrenDept:childrenDepts) {
				if (childrenDept.getChildren() != null && childrenDept.getChildren().size() > 0) {
					temp=selectChindrenDept(childrenDept.getUuid());
					allDept.addAll(temp);
				}else {
					allDept.add(childrenDept);
				}
			}
		}else {
			allDept.add(dept);
		}
		return allDept;
	}

	@Override
	public void changeDeptName(String uuid, String oldname, String newname) {
		List<Dept> list = selectChindrenDept(uuid);
		if (null != list & list.size() > 0) {
			for (Dept deptTemp : list) {
				String pnamePath=deptTemp.getPnamepath();
				deptTemp.setPnamepath(pnamePath.replace(oldname, newname));
				deptDao.save(deptTemp);
			}
		}
	}
	
	@Override
	public void changeDeptPid(String uuid, String oldpid,String newpid,String oldname,String newname) {
		List<Dept> list = selectChindrenDept(uuid);
		if (null != list & list.size() > 0) {
			for (Dept deptTemp : list) {
				String pidPath=deptTemp.getPidpath();
				String pnamePath=deptTemp.getPnamepath();
				deptTemp.setPidpath(pidPath.replace(oldpid, newpid));
				deptTemp.setPnamepath(pnamePath.replace(oldname, newname));
				deptDao.save(deptTemp);
			}
		}
	}

}
