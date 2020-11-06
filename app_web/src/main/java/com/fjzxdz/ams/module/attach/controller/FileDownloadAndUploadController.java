package com.fjzxdz.ams.module.attach.controller;

import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.Result;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.util.ResultUtil;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@RestController
@RequestMapping("/fileDownloadAndUpload")
public class FileDownloadAndUploadController {

	@Autowired
	private IMongoAttachFile iMongoAttachFile;

	@Autowired
	private MongoTemplate mongoTemplate;


	/**
	 * 上传文件
	 */
	@RequestMapping("/upload")
	public Result uploadFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
			throws Exception {
		String originFilename = multipartFile.getOriginalFilename();
		MongoAttachFile mongoAttachFile = new MongoAttachFile();
		if (ToolUtil.isNotEmpty(originFilename)) {
			mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
					StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
		}
		return ResultUtil.getOkResult(mongoAttachFile);
	}

	/**
	 * 多文件上传
	 * @param multipartFiles
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/multiUpload")
	@ResponseBody
	public Result multiUploadFile(@RequestParam("file") List<MultipartFile> multipartFiles, HttpServletRequest request) throws Exception {
		StringBuilder fileIdBuilder = new StringBuilder();
		MongoAttachFile mongoFile = null;
		if (multipartFiles != null && !multipartFiles.isEmpty()) {
			for (MultipartFile file : multipartFiles) {
				mongoFile = saveFile(file);
				fileIdBuilder.append(mongoFile.getUuid()).append(",");
			}
		}
		mongoFile = new MongoAttachFile();
		mongoFile.setFileId(fileIdBuilder.substring(0, fileIdBuilder.length() - 1));
		return ResultUtil.getOkResult(mongoFile);
	}

	/**
	 * 保存文件
	 * @param file
	 * @return
	 * @throws Exception
	 */
	private MongoAttachFile saveFile(MultipartFile file) throws Exception {
		String originFilename = file.getOriginalFilename();
		MongoAttachFile mongoFile = new MongoAttachFile();
		if (ToolUtil.isNotEmpty(originFilename)) {
			mongoFile = iMongoAttachFile.saveFile(file.getInputStream(),
					StringUtils.getFilename(originFilename),
					StringUtils.getFilenameExtension(originFilename));
		}
		return mongoFile;
	}
	
	/*@Test
	public void aaa(){
		String apkUrl = "D:/app/com.sgkt.phone_3.0.1_2018081800.apk";
		getApkInfo(new File(apkUrl));
		
	}
	*/
	
	/**
	 * 下载附件
	 */
	@RequestMapping(value = "/download/{fileId}")
	public void getFile(@PathVariable String fileId, HttpServletResponse response) {
		try {
			GridFSFile gridfs = iMongoAttachFile.getFile(fileId);
//			response.setContentType("application/octet-stream");
			String contentType = getContentType(gridfs.getFilename());
			response.setContentType(contentType);
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(),"utf-8"));
			response.setHeader("Content-Length",String.valueOf(gridfs.getLength()));
			OutputStream out = response.getOutputStream();
			getGridFs().downloadToStream(gridfs.getId(), out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private GridFSBucket getGridFs() {
		MongoDatabase db = mongoTemplate.getDb();
		return GridFSBuckets.create(db);
	}
	
	/**
	 * 多文件具体上传时间，主要是使用了MultipartHttpServletRequest和MultipartFile
	 *
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/batch/upload", method = RequestMethod.POST)
	@ResponseBody
	public void handleFileUpload(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    List<MultipartFile> files = ((MultipartHttpServletRequest) request).getFiles("file");
	    MultipartFile file = null;
	    MongoAttachFile mongoAttachFile = null;
	    String fileId = "";
	    for (int i = 0; i < files.size(); ++i) {
	        file = files.get(i);
        	String originFilename = file.getOriginalFilename();
    		mongoAttachFile = new MongoAttachFile();
    		if (ToolUtil.isNotEmpty(originFilename)) {
    			mongoAttachFile = iMongoAttachFile.saveFile(file.getInputStream(),
    					StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
    		}
            fileId = mongoAttachFile.getUuid()+","+fileId;
	    }
	    String fileIds = fileId.substring(0, fileId.lastIndexOf(","));
	    OutputStream outputStream = response.getOutputStream();//获取OutputStream输出流
	    response.setHeader("content-type", "text/html;charset=UTF-8");//通过设置响应头控制浏览器以UTF-8的编码显示数据，如果不加这句话，那么浏览器显示的将是乱码
	    byte[] dataByteArr = fileIds.getBytes("UTF-8");//将字符转换成字节数组，指定以UTF-8编码进行转换
	    outputStream.write(dataByteArr);//使用OutputStream流向客户端输出字节数组
	    //return fileIds.substring(0, fileIds.lastIndexOf(","));
	}
	
	public static String getContentType(String filename){
		String type = null;
		Path path = Paths.get(filename);
		try {
			type = Files.probeContentType(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return type;
	}
}
