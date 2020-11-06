package com.fjzxdz.ams.util;

import java.math.BigDecimal;

import com.fjzxdz.ams.common.generate.utils.StringUtils;
import com.fjzxdz.ams.module.enums.WaterQualityEnum;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONException;
import cn.hutool.json.JSONObject;

public class WaterQualityUtil {

	public static Boolean isCalWaterQuality(JSONArray dataArray) {
		Boolean isHaveW01001 = false, isHaveW01009 = false, isHaveW01019 = false, isHaveW21003 = false,
				isHaveW21011 = false;
		if (!dataArray.isEmpty()) {
			JSONObject row = null;
			for (int i = 0; i < dataArray.size(); i++) {
				row = dataArray.getJSONObject(i);
				switch (row.getStr("codePollute").toUpperCase()) {
				case "W01001":
					isHaveW01001 = true;
					break;
				case "W01009":
					isHaveW01009 = true;
					break;
				case "W01019":
					isHaveW01019 = true;
					break;
				case "W21003":
					isHaveW21003 = true;
					break;
				case "W21011":
					isHaveW21011 = true;
					break;
				}
			}
		}
		return isHaveW01001 && isHaveW01009 && isHaveW01019 && isHaveW21003 && isHaveW21011;
	}

	/**
	 * @param dataArray,污染物数据
	 * @param pointType(0:非湖库,1:湖库)
	 * @param targetQuality,目标水质
	 *
	 */
	public static JSONObject getWaterQuality(JSONArray dataArray, String pointType, WaterQualityEnum targetQuality) {
		JSONObject resultObject = new JSONObject();
		JSONArray excessArray = new JSONArray();
		WaterQualityEnum resultQuality = WaterQualityEnum.NONE;
		if (!dataArray.isEmpty()) {
			JSONObject row = null;
			for (int i = 0; i < dataArray.size(); i++) {
				row = dataArray.getJSONObject(i);
				resultQuality = calQualityByFactor(row, resultQuality, excessArray, targetQuality, pointType);
			}
		}
		resultObject.put("resultQuality", resultQuality);
		resultObject.put("excessFactor", excessArray);
		return resultObject;
	}

	private static WaterQualityEnum calQualityByFactor(JSONObject row, WaterQualityEnum resultQuality,
			JSONArray excessArray, WaterQualityEnum targetQuality, String pointType) {
		String codePollute = row.getStr("codePollute");
		Object tempvalue = row.get("polluteValue");
		if (tempvalue == null) {
			return resultQuality;
		}
		BigDecimal polluteValue = (BigDecimal) tempvalue;
		if (polluteValue.compareTo(new BigDecimal(0)) == 0) {
			return resultQuality;
		}
		WaterQualityEnum tempQuality = WaterQualityEnum.NONE;
		switch (codePollute.toUpperCase()) {
		// pH
		case "W01001":
			if (polluteValue.compareTo(new BigDecimal(6)) == -1 || polluteValue.compareTo(new BigDecimal(9)) == 1) {
				tempQuality = WaterQualityEnum.OTHER;
			} else {
				tempQuality = WaterQualityEnum.FIRSR;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		case "W01009":
			if (polluteValue.compareTo(new BigDecimal(7.5)) >= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(6)) >= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(5)) >= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(3)) >= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) >= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		// 高锰酸盐指数
		case "W01019":
			if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		case "W01018":
			if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(20)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(30)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(40)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		case "W01017":
			if (polluteValue.compareTo(new BigDecimal(3)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		// 氨氮
		case "W21003":
			if (polluteValue.compareTo(new BigDecimal(0.15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(0.5)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(1)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(1.5)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		// 总磷
		case "W21011":
			if ("0".equals(pointType)) {
				if (polluteValue.compareTo(new BigDecimal(0.02)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.3)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.4)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			} else {
				if (polluteValue.compareTo(new BigDecimal(0.01)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.025)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.05)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		// 总氮:0.2 0.5 1 1.5 2
		case "W21001":
			if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(0.5)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(1)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(1.5)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			excessArray.add(row);
			if (tempQuality.compareTo(resultQuality) > 0) {
				resultQuality = tempQuality;
			}
			break;
		default:
			break;
		}
		return resultQuality;
	}

	public static WaterQualityEnum calQualityBySingleFactor(String codePollute, String polluteVal,
			WaterQualityEnum targetQuality, String pointType) {
		if (StringUtils.isNull(polluteVal)) {
			return WaterQualityEnum.NONE;
		}
		BigDecimal polluteValue = new BigDecimal(polluteVal);
		if (polluteValue.compareTo(new BigDecimal(0)) == 0) {
			return WaterQualityEnum.NONE;
		}
		WaterQualityEnum tempQuality = WaterQualityEnum.NONE;
		switch (codePollute) {
		case "W01001":
			if (polluteValue.compareTo(new BigDecimal(6)) == -1 || polluteValue.compareTo(new BigDecimal(9)) == 1) {
				tempQuality = WaterQualityEnum.OTHER;
			} else {
				tempQuality = WaterQualityEnum.FIRSR;
			}
			break;
		// 溶解氧
		case "W01009":
			if (polluteValue.compareTo(new BigDecimal(7.5)) >= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(6)) >= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(5)) >= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(3)) >= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) >= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			break;
		// 高锰酸盐指数
		case "W01019":
			if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			break;
		// 化学需氧量
		case "W01018":
			if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(20)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(30)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(40)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			break;
		// 五日生化需氧量
		case "W01017":
			if (polluteValue.compareTo(new BigDecimal(3)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			break;
		// 氨氮
		case "W21003":
			if (polluteValue.compareTo(new BigDecimal(0.15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(0.5)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(1)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(1.5)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			break;
		case "W21011":
			if ("0".equals(pointType)) {
				if (polluteValue.compareTo(new BigDecimal(0.02)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.3)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.4)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			} else {
				if (polluteValue.compareTo(new BigDecimal(0.01)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.025)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.05)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			}
			break;
		default:
			break;
		}
		return tempQuality;
	}

	/**
	 * 格式化水质
	 *
	 * @param s
	 *            格式：FIRSR。。。
	 * @return FIRSR --》1
	 */
	public static int formatVal(String s) {
		int a = 0;
		switch (s) {
		case "FIRSR":
			a = 1;
			break;
		case "SECOND":
			a = 2;
			break;
		case "THIRD":
			a = 3;
			break;
		case "FOURTH":
			a = 4;
			break;
		case "FIFTH":
			a = 5;
			break;
		default:
			a = 10;
		}
		return a;
	}

	/**
	 * 格式化水质
	 *
	 * @param s
	 *            格式：Ⅰ。。。
	 * @return Ⅰ--》1
	 */
	public static int formatVal2(String s) {
		int a = 0;
		switch (s) {
		case "Ⅰ":
			a = 1;
			break;
		case "Ⅱ":
			a = 2;
			break;
		case "Ⅲ":
			a = 3;
			break;
		case "Ⅳ":
			a = 4;
			break;
		case "Ⅴ":
			a = 5;
			break;
		default:
			a = 10;
		}
		return a;
	}

	/**
	 * 根据污染源因子代码及监测值判断相应水质级别及是否超标
	 * 
	 * @param codePollute
	 * @param codeValue
	 * @param targetQuality
	 * @param pointType
	 * @return
	 * @throws JSONException
	 */
	public static org.json.JSONObject getQualityByFactor(String codePollute, Object codeValue,
			WaterQualityEnum targetQuality, String pointType) throws JSONException {
		org.json.JSONObject row = new org.json.JSONObject();
		row.put("resultQuality", "");
		row.put("isExcess", false);
		row.put("flag", "N");

		if (codeValue == null) {
			return row;
		}
		
		BigDecimal polluteValue = BigDecimal.valueOf(Double.parseDouble(String.valueOf(codeValue)));
		if (polluteValue.compareTo(new BigDecimal(0)) == 0) {
			return row;
		}
		WaterQualityEnum tempQuality = WaterQualityEnum.NONE;
		switch (codePollute.toUpperCase()) {
		// pH 值：6~9
		case "W01001":
			if (polluteValue.compareTo(new BigDecimal(6)) == -1 || polluteValue.compareTo(new BigDecimal(9)) == 1) {
				tempQuality = WaterQualityEnum.OTHER;
			} else {
				tempQuality = WaterQualityEnum.FIRSR;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		case "W01009":
			if (polluteValue.compareTo(new BigDecimal(7.5)) >= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(6)) >= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(5)) >= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(3)) >= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) >= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		// 高锰酸盐指数:2 4 6 10 15
		case "W01019":
			if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		case "W01018":
			if (polluteValue.compareTo(new BigDecimal(15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(20)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(30)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(40)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		// 五日生化需氧:3 3 4 6 10
		case "W01017":
			if (polluteValue.compareTo(new BigDecimal(3)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(4)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(6)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(10)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		case "W21003":
			if (polluteValue.compareTo(new BigDecimal(0.15)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(0.5)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(1)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(1.5)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		case "W21011":
			if ("0".equals(pointType)) {
				if (polluteValue.compareTo(new BigDecimal(0.02)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.3)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.4)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			} else {
				if (polluteValue.compareTo(new BigDecimal(0.01)) <= 0) {
					tempQuality = WaterQualityEnum.FIRSR;
				} else if (polluteValue.compareTo(new BigDecimal(0.025)) <= 0) {
					tempQuality = WaterQualityEnum.SECOND;
				} else if (polluteValue.compareTo(new BigDecimal(0.05)) <= 0) {
					tempQuality = WaterQualityEnum.THIRD;
				} else if (polluteValue.compareTo(new BigDecimal(0.1)) <= 0) {
					tempQuality = WaterQualityEnum.FOURTH;
				} else if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
					tempQuality = WaterQualityEnum.FIFTH;
				} else {
					tempQuality = WaterQualityEnum.OTHER;
				}
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		case "W21001":// 总氮:0.2 0.5 1 1.5 2
			if (polluteValue.compareTo(new BigDecimal(0.2)) <= 0) {
				tempQuality = WaterQualityEnum.FIRSR;
			} else if (polluteValue.compareTo(new BigDecimal(0.5)) <= 0) {
				tempQuality = WaterQualityEnum.SECOND;
			} else if (polluteValue.compareTo(new BigDecimal(1)) <= 0) {
				tempQuality = WaterQualityEnum.THIRD;
			} else if (polluteValue.compareTo(new BigDecimal(1.5)) <= 0) {
				tempQuality = WaterQualityEnum.FOURTH;
			} else if (polluteValue.compareTo(new BigDecimal(2)) <= 0) {
				tempQuality = WaterQualityEnum.FIFTH;
			} else {
				tempQuality = WaterQualityEnum.OTHER;
			}
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		default:// 当需要判断的因子不在判断范围内时，统一使用WaterQualityEnum.NONE赋值
			tempQuality = WaterQualityEnum.NONE;
			row.put("resultQuality", tempQuality);
			if (targetQuality.compareTo(WaterQualityEnum.NONE) > 0 && tempQuality.compareTo(targetQuality) > 0) {
				row.put("isExcess", true);
			} else {
				row.put("isExcess", false);
			}
			break;
		}
		return row;
	}

	public static void main(String[] args) {
		JSONArray dataArray = new JSONArray();
		JSONObject temp1 = new JSONObject();
		temp1.put("codePollute", "W01001");
		temp1.put("polluteValue", new BigDecimal(String.valueOf(7.19)));
		temp1.put("polluteName", "PH值");
		dataArray.add(temp1);
		JSONObject temp2 = new JSONObject();
		temp2.put("codePollute", "W21011");
		temp2.put("polluteValue", new BigDecimal(String.valueOf(0.085)));
		temp2.put("polluteName", "总磷（以P计）");
		dataArray.add(temp2);
		JSONObject temp3 = new JSONObject();
		temp3.put("codePollute", "W01009");
		temp3.put("polluteValue", new BigDecimal(String.valueOf(7.64)));
		temp3.put("polluteName", "溶解氧");
		dataArray.add(temp3);
		JSONObject temp4 = new JSONObject();
		temp4.put("codePollute", "W01019");
		temp4.put("polluteValue", new BigDecimal(String.valueOf(3.65)));
		temp4.put("polluteName", "高锰酸盐指数");
		dataArray.add(temp4);
		JSONObject temp5 = new JSONObject();
		temp5.put("codePollute", "W01018");
		temp5.put("polluteValue", new BigDecimal(String.valueOf(0.012)));
		temp5.put("polluteName", "化学需氧量（COD）");
		dataArray.add(temp5);
		JSONObject temp6 = new JSONObject();
		temp6.put("codePollute", "w01017");
		temp6.put("polluteValue", new BigDecimal(String.valueOf(4.20)));
		temp6.put("polluteName", "五日生化需氧量（BOD5");
		dataArray.add(temp6);
		JSONObject temp7 = new JSONObject();
		temp7.put("codePollute", "W21003");
		temp7.put("polluteValue", new BigDecimal(String.valueOf(0.97)));
		temp7.put("polluteName", "氨氮");
		dataArray.add(temp7);
		String pointType = "0";
		WaterQualityEnum targetQuality = WaterQualityEnum.SECOND;
		System.out.println("=======" + WaterQualityUtil.isCalWaterQuality(dataArray));
		JSONObject resultQuality = WaterQualityUtil.getWaterQuality(dataArray, pointType, targetQuality);
		System.out.println(resultQuality.toString());
	}

}
