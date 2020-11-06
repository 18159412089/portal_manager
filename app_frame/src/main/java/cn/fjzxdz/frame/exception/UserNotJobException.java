package cn.fjzxdz.frame.exception;

public class UserNotJobException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    public UserNotJobException() {
        super();
    }

    public UserNotJobException(String message) {
        super(message);
    }

    
}
