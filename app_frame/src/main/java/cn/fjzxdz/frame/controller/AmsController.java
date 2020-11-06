package cn.fjzxdz.frame.controller;

import cn.fjzxdz.frame.toolbox.ajax.AjaxResult;
import cn.fjzxdz.frame.toolbox.kit.CharsetKit;
import cn.fjzxdz.frame.toolbox.kit.ObjectKit;
import cn.fjzxdz.frame.toolbox.kit.StrKit;
import cn.fjzxdz.frame.toolbox.kit.URLKit;
import cn.fjzxdz.frame.toolbox.support.BeanInjector;
import cn.fjzxdz.frame.toolbox.support.CMap;
import cn.fjzxdz.frame.toolbox.support.Convert;
import cn.fjzxdz.frame.toolbox.support.WafRequestWrapper;
import cn.fjzxdz.frame.toolbox.util.ToolUtil;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

/**
 * 公共方法组装
 *
 * @author liuyankun
 */
public class AmsController {

    protected Logger LOGGER = LogManager.getLogger(this.getClass());

    /**
     * ============================     requset    =================================================
     */

    @Resource
    private HttpServletRequest request;

    /**
     * 获取request
     */
    public HttpServletRequest getRequest() {
        return new WafRequestWrapper(this.request);
    }

    /**
     * 是否ajax
     */
    public boolean isAjax() {
        String header = getRequest().getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(header);
        return isAjax;
    }

    /**
     * 是否post
     */
    public boolean isPost() {
        String method = getRequest().getMethod();
        return StrKit.equalsIgnoreCase("POST", method);
    }

    /**
     * 获取String参数
     */
    public String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    /**
     * 获取String参数
     */
    public String getParameter(String name, String defaultValue) {
        return Convert.toStr(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取Integer参数
     */
    public Integer getParameterToInt(String name) {
        return Convert.toInt(getRequest().getParameter(name));
    }

    /**
     * 获取Integer参数
     */
    public Integer getParameterToInt(String name, Integer defaultValue) {
        return Convert.toInt(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取Long参数
     */
    public Long getParameterToLong(String name) {
        return Convert.toLong(getRequest().getParameter(name));
    }

    /**
     * 获取Long参数
     */
    public Long getParameterToLong(String name, Long defaultValue) {
        return Convert.toLong(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取Float参数
     */
    public Float getParameterToFloat(String name) {
        return Convert.toFloat(getRequest().getParameter(name));
    }

    /**
     * 获取Float参数
     */
    public Float getParameterToFloat(String name, Float defaultValue) {
        return Convert.toFloat(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取BigDecimal参数
     */
    public BigDecimal getParameterToBigDecimal(String name) {
        return Convert.toBigDecimal(getRequest().getParameter(name));
    }

    /**
     * 获取BigDecimal参数
     */
    public BigDecimal getParameterToBigDecimal(String name, BigDecimal defaultValue) {
        return Convert.toBigDecimal(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取Encode参数
     */
    public String getParameterToEncode(String para) {
        return URLKit.encode(getRequest().getParameter(para), CharsetKit.UTF_8);
    }

    /**
     * 获取Decode参数
     */
    public String getParameterToDecode(String para) {
        return URLKit.decode(getRequest().getParameter(para), CharsetKit.UTF_8);
    }

    /**
     * 获取ContextPath
     */
    public String getContextPath() {
        return getRequest().getContextPath();
    }

    /**
     * 页面跳转
     *
     * @param url
     */
    public String redirect(String url) {
        return StrKit.format("redirect:{}", url);
    }

    /**
     * 对象是否为空
     *
     * @param obj String,List,Map,Object[],int[],long[]
     * @return
     */
    public boolean isEmpty(Object obj) {
        return ToolUtil.isEmpty(obj);
    }

    /**
     * 对象是否不为空
     *
     * @param obj String,List,Map,Object[],int[],long[]
     * @return
     */
    public boolean notEmpty(Object obj) {
        return !isEmpty(obj);
    }

    /**
     * 字符串是否为空白 空白的定义如下： <br>
     * 1、为null <br>
     * 2、为不可见字符（如空格）<br>
     * 3、""<br>
     *
     * @param str 被检测的字符串
     * @return 是否为空
     */
    public boolean isBlank(String str) {
        return StrKit.isBlank(str);
    }

    /**
     * 字符串是否为非空白 空白的定义如下： <br>
     * 1、不为null <br>
     * 2、不为不可见字符（如空格）<br>
     * 3、不为""<br>
     *
     * @param str 被检测的字符串
     * @return 是否为非空
     */
    public boolean notBlank(String str) {
        return StrKit.notBlank(str);
    }

    /**
     * 格式化文本, {} 表示占位符<br>
     * 此方法只是简单将占位符 {} 按照顺序替换为参数<br>
     * 如果想输出 {} 使用 \\转义 { 即可，如果想输出 {} 之前的 \ 使用双转义符 \\\\ 即可<br>
     * 例：<br>
     * 通常使用：format("this is {} for {}", "a", "b") -> this is a for b<br>
     * 转义{}： 	format("this is \\{} for {}", "a", "b") -> this is \{} for a<br>
     * 转义\：		format("this is \\\\{} for {}", "a", "b") -> this is \a for b<br>
     *
     * @param template 文本模板，被替换的部分用 {} 表示
     * @param params   参数值
     * @return 格式化后的文本
     */
    public String format(String template, Object... params) {
        return StrKit.format(template, params);
    }

    /**
     * 格式化文本，使用 {varName} 占位<br>
     * map = {a: "aValue", b: "bValue"}
     * format("{a} and {b}", map)    ---->    aValue and bValue
     *
     * @param template 文本模板，被替换的部分用 {key} 表示
     * @param map      参数值对
     * @return 格式化后的文本
     */
    public String format(String template, Map<?, ?> map) {
        return StrKit.format(template, map);
    }


    /**
     * 创建StringBuilder对象
     */
    public StringBuilder builder() {
        return StrKit.builder();
    }

    /**
     * 创建StringBuilder对象
     */
    public StringBuilder builder(int capacity) {
        return StrKit.builder(capacity);
    }

    /**
     * 创建StringBuilder对象
     */
    public StringBuilder build(String... strs) {
        return StrKit.builder(strs);
    }

    /**
     * 克隆对象<br>
     * 对象必须实现Serializable接口
     *
     * @param obj 被克隆对象
     * @return 克隆后的对象
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public <T extends Cloneable> T clone(T obj) {
        return ObjectKit.clone(obj);
    }

    /**
     * 克隆对象<br>
     * 对象必须实现Serializable接口
     *
     * @param obj 被克隆对象
     * @return 克隆后的对象
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public <T> T clone(T obj) {
        return ObjectKit.clone(obj);
    }

    /** ============================     mapping    =================================================  */

    /**
     * 表单值映射为javabean
     *
     * @param beanClass javabean.class
     * @return T
     */
    public <T> T mapping(Class<T> beanClass) {
        return (T) BeanInjector.inject(beanClass, getRequest());
    }

    /**
     * 表单值映射为javabean
     *
     * @param prefix    name前缀
     * @param beanClass javabean.class
     * @return T
     */
    public <T> T mapping(String prefix, Class<T> beanClass) {
        return (T) BeanInjector.inject(beanClass, prefix, getRequest());
    }

    /**
     * 表单值映射为CMap
     *
     * @return CMap
     */
    public CMap getCMap() {
        return BeanInjector.injectMaps(getRequest());
    }

    /**
     * 表单值映射为CMap
     *
     * @param prefix name前缀
     * @return CMap
     */
    public CMap getCMap(String prefix) {
        return BeanInjector.injectMaps(prefix, getRequest());
    }

    /**===========================     convert    ===============================================  */

    /**
     * 强转String
     */
    public String toStr(Object value) {
        return Convert.toStr(value);
    }

    /**
     * 强转String
     */
    public String toStr(Object value, String defaultValue) {
        return Convert.toStr(value, defaultValue);
    }

    /**
     * 强转Integer
     */
    public Integer toInt(Object value) {
        return Convert.toInt(value);
    }

    /**
     * 强转Integer
     */
    public Integer toInt(Object value, Integer defaultValue) {
        return Convert.toInt(value, defaultValue);
    }

    /**
     * 强转Long
     */
    public Long toLong(Object value) {
        return Convert.toLong(value);
    }

    /**
     * 强转Long
     */
    public Long toLong(Object value, Long defaultValue) {
        return Convert.toLong(value, defaultValue);
    }

    /**
     * 强转Float
     */
    public Float toFloat(Object value) {
        return Convert.toFloat(value);
    }

    /**
     * 强转Float
     */
    public Float toFloat(Object value, Float defaultValue) {
        return Convert.toFloat(value, defaultValue);
    }

    /**
     * 强转BigDecimal
     */
    public BigDecimal toBigDecimal(Object value) {
        return Convert.toBigDecimal(value);
    }

    /**
     * 强转BigDecimal
     */
    public BigDecimal toBigDecimal(Object value, BigDecimal defaultValue) {
        return Convert.toBigDecimal(value, defaultValue);
    }

    /**
     * 强转String数组
     */
    public String[] toArray(String str) {
        return Convert.toStrArray(str);
    }

    /**
     * 强转String数组
     */
    public String[] toArray(String split, String str) {
        return Convert.toStrArray(split, str);
    }

    /**
     * 强转Integer数组
     */
    public Integer[] toIntArray(String str) {
        return Convert.toIntArray(str);
    }

    /**
     * 强转Integer数组
     */
    public Integer[] toIntArray(String split, String str) {
        return Convert.toIntArray(split, str);
    }

    /**
     * encode
     */
    public String encode(String value) {
        return URLKit.encode(value, CharsetKit.UTF_8);
    }

    /**
     * decode
     */
    public String decode(String value) {
        return URLKit.decode(value, CharsetKit.UTF_8);
    }

    /** ============================     ajax    =================================================  */

    /**
     * 返回ajaxresult
     *
     * @param data
     * @return AjaxResult
     */
    public AjaxResult json(Object data) {
        return new AjaxResult().success(data);
    }

    /**
     * 返回ajaxresult
     *
     * @param data
     * @param message
     * @return AjaxResult
     */
    public AjaxResult json(Object data, String message) {
        return json(data).setMessage(message);
    }

    /**
     * 返回ajaxresult
     *
     * @param data
     * @param message
     * @param code
     * @return AjaxResult
     */
    public AjaxResult json(Object data, String message, int code) {
        return json(data, message).setCode(code);
    }

    /**
     * 返回ajaxresult
     *
     * @param message
     * @return AjaxResult
     */
    public AjaxResult success(String message) {
        return new AjaxResult().addSuccess(message);
    }

    /**
     * 返回ajaxresult
     *
     * @param message
     * @return AjaxResult
     */
    public AjaxResult error(String message) {
        return new AjaxResult().addError(message);
    }

    /**
     * 返回ajaxresult
     *
     * @param message
     * @return AjaxResult
     */
    public AjaxResult warn(String message) {
        return new AjaxResult().addWarn(message);
    }

    /**
     * 返回ajaxresult
     *
     * @param message
     * @return AjaxResult
     */
    public AjaxResult fail(String message) {
        return new AjaxResult().addFail(message);
    }

}