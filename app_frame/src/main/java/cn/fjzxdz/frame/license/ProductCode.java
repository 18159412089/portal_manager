package cn.fjzxdz.frame.license;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author dai
 */
@Component
public class ProductCode {
    public  static String PRODUCT_CODE = "FJZX_DEV";

    @Value("${fjzx.productCode:FJZX_DEV}")
    public void setProductCode(String productCode) {
            PRODUCT_CODE = productCode;
    }
}
