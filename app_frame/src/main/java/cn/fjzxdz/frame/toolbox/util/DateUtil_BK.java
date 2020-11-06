package cn.fjzxdz.frame.toolbox.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @className: DataUtil
 * @description: TODO
 * @author: lianhuinan
 * @create: 2019-10-16 15:18
 * @version: 1.0
 */
public final class DateUtil_BK {

    /**
     * 常用的日期时间格式
     **/
    public final static SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");

    public final static SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");

    public final static SimpleDateFormat M = new SimpleDateFormat("M");

    public final static SimpleDateFormat MM = new SimpleDateFormat("MM");

    public final static SimpleDateFormat MM_dd = new SimpleDateFormat("MM-dd");

    public final static SimpleDateFormat dd = new SimpleDateFormat("dd");

    public final static SimpleDateFormat yyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");

    public final static SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");

    public final static SimpleDateFormat yyyy_MM_dd_HH = new SimpleDateFormat("yyyy-MM-dd HH");

    public final static SimpleDateFormat dd_HH = new SimpleDateFormat("dd HH");

    public final static SimpleDateFormat yyyy_MM_dd_HH_mm_ss = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public final static SimpleDateFormat yyyy_MM_dd_hh_mm_ss = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

    public final static SimpleDateFormat yyyy_MM_dd_HH_mm_ss_SSS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    public final static SimpleDateFormat yyyy_MM_dd_hh_mm_ss_SSS = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");

    public final static SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");

    /**=============================    转化为Calendar类型   ========================================================**/
    /**
     * @Author lianhuinan
     * @Description //TODO(Date类型转Calender类型)
     * @Date 2019/10/16 0016 16:49
     * @param date
     * @return java.util.Calendar
     * @version 1.0
     **/
    public final static Calendar date2Calendar(Date date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(String类型转Calender类型)
     * @Date 2019/10/16 0016 16:49
     * @param date
     * @param sdf SimpleDateFormat转化格式
     * @return java.util.Calendar
     * @version 1.0
     **/
    public final static Calendar str2Calendar(String date, SimpleDateFormat sdf) throws ParseException {
        if(sdf == null){
            sdf = yyyy_MM_dd;
        }
        return date2Calendar(sdf.parse(date));
    }

    /**=============================    转化为Date类型   ============================================================**/
    /**
     * @Author lianhuinan
     * @Description //TODO(String类型转Date类型)
     * @Date 2019/10/16 0016 15:49
     * @param dateStr 日期格式
     * @param sdf SimpleDateFormat转化格式
     * @return java.util.Date
     **/
    public final static Date parse2Date(String dateStr, SimpleDateFormat sdf) throws ParseException {
        if(sdf == null){
            sdf = yyyy_MM_dd;
        }
        return sdf.parse(dateStr);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取某天的00时，yyyy-MM-dd HH)
     * @Date 2019/10/18 0018 13:51
     * @param date
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date getMinHour(Date date){
        Calendar calendar = date2Calendar(date);
        calendar.set(Calendar.HOUR_OF_DAY, calendar.getActualMinimum(Calendar.HOUR));
        return calendar.getTime();
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取某天的23时，yyyy-MM-dd HH)
     * @Date 2019/10/18 0018 13:51
     * @param date
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date getMaxHour(Date date){
        Calendar calendar = date2Calendar(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        return calendar.getTime();
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取该年-月-日的最后一天)
     * @Date 2019/10/16 0016 18:02
     * @param yearMonth "2019-01-01"，若不是该格式需传入SimpleDateFormat的格式化类型
     * @param sdf ：null 默认为yyyy-MM-dd
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date getLastDateOfMonthYear(String yearMonth, SimpleDateFormat sdf) throws ParseException {
        Date date = parse2Date(yearMonth, sdf);
        return getLastDateOfMonthYear(date);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取该年-月-日的第一天)
     * @Date 2019/10/16 0016 18:02
     * @param yearMonth
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date getFirstDateOfMonthYear(Date yearMonth){
        Calendar calendar = date2Calendar(yearMonth);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取该年-月-日的最后一天)
     * @Date 2019/10/16 0016 18:02
     * @param yearMonth
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date getLastDateOfMonthYear(Date yearMonth){
        Calendar calendar = date2Calendar(yearMonth);
        int lastDay=calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, lastDay);
        return calendar.getTime();
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(修改时间：添加或减去指定的时间量。例如，要从日历的时间减去 5天)
     * @Date 2019/10/17 0017 15:02
     * @param date
     * @param CalendarType
     * @param amount
     * @return java.util.Date
     * @version 1.0
     **/
    public final static Date add(Date date, int CalendarType, int amount){
        Calendar calendar = date2Calendar(date);
        calendar.add(CalendarType, amount);
        return calendar.getTime();
    }

    /**=============================    转化为String类型   ==========================================================**/
    /**
     * @Author lianhuinan
     * @Description //TODO(Date类型转String类型)
     * @Date 2019/10/16 0016 17:04
     * @param date
     * @param sdf
     * @return java.lang.String
     * @version 1.0
     **/
    public final static String date2String(Date date, SimpleDateFormat sdf){
        if (sdf == null){
            sdf = yyyy_MM_dd;
        }
        return sdf.format(date);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取指定类型日期的日期号)
     * @Date 2019/10/16 0016 17:13
     * @param date
     * @param CalendarType 为Calender的取值类型
     * @return java.lang.String
     * @version 1.0
     * @param CalendarType 0；ERA
     * @param CalendarType 1；YEAR
     * @param CalendarType 2；MONTH
     * @param CalendarType 3；WEEK_OF_YEAR
     * @param CalendarType 4；WEEK_OF_MONTH
     * @param CalendarType 5；DATE / DAY_OF_MONTH
     * @param CalendarType 6；DAY_OF_YEAR
     * @param CalendarType 7；DAY_OF_WEEK
     * @param CalendarType 10；HOUR / HOUR_OF_DAY
     * @param CalendarType 12；MINUTE
     * @param CalendarType 13；SECOND
     * @param CalendarType 14；MILLISECOND
     **/
    public final static String get(Date date, int CalendarType){
        Calendar calendar = date2Calendar(date);
        int val = calendar.get(CalendarType);
        if(CalendarType == 2){
            val += 1;
            if(val < 10){ return "0" + val;}
            else{ return val + "";}
        }else{
            return val+"";
        }
    }

    /**================================     Map类型(echarts图表的日期排序)      ======================================**/
    /**
     * @Author lianhuinan
     * @Description //TODO(两个时间区间获取yyyy-MM-dd HH的日期。比如：2019-01-01 00~2019-03-22 12)
     * @Date 2019/10/17 0017 15:59
     * @param start
     * @param end
     * @param period 默认为：1
     * @param sdf
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> getHoursBetweenDate(Date start, Date end, Integer period, SimpleDateFormat sdf) {
        Map<String, Object> map = new HashMap<>(4);
        Map<String, Object> indexmap = new HashMap<>();
        if(sdf == null){
            sdf = yyyy_MM_dd_HH;
        }
        if(period == null){
            period = 1;
        }
        List<String> xList = new ArrayList<String>();
        map.put("startTime", sdf.format(start));
        map.put("endTime", sdf.format(end));
        int i = 0;
        while(start.compareTo(end)<=0) {//<=0时，是有end这一天的数值
            xList.add(sdf.format(start));
            indexmap.put(sdf.format(start), i++);
            start = add(start,Calendar.HOUR, period);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(两个时间区间获取yyyy-MM-dd的日期。比如：2019-01-01~2019-03-22)
     * @Date 2019/10/17 0017 15:46
     * @param start
     * @param end
     * @param period 默认为：1
     * @param sdf 建议为空
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> getDaysBetweenDate(Date start, Date end, Integer period, SimpleDateFormat sdf) {
        Map<String, Object> map = new HashMap<>(4);
        Map<String, Object> indexmap = new HashMap<>();
        if(sdf == null){
            sdf = yyyy_MM_dd;
        }
        if(period == null){
            period = 1;
        }
        List<String> xList = new ArrayList<String>();
        map.put("startTime", sdf.format(start));
        map.put("endTime", sdf.format(end));
        int i = 0;
        while(start.compareTo(end)<=0) {//<=0时，是有end这一天的数值
            xList.add(sdf.format(start));
            indexmap.put(sdf.format(start), i++);
            start = add(start,Calendar.DATE, 1);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(两个时间区间获取yyyy-MM-dd的日期。比如：2019-01-01~2019-03-22)
     * @Date 2019/10/17 0017 15:46
     * @param start
     * @param end
     * @param period 默认为：1
     * @param sdf 建议为空
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> getWeeksBetweenDate(Date start, Date end, Integer period, SimpleDateFormat sdf) {
        Map<String, Object> map = new HashMap<>(4);
        Map<String, Object> indexmap = new HashMap<>();
        if(sdf == null){
            sdf = yyyy_MM_dd;
        }
        if(period == null){
            period = 1;
        }
        List<String> xList = new ArrayList<String>();
        map.put("startTime", sdf.format(start));
        map.put("endTime", sdf.format(end));
        int i = 0;
        while(start.compareTo(end)<=0) {//<=0时，是有end这一天的数值
            xList.add(sdf.format(start));
            indexmap.put(sdf.format(start), i++);
            start = add(start,Calendar.DAY_OF_WEEK, 1);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(两个时间区间获取yyyy-MM的日期。比如：2019-01-01~2019-03-22)
     * @Date 2019/10/17 0017 16:16
     * @param start
     * @param end
     * @param period 默认为：1
     * @param sdf 建议为空
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> getMonthsBetweenDate(Date start, Date end, Integer period, SimpleDateFormat sdf) {
        Map<String, Object> map = new HashMap<>(4);
        Map<String, Object> indexmap = new HashMap<>();
        if(sdf == null){
            sdf = yyyy_MM;
        }
        if(period == null){
            period = 1;
        }
        List<String> xList = new ArrayList<String>();
        map.put("startTime", sdf.format(start));
        map.put("endTime", sdf.format(end));
        int i = 0;
        while(start.compareTo(end)<=0) {//<=0时，是有end这一天的数值
            xList.add(sdf.format(start));
            indexmap.put(sdf.format(start), i++);
            start = add(start,Calendar.MONTH, 1);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(两个时间区间获取yyyy的日期。)
     * @Date 2019/10/17 0017 16:16
     * @param start
     * @param end
     * @param period 默认为：1
     * @param sdf 建议为空
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> getYearsBetweenDate(Date start, Date end, Integer period, SimpleDateFormat sdf) {
        Map<String, Object> map = new HashMap<>(4);
        Map<String, Object> indexmap = new HashMap<>();
        if(sdf == null){
            sdf = yyyy;
        }
        if(period == null){
            period = 1;
        }
        List<String> xList = new ArrayList<String>();
        map.put("startTime", sdf.format(start));
        map.put("endTime", sdf.format(end));
        int i = 0;
        while(start.compareTo(end)<=0) {//<=0时，是有end这一天的数值
            xList.add(sdf.format(start));
            indexmap.put(sdf.format(start), i++);
            start = add(start,Calendar.YEAR, 1);
        }
        map.put("xList", xList);
        map.put("indexmap", indexmap);
        return map;
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取前十二个月,比如：2018-10~2019-10)
     * @Date 2019/10/17 0017 14:50
     * @param end
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public static Map<String, Object> get12Months(Date end) {
        Date start = add(end, Calendar.YEAR, -1);//add(end, Calendar.MONTH, -12);
        return getMonthsBetweenDate(start, end, null, null);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取某年的yyyy-MM-dd的日期)
     * @Date 2019/10/17 0017 16:40
     * @param year
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public final static Map<String, Object> getDaysOfYear(Date year) throws ParseException {
        Calendar calendar = date2Calendar(year);
        Date start = yyyy_MM_dd.parse(calendar.get(Calendar.YEAR) + "-01-01");
        Date end = yyyy_MM_dd.parse(calendar.get(Calendar.YEAR) + "-12-31");
        return getDaysBetweenDate(start, end, null, MM_dd);
    }

    public final static Map<String, Object> getDaysOfMonth(Date yearMonth) throws ParseException {
        Calendar calendar = date2Calendar(yearMonth);
        calendar.set(Calendar.DAY_OF_MONTH, 0);
        Date start = yyyy_MM_dd.parse(calendar.get(Calendar.YEAR) + "-01-01");
        Date end = getLastDateOfMonthYear(yearMonth);
        return getDaysBetweenDate(start, end, null, MM_dd);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取前30天,比如：2019-09-17~2019-10-17)
     * @Date 2019/10/17 0017 15:14
     * @param end
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public final static Map<String, Object> getDaysOfLastMonth(Date end) {
        Date start = add(end, Calendar.MONTH, -1);
        return getDaysBetweenDate(start, end, null, null);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取前30天,比如：2019-09-17~2019-10-17)
     * @Date 2019/10/17 0017 15:14
     * @param end
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public final static Map<String, Object> get30Days(Date end) {
        Date start = add(end, Calendar.DATE, -30);//-29数值才对
        return getDaysBetweenDate(start, end, null, null);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取过去24个小时,比如：2019-10-16 15~2019-10-17 15)
     * @Date 2019/10/17 0017 15:14
     * @param end
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public final static Map<String, Object> get24Hours(Date end) {
        Date start = add(end, Calendar.DATE, -1);
        return getHoursBetweenDate(start, end, null, null);
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取过去interval小时区间的间隔period小时yyyy-MM-dd HH的日期时间集合)
     * @Date 2019/10/18 0018 9:41
     * @param end
     * @param interval
     * @param period
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
    public final static Map<String, Object> getHoursWithIntervalAndPeriod(Date end, Integer interval, Integer period) {
        Date start = add(end, Calendar.HOUR, -interval);
        return getHoursBetweenDate(start, end, period, null);
    }

    public static void main(String[] args) throws ParseException {
        Date date = new Date();
        Date date2 = yyyy_MM_dd.parse("2019-8-17");
        System.out.println(getWeeksBetweenDate(date2, date, null, null));
    }
}
