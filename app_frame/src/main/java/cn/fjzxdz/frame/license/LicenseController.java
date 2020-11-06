package cn.fjzxdz.frame.license;

import cn.fjzxdz.frame.controller.BaseController;
import cn.fjzxdz.frame.license.entity.License;
import cn.fjzxdz.frame.license.security.RSATool;
import cn.fjzxdz.frame.pojo.R;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;
import cn.hutool.core.io.FileUtil;
import com.alibaba.druid.util.Utils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;

@Controller
@RequestMapping("/license")
public class LicenseController extends BaseController {
    @RequestMapping("")
    public String license(HttpServletRequest request) throws Exception {
        request.setAttribute("hardwarecode", License.getInstance()
                .getHardwareCodeForTool());
        return "/moudles/license/license";
    }

    @RequestMapping("licenseInfo")
    public String licenseInfo(HttpServletRequest request) throws Exception {
        request.setAttribute("licenseInfoText", License.getInstance()
                .getLicenseInfoText());
        return "/moudles/license/licenseInfo";
    }

    @RequestMapping("/submitRecoverKey")
    @ResponseBody
    public R submitRecoverKey(String recoverKey) throws Exception {

        String key = Utils.md5(String.valueOf(License.getInstance()
                .getServerDate()));
        if (!key.equals(recoverKey)) {
            return R.error("修复口令不正确");
        }

        String dir = System.getProperty("java.io.tmpdir");
        String serverTimeFilePath = String.format(
                RSATool.decrypt(License.SERVER_TIME_FILE), dir);

        long now = new Date().getTime();
        File serverTimeFile = new File(serverTimeFilePath);
        License.getInstance().saveNewServerTime(serverTimeFile, now);
        return R.ok("服务器时间状态已经成功修复，请重新启动Tomcat服务器");
    }

    @RequestMapping("/downloadHardWareCode")
    public void downloadHardWareCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置响应和请求编码utf-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String strData = License.getInstance()
                .getHardwareCodeForTool();
        //region 设置返回头文件
        String strFileName = "hardwarecode.lic";
            response.setHeader("Content-disposition", "attachment;filename=" + strFileName);
//        File file = new File(LicenseController.class.getResource("/").getPath(),strFileName);
        File file = new File(System.getProperty("user.dir")+File.separator+strFileName);
        if(file.exists()){
            file.delete();
        }
        FileUtil.writeBytes(strData.getBytes(),file);
        InputStream in=null;
        OutputStream out = null;
        try {
            in=new FileInputStream(file.getPath());
            int len = 0;
            byte buffer[] = new byte[1024];
            out = response.getOutputStream();
             while((len=in.read(buffer))>0){
                out.write(buffer, 0, len);
             }
        } finally {
            if (in != null) {
                try {
                    in.close();
                    out.flush();
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 上传文件
     */
    @RequestMapping("/uploadLicenseFile")
    @ResponseBody
    public R uploadLicenseFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request){
        try {
            String originFilename = multipartFile.getOriginalFilename();
//            String savePath = LicenseController.class.getResource("/").getPath()+"license.lic";
            String savePath = System.getProperty("user.dir")+File.separator+"license.lic";
            if (ToolUtil.isNotEmpty(originFilename)) {
                if(!originFilename.endsWith(".lic")){
                    return R.error("授权文件格式有误，请确认授权文件是否正确！");
                }
                FileUtil.writeFromStream(multipartFile.getInputStream(),savePath);
                if(!License.getInstance().checkLicenseFile(ProductCode.PRODUCT_CODE,multipartFile.getInputStream())){
                    return R.error("授权文件更新失败，请确认授权文件内容是否正确！");
                }
                File file = new File(savePath);
                if(file.exists()){
                    file.delete();
                }
                FileUtil.writeFromStream(multipartFile.getInputStream(),savePath);
                new LicenseInitializer().init();
            }
        }catch (Exception e){
            return R.error("授权文件更新失败，请确认授权文件是否正确！");
        }
        return R.ok("授权文件更新成功，请重新刷新浏览器或者重启浏览器！");
    }

}
