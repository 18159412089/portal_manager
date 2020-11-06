package cn.fjzxdz.frame.license.auto;

import java.io.File;
import java.net.URLDecoder;
import java.util.Date;
import java.util.Random;

import cn.fjzxdz.frame.license.utils.HardwareLicenseValidator;
import cn.fjzxdz.frame.license.entity.License;
import cn.fjzxdz.frame.license.security.RSATool;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;


public class AutoLink {

	private static AutoLink INSTANCE = new AutoLink();

	private AutoLink() {

	}

	public static AutoLink getInstance() {
		return INSTANCE;
	}

	private String hardWareCodeEncrypted;
	private boolean lic = true;
	private long latestServerTime;
	private boolean serverTimeOk = License.getInstance().isServerTimeOk();

	private AutoAuth validator = new AutoAuth();
	private String licenseType;

	public void init(String productCode) throws Exception {
		this.initOk();
		this.initHardwareInfo();
		this.initLicenseStatus(productCode);
		this.initServerTime();
	}

	private void initOk() {
		this.lic = true;
	}

	private void initServerTime() {
		if (this.serverTimeOk) {
			long now = new Date().getTime();
			if (now >= this.latestServerTime) {
				this.latestServerTime = now;
				this.saveServerTimerFile(now);
			} else {
				this.serverTimeOk = false;
			}
		}
	}

	private void saveServerTimerFile(long now) {
		try {
			String dir = System.getProperty("java.io.tmpdir");
			String serverTimeFilePath = String.format(
					RSATool.decrypt(License.SERVER_TIME_FILE), dir);

			File serverTimeFile = new File(serverTimeFilePath);
			License.getInstance().saveNewServerTime(serverTimeFile, now);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void initLicenseStatus(String productCode) throws Exception {
		String path = URLDecoder.decode(AutoLink.class.getResource("/")
				.getPath() + RSATool.decrypt("HMOzLlbJ1etX/VJelRf+bQ=="),
				"UTF-8");
		File file = new File(path);

		if (!file.exists()) {
			this.lic = false;
			return;
		}

		try {
			String dataStr = FileUtils.readFileToString(file, "UTF-8");
			String[] data = dataStr.split(":");
			String desKeyEncrypted = data[0];
			String dataEncrypted = data[1];

			this.process(productCode, this.getHardwareCode(), desKeyEncrypted,
					dataEncrypted);
		} catch (Exception e) {
			this.lic = false;
			throw e;
		}
	}

	private void process(String productCode, String hardwareCode,
			String desKeyEncrypted, String dataEncrypted) throws Exception {
		String desKey = AutoServer.decrypt(desKeyEncrypted);
		String data = AutoServer.decryptDes(dataEncrypted, desKey);
		data = URLDecoder.decode(data, "UTF-8");

		JSONObject license = new JSONObject(data);
		this.licenseType = this.getString(license,
				HardwareLicenseValidator.LICENSE_TYPE, "");

		if (!this.checkProductOK(productCode, license))
			this.lic = false;

		if (!this.checkExpireDateOK(license))
			this.lic = false;

		if (!this.licenseType.equalsIgnoreCase("BINDINGHARDWARE"))
			this.lic = true;
		else
			this.lic = this.validator.isValid(productCode, hardwareCode, data);
	}

	private boolean checkProductOK(String productCode, JSONObject license)
			throws Exception {
		String licenseProduceCode = license
				.getString(AutoAuth.LICENSE_PRODUCT_CODE);
		return licenseProduceCode.equals(productCode);
	}

	private boolean checkExpireDateOK(JSONObject license) throws Exception {
		long expireTime = license.getLong(AutoAuth.LICENSE_EXPIRE_DATE);
		long now = new Date().getTime();

		return expireTime >= now;
	}

	private String getString(JSONObject data, String key, String defaultValue)
			throws Exception {
		if (data.has(key))
			return data.getString(key);
		return defaultValue;
	}

	private void initHardwareInfo() throws Exception {
		String hardwareInfo = AutoHdUtils.getHardwareInfo();
		this.hardWareCodeEncrypted = RSATool.encrypt(hardwareInfo);
	}

	public boolean isServerTimeOk() {
		return this.serverTimeOk;
	}

	public boolean hasNoError(String url) {
		try {
			if (url.contains(RSATool.decrypt("8WZx/cHMgFTStABbyc76iA==")))
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (this.lic)
			return this.lic;
		else
			return this.randomLicense();
	}

	private boolean randomLicense() {
		Random rand = new Random();
		int i = rand.nextInt(100);
		if (i > 80)
			return true;
		else
			return false;
	}

	public String getHardwareCode() {
		try {
			return RSATool.decrypt(hardWareCodeEncrypted);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static void main(String[] args) throws Exception {
		// String dir = System.getProperty("java.io.tmpdir");
		// String serverTimeFilePath = String.format(
		// RSATool.decrypt(License.SERVER_TIME_FILE), dir);
		// System.out.println(serverTimeFilePath);

		System.out.println(RSATool.decrypt("8WZx/cHMgFTStABbyc76iA=="));
	}
}
