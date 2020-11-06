package cn.fjzxdz.frame.entity;

import javax.persistence.MappedSuperclass;
import javax.persistence.Version;

/**
 * 具有乐观锁的基类
 * 
 */
@MappedSuperclass
public abstract class VersionEntity extends TrackingEntity {

	private static final long serialVersionUID = 1L;

	@Version
	private int version;

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}
}
