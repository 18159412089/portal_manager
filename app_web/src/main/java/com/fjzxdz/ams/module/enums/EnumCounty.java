package com.fjzxdz.ams.module.enums;

public enum EnumCounty {
	// 漳州市的县枚举类型
	YUNXIAO("yunxiao", "云霄县"), NANJING("nanjing", "南靖"),SHAOAN("shaoa","绍安县"),PINGHE("pinghe","平和县"),
	HUAAN("huaan","华安县"),LONGHAI("longhai","龙海市"),XIANGCHENG("xiangcheng","芗城区"),CHANGTAI("changtai","长泰县"),
	ZHANGPU("zhangpu","漳浦县");
	
	private String key;
	private String value;

	EnumCounty(String key, String value) {
		this.key = key;
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public static EnumCounty getEnumByKey(String key) {
		if (null == key)
			return null;
		EnumCounty enumcounty[] = values();
		int i = enumcounty.length;
		for (int j = 0; j < i; j++) {
			EnumCounty colorenum = enumcounty[j];
			if (colorenum.getKey().equals(key))
				return colorenum;
		}
		return null;
	}

	public String getKey() {
		return key;
	}
}
