package cn.fjzxdz.frame.toolbox.util;

import java.util.UUID;

/**
 * @author liuyankun
 * @desc UUID
 */
public class UUIDUtil {

    public static String randomUUID() {
        return UUID.randomUUID().toString();
    }

    public static void main(String[] args) {
        System.out.println(randomUUID());
    }
}
