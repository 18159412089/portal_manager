package cn.fjzxdz.frame.license.entity;

public class LicenseData {

	private String licenseDate;
	private String licenseExpireDate;
	private String licenseTo;
	private String product;
	private int mobileClientQty;
	private String licenseType;
	private String licenseDomainName;
	private String licenseIp;
	private String productCode;
	private long expireTime;

	public LicenseData(String licenseDate, String licenseExpireDate,
			String licenseTo, String product, String productCode,
			int mobileClientQty, String licenseType, String licenseDomainName,
			String licenseIp, long expireTime) {
		this.licenseDate = licenseDate;
		this.licenseExpireDate = licenseExpireDate;
		this.licenseTo = licenseTo;
		this.product = product;
		this.productCode = productCode;

		this.mobileClientQty = mobileClientQty;
		this.licenseType = licenseType;
		this.licenseDomainName = licenseDomainName;
		this.licenseIp = licenseIp;
		this.expireTime = expireTime;
	}

	public String getLicenseDate() {
		return licenseDate;
	}

	public void setLicenseDate(String licenseDate) {
		this.licenseDate = licenseDate;
	}

	public String getLicenseExpireDate() {
		return licenseExpireDate;
	}

	public void setLicenseExpireDate(String licenseExpireDate) {
		this.licenseExpireDate = licenseExpireDate;
	}

	public String getLicenseTo() {
		return licenseTo;
	}

	public void setLicenseTo(String licenseTo) {
		this.licenseTo = licenseTo;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public int getMobileClientQty() {
		return mobileClientQty;
	}

	public void setMobileClientQty(int mobileClientQty) {
		this.mobileClientQty = mobileClientQty;
	}

	public String getLicenseType() {
		return licenseType;
	}

	public void setLicenseType(String licenseType) {
		this.licenseType = licenseType;
	}

	public String getLicenseDomainName() {
		return licenseDomainName;
	}

	public void setLicenseDomainName(String licenseDomainName) {
		this.licenseDomainName = licenseDomainName;
	}

	public String getLicenseIp() {
		return licenseIp;
	}

	public void setLicenseIp(String licenseIp) {
		this.licenseIp = licenseIp;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public long getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(long expireTime) {
		this.expireTime = expireTime;
	}

}
