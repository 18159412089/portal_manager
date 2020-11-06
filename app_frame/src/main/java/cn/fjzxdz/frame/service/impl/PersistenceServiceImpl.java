package cn.fjzxdz.frame.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.fjzxdz.frame.dao.common.EntityDao;
import cn.fjzxdz.frame.dao.common.SimpleDao;
import cn.fjzxdz.frame.entity.AlEntity;
import cn.fjzxdz.frame.service.PersistenceService;

@Service
@Transactional(rollbackFor=Exception.class)
public class PersistenceServiceImpl implements PersistenceService {
    @Autowired
    private EntityDao entityDao;
    @Autowired
    private SimpleDao simpleDao;

    @Override
    public void add(AlEntity entity) {
        entityDao.save(entity);
    }

    @Override
    public void delete(AlEntity entity) throws Exception {
        entityDao.delete(entityDao.loadEntity(entity));
    }

    @Override
    public AlEntity update(AlEntity entity) {
        return entityDao.update(entity);
    }

	@Override
	public void upgrade(String sql) {
		simpleDao.createNativeQuery(sql).executeUpdate();
	}

}
