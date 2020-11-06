package com.fjzxdz.ams.common.aop;

import com.fjzxdz.ams.common.annotation.ApiValid;
import cn.fjzxdz.frame.license.utils.Utils;
import cn.fjzxdz.frame.pojo.R;
import com.fjzxdz.ams.common.generate.utils.JedisUtils;
import com.fjzxdz.ams.module.enums.RegionCodeEnum;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.sitemesh.webapp.contentfilter.HttpServletRequestFilterable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.*;

/**
 * @ClassName ApiAop
 * @Description 接口调用校验注解，判断接口调用频率是否过高、传参是否合法
 * @Author ZhangGQ
 * @Date 2019/10/24 0024 下午 2:51
 * @Version 1.0
 */
@Aspect
@Component
public class ApiValidAop {

    Logger log = LoggerFactory.getLogger(ApiValidAop.class);

    /**
     * 单位时间
     */
    @Value("${api.visit.interval}")
    private Long apiVisitInterval;
    /**
     * 单位时间内访问次数
     */
    @Value("${api.visit.count}")
    private Integer apiVisitCount;
    /**
     * Redis缓存时间
     */
    @Value("${api.visit.data.cachesecond}")
    private Integer apiVisitDataCacheSecond;

    @Before("@annotation(apiValid)")
    public void apiValid(JoinPoint point, ApiValid apiValid) {
        try {
            Object[] paramObjs = point.getArgs();
            if (paramObjs.length > 0) {

                HttpServletRequestFilterable requestFilterable = null;
                for (Object obj : paramObjs) {
                    if (obj instanceof HttpServletRequestFilterable) {
                        requestFilterable = (HttpServletRequestFilterable) obj;
                        break;
                    }
                }
                if (requestFilterable == null) {
                    throw new Exception("接口参数错误，请确认参数是否正确");
                }

                //接口调用次数校验
                this.validRequestCount(point, requestFilterable, apiValid);
                //参数校验
                this.validRequestParams(requestFilterable, apiValid);
            } else {
                throw new Exception("接口参数错误，请确认参数是否正确");
            }
        } catch (Exception ex) {
            log.error(ex.getMessage());
            ServletRequestAttributes res = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletResponse response = res.getResponse();
            response.setCharacterEncoding("UTF-8");
            response.setContentType(MediaType.APPLICATION_JSON_UTF8_VALUE);
            response.setStatus(HttpStatus.BAD_REQUEST.value());

            OutputStream os = null;
            try {
                os = response.getOutputStream();
                os.write(R.error(ex).toString().getBytes("UTF-8"));
            } catch (Exception e) {
                log.error(e.getMessage());
            } finally {
                try {
                    if (os != null) {
                        os.close();
                    }
                } catch (Exception e) {
                    log.error(e.getMessage());
                }
            }
        }
    }

    /**
     * 校验接口调用次数
     *
     * @param requestFilterable
     * @param apiValid
     * @throws Exception
     */
    private void validRequestCount(JoinPoint point, HttpServletRequestFilterable requestFilterable, ApiValid apiValid) throws Exception {
        //客户端IP地址
        String clientAddress = requestFilterable.getRemoteAddr();
        String className = point.getTarget().getClass().getSimpleName();
        String methodName = StringUtils.isEmpty(apiValid.name()) ? point.getSignature().getName() : apiValid.name();
        String key = String.format("%s_%s_%s", clientAddress, className, methodName);

        Timestamp now = Utils.getTimestamp();
        if (JedisUtils.exists(key)) {
            List<Long> list = (List<Long>) JedisUtils.getObject(key);
            List<Long> subList = new ArrayList<>();
            if (list.size() > this.apiVisitCount) {
                subList = list.subList(list.size() - this.apiVisitCount, list.size());
            } else {
                subList = list;
            }
            Long firstTime = subList.size()>0 ? subList.get(0) : Utils.getTimestampZero().getTime();
            Long interval = now.getTime() - firstTime;
            if (interval < this.apiVisitInterval) {
                list.add(now.getTime());
                JedisUtils.setObject(key, list, this.apiVisitDataCacheSecond);
                throw new Exception("接口访问频率过高");
            }
            list.add(now.getTime());
            JedisUtils.setObject(key, list, this.apiVisitDataCacheSecond);
        } else {
            List<Long> list = new ArrayList();
            list.add(now.getTime());

            JedisUtils.setObject(key, list, this.apiVisitDataCacheSecond);
        }
    }

    /**
     * 参数合法性校验
     *
     * @param requestFilterable
     * @return
     * @throws Exception
     */
    private R validRequestParams(HttpServletRequestFilterable requestFilterable, ApiValid apiValid) throws Exception {
        ServletRequest request = requestFilterable.getRequest();
        Map<String, String[]> paramMap = request.getParameterMap();
        if (!paramMap.containsKey("token")) {
            throw new Exception("接口参数错误，请确认参数是否正确");
        }

        String[] tokens = paramMap.get("token");
        String token = tokens.length > 0 ? tokens[0] : "";
        if (StringUtils.isEmpty(token) || !RegionCodeEnum.containKey(token)) {
            throw new Exception("接口参数错误，请确认参数是否正确");
        } else if (apiValid.value().length > 0) {
            Boolean isContain = false;
            for (String val : apiValid.value()) {
                if (val.equals(token)) {
                    isContain = true;
                    break;
                }
            }
            if (!isContain) {
                throw new Exception("接口参数错误，请确认参数是否正确");
            }
        }

        for (Map.Entry<String, String[]> entry : paramMap.entrySet()) {
            String paramName = entry.getKey();
            String[] paramVals = entry.getValue();

            for (String paramVal : paramVals) {
                if (paramVal.toLowerCase().contains("select") || paramVal.toLowerCase().contains("update") || paramVal.toLowerCase().contains("delete")) {
                    throw new Exception("接口参数不合法！");
                }
            }
        }
        return null;
    }

    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>();
        for(int i = 0; i<50; i++){
            list.add(i);
        }

        List<Integer> temp = list.subList(list.size()-10,list.size());

        for (Integer integer : temp) {
            System.out.println(integer);
        }

    }
}
