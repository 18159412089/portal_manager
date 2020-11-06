package cn.fjzxdz.frame.listener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.beans.factory.annotation.Autowired;

import cn.fjzxdz.frame.service.PersistenceService;

@WebListener
public class UpgradeDbListener implements ServletContextListener {
	@Autowired
	private PersistenceService persistenceService;
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
    	File file = new File(System.getProperty("user.dir")+File.separator+"脚本.txt");
    	BufferedReader br = null;
		if (file.exists()) {
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis,"GBK");
				br = new BufferedReader(isr);
				String lineTxt = null;
				while ((lineTxt = br.readLine()) != null) {
					try {
						if (lineTxt.endsWith(";")) {
							persistenceService.upgrade(lineTxt.substring(0, lineTxt.length()-1));
						} else {
							persistenceService.upgrade(lineTxt);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null) {
						fis.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				file.delete();
			}
		}
    }
 
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
 
    }
}