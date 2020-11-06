package cn.fjzxdz.frame.common;

import java.math.BigDecimal;

public class Constants {
    //用户的初始密码
    //public static final String INIT_PWD = "zzhb12369";
    public static final String INIT_PWD = "123456";

    public static final String COMPANY = "A&L Canada Laboratories Inc.";

    public static final String PAGE_LIKE = "*";

    public static final String SQL_LIKE = "%";

    public static final String SQL_NULL = "null";

    public static final String SQL_NOT_NULL = "!null";

    public static final String YES = "Y";

    public static final String NO = "N";

    public static final String SOILCL_KEY = "SOILCL.";

    public static final String SOILEC_KEY = "SOILEC.";

    public static final String SOILN_KEY = "SOILN.";
    
    public static final String SOIL_ICP_KEY = "SOIL.TXT";
    
    public static final String SOIL_BICARB_KEY = "\\d{5}.CSV";
    
    public static final String SOIL_OM_KEY = "om000two.dbf";
    
    public static final String SOIL_PH_KEY = "phdat";
    
    public static final String SOIL_PH_PATTERN = "phdat[0-3]\\d{2}.dbf";    
    
    public static final String SOIL_BPH_KEY = "smp";
    
    public static final String SOIL_BPH_PATTERN = "smp[0-3]\\d{2}x.dbf";    
    
    public static final String PLANTCL_KEY = "PLANTCL.";

    public static final String PLANTN_KEY = "PLANTN.";
    
    public static final String PLANTNT_KEY = "FOSSN.";
    
    public static final String FEEDN_KEY = "FOSS.";
    
    public static final String PLANTM_KEY = "PLANTM.";
    
    public static final String PLANT_ICP_KEY = "PTICP.TXT";
    
    public static final String PLANT_LECO_KEY = "RESULTS.CSV";
    
    public static final String PLANT_LACHET_KEY = "RESULTS.CSV";
    
    public static final String SOIL_LACHET_KEY = "RESULTS.CSV";
    
    public static final String ENV_LACHET_KEY = "ENVIRO.XLS[X]?";
    
    public static final String FERT_LACHET_KEY = "FERTILIZER.XLS[X]?";
    
    public static final String MANU_LACHET_KEY = "MANURE.XLS[X]?";
    
    public static final String FERT_LECO_KEY = "RESULTS.CSV";
    
    public static final String MANU_LECO_KEY = "RESULTS.CSV";
    
    public static final String ENV_LECO_KEY = "RESULTS.CSV";
    
    public static final String MANU_DATA_KEY = "M-\\d{3}.XLS[X]?";
    
    public static final String FEED_ICP_PATTERN = "F[0-3]\\d{2}.XLS[X]?";
    
    public static final String FEED_ADF_PATTERN = "F[0-3]\\d{2}-ADF.XLS[X]?";
    
    public static final String FEED_NDF_PATTERN = "F[0-3]\\d{2}-NDF.XLS[X]?";
    
    public static final String FEED_SP_PATTERN = "F[0-3]\\d{2}-SP.XLS[X]?";
    
    public static final String FEED_M_PATTERN = "F[0-3]\\d{2}-M.XLS[X]?";
    
    public static final String FEED_LIGNIN_PATTERN = "F[0-3]\\d{2}-LIGNIN.XLS[X]?";
    
    public static final String FEED_CF_PATTERN = "F[0-3]\\d{2}-CF.XLS[X]?";
    
    public static final String FEED_NIR_PATTERN = "F[0-3]\\d{2}-NIR.XLS[X]?";
    
    public static final String FEED_LACHET_PATTERN = "F[0-3]\\d{2}-LACHET.XLS[X]?";

    public static final String FILE_SEPARATOR = System.getProperty("file.separator");

    public static final String PDF_FILE_EXTENTION = ".pdf";
    
    public static final String DBF_FILE_EXTENTION = ".dbf";
    
    public static final String ID_SEPARATOR = "-";

    public static final String CANADA_DIST = "C";
    
    public static final String COMMA = ",";
    
    public static final String MISC_REPORT_NAME = "AL-MISC";
    
    public static final BigDecimal DECIMAL_NEGATIVE_NINE = new BigDecimal("-9");
    
    public static final BigDecimal DECIMAL_NEGATIVE_THREE = new BigDecimal("-3");
    
    public static final Integer INTEGER_NEGATIVE_NINE = new Integer("-9");
    
    public static final String SOIL_TEST = "soil-test";
    
    public static final String PLANT_TEST = "plant-test";
    
    public static final String FERT_TEST = "fert-test";
    
    public static final String FEED_TEST = "feed-test";
    
    public static final String MANU_TEST = "manu-test";
    
    public static final String ENV_TEST = "env-test";
    
    public static final String BIO_TEST = "bio-test";
    
    public static final String QUOTE_TEST = "quote-test";
    
    public static final String COMMENTS_TEST = "comments-test";
    
    public static final String SUMMARY_TEST = "summary-test";
    
    public static final String NUTRIENTREMOVAL_TEST = "nutrientremoval-test";
    
    public static final String DEFAULT_LOGO_FILE_NAME = "default";
}
