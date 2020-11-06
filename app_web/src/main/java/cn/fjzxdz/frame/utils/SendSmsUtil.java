package cn.fjzxdz.frame.utils;

import cn.hutool.crypto.SecureUtil;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSON;
import org.apache.commons.codec.binary.Base64;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

/**
 * 发短信工具类
 *
 * @author fushixing
 * @date 2019-03-25
 */
public class SendSmsUtil {

    private static String smsUrl = "http://112.35.1.155:1992/sms/norsubmit";
    private static String smsTmpUrl = "http://112.35.1.155:1992/sms/tmpsubmit";

    public static String getSmsParam(String mobiles, String content) {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        hashMap.put("ecName", "漳州市环境信息中心");
        hashMap.put("apId", "lafase");
        hashMap.put("secretKey", "passwd@2345");
        hashMap.put("mobiles", mobiles);
        hashMap.put("content", content);
        hashMap.put("sign", "Ooaib89cH");
        hashMap.put("addSerial", "");

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(hashMap.get("ecName"));
        stringBuilder.append(hashMap.get("apId"));
        stringBuilder.append(hashMap.get("secretKey"));
        stringBuilder.append(hashMap.get("mobiles"));
        stringBuilder.append(hashMap.get("content"));
        stringBuilder.append(hashMap.get("sign"));
        stringBuilder.append("");
        System.out.println("stringBuilder.toString():" + stringBuilder.toString());
        String selfMac = SecureUtil.md5(stringBuilder.toString());
        System.out.println("selfMac:" + selfMac);
        hashMap.put("mac", selfMac);
        String param = JSON.toJSONString(hashMap);
        System.out.println("param:" + param);

        String encode = null;
        try {
            encode = Base64.encodeBase64String(param.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println("encode:" + encode);
        return encode;
    }

    public static String getSmsTmpParam(String mobiles, String content) {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        String[] paramss = {content};

        hashMap.put("ecName", "漳州市环境信息中心");
        hashMap.put("apId", "lafase");
        hashMap.put("secretKey", "passwd@2345");
        hashMap.put("mobiles", mobiles);
        hashMap.put("content", content);
        hashMap.put("sign", "Ooaib89cH");
        hashMap.put("params", JSON.toJSONString(paramss));
        hashMap.put("templateId", "38516fabae004eddbfa3ace1d4194696");
        hashMap.put("addSerial", "");

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(hashMap.get("ecName"));
        stringBuilder.append(hashMap.get("apId"));
        stringBuilder.append(hashMap.get("secretKey"));
        stringBuilder.append(hashMap.get("templateId"));
        stringBuilder.append(hashMap.get("mobiles"));
        stringBuilder.append(hashMap.get("params"));
        stringBuilder.append(hashMap.get("sign"));
        stringBuilder.append("");
        System.out.println("stringBuilder.toString():" + stringBuilder.toString());
        String selfMac = SecureUtil.md5(stringBuilder.toString());
        System.out.println("selfMac:" + selfMac);
        hashMap.put("mac", selfMac);
        String param = JSON.toJSONString(hashMap);
        System.out.println("param:" + param);

        String encode = null;
        try {
            encode = Base64.encodeBase64String(param.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println("encode:" + encode);
        return encode;
    }

    public static void sendSms(String mobiles, String content) {
        String smsParam = getSmsParam(mobiles, content);
        String post = HttpUtil.post(smsUrl, smsParam);
        System.out.println("post:" + post);
    }

    public static void sendTmlSms(String mobiles, String content) {
        String smsParam = getSmsTmpParam(mobiles, content);
        String post = HttpUtil.post(smsTmpUrl, smsParam);
        System.out.println("post:" + post);
    }

    public static void main(String[] args) {
        sendSms("138xxxxx", "移动改变生活");
        //sendTmlSms("138xxxxx", "移动改变生活");
    }
}


