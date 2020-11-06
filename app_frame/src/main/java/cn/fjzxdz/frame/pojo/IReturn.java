package cn.fjzxdz.frame.pojo;

/**
 * 类描述：ReturnCode 统一返回状态码
 *
 * @author liuyankun
 */
public interface IReturn {

    /**
     * 获取编码
     *
     * @return
     */
    int getCode();

    /**
     * 获取信息
     *
     * @return
     */
    String getMsg();

}
