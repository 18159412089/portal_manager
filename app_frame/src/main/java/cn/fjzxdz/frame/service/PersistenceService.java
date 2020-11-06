package cn.fjzxdz.frame.service;

import cn.fjzxdz.frame.entity.AlEntity;

public interface PersistenceService {
    void add(AlEntity entity);

    AlEntity update(AlEntity entity);

    void delete(AlEntity entity) throws Exception;
    
    void upgrade(String sql);
}
