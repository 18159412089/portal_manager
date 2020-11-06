package cn.fjzxdz.frame.license.auto;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
/**
 * 项目启动的时候需要初始化，主要用于定时检查授权是否过期
 */
public class Auto {

	private ScheduledExecutorService executor = Executors
			.newScheduledThreadPool(1);

	public Auto() {
		super();
		this.initSchedule();
	}

	private void initSchedule() {
		executor.scheduleAtFixedRate(new AutoFinTask(), 10, 10*60*1000,
				TimeUnit.SECONDS);
	}

}
