package com.fjzxdz.ams.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
import cn.fjzxdz.frame.config.MongoGridConfig;
import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.entity.core.MongoAttachFile;
import cn.fjzxdz.frame.mongo.service.IMongoAttachFile;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.page.PageEU;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import com.fjzxdz.ams.module.enviromonit.water.entity.WaterAttachment;
import com.fjzxdz.ams.module.enviromonit.water.param.WaterAttachmentParam;
import com.fjzxdz.ams.module.enviromonit.water.service.WaterAttachmentService;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import com.mongodb.client.gridfs.model.GridFSFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/environment/waterAttachment")
@Secured({"ROLE_USER"})
public class WaterAttachmentController extends BaseController {

    @Autowired
    private WaterAttachmentService waterAttachmentService;
    @Autowired
    private IMongoAttachFile iMongoAttachFile;
    @Autowired
    private MongoTemplate mongoTemplate;

    /**
     * 根据站点编码跳转到附件页面
     *
     * @param modelAndView
     * @param pointCode    河流站点编码
     * @return
     */
    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelAndView, String pointCode,String pid) {
        modelAndView.addObject("pointCode", pointCode);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/waterAttachmentList");
        return modelAndView;
    }

    /**
     * 根据站点编码跳转到附件页面[小流域]
     *
     * @param modelAndView
     * @param pointCode
     * @return
     */
    @RequestMapping("/river")
    public ModelAndView river(ModelAndView modelAndView, String pointCode,String pid) {
        modelAndView.addObject("pointCode", pointCode);
        modelAndView.addObject("pid", pid);
        modelAndView.setViewName("/moudles/enviromonit/water/riverAttachmentList");
        return modelAndView;
    }

    /**
     * 获取河流站点附件信息
     *
     * @param param
     * @param request
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public PageEU<WaterAttachment> list(WaterAttachmentParam param, HttpServletRequest request) {
        Page<WaterAttachment> page = pageQuery(request);
        Page<WaterAttachment> waterAttachment = waterAttachmentService.listByPage(param, page);
        return new PageEU<>(waterAttachment);
    }

    /**
     * 保存河流站点附件信息
     *
     * @param waterAttachment 保存对象
     * @param multipartFile   附件
     * @param request         请求对象
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public R save(WaterAttachment waterAttachment, @RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
        try {
            String originFilename = multipartFile.getOriginalFilename();
            MongoAttachFile mongoAttachFile = null;
            if (ToolUtil.isNotEmpty(originFilename)) {
                mongoAttachFile = iMongoAttachFile.saveFile(multipartFile.getInputStream(),
                        StringUtils.getFilename(originFilename), StringUtils.getFilenameExtension(originFilename));
                waterAttachment.setMongoid(mongoAttachFile.getUuid());
            }
            waterAttachmentService.save(waterAttachment);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 删除，删除对象和图片信息
     *
     * @param uuid
     * @param mongoid
     * @return
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public R delete(@RequestParam(value = "uuid", required = true) String uuid,
                    @RequestParam(value = "mongoid", required = true) String mongoid) {
        try {
            waterAttachmentService.delete(uuid);
            iMongoAttachFile.removeFile(mongoid);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 根据id获取附件对象
     *
     * @param uuid 主键id
     * @return
     */
    @RequestMapping(value = "/get")
    @ResponseBody
    public R get(@RequestParam(value = "uuid") String uuid) {
        WaterAttachment waterAttachment;
        try {
            waterAttachment = waterAttachmentService.getById(uuid);
        } catch (Exception e) {
            return R.error(e.getMessage());
        }
        return R.ok().put("result", waterAttachment);
    }

    /**
     * 根据河流站点编码获取对应的附件信息
     *
     * @param pointCode 站点编码
     * @return
     */
    @RequestMapping(value = "/getAttachments")
    @ResponseBody
    public List<WaterAttachment> getAttachments(@RequestParam(value = "pointCode") String pointCode) {
        return waterAttachmentService.getAttachments(pointCode);
    }

    @Autowired
    private MongoGridConfig gridConfig;

    /**
     * 访问文件
     */
    @RequestMapping(value = "/download/{fileId}/{type}")
    public void getFile(@PathVariable String fileId, @PathVariable String type, HttpServletResponse response,
                        HttpServletRequest request) {
        try {
            GridFSFile gridfs = iMongoAttachFile.getFile(fileId);
            String contentType = "_contentType";
            String name = "Content-Disposition";
            String enc = "utf-8";
            OutputStream out = null;
            if ("pdf".equals(gridfs.getMetadata().get(contentType))) {
                response.setContentType("application/pdf");
                response.setHeader(name, "fileName=" + URLEncoder.encode(gridfs.getFilename(), enc));
                Window.getWindows();
                out = response.getOutputStream();
                getGridFs().downloadToStream(gridfs.getId(), out);
                out.flush();
                out.close();
            } else if ("mp4".equals(gridfs.getMetadata().get(contentType))) {
                GridFsResource fsResource = gridConfig.convertGridFSFile2Resource(gridfs);
                BufferedInputStream bis = null;
                try {
                    if (fsResource.exists()) {
                        long p = 0L;
                        long toLength = 0L;
                        long contentLength = 0L;
                        int rangeSwitch = 0; // 0,从头开始的全文下载；1,从某字节开始的下载（bytes=27000-）；2,从某字节开始到某字节结束的下载（bytes=27000-39000）
                        long fileLength;
                        String rangBytes = "";
                        fileLength = fsResource.contentLength();

                        // 获取mongodb文件的输入流
                        InputStream ins = fsResource.getInputStream();
                        bis = new BufferedInputStream(ins);

                        // 告诉客户端允许接受范围（accept-ranges）
                        response.reset();
                        response.setHeader("Accept-Ranges", "bytes");

                        String range = request.getHeader("Range");
                        if (range != null && range.trim().length() > 0 && !"null".equals(range)) {
                            response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
                            rangBytes = range.replaceAll("bytes=", "");
                            if (rangBytes.endsWith("-")) { // bytes=270000-
                                rangeSwitch = 1;
                                p = Long.parseLong(rangBytes.substring(0, rangBytes.indexOf("-")));
                                contentLength = fileLength - p; // 客户端请求的是270000之后的字节（包括bytes下标索引为270000的字节）
                            } else { // bytes=270000-320000
                                rangeSwitch = 2;
                                String temp1 = rangBytes.substring(0, rangBytes.indexOf("-"));
                                String temp2 = rangBytes.substring(rangBytes.indexOf("-") + 1, rangBytes.length());
                                p = Long.parseLong(temp1);
                                toLength = Long.parseLong(temp2);
                                contentLength = toLength - p + 1; // 客户端请求的是 270000-320000 之间的字节
                            }
                        } else {
                            contentLength = fileLength;
                        }

                        // 如果设设置了Content-Length，则客户端会自动进行多线程下载。如果不希望支持多线程，则不要设置这个参数。
                        // Content-Length: [文件的总大小] - [客户端请求的下载的文件块的开始字节]
                        response.setHeader("Content-Length", new Long(contentLength).toString());

                        // 断点开始
                        // 响应的格式是:
                        // Content-Range: bytes [文件块的开始字节]-[文件的总大小 - 1]/[文件的总大小]
                        if (rangeSwitch == 1) {
                            String contentRange = new StringBuffer("bytes ").append(new Long(p).toString()).append("-")
                                    .append(new Long(fileLength - 1).toString()).append("/")
                                    .append(new Long(fileLength).toString()).toString();
                            response.setHeader("Content-Range", contentRange);
                            bis.skip(p);
                        } else if (rangeSwitch == 2) {
                            String contentRange = range.replace("=", " ") + "/" + new Long(fileLength).toString();
                            response.setHeader("Content-Range", contentRange);
                            bis.skip(p);
                        } else {
                            String contentRange = new StringBuffer("bytes ").append("0-").append(fileLength - 1).append("/")
                                    .append(fileLength).toString();
                            response.setHeader("Content-Range", contentRange);
                        }

                        String fileName = fsResource.getFilename();
                        response.setContentType("application/octet-stream");
                        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);

                        out = response.getOutputStream();
                        int n = 0;
                        long readLength = 0;
                        int bsize = 1024;
                        byte[] bytes = new byte[bsize];
                        if (rangeSwitch == 2) {
                            // 针对 bytes=27000-39000 的请求，从27000开始写数据
                            while (readLength <= contentLength - bsize) {
                                n = bis.read(bytes);
                                readLength += n;
                                out.write(bytes, 0, n);
                            }
                            if (readLength <= contentLength) {
                                n = bis.read(bytes, 0, (int) (contentLength - readLength));
                                out.write(bytes, 0, n);
                            }
                        } else {
                            while ((n = bis.read(bytes)) != -1) {
                                out.write(bytes, 0, n);
                            }
                        }
                        out.flush();
                        out.close();
                        bis.close();
                    }
                } catch (IOException ie) {
                    ie.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if ("2".equals(type)) {
                response.setContentType("image/jpeg");
                response.setHeader(name, "filename=" + URLEncoder.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString(contentType), enc));
                Window.getWindows();
                out = response.getOutputStream();
                getGridFs().downloadToStream(gridfs.getId(), out);
                out.flush();
                out.close();
            }else{
                response.setContentType("application/octet-stream");
                response.setHeader(name, "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(), enc));
                Window.getWindows();
                out = response.getOutputStream();
                getGridFs().downloadToStream(gridfs.getId(), out);
                out.flush();
                out.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected GridFSBucket getGridFs() {
        MongoDatabase db = mongoTemplate.getDb();
        return GridFSBuckets.create(db);
    }

    /**
     * 直接下载文件内容不用查看
     */

    @RequestMapping(value = "/downloadFile/{fileId}/{type}")
    public void downloadFile(@PathVariable String fileId, @PathVariable String type,
                             HttpServletResponse response, HttpServletRequest request) {
        try {
            GridFSFile gridfs = iMongoAttachFile.getFile(fileId);
            String contentType = "_contentType";
            String name = "Content-Disposition";
            String enc = "utf-8";
            if ("pdf".equals(gridfs.getMetadata().get(contentType))) {
                response.setContentType("application/x-download");//如果是pdf的话就下载pdf
                response.setHeader(name, "fileName=" + URLEncoder.encode(gridfs.getFilename(), enc));
            } else if ("mp4".equals(gridfs.getMetadata().get(contentType))) {
                byte[] data = gridfs.getObjectId().toByteArray();
                response.setContentType("application/octet-stream");
                response.setContentType("application/x-download");
                response.setHeader(name, "attachment;filename=" + URLEncoder.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString(contentType), enc));
                String range = request.getHeader("range");
                response.setContentType("video/mp4");
                response.setContentLength((int) gridfs.getLength());
                response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
                response.setHeader("Accept-Ranges", "text/x-dvi");
                response.setHeader("Etag", "W/\"9767057-1323779115364\"");
            } else {
                response.setContentType("application/octet-stream");
                response.setHeader(name, "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(), enc));
            }
            OutputStream out = response.getOutputStream();
            getGridFs().downloadToStream(gridfs.getId(), out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 通过名称获取流域附件
     *
     * @param param
     * @param request
     * @return
     */
    @RequestMapping("/findAttachementByName")
    @ResponseBody
    public PageEU<WaterAttachment> findAttachementByName(WaterAttachmentParam param, String attachementName, HttpServletRequest request) {
        Page<WaterAttachment> page = pageQuery(request);
        List<WaterAttachment> attachments = waterAttachmentService.getAttachments(param.getPointCode());
        List<WaterAttachment> attachmentList = new ArrayList<>();
        if (StringUtils.isEmpty(attachementName)) {
            page.setResult(attachments);
            return new PageEU<>(page);
        }
        for (WaterAttachment attachment : attachments) {
            if (attachment.getName().contains(attachementName)) {
                attachmentList.add(attachment);
            }
        }
        page.setResult(attachmentList);
        page.setTotalCount(attachmentList.size());
        page.setCurrentPage(1);
        return new PageEU<>(page);
    }


}
