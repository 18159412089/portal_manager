package cn.fjzxdz.frame.toolbox.util;

import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * sql语句工具类
 */
public class SqlUtil {

    /**
     * @Description 根据集合的大小，输出相应个数"?"
     * @author fengshuonan
     */
    public static String parse(List<?> list) {
        String str = "";
        if (list != null && list.size() > 0) {
            str = str + "?";
            for (int i = 1; i < list.size(); i++) {
                str = str + ",?";
            }
        }
        return str;
    }

    /**
     * 拼接sql   "1,2,3,4" --> '1','2'
     * @param str "中国" 或者是"中国,美国，。。。"
     * @return
     */
    public static String toSqlStr(String str) {
        String sqlStr=null;
        if(ToolUtil.isNotEmpty(str)) {
            String[] strs=str.split(",");
            sqlStr="'" + StringUtils.join(strs,"','") +"'";
        }
        return sqlStr;
    }

    /**
     * sql 模糊查询  例： "中国" --》 "%中国%"
     * @param str  "中国"
     * @return  "%中国%"
     */
    public static String toSqlStr_like(String str) {
        String sqlStr=null;
        if(ToolUtil.isNotEmpty(str)) {
            sqlStr = "'%" + str + "%'";
        }
        return sqlStr;
    }

    /**
     * in 查询
     * @param list
     * @return
     */
    public static String toSqlIn(List list) {
        String join = StringUtils.join(list, ",");
        return toSqlStr(join);
    }


    /**
     * 字符串转化集合
     * @param str
     * @return
     */
    public static List<String> strToList(String str){
        if(ToolUtil.isNotEmpty(str)) {
            return Arrays.asList(str.split(","));
        }
        return new ArrayList<String>();
    }


    public static void main(String[] args) {
        ArrayList<Object> arrayList = new ArrayList<>();
        arrayList.add(2);
        arrayList.add(2);
        System.out.println(parse(arrayList));
        System.out.println(toSqlStr("2,3,4"));
        System.out.println(toSqlStr_like("都得"));
    }
}
