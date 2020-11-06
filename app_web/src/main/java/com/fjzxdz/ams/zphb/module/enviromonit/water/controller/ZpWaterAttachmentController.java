package com.fjzxdz.ams.zphb.module.enviromonit.water.controller;

import cn.fjzxdz.frame.common.Page;
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
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/zphb/environment/waterAttachment")
@Secured({"ROLE_USER"})
public class ZpWaterAttachmentController extends BaseController {

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

    /**
     * 访问文件
     */
    @RequestMapping(value = "/download/{fileId}/{type}")
    public void getFile(@PathVariable String fileId, @PathVariable String type,
                        HttpServletResponse response, HttpServletRequest request) {
        try {
            GridFSFile gridfs = iMongoAttachFile.getFile(fileId);
            String contentType = "_contentType";
            String name = "Content-Disposition";
            String enc = "utf-8";
            if ("pdf".equals(gridfs.getMetadata().get(contentType))) {
                response.setContentType("application/pdf");
                response.setHeader(name, "fileName=" + URLEncoder.encode(gridfs.getFilename(), enc));
            } else if ("mp4".equals(gridfs.getMetadata().get(contentType))) {
                byte[] data = gridfs.getObjectId().toByteArray();
                response.setContentType("application/octet-stream");
                response.setHeader(name, "attachment;filename=" + URLEncoder.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString(contentType), enc));
                String range = request.getHeader("range");
                response.setContentType("video/mp4");
                response.setContentLength((int) gridfs.getLength());
                response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
                response.setHeader("Accept-Ranges", "text/x-dvi");
                response.setHeader("Etag", "W/\"9767057-1323779115364\"");
            } else if ("2".equals(type)) {
                response.setContentType("image/jpeg");
                response.setHeader(name, "filename=" + URLEncoder.encode(gridfs.getFilename() + "." + gridfs.getMetadata().getString(contentType), enc));
            }else{
                response.setContentType("application/octet-stream");
                response.setHeader(name, "attachment;filename=" + URLEncoder.encode(gridfs.getFilename(), enc));
            }
            Window.getWindows();
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
