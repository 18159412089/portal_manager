package cn.fjzxdz.frame.toolbox.kit;

import javax.servlet.http.HttpServletRequest;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class IpKit {

	/**
	 * 获得客户端真实IP地址
	 * 
	 * @[author]param[/author] request
	 * @return
	 */
	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		ip = getTrueIp(ip);

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
			ip = getTrueIp(ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
			ip = getTrueIp(ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
			ip = getTrueIp(ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			ip = getTrueIp(ip);
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
			ip = getTrueIp(ip);
		}
		return ip;
	}

	/**
	 * 取真实客户端IP，过滤代理IP
	 * 
	 * @[author]param[/author] ip
	 * @return
	 */
	public static String getTrueIp(String ip) {
		if (ip == null || "".equals(ip)) {
            return null;
        }
		if (ip.indexOf(",") != -1) {
			String[] ipAddr = ip.split(",");
			for (int i = 0; i < ipAddr.length; i++) {
				if (isIp(ipAddr[i].trim()) && !ipAddr[i].trim().startsWith("10.")
						&& !ipAddr[i].trim().startsWith("172.16")) {
					return ipAddr[i].trim();
				}
			}
		} else {
			if (isIp(ip.trim()) && !ip.trim().startsWith("10.") && !ip.trim().startsWith("172.16")) {
                return ip.trim();
            }
		}
		return null;
	}

	public static boolean isIp(String addr)
	{
		 if(addr.length() < 7 || addr.length() > 15 ||"".equals(addr))
		{
		 return false;
		}
		 String rexp ="([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";
	
		 Pattern pat = Pattern.compile(rexp); 
	
		 Matcher mat = pat.matcher(addr); 
	
		 boolean ipAddress = mat.find();
	
		 return ipAddress;
	}

	public static String getRealIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static String getRealIpV2(HttpServletRequest request) {
		String accessIP = request.getHeader("x-forwarded-for");
		if (null == accessIP) {
            return request.getRemoteAddr();
        }
		return accessIP;
	}
}
