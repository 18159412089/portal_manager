package com.fjzxdz.ams.zphb.module.hbdc.service;

import java.util.List;

public interface ZpAirComplianceRateService {

	List<Object[]> getAirComplianceRate(String start, String end);

	List<Object[]> getAirComplianceRate2(String start, String end, String category);

}
