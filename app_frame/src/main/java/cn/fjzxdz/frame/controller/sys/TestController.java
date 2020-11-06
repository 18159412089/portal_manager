package cn.fjzxdz.frame.controller.sys;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/sys/test")
public class TestController {
    @RequestMapping(value = "/test.do")
    public String  test(){
        return  "/EcologicalCloudHome";
    }

}
