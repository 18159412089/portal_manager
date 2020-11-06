package cn.fjzxdz.frame.license;

import java.io.File;
import java.sql.Timestamp;
import java.util.Date;

import cn.fjzxdz.frame.license.auto.Auto;
import cn.fjzxdz.frame.license.entity.License;
import cn.fjzxdz.frame.license.security.RSATool;
import cn.fjzxdz.frame.license.utils.Utils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * @author dai
 */
@Component
@Order(value = 2)
public class LicenseInitializer implements CommandLineRunner {
	private static Log log = LogFactory.getLog(LicenseInitializer.class);

	public void init()  {
		this.doInit();
	}

	private void doInit() {
		Timestamp startTime = Utils.getTimestamp();
		try {
			System.out.println("LicenseInitializer初始化开始。。。");
			// 初始化时间
			this.doInitServerTime();
			// 初始化授权信息
			this.doInitLicense();
			//初始化定时检查License
			new Auto();
			System.out.println("LicenseInitializer初始化结束。。。");
		} catch (Exception e) {
			System.err.println(e.getMessage());
			log.error(Utils.getOriginalMessageFromException(e), e);
		}
	}

	private void doInitServerTime() throws Exception {
		String dir = System.getProperty("java.io.tmpdir");
		String serverTimeFilePath = String.format(
				RSATool.decrypt(License.SERVER_TIME_FILE), dir);

		long now = new Date().getTime();
		File serverTimeFile = new File(serverTimeFilePath);
		if (!serverTimeFile.exists()) {
			License.getInstance().saveNewServerTime(serverTimeFile, now);
		} else {
			String data = RSATool.decrypt(FileUtils.readFileToString(
					serverTimeFile, "UTF-8"));
			long lastTime = 0;
			try {
				lastTime = Long.valueOf(data);
			} catch (Exception e) {
				e.printStackTrace();
				log.error("ServerTime reset for error.");
				License.getInstance().saveNewServerTime(serverTimeFile, now);
				return;
			}
			if (now > lastTime) {
				License.getInstance().saveNewServerTime(serverTimeFile, now);
			} else {
				License.getInstance().setServerTimeOk(false);
			}
		}
	}

	private void doInitLicense() throws Exception {
		License.getInstance().init(ProductCode.PRODUCT_CODE);
	}

	public static void main(String[] args) throws Exception {
		String dir = System.getProperty("java.io.tmpdir");
		String serverTimeFile = String.format(
				RSATool.decrypt(License.SERVER_TIME_FILE), dir);
		try {
			new File(serverTimeFile).delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void run(String... args) throws Exception {
		init();
	}
}