package com.fjzxdz.ams.apply.service;

import com.fjzxdz.ams.apply.entity.Apply;
public interface ApplyService {
	void save(Apply entity);

	Apply update(Apply entity);
	Apply getById(String uuid);

}
