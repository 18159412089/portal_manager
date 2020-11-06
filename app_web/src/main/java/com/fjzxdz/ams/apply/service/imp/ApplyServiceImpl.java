package com.fjzxdz.ams.apply.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fjzxdz.ams.apply.dao.ApplyDao;
import com.fjzxdz.ams.apply.entity.Apply;
import com.fjzxdz.ams.apply.service.ApplyService;

@Service
@Transactional()
public class ApplyServiceImpl implements ApplyService {
	@Autowired
	private ApplyDao applyDao;
	@Override
	public void save(Apply entity) {
		entity.setUuid(null);
		applyDao.save(entity);
	}

	@Override
	public Apply update(Apply entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Apply getById(String uuid) {
		// TODO Auto-generated method stub
		return null;
	}
	

}
