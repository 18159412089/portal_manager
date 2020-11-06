package cn.fjzxdz.frame.exception;

/**
 * 异常抽象接口
 *
 * @author liuyankun
 */
public interface IAmsException {

    /**
     * 获取异常编码
     *
     * @return
     */
    Integer getCode();

    /**
     * 获取异常信息
     *
     * @return
     */
    String getMessage();
}
