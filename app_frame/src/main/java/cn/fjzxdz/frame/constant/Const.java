package cn.fjzxdz.frame.constant;


public interface Const {

    /**
     * 超级管理员角色的名字
     */
    String SUPER_ADMIN = "ROLE_ROOT";

    /**
     * 管理员角色的名字
     */
    String ADMIN = "ROLE_ADMIN";

    /**
     * 新增用户的初始密码
     */
    String INIT_PWD = "123456";

    /**
     * 字符编码
     */
    String ENCODING = "UTF-8";

    /**
     * 定义乐观锁字段
     */
    String OPTIMISTIC_LOCK = "VERSION";
}
