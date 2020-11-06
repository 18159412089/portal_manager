package com.fjzxdz.ams.module.deployball.xml;

import com.fjzxdz.ams.module.deployball.util.DemoUtil;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;



/**
 * 对接口返回的xml进行修改，具体可以参考调用《8200 V3.0 CMS对外接口文档.doc》中的"3.8.获取预览所需的参数"来获取预览控件所需的xml参数。
 */
public class PlayBackXml {
    public static String changePlayBackXml(String xmlStr) throws Exception {
   	 
 	   Document doc = DocumentHelper.parseText(xmlStr);  //String转xml
 	   Element root =doc.getRootElement();
 	   Element intelligence =root.element("Intelligence");
 	   Element imp =intelligence.element("Imp");
 	   imp.addAttribute("userName", DemoUtil.getPropertyByName(DemoUtil.USERNAME));
 	   imp.addAttribute("password", DemoUtil.getPropertyByName(DemoUtil.PASSWORD));
 	   Element privilege =root.element("Privilege");
 	   privilege.setText("7");
 	   Element autoPlay = root.addElement("AutoPlay");
 	   autoPlay.setText("0");
 	   String  xmlre_Str = doc.asXML();
 	   return xmlre_Str; 
  }
}
