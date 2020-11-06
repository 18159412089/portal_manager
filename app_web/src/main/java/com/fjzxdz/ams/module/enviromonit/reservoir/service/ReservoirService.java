package com.fjzxdz.ams.module.enviromonit.reservoir.service;

import java.util.List;

public interface ReservoirService {
	
	List<Object[]> getConDaychart(String eqpID,Integer days);

}
