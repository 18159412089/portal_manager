package cn.fjzxdz.frame.license.utils;

import cn.fjzxdz.frame.license.security.Coder;
import cn.fjzxdz.frame.license.security.DESCoder;
import cn.fjzxdz.frame.license.security.RSACoder;

public class RSAServer {

	private static String SERVER_PRIVATE_KEY;
	private static String TOOL_PUBLIC_KEY;

	static {
		SERVER_PRIVATE_KEY = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAK0iaTGEKPLgGKxUrBovOCq9UtZn"
				+ "tO/im7GKyh21TD2HwVD9rGPK/CdLHFaKXSkuLwmHpL8nqY2jbP10/gbHm4PlBryCPLR7P7onsyKF"
				+ "hNZ9xLS/yo8QLfO2AHlydC1mki/chpa4fMDyuz5VfbRsyrYe5XN58ci53BiqCN6NAC75AgMBAAEC"
				+ "gYAuMQkZweXe7rUGfUyxa7mzhXFtbJvUiIP7eUj1ZiJiJC8KebOdqFFf9mUoHaA/VWgNRdhJe757"
				+ "4Ic6lBUWH/k4ZdfJ1NR3wU2tt8dh077QyVkRECYZgPvNfxVt5Y+hdLDchZyNZQOTpLpay0cypnHz"
				+ "x1mO2M9e7Vq6Y4zxJQq/VQJBANvWJCsxdr1enPAuynV+I9Pa7hSPNxM2wg5nlP0Uo+tazH07rM0s"
				+ "ORLZrSYDPPzZsBSDlY6iMDI1zw4A2s6+mCMCQQDJnYegHQWF7eVAdhMdnkyGXd/GdkABOL/30SiV"
				+ "cbTX9pVdX6F+9MAmigjtCX8oiuYEGKiMAjip8bFs9IvgZqAzAkEAxbsnzx3vgkcOe85qViG+EfkS"
				+ "ObXTQNn408IBNV2STsfdtCqvs9+5+iWGYvF4sqkOgnUUWTWyigbyFNNZ+6lc5wJAU67hFmI1Yqul"
				+ "liXsNUT5OmRId5WpZ1hoxbG5CJ6Tk3gz8ve4jnuELfrpTYm9j9RnOJgLjWF2p4M8Q58VV+UA5QJA"
				+ "FhBQeyFTu04L3mwGggXfnBavPAailDSWtXX2MsxXumX/aCnNKdtXtmuVZcror/ITMj6fWwAhWD4z"
				+ "DCEhHQIhnw==";

		TOOL_PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCe6nAyVtwaKLEgovJEREaYWq40HYZEqPfqeNAw"
				+ "jQPI5WJXLFsDc1cfJvVZgmAtpWLcJ8T1APw2XxSppu2qMokQemXsg1h4Q5Uqvo/Yqw3MoABiz4hH"
				+ "mPBl3RP2LVuYCryl3NCJOLJlgis9JNyNEsi6k5sW7RbCZbIiCl0jX2Bn9wIDAQAB";
	}

	public static String encryptDes(String input, String desKey)
			throws Exception {
		byte[] inputData = input.getBytes();
		inputData = DESCoder.encrypt(inputData, desKey);

		return Coder.encryptBASE64(inputData);
	}

	public static String decryptDes(String input, String desKey)
			throws Exception {
		byte[] outputData = DESCoder
				.decrypt(Coder.decryptBASE64(input), desKey);
		return new String(outputData);

	}

	public static String decrypt(String input) throws Exception {
		input = input.replaceAll(" ", "");

		byte[] encodedData = Coder.decryptBASE64(input);
		byte[] decodedData = RSACoder.decryptByPrivateKey(encodedData,
				SERVER_PRIVATE_KEY);
		return new String(decodedData);
	}

	public static String encrypt(String input) throws Exception {
		byte[] data = input.getBytes();
		byte[] encodedData = RSACoder.encryptByPublicKey(data, TOOL_PUBLIC_KEY);

		return Coder.encryptBASE64(encodedData);
	}
}
