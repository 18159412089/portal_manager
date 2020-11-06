package cn.fjzxdz.frame.controller;

import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;

import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

@RestController
@RequestMapping("file")
public class FileController extends BaseController {

	@Autowired
	private IMongoAttachFile iMongoAttachFile;

	@Autowired
	private MongoTemplate mongoTemplate;

	/**
	 * 上传文件
	 */
	@RequestMapping("/upload")
	public MongoAttachFile uploadFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
			throws Exception {
		String originFilename = multipartFile.getOriginalFilename();
		MongoAttachFile mongoAttachFile = new MongoAttachFile();
		if (ToolUtil.isNotEmpty(originFilename)) {
			mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
					StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
		}
		return mongoAttachFile;
	}

	/**
	 * 访问文件
	 */
	@RequestMapping(value = "/download/{fileId}")
	public void getFile(@PathVariable String fileId, HttpServletResponse response) {
		try {
			GridFSFile gridfs = iMongoAttachFile.getFile(fileId);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(),"utf-8"));
			OutputStream out = response.getOutputStream();
			getGridFs().downloadToStream(gridfs.getId(), out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected GridFSBucket getGridFs() {
		MongoDatabase db = mongoTemplate.getDb();
		return GridFSBuckets.create(db);
	}
}
