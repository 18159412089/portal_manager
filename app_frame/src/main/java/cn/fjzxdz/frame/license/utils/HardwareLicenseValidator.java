package cn.fjzxdz.frame.license.utils;


import org.json.JSONObject;

public class HardwareLicenseValidator {

	public boolean isValid(String productCode, String hardwareCode, String data)
			throws Exception {

		JSONObject hardware = new JSONObject(hardwareCode);
		JSONObject license = new JSONObject(data);

		if (!this.checkCpuOK(hardware, license))
			return false;

		if (!this.checkMotherboardOK(hardware, license))
			return false;

		if (!this.checkHddcOK(hardware, license))
			return false;

		return true;
	}

	private boolean checkHddcOK(JSONObject hardware, JSONObject license)
			throws Exception {
		String hardwareHddc = hardware.getString(HardwareUtils.HDDC);
		String licenseHddc = license.getString(HardwareUtils.HDDC);

		if (licenseHddc == null || hardwareHddc.equals(licenseHddc))
			return true;

		return false;
	}

	private boolean checkMotherboardOK(JSONObject hardware, JSONObject license)
			throws Exception {
		String hardwareMotherboard = hardware
				.getString(HardwareUtils.MOTHERBOARD);
		String licenseMotherboard = license
				.getString(HardwareUtils.MOTHERBOARD);

		if (licenseMotherboard == null
				|| hardwareMotherboard.equals(licenseMotherboard))
			return true;

		return false;
	}

	private boolean checkCpuOK(JSONObject hardware, JSONObject license)
			throws Exception {
		String hardwareCpu = hardware.getString(HardwareUtils.CPU);
		String licenseCpu = license.getString(HardwareUtils.CPU);

		if (licenseCpu == null || hardwareCpu.equals(licenseCpu))
			return true;

		return false;
	}

	final public static String LICENSE_DATE = "LICENSE_DATE";
	final public static String LICENSE_STATUS = "LICENSE_STATUS";
	final public static String LICENSE_EXPIRE_DATE = "LICENSE_EXPIRE_DATE";
	final public static String LICENSE_TO = "LICENSE_TO";
	final public static String LICENSE_PRODUCT = "LICENSE_PRODUCT";
	final public static String LICENSE_PRODUCT_CODE = "LICENSE_PRODUCT_CODE";
	final public static String SERVER_DATE = "SERVER_DATE";

	final public static String LICENSE_MOBILE_CLIENT_QTY = "LICENSE_MOBILE_CLIENT_QTY";
	final public static String LICENSE_TYPE = "LICENSE_TYPE";
	final public static String LICENSE_DOMAIN_NAME = "LICENSE_DOMAIN_NAME";
	final public static String LICENSE_IP = "LICENSE_IP";

}
