package cn.fjzxdz.frame.controller;

import cn.fjzxdz.frame.config.RTCProperties;
import cn.fjzxdz.frame.service.sys.MenuService;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

@Controller
public class LoginController extends BaseController {

    @Autowired
    private MenuService menuService;

    @Value("${rtmp}")
    private String rtmp;
    @Value("${server.index.page:#{null}}")
    private String indexPage;

    /**
     * 跳转到主页
     */
    @PreAuthorize("hasAuthority('front:index')")
    @RequestMapping(value = "/index", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String index(Model model) {
//        String userName = getUserName();
//        JSONArray jsonArray;
//        if (userName.equals("root")) {
//            jsonArray = menuService.getRootMenu();
//        } else {
//        	String userId = getUserId();
//            jsonArray = menuService.getIndexMenu(userId);
//        }
//        model.addAttribute("titles", jsonArray.toJSONString());
        return com.alibaba.druid.util.StringUtils.isEmpty(indexPage)?"/index":indexPage;
    }

    /**
     * 跳转到主页
     */
    @RequestMapping(value = "/indextemp", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp(Model model) {
        return "indextemp";
    }

    /**
     * 跳转到主页1
     */
    @RequestMapping(value = "/indextemp1", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp1(Model model) {
        return "indextemp1";
    }

    /**
     * 跳转到主页2
     */
    @RequestMapping(value = "/indextemp2", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp2(Model model) {
        return "indextemp2";
    }

    /**
     * 跳转到主页3
     */
    @RequestMapping(value = "/indextemp3", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp3(Model model) {
        return "indextemp3";
    }

    /**
     * 跳转到主页4
     */
    @RequestMapping(value = "/indextemp4", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp4(Model model) {
        return "indextemp4";
    }

    /**
     * 跳转到主页5
     */
    @RequestMapping(value = "/indextemp5", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp5(Model model) {
        return "indextemp5";
    }

    /**
     * 跳转到主页6
     */
    @RequestMapping(value = "/indextemp6", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp6(Model model) {
        return "indextemp6";
    }

    /**
     * 跳转到主页7
     */
    @RequestMapping(value = "/indextemp7", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp7(Model model) {
        return "indextemp7";
    }

    /**
     * 跳转到主页7
     */
    @RequestMapping(value = "/showWarMig")
//    @Secured({"ROLE_USER"})
    public String temp7(Model model) {
        return "/showWarMig";
    }

    /**
     * 跳转到主页8
     */
    @RequestMapping(value = "/indextemp8", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp8(Model model) {
        return "indextemp8";
    }

    /**
     * 跳转到主页9
     */
    @RequestMapping(value = "/indextemp9", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp9(Model model) {
        return "indextemp9";
    }

    /**
     * 跳转到主页10
     */
    @RequestMapping(value = "/indextemp10", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp10(Model model) {
        return "indextemp10";
    }

    /**
     * 跳转到主页11
     */
    @RequestMapping(value = "/indextemp11", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp11(Model model) {
        return "indextemp11";
    }

    /**
     * 跳转到主页12
     */
    @RequestMapping(value = "/indextemp12", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp12(Model model) {
        return "indextemp12";
    }


    /**
     * 跳转到主页13
     */
    @RequestMapping(value = "/indextemp13", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp13(Model model) {
        return "indextemp13";
    }

    /**
     * 跳转到主页14
     */
    @RequestMapping(value = "/indextemp14", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp14(Model model) {
        return "indextemp14";
    }

    /**
     * 跳转到主页15
     */
    @RequestMapping(value = "/indextemp15", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp15(Model model) {
        return "indextemp15";
    }

    /**
     * 跳转到主页16
     */
    @RequestMapping(value = "/indextemp16", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp16(Model model) {
        return "indextemp16";
    }

    /**
     * 跳转到主页17
     */
    @RequestMapping(value = "/indextemp17", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp17(Model model) {
        return "indextemp17";
    }

    @RequestMapping(value = "/indextemp171", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp171(Model model) {
        return "indextemp171";
        ///app_web/src/main/resources/templates/moudles/enviromonit/dataRoll.ftl
    }

    @RequestMapping(value = "/indextemp17_2", method = RequestMethod.GET)
	public String indextemp17_2(Model model) {
		return "/moudles/enviromonit/dataRoll";
	}

    @RequestMapping(value = "/indextemp18test", method = RequestMethod.GET)
    public String indextemp18test(Model model) {
        return "/indextemp18test";
    }

    @RequestMapping(value = "/indextemp20", method = RequestMethod.GET)
    public String indextemp20(Model model) {
        return "/indextemp20";
    }

    @RequestMapping(value = "/indextemp21", method = RequestMethod.GET)
    public String indextemp21(Model model) {
        return "/indextemp21";
    }
    @RequestMapping(value = "/indextemp22", method = RequestMethod.GET)
    public String indextemp22(Model model) {
        return "/indextemp22";
    }
    @RequestMapping(value = "/indextemp23", method = RequestMethod.GET)
    public String indextemp23(Model model) {
        return "/indextemp23";
    }
    @RequestMapping(value = "/indextemp24", method = RequestMethod.GET)
    public String indextemp24(Model model) {
        return "/indextemp24";
    }
    @RequestMapping(value = "/indextemp25", method = RequestMethod.GET)
    public ModelAndView indextemp25(ModelAndView model,String pid) {
        model.addObject("pid", pid);
        model.setViewName("/indextemp25");
        return model;
    }
    @RequestMapping(value = "/indextemp26", method = RequestMethod.GET)
    public String indextemp26(Model model) {
        return "/indextemp26";
    }

    @RequestMapping(value = "/indextemp27", method = RequestMethod.GET)
    public String indextemp27(Model model) {
        return "/indextemp27";
    }

    @RequestMapping(value = "/indextemp28", method = RequestMethod.GET)
    public String indextemp28(Model model) {
        return "/indextemp28";
    }

    @RequestMapping(value = "/indextemp29", method = RequestMethod.GET)
    public String indextemp29(Model model) {
        return "/indextemp29";
    }

    @RequestMapping(value = "/indextemp30", method = RequestMethod.GET)
    public String indextemp30(Model model) {
        return "/indextemp30";
    }
    /**
     * 跳转到静态漳浦首页
     */
    @RequestMapping(value = "/zhangPuTempHome", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String zhangPuTempHome(Model model) {
        return "zhangPuTempHome";
    }
    /**
     * 跳转到漳浦污染源数据
     */
    @RequestMapping(value = "/zphb/zhangPuPollutionDataMap", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String zhangPuPollutionDataMap(Model model) {
        return "zphb/zhangPuPollutionDataMap";
    }
    /**
     * 跳转到静态漳浦环保一张图
     */
    @RequestMapping(value = "/zphb/zhangPuTempMap", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String zhangPuTempMap(Model model) {
        return "zphb/zhangPuTempMap";
    }
    @RequestMapping(value = "/zphb/zpCameraMap", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String zpCameraMap(Model model) {
        return "zphb/zpCameraMap";
    }
    /**
     * 跳转到静态漳浦年度大数据
     */
    @RequestMapping(value = "/zphb/zhangPuTempBigData", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String zhangPuTempBigData(Model model) {
        return "zphb/zhangPuTempBigData";
    }


    @Autowired
    private RTCProperties rtcProperties;

    @RequestMapping(value = "/commandCenter", method = RequestMethod.GET)
    public String commandCenter(Model model) {
        model.addAttribute("rtcProperties", rtcProperties);
        return "commandCenter";
    }

    @RequestMapping(value = "/commandCenter1", method = RequestMethod.GET)
    public String commandCenter1(Model model) {
        model.addAttribute("rtcProperties", rtcProperties);
        model.addAttribute("rtmp", rtmp);
        return "commandCenter1";
    }

    @RequestMapping(value = "/zphb/zpCommandCenter", method = RequestMethod.GET)
    public String zpCommandCenter1(Model model) {
        model.addAttribute("rtcProperties", rtcProperties);
        model.addAttribute("rtmp", rtmp);
        return "zphb/zpCommandCenter";
    }

    @RequestMapping(value = "/videoDemo", method = RequestMethod.GET)
    public String videoDemo(Model model) {
        model.addAttribute("rtcProperties", rtcProperties);
        model.addAttribute("rtmp", rtmp);
        return "videoDemo";
    }
    
    /**
     * 跳转到主页18
     */
    @RequestMapping(value = "/indextemp18", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp18(Model model) {
        return "indextemp18";
    }
    /**
     * 跳转到主页19
     */
    @RequestMapping(value = "/indextemp19", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp19(Model model) {
        return "indextemp19";
    }
    /**
     * 跳转到主页21chart
     */
    @RequestMapping(value = "/indextemp21chart", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String indextemp21chart(Model model) {
        return "indextemp21chart";
    }
    /**
     * 跳转到待开发页面
     */
    @RequestMapping(value = "/todo", method = RequestMethod.GET)
//    @Secured({"ROLE_USER"})
    public String todo(Model model) {
        return "todo";
    }

    /**
     * 跳转到后台主页
     */
    @PreAuthorize("hasAuthority('front:manage')")
    @RequestMapping(value = "/manage", method = RequestMethod.GET)
//    @Secured({"ROLE_USER", "ROLE_ROOT"})
    public String manage(Model model) throws UnsupportedEncodingException {
        String titleName = getRequest().getParameter("titleName");
        if(StringUtils.isNotEmpty(titleName)){
            titleName =java.net.URLDecoder.decode(titleName,"UTF-8");
        }
        String userName = getUserName();
        JSONArray jsonArray;
        if (userName.equals("root")) {
            jsonArray = menuService.getRootMenu();
        } else {
            String userId = getUserId();
            jsonArray = menuService.getIndexMenu(userId);
        }
        model.addAttribute("titles", jsonArray.toJSONString());
        model.addAttribute("titleName",titleName);
        return "manage";
    }

    /**
     * 跳转到登录页面
     */
    @RequestMapping(value = "/login")
    public String login(Model model, HttpServletRequest request) {
        try {
            model.addAttribute("error", request.getSession().getAttribute("error"));
            model.addAttribute("message", request.getSession().getAttribute("message"));
            request.getSession().setAttribute("error", null);
            request.getSession().setAttribute("message", null);
        } catch (Exception e) {
        }
        return "/login";
    }

    @RequestMapping(value = "/session/invalid")
    public void sessionInvalid(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        if ((request.getHeader("X-Requested-With") != null && "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With")))
                || (request.getContentType() != null && request.getContentType().equals(MediaType.APPLICATION_JSON_UTF8_VALUE))
                || (request.getContentType() != null && request.getContentType().equals(MediaType.APPLICATION_JSON_VALUE))) { // ajax 超时处理
            response.setStatus(HttpStatus.UNAUTHORIZED.value());
            response.getWriter().print("回话超时");  //设置超时标识
            response.getWriter().close();
            response.getWriter().flush();
        } else {
            response.sendRedirect("/login");
        }
    }


}
