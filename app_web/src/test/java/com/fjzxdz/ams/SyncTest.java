package com.fjzxdz.ams;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.dao.sys.DeptDao;
import cn.fjzxdz.frame.entity.core.Dept;
import cn.fjzxdz.frame.entity.core.Job;
import cn.fjzxdz.frame.entity.core.LoginType;
import cn.fjzxdz.frame.entity.core.Role;
import cn.fjzxdz.frame.entity.core.User;
import cn.fjzxdz.frame.toolbox.util.MD5Util;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(false)
public class SyncTest {

	@Autowired
	private DeptDao deptDao;
	@Autowired
	private SimpleDao simpleDao;
	
	private static Connection conn = null;
    
    private static String driver = "oracle.jdbc.driver.OracleDriver"; //驱动
     
    private static String url = "jdbc:oracle:thin:@192.169.8.247:1521:orcl"; //连接字符串
     
    private static String username = "jxba"; //用户名
     
    private static String password = "root"; //密码
    
    private Set<Role> roleSet = new HashSet<Role>();
	
	@Test
	@Transactional
	public void test() throws Exception {
		 Dept topdept = simpleDao.findUnique("from Dept d where d.parent is null or d.parent =''");
		 roleSet.add(simpleDao.get(Role.class, "70ad8763-7e46-45d7-bc73-811a34abaf49"));
		 Job topjob = new Job();
		 topjob.setEnable(1);
		 topjob.setName("民警");
		 topjob.setDept(topdept);
		 topjob.setRoles(roleSet);
		 simpleDao.add(topjob);
		 if(conn == null){
	            try {
	                Class.forName(driver);
	                conn = DriverManager.getConnection(url, username, password);
	            } catch (ClassNotFoundException e) {
	                e.printStackTrace();
	            }catch (SQLException e) {
	                e.printStackTrace();
	            }
	     }
		 PreparedStatement pstmt;
         	Map<String,String> deptIdMap = new HashMap<String,String>();
	        try {
	            pstmt = conn.prepareStatement("select id,parent_id,name from IM_DEPARTMENT where PARENT_ID = '340500000000'");
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	                String name = rs.getString("name");
	                Dept tempDept = new Dept();
	                tempDept.setName(name);
	                tempDept.setParent(topdept);
	                tempDept.setEnable(1);
	                tempDept.setPidpath(topdept.getPidpath());
	                tempDept.setPnamepath(topdept.getPnamepath()+"/"+tempDept.getName());
	                simpleDao.add(tempDept);
	                tempDept.setPidpath(topdept.getPidpath()+"/"+tempDept.getUuid());
	            	deptDao.save(tempDept);
	                Job job = new Job();
	                job.setEnable(1);
	                job.setName("民警");
	                job.setDept(tempDept);
					job.setRoles(roleSet);
					simpleDao.add(job);
	                deptIdMap.put(rs.getString("id"),tempDept.getUuid());
	                addChildren(rs.getString("id"),deptIdMap,tempDept);
	            }
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        
	        try {
	            pstmt = conn.prepareStatement("select u.id,p.department_id,u.login_id,u.name,u.contact from IM_USER u inner join IM_DEPARTMENT_POSITION p on u.id=p.USER_ID where login_id !='10000'");
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	User user = new User();
	            	user.setEnable(1);
	            	user.setLogintype(LoginType.SYSTEM);
	            	user.setName(rs.getString("name"));
	            	user.setLoginname(rs.getString("login_id"));
	            	user.setPhone(rs.getString("contact"));
	            	user.setSex(1);
	            	user.setPassword(MD5Util.encode("123456"));
	            	simpleDao.add(user);
	            	Job j=null;
	            	if (deptIdMap.containsKey(rs.getString("department_id"))) {
						j = simpleDao.findUnique("from Job where dept.uuid=?", deptIdMap.get(rs.getString("department_id")));
					} else {
						j=topjob;
					}
	            	simpleDao.createNativeQuery(
	            			"INSERT INTO sys_job_user (job, user_id) VALUES ('"+j.getUuid()+"','"+user.getUuid()+"')")
	            	.executeUpdate();
	            }
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		 
		conn.close();
	}

	private void addChildren(String parent_id, Map<String, String> deptIdMap, Dept topdept) {
		PreparedStatement pstmt;
        try {
            pstmt = conn.prepareStatement("select id,parent_id,name from IM_DEPARTMENT where PARENT_ID = '"+parent_id+"'");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                Dept tempDept = new Dept();
                tempDept.setName(name);
                tempDept.setParent(topdept);
                tempDept.setEnable(1);
                tempDept.setPidpath(topdept.getPidpath());
                tempDept.setPnamepath(topdept.getPnamepath()+"/"+tempDept.getName());
                simpleDao.add(tempDept);
                tempDept.setPidpath(topdept.getPidpath()+"/"+tempDept.getUuid());
            	deptDao.save(tempDept);
                Job job = new Job();
                job.setEnable(1);
                job.setName("民警");
                job.setDept(tempDept);
				job.setRoles(roleSet);
				simpleDao.add(job);
                deptIdMap.put(rs.getString("id"),tempDept.getUuid());
                addChildren(rs.getString("id"),deptIdMap,tempDept);
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
		
	}
}
