package cn.fjzxdz.frame.mongo.dao;


import org.springframework.data.mongodb.repository.MongoRepository;

import cn.fjzxdz.frame.mongo.models.DocFile;

public interface DocFileRepository extends MongoRepository<DocFile, String> {
}
