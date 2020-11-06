package com.fjzxdz.ams;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.bson.types.ObjectId;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.GridFSDownloadStream;
import com.mongodb.client.gridfs.model.GridFSFile;

@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(true)
public class MongoTest {

	@Autowired
	private GridFsTemplate gridFsTemplate;
	
	@Autowired
	private MongoTemplate mongoTemplate;

    @Test
    public void contextLoads() throws IllegalStateException, IOException {
    	System.out.println("===============");
    	 File file = new File("E:\\00000.jpg");
    	 InputStream ins = new FileInputStream("E:\\00000.jpg");  
    	 System.out.println("==============="+gridFsTemplate);
//         // 将文件存储到mongodb中,mongodb 将会返回这个文件的具体信息  
         ObjectId gfs = gridFsTemplate.store(ins, "00000.jpg", "jpg");  
         System.out.println("======="+gfs.toString());
         Query query = new Query(Criteria.where("_id").is(gfs.toString()));
         GridFSFile sfile = gridFsTemplate.findOne(query);
         System.out.println("==========="+sfile.getFilename());
         GridFSBucket gridFSBucket = GridFSBuckets.create(mongoTemplate.getDb());
         
         OutputStream out=new FileOutputStream("E://000007.jpg");
         gridFSBucket.downloadToStream(sfile.getObjectId(), out);
//         
//         GridFSDownloadStream gridFSDownloadStream = gridFSBucket.openDownloadStream(sfile.getObjectId());
//         GridFsResource gridFsResource =  new GridFsResource(sfile, gridFSDownloadStream);
//         System.out.println(gridFsResource.getFilename()+"=========="+gridFsResource.getInputStream());
//         IOUtils.copy(gridFsResource.getInputStream(), out);
         
         //gridFsTemplate.delete(query);
	}
}
