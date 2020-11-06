package cn.fjzxdz.frame.license.auto;

import org.json.JSONObject;

public class AutoAuth {

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
		String hardwareHddc = hardware.getString(AutoHdUtils.HDDC);
		String licenseHddc = license.getString(AutoHdUtils.HDDC);

		if (licenseHddc == null || hardwareHddc.equals(licenseHddc))
			return true;

		return false;
	}

	private boolean checkMotherboardOK(JSONObject hardware, JSONObject license)
			throws Exception {
		String hardwareMotherboard = hardware
				.getString(AutoHdUtils.MOTHERBOARD);
		String licenseMotherboard = license.getString(AutoHdUtils.MOTHERBOARD);

		if (licenseMotherboard == null
				|| hardwareMotherboard.equals(licenseMotherboard))
			return true;

		return false;
	}

	private boolean checkCpuOK(JSONObject hardware, JSONObject license)
			throws Exception {
		String hardwareCpu = hardware.getString(AutoHdUtils.CPU);
		String licenseCpu = license.getString(AutoHdUtils.CPU);

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
	public static final String SERVER_DATE = "SERVER_DATE";

}
