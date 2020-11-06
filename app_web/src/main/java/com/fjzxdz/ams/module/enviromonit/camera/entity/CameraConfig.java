package com.fjzxdz.ams.module.enviromonit.camera.entity;

public class CameraConfig {

	private static CameraConfig cameraConfig;

	private String opUserUuid;
	private String subSystemCode;
	private Integer allChildren;

	public CameraConfig() {
		this.opUserUuid = "cc78be40ec8611e78168af26905e6f0f";
		this.subSystemCode = "2097152";
		this.allChildren = 0;
	}

	public static CameraConfig getInstance() {
		if (cameraConfig == null) {
			cameraConfig = new CameraConfig();
		}

		return cameraConfig;
	}

	public String getOpUserUuid() {
		return opUserUuid;
	}

	public void setOpUserUuid(String opUserUuid) {
		this.opUserUuid = opUserUuid;
	}

	public String getSubSystemCode() {
		return subSystemCode;
	}

	public void setSubSystemCode(String subSystemCode) {
		this.subSystemCode = subSystemCode;
	}

	public Integer getAllChildren() {
		return allChildren;
	}

	public void setAllChildren(Integer allChildren) {
		this.allChildren = allChildren;
	}
}
