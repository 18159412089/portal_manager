package cn.fjzxdz.frame.license.auto;

import cn.fjzxdz.frame.license.ProductCode;
import cn.hutool.core.date.DateUtil;

import java.util.Date;


public class AutoFinTask implements Runnable {

	@Override
	public void run() {
		try {
			System.out.println("开始定时检查授权是否正常"+DateUtil.formatTime(new Date()) +"...");
			AutoLink.getInstance().init(ProductCode.PRODUCT_CODE);
			System.out.println("结束定时检查授权是否正常"+DateUtil.formatTime(new Date()) +"...");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
