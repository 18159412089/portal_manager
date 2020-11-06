package cn.fjzxdz.frame.pojo;

import java.io.Serializable;

/**
 * @author liuyankun
 * @desc 返回数据基类
 */
public class Result implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 返回状态码
     */
    private int code;

    /**
     * 返回信息
     */
    private String msg;

    /**
     * 返回数据
     */
    private Object data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Result() {
        super();
    }

    public Result(int code) {
        super();
        this.code = code;
    }

    public Result(int code, String msg) {
        super();
        this.code = code;
        this.msg = msg;
    }

    public Result(int code, String msg, Object data) {
        super();
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public Result(IReturn IReturn) {
        super();
        this.code = IReturn.getCode();
        this.msg = IReturn.getMsg();
    }

    public Result cm(IReturn IReturn) {
        this.code = IReturn.getCode();
        this.msg = IReturn.getMsg();
        return this;
    }

    public Result(IReturn IReturn, Object data) {
        super();
        this.code = IReturn.getCode();
        this.msg = IReturn.getMsg();
        this.data = data;
    }

    public Result cmd(IReturn IReturn, Object data) {
        this.code = IReturn.getCode();
        this.msg = IReturn.getMsg();
        this.data = data;
        return this;
    }

    public Result ok() {
        this.code = 200;
        this.msg = null;
        this.data = null;
        return this;
    }

    public Result ok(String msg) {
        this.code = 200;
        this.msg = msg;
        this.data = null;
        return this;
    }

    public Result ok(Object data) {
        this.code = 200;
        this.msg = null;
        this.data = data;
        return this;
    }

    public Result ok(String msg, Object data) {
        this.code = 200;
        this.msg = msg;
        this.data = data;
        return this;
    }

    public Result fail() {
        this.code = 500;
        this.msg = null;
        this.data = null;
        return this;
    }

    public Result fail(int code, String msg) {
        this.code = code;
        this.msg = msg;
        this.data = null;
        return this;
    }

    public Result fail(Object data) {
        this.code = 500;
        this.msg = null;
        this.data = data;
        return this;
    }

    public Result fail(String msg, Object data) {
        this.code = 500;
        this.msg = msg;
        this.data = data;
        return this;
    }
}
