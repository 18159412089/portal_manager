package com.fjzxdz.ams.module.deployball.xml;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
/**
 * 对接口返回的xml进行修改，具体可以参考调用《8200 V3.0 CMS对外接口文档.doc》中的"3.9.获取回放所需的参数"来获取回放控件所需的xml参数。
 */

public class PlayViewXml {
     public static String changePlayViewXml(String xmlStr) throws Exception {
    	 
    	   Document doc = DocumentHelper.parseText(xmlStr);  //String转xml
    	   Element root =doc.getRootElement();
    	   Element privilege=root.element("Privilege");
    	   Attribute priority=privilege.attribute("Priority");
    	   priority.setValue("50");
    	   Attribute code=privilege.attribute("Code");
    	   code.setValue("31");
    	   Element option=root.element("Option");
    	   Element talk =option.element("Talk");
    	   talk.setText("1");
    	   String  xmlre_Str = doc.asXML();
    	   return xmlre_Str; 
     }
}
