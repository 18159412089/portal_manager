package cn.fjzxdz.frame.license.entity;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import cn.fjzxdz.frame.license.security.RSATool;
import cn.fjzxdz.frame.license.utils.HardwareLicenseValidator;
import cn.fjzxdz.frame.license.utils.HardwareUtils;
import cn.fjzxdz.frame.license.utils.IdGenerator;
import cn.fjzxdz.frame.license.utils.RSAServer;


public class License {

	private static License INSTANCE = new License();

	private License() {

	}

	public static License getInstance() {
		return INSTANCE;
	}

	private String productCode = "";

	private String hardWareCodeEncrypted = "";
	private String hardWareCodeForTool = "";
	private boolean hardwareLicenseOk = false;

	private boolean serverTimeOk = true;

	private HardwareLicenseValidator hardwareValidator = new HardwareLicenseValidator();
	private String licenseData = "";
	private long serverDate;
	private String licenseDataText = "";
	private LicenseData licenseDataShow;

	public void init(String productCode) throws Exception {
		this.productCode = productCode;
		this.initHardwareInfo();
		this.initLicenseStatus(productCode);
	}

	private void initLicenseStatus(String productCode) throws Exception {
		InputStream fis = null;
		byte[] filecontent = null;
		try {
			File file = new File(System.getProperty("user.dir")+File.separator+"license.lic");
			if (file.exists()) {
				fis = new FileInputStream(file);
			}else {
				fis = this.getClass().getResourceAsStream("/license.lic");
			}
			filecontent = new byte[fis.available()];
			fis.read(filecontent);
			fis.close();
		} catch (Exception e) {
			if (null!=fis) {
				fis.close();
			}
			throw new Exception("授权文件不存在，请检查resource下面是否存在license.lic文件");
		}
		String dataStr = new String(filecontent, "UTF-8");
		String[] data = dataStr.split(":");
		String desKeyEncrypted = data[0];
		String dataEncrypted = data[1];

		this.process(productCode, this.getHardwareCode(), desKeyEncrypted,
				dataEncrypted);
	}

	public boolean checkLicenseFile(String productCode, InputStream inputStream){
		try {
			String dataStr = IOUtils.toString(inputStream, "utf-8");
			String[] data = dataStr.split(":");
			String desKeyEncrypted = data[0];
			String dataEncrypted = data[1];
			String desKey = RSAServer.decrypt(desKeyEncrypted);
			String decryptData = RSAServer.decryptDes(dataEncrypted, desKey);
			URLDecoder.decode(decryptData, "UTF-8");
			return true;
		}catch (Exception e){
			return false;
		}
	}

	private void process(String productCode, String hardwareCode,
			String desKeyEncrypted, String dataEncrypted) throws Exception {
		String desKey = RSAServer.decrypt(desKeyEncrypted);
		String data = RSAServer.decryptDes(dataEncrypted, desKey);
		data = URLDecoder.decode(data, "UTF-8");

		this.setLicenseData(data);
		this.setLicenseDataShow(data);
		this.setLicenseDataText(data);

		if (this.licenseDataShow.getLicenseType().equalsIgnoreCase(
				"BINDINGHARDWARE"))
			this.hardwareLicenseOk = this.hardwareValidator.isValid(
					productCode, hardwareCode, data);
	}

	private void setLicenseDataShow(String data) throws Exception {
		JSONObject licenseInfoData = new JSONObject(data);

		String licenseDate = this.getDate(licenseInfoData
				.getLong(HardwareLicenseValidator.LICENSE_DATE));
		String licenseExpireDate = this.getDate(licenseInfoData
				.getLong(HardwareLicenseValidator.LICENSE_EXPIRE_DATE));
		String licenseTo = licenseInfoData
				.getString(HardwareLicenseValidator.LICENSE_TO);
		String product = licenseInfoData
				.getString(HardwareLicenseValidator.LICENSE_PRODUCT);
		String productCode = licenseInfoData
				.getString(HardwareLicenseValidator.LICENSE_PRODUCT_CODE);
		long expireTime = licenseInfoData
				.getLong(HardwareLicenseValidator.LICENSE_EXPIRE_DATE);

		int mobileClientQty = this.getInt(licenseInfoData,
				HardwareLicenseValidator.LICENSE_MOBILE_CLIENT_QTY, -1);
		String licenseType = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_TYPE, "");
		String licenseDomainName = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_DOMAIN_NAME, null);
		String licenseIp = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_IP, null);

		this.licenseDataShow = new LicenseData(licenseDate, licenseExpireDate,
				licenseTo, product, productCode, mobileClientQty, licenseType,
				licenseDomainName, licenseIp, expireTime);
	}

	private String getString(JSONObject data, String key, String defaultValue)
			throws Exception {
		if (data.has(key))
			return data.getString(key);
		return defaultValue;
	}

	private int getInt(JSONObject data, String key, int defaultValue)
			throws Exception {
		if (data.has(key))
			return data.getInt(key);
		return defaultValue;
	}

	public LicenseData getLicenseData() {
		return this.licenseDataShow;
	}

	private void setLicenseDataText(String data) throws Exception {
		JSONObject licenseInfoData = new JSONObject(data);

		String licenseDate = this.getDatetime(licenseInfoData
				.getLong(HardwareLicenseValidator.LICENSE_DATE));
		String licenseExpireDate = this.getDatetime(licenseInfoData
				.getLong(HardwareLicenseValidator.LICENSE_EXPIRE_DATE));
		String licenseTo = licenseInfoData
				.getString(HardwareLicenseValidator.LICENSE_TO);
		String product = licenseInfoData
				.getString(HardwareLicenseValidator.LICENSE_PRODUCT);

		int mobileClientQty = this.getInt(licenseInfoData,
				HardwareLicenseValidator.LICENSE_MOBILE_CLIENT_QTY, 0);
		String licenseType = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_TYPE, "");
		String licenseDomainName = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_DOMAIN_NAME, "");
		String licenseIp = this.getString(licenseInfoData,
				HardwareLicenseValidator.LICENSE_IP, "");

		List<String> items = new ArrayList<String>();
		List<Object> values = new ArrayList<Object>();

		items.add("软件名称：%s\n");
		values.add(product);

		items.add("授权给：%s\n");
		values.add(licenseTo);

		items.add("授权时间：%s\n");
		values.add(licenseDate);

		items.add("到期时间：%s\n");
		values.add(licenseExpireDate);

		if (mobileClientQty > 0) {
			items.add("授权手机客户端数量：%d\n");
			values.add(mobileClientQty);
		}

		if (licenseType.equalsIgnoreCase("BINDDOMAIN")) {
			items.add("绑定域名：%s\n");
			values.add(licenseDomainName);
		} else if (licenseType.equalsIgnoreCase("BINDIP")) {
			items.add("绑定IP：%s\n");
			values.add(licenseIp);
		} else {
			items.add("授权方式：%s\n");
			values.add("绑定硬件");
		}

		String temp = "";
		Object[] valueArray = new Object[values.size()];
		for (int i = 0; i < items.size(); i++) {
			temp = temp + items.get(i);
			valueArray[i] = values.get(i);
		}

		this.licenseDataText = String.format(temp, valueArray);
	}

	private String getDate(Long time) {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(time);

		return new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	}

	private String getDatetime(Long time) {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(time);

		return new SimpleDateFormat("yyyy年MM月dd日 HH:mm").format(cal.getTime());
	}

	private void setLicenseData(String data) throws Exception {
		this.serverDate = new Date().getTime();

		JSONObject obj = new JSONObject(data);
		obj.put(HardwareLicenseValidator.SERVER_DATE, this.serverDate);

		String desKey = IdGenerator.getNewId();
		String licenseData = RSAServer.encryptDes(
				URLEncoder.encode(obj.toString(), "UTF-8"), desKey);
		String desKeyEncrypted = RSAServer.encrypt(desKey);
		this.licenseData = String.format("%s:%s", desKeyEncrypted, licenseData);
	}

	private void initHardwareInfo() throws Exception {
		String hardwareInfo = HardwareUtils.getHardwareInfo();
		this.hardWareCodeEncrypted = RSATool.encrypt(hardwareInfo);

		String desKey = IdGenerator.getNewId();
		String licenseData = RSAServer.encryptDes(hardwareInfo, desKey);
		String desKeyEncrypted = RSAServer.encrypt(desKey);
		String data = String.format("%s:%s", desKeyEncrypted, licenseData);
		this.hardWareCodeForTool = data;
	}

	public boolean isLicenseOk(HttpServletRequest request) {
        if(true){
            return true;
        }
		if (!this.checkProductCodeOK())
			return false;
		if (!this.checkExpireTimeOk())
			return false;

		if (this.licenseDataShow.getLicenseType().equalsIgnoreCase(
				"BINDINGHARDWARE"))
			return this.hardwareLicenseOk;
		else if (this.licenseDataShow.getLicenseType().equalsIgnoreCase(
				"BINDDOMAIN"))
			return this.checkBindDomain(request);
		else if (this.licenseDataShow.getLicenseType().equalsIgnoreCase(
				"BINDIP"))
			return this.checkBindIp(request);
		else
			return false;
	}

	private boolean checkExpireTimeOk() {
		long now = new Date().getTime();

		return this.licenseDataShow.getExpireTime() >= now;
	}

	private boolean checkProductCodeOK() {
		return this.productCode.equals(this.licenseDataShow.getProductCode());
	}

	private boolean checkBindDomain(HttpServletRequest request) {
		String domain = this.getDomainOrIp(request);
		String requiredDomain = this.licenseDataShow.getLicenseDomainName();
		return domain.equals(requiredDomain);
	}

	private boolean checkBindIp(HttpServletRequest request) {
		String ip = this.getDomainOrIp(request);
		String requiredIp = this.licenseDataShow.getLicenseIp();
		return ip.equals(requiredIp);
	}

	public boolean isServerTimeOk() {
		return this.serverTimeOk;
	}

	private String getDomainOrIp(HttpServletRequest request) {
		String url = request.getRequestURL().toString();
		url = url.replaceAll("http://", "").replaceAll("https://", "");
		String[] parts = url.split("/");
		String[] domainOrIpParts = parts[0].split(":");
		return domainOrIpParts[0];
	}

	private String getHardwareCode() {
		try {
			return RSATool.decrypt(hardWareCodeEncrypted);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getHardwareCodeForTool() {
		return hardWareCodeForTool;
	}

	public void setServerTimeOk(boolean b) {
		this.serverTimeOk = b;
	}

	public String getLicenseInfoForTool() {
		return this.licenseData;
	}

	public void saveNewServerTime(File serverTimeFile, long now)
			throws Exception {
		String data = RSATool.encrypt(String.valueOf(now));
		FileUtils.writeStringToFile(serverTimeFile, data, "UTF-8");
	}

	public long getServerDate() {
		return this.serverDate;
	}

	/**
	 * 用于系统授权页面显示授权信息
	 * 
	 * @return
	 */
	public String getLicenseInfoText() {
		return this.licenseDataText;
	}

	public static final String SERVER_TIME_FILE = "qVHZuC50T2l3mCYn/HHuuw==";

	public static void main(String[] args) throws Exception {
		String s = "https://192.168.8.109/fjzxFrameWeb/product/productManagementController";
		s = s.replaceAll("http://", "").replaceAll("https://", "");
		String[] parts = s.split("/");
		String[] domainOrIpParts = parts[0].split(":");
		String domainOrIp = domainOrIpParts[0];
		System.out.println(domainOrIp);

		s = "{}";
		JSONObject obj = new JSONObject(s);
		int i = 0;
		if (obj.has("ok"))
			obj.getInt("ok");
	}
}
