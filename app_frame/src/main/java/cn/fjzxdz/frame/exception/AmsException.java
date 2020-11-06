package cn.fjzxdz.frame.exception;

/**
 * 封装异常
 *
 * @author liuyankun
 */
public class AmsException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private Integer code;

    private String message;

    public AmsException(IAmsException iAmsException) {
        this.code = iAmsException.getCode();
        this.message = iAmsException.getMessage();
    }

    public AmsException(String message, Throwable cause) {
        super(cause);
        this.code = 500;
        this.message = message;
    }

    public AmsException(String message) {
        super(message);
        this.code = 500;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
