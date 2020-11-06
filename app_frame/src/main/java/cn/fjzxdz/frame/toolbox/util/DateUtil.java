package cn.fjzxdz.frame.toolbox.util;

import io.netty.util.internal.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {
    private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");

    private final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    private final static SimpleDateFormat sdfDays = new SimpleDateFormat("yyyyMMdd");

    private final static SimpleDateFormat sdfHour = new SimpleDateFormat("yyyy-MM-dd HH");

    private final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private final static SimpleDateFormat sdfmsTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    private final static SimpleDateFormat allTime = new SimpleDateFormat("yyyyMMddHHmmss");


    /**
     * 获取YYYY格式
     *
     * @return
     */
    public static String getYear() {
        return sdfYear.format(new Date());
    }

    /**
     * 获取YYYY格式
     *
     * @return
     */
    public static String getYear(Date date) {
        return sdfYear.format(date);
    }

    /**
     * 获取YYYY-MM-DD格式
     *
     * @return
     */
    public static String getDay() {
        return sdfDay.format(new Date());
    }

    /**
     * 获取YYYY-MM-DD格式
     *
     * @return
     */
    public static String getDay(Date date) {
        return sdfDay.format(date);
    }

    /**
     * 获取YYYYMMDD格式
     *
     * @return
     */
    public static String getDays() {
        return sdfDays.format(new Date());
    }

    /**
     * 获取YYYYMMDD格式
     *
     * @return
     */
    public static String getDays(Date date) {
        return sdfDays.format(date);
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式
     *
     * @return
     */
    public static String getTime() {
        return sdfTime.format(new Date());
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss.SSS格式
     *
     * @return
     */
    public static String getMsTime() {
        return sdfmsTime.format(new Date());
    }

    /**
     * 获取YYYYMMDDHHmmss格式
     *
     * @return
     */
    public static String getAllTime() {
        return allTime.format(new Date());
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式
     *
     * @return
     */
    public static String getTime(Date date) {
        return sdfTime.format(date);
    }

    /**
     * @param s
     * @param e
     * @return boolean
     * @throws
     * @Title: compareDate
     * @Description:(日期比较，如果s>=e 返回true 否则返回false)
     * @author luguosui
     */
    public static boolean compareDate(String s, String e) {
        if (parseDate(s) == null || parseDate(e) == null) {
            return false;
        }
        return parseDate(s).getTime() >= parseDate(e).getTime();
    }

    /***
     * 比较时间精确到小时
     * @param s
     * @param e
     * @return
     * @Description:(日期比较，如果s>=e 返回true 否则返回false)
     */
    public static boolean compareDateHour(String s, String e) {
        if (parseDateHour(s) == null || parseDateHour(e) == null) {
            return false;
        }
        return parseDateHour(s).getTime() >= parseDateHour(e).getTime();
    }


    /**
     * 格式化日期
     *
     * @return
     */
    public static Date parseDateHour(String date) {
        try {
            return sdfHour.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * 格式化日期
     *
     * @return
     */
    public static Date parseDate(String date) {
        try {
            return sdfDay.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 格式化日期
     *
     * @return
     */
    public static Date parseTime(String date) {
        try {
            return sdfTime.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 格式化日期
     *
     * @return
     */
    public static Date parse(String date, String pattern) {
        DateFormat fmt = new SimpleDateFormat(pattern);
        try {
            return fmt.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 格式化日期
     *
     * @return
     */
    public static String format(Date date, String pattern) {
        DateFormat fmt = new SimpleDateFormat(pattern);
        return fmt.format(date);
    }

    /**
     * 把日期转换为Timestamp
     *
     * @param date
     * @return
     */
    public static Timestamp format(Date date) {
        return new Timestamp(date.getTime());
    }

    /**
     * 校验日期是否合法
     *
     * @return
     */
    public static boolean isValidDate(String s) {
        try {
            sdfTime.parse(s);
            return true;
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return false;
        }
    }

    /**
     * 校验日期是否合法
     *
     * @return
     */
    public static boolean isValidDate(String s, String pattern) {
        DateFormat fmt = new SimpleDateFormat(pattern);
        try {
            fmt.parse(s);
            return true;
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return false;
        }
    }

    public static int getDiffYear(String startTime, String endTime) {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        try {
            int years = (int) (((fmt.parse(endTime).getTime() - fmt.parse(
                    startTime).getTime()) / (1000 * 60 * 60 * 24)) / 365);
            return years;
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return 0;
        }
    }

    /**
     *  两个时间相差多少小时
     * @param startTime
     * @param endTime
     * @return
     */

    public static double getDiffHour(String startTime, String endTime)   {
        if(StringUtil.isNullOrEmpty(startTime) || StringUtil.isNullOrEmpty(endTime) ){
            return 0;
        }
        if( !(isLegalDate(startTime)&&isLegalDate(endTime))){
              return -1;
        }
        double hour = 0;
        long time1 = 0;
        long time2 = 0 ;
        try {
                time1 = sdfTime.parse(startTime).getTime();
                time2 = sdfTime.parse(endTime).getTime();
        } catch (ParseException e) {
            e.printStackTrace();
            return -1 ;
        }
        long diff;
        if (time1 < time2) {
            diff = time2 - time1;
        } else {
            diff = time1 - time2;
        }
        hour = (diff / (60 * 60 * 1000));
        return hour;
    }

    /**
     * 判断时间格式是否为 yyyy-MM-dd HH:mm:ss
     * @param sDate
     * @return
     */
    private static boolean isLegalDate(String sDate) {

        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date date = formatter.parse(sDate);
            return sDate.equals(formatter.format(date));
        } catch (Exception e) {
            return false;
        }

    }


    /**
     * <li>功能描述：时间相减得到天数
     *
     * @param beginDateStr
     * @param endDateStr
     * @return long
     * @author Administrator
     */
    public static long getDaySub(String beginDateStr, String endDateStr) {
        long day = 0;
        SimpleDateFormat format = new SimpleDateFormat(
                "yyyy-MM-dd");
        Date beginDate = null;
        Date endDate = null;

        try {
            beginDate = format.parse(beginDateStr);
            endDate = format.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        day = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
        // System.out.println("相隔的天数="+day);

        return day;
    }

    /**
     * 得到n天之后的日期
     *
     * @param days
     * @return
     */
    public static Date getAfterDayDate(String days) {
        int daysInt = Integer.parseInt(days);

        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
//        SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String dateStr = sdfd.format(date);

        return date;
    }

    /**
     * 得到n天之后是周几
     *
     * @param days
     * @return
     */
    public static String getAfterDayWeek(String days) {
        int daysInt = Integer.parseInt(days);

        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();

        SimpleDateFormat sdf = new SimpleDateFormat("E");
        String dateStr = sdf.format(date);

        return dateStr;
    }
    
    /**
     * 得到某年某个月的最后一天日期
     * @param date
     * @param pattern
     * @return
     */
    public static String getLastDayOfMonth(Date date,String pattern) {
    	if(pattern.equals("")) {
    		pattern="yyyy-MM";
    	}
    	String yearMonth=formatDate(date, pattern);
    	String year=yearMonth.split("-")[0];
    	String month=yearMonth.split("-")[1];
    	Calendar cal=Calendar.getInstance();
    	cal.set(Calendar.YEAR, Integer.parseInt(year));
    	cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
    	int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    	cal.set(Calendar.DAY_OF_MONTH, lastDay);
    	return formatCommonDate(cal.getTime());
    }
    
    /**
     * 得到某年某个月的最后一天日期
     * @param date
     * @param pattern
     * @return
     */
    public static String getLastDayOfMonth2(String date) {
    	String year=date.split("-")[0];
    	String month=date.split("-")[1];
    	Calendar cal=Calendar.getInstance();
    	cal.set(Calendar.YEAR, Integer.parseInt(year));
    	cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
    	int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    	cal.set(Calendar.DAY_OF_MONTH, lastDay);
    	return formatCommonDate(cal.getTime());
    }

    /**
     * The Constant LOG.
     */
    private static final Logger LOG = LogManager.getLogger(DateUtils.class);

    /**
     * The Constant MILLISECONDS_OF_ONE_DAY.
     */
    private static final int MILLISECONDS_OF_ONE_DAY = 1000 * 60 * 60 * 24;

    public static final SimpleDateFormat COMMON_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    public static final SimpleDateFormat MONTH_FORMAT = new SimpleDateFormat("yyyy-MM");
    public static final SimpleDateFormat DFORMAT = new SimpleDateFormat("dd");

    /**
     * The en locale.
     */
    private static Locale enLocale = new Locale("en", "US");

    /**
     * Instantiates a new date utils.
     */
    private DateUtil() {
    }

    public static String formatCommonDate(Date date) {
        return COMMON_FORMAT.format(date);
    }

    /**
     * Format date.
     *
     * @param date    the date
     * @param pattern the pattern
     * @return the string
     */
    public static String formatDate(Date date, String pattern) {
        if (date == null) {
            return "";
        }
        if (pattern == null) {
            pattern = "MM-dd-yyyy";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern, enLocale);
        return sdf.format(date);
    }

    /**
     * Format date time.
     *
     * @param date the date
     * @return the string
     */
    public static String formatDateTime(Date date) {
        return (formatDate(date, "MM-dd-yyyy HH:mm:ss"));
    }

    /**
     * Format date time.
     *
     * @return the string
     */
    public static String formatDateTime() {
        return (formatDate(now(), "MM-dd-yyyy HH:mm:ss"));
    }

    /**
     * Format date.
     *
     * @param date the date
     * @return the string
     */
    public static String formatDate(Date date) {
        return (formatDate(date, "MM-dd-yyyy"));
    }

    /**
     * Format date.
     *
     * @return the string
     */
    public static String formatDate() {
        return (formatDate(now(), "MM-dd-yyyy"));
    }

    /**
     * Format time.
     *
     * @param date the date
     * @return the string
     */
    public static String formatTime(Date date) {
        return (formatDate(date, "HH:mm:ss"));
    }

    /**
     * Format time no colon.
     *
     * @param date the date
     * @return the string
     */
    public static String formatTimeNoColon(Date date) {
        return (formatDate(date, "HHmmssSS"));
    }

    /**
     * Format time.
     *
     * @return the string
     */
    public static String formatTime() {
        return (formatDate(now(), "HH:mm:ss"));
    }

    /**
     * Format full time.
     *
     * @param date the date
     * @return the string
     */
    public static String formatFullTime(Date date) {
        return (formatDate(date, "HH:mm:ss SS a"));
    }

    /**
     * Now.
     *
     * @return the date
     */
    public static Date now() {
        return (new Date());
    }

    /**
     * Parses the datetime.
     *
     * @param datetime the datetime
     * @return the date
     * @throws ParseException the parse exception
     */
    public static Date parseDatetime(String datetime) throws ParseException {
        return parseDate(datetime, "MM-dd-yyyy HH:mm:ss", true);

    }

    /**
     * Specify whether or not date parsing is to be lenient. With lenient
     * parsing, the parser may use heuristics to interpret inputs that do not
     * precisely match this object's format. With strict parsing, inputs must
     * match this object's format. when the date is 2008-13-12 and
     * isLenient=false then throws parase exception when the date is 2008-13-12
     * and isLenient=true then return 2009-01-12.
     *
     * @param date      date
     * @param isLenient isLenient
     * @return Date
     * @throws ParseException ParseException
     */
    public static Date parseDate(String date, boolean isLenient) throws ParseException {
        return parseDate(date, "MM-dd-yyyy", isLenient);
    }

    /**
     * Format date.
     *
     * @param o the o
     * @return the string
     */
    public static String formatDate(Object o) {
        if (o == null) {
            return "";
        }
        if (o.getClass() == String.class) {
            return formatDate((String) o);
        } else if (o.getClass() == Date.class) {
            return formatDate((Date) o);
        } else if (o.getClass() == Timestamp.class) {
            return formatDate(new Date(((Timestamp) o).getTime()));
        } else {
            return o.toString();
        }
    }

    /**
     * Format date time.
     *
     * @param o the o
     * @return the string
     */
    public static String formatDateTime(Object o) {
        if ((o == null) || (o.toString().trim().length() == 0)) {
            return "";
        }
        if (o.getClass() == String.class) {
            return formatDateTime((String) o);
        } else if (o.getClass() == Date.class) {
            return formatDateTime((Date) o);
        } else if (o.getClass() == Timestamp.class) {
            return formatDateTime(new Date(((Timestamp) o).getTime()));
        } else {
            return o.toString();
        }
    }

    /**
     * Gets the date.
     *
     * @return the date
     * @throws ParseException the parse exception
     */
    public static Date getDate() throws ParseException {
        return parseDate(formatDate(), false);
    }

    /**
     * Parses the date.
     *
     * @param dateString the date string
     * @param pattern    the pattern
     * @return the date
     * @throws ParseException the parse exception
     */
    public static Date parseDate(String dateString, String pattern) throws ParseException {
        return parseDate(dateString, pattern, true);
    }

    /**
     * Date diff.
     *
     * @param startDay the start day
     * @param endDay   the end day
     * @return the int
     */
    public static int dateDiff(Date startDay, Date endDay) {
        if (startDay.after(endDay)) {
            Date temp = startDay;
            startDay = endDay;
            endDay = temp;
        }
        long sl = startDay.getTime();
        long el = endDay.getTime();
        long ei = el - sl;
        return (int) (ei / (MILLISECONDS_OF_ONE_DAY));
    }

    /**
     * Adds the date.
     *
     * @param date   the date
     * @param amount the amount
     * @return the date
     */
    public static Date addDate(Date date, int amount) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, amount); // calendar.DATE
        return calendar.getTime();
    }
    
    public static Date addHour(Date date, int amount) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.HOUR_OF_DAY, amount); // calendar.DATE
        return calendar.getTime();
    }

    /**
     * Adds the month.
     *
     * @param date   the date
     * @param amount the amount
     * @return the date
     */
    public static Date addMonth(Date date, int amount) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, amount); // calendar.MONTH
        return calendar.getTime();
    }

    /**
     * Adds the year.
     *
     * @param date   the date
     * @param amount the amount
     * @return the date
     */
    public static Date addYear(Date date, int amount) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.YEAR, amount); // calendar.YEAR
        return calendar.getTime();
    }
    
    /**
     * Adds the week.
     *
     * @param date   the date
     * @param amount the amount
     * @return the date
     */
    public static Date addWeek(Date date, int amount) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.WEEK_OF_YEAR, amount); // calendar.week
        return calendar.getTime();
    }

    /**
     * Gets the first day of current month.
     *
     * @return the first day of current month
     */
    public static Date getFirstDayOfCurrentMonth() {
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(new Date());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * Gets the first day of current month.
     *
     * @return the first day of current month
     */
    public static Date getLastDayOfMonth(String time) {
    	String[] ym = time.split("-");
    	
    	Calendar cal = Calendar.getInstance();
    	cal.set(Calendar.YEAR, Integer.parseInt(ym[0]));
    	cal.set(Calendar.MONTH, Integer.parseInt(ym[1])-1);
    	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        //设置日历中月份的最大天数
        cal.set(Calendar.DAY_OF_MONTH, lastDay);
        return cal.getTime();
    }
    /**
	 * 获取某年某月的第一天
	 * @Title:getFisrtDayOfMonth
	 * @Description:
	 * @param:@param year
	 * @param:@param month
	 * @param:@return
	 * @return:String
	 * @throws
	 */
	public  static Date getFisrtDayOfMonth(String time)
	{
		String[] ym = time.split("-");
    	Calendar cal = Calendar.getInstance();
    	cal.set(Calendar.YEAR, Integer.parseInt(ym[0]));
    	cal.set(Calendar.MONTH, Integer.parseInt(ym[1])-1);
		int firstDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
		//设置日历中月份的最小天数
		cal.set(Calendar.DAY_OF_MONTH, firstDay);
	     return cal.getTime();
	}
	
	/**
	 * 获取某年的第一天
	 * @param time
	 * @return
	 */
    public static Date getFirstDayOfYear(String time) {
    	String[] ym = time.split("-");
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, Integer.parseInt(ym[0]));
        calendar.set(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }
 
	
	
    /**
     * Gets the next day of current month.
     *
     * @return the next day of current month
     */
    public static Date getNextDayOfCurrentMonth() {
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(new Date());
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * Gets the before day of current day.
     *
     * @return the before day of current day
     */
    public static Date getBeforeDayOfCurrentDay() {
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(new Date());
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return calendar.getTime();
    }

    /**
     * Gets the first day of current year.
     *
     * @return the first day of current year
     */
    public static Date getFirstDayOfCurrentYear() {
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(new Date());
        calendar.set(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * 获取去年的第一天
     *
     * @return Date
     */
    public static Date getFirstDayOfLastYear() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, -1);
        calendar.set(Calendar.MONTH, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * 获取去年的第一天
     *
     * @return Date
     */
    public static Date getNowDayOfLastYear() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, -1);
        return calendar.getTime();
    }
    
    public static void main(String[] args) throws ParseException {
        System.out.println(getYearDay(2013));
        System.out.println(getMonthDays("2019-10", "2019-11"));
        System.out.println(getLastYearSameDay("2016-02-29"));
    	System.out.println(sdfDay.format(getLastDayOfMonth("2019-01")));
    	System.out.println(sdfDay.format(getFirstDayOfCurrentYear()));
        System.out.println(getYearMonths("2018"));
        System.out.println(getYearMonth42("2019"));
        System.out.println(getMonthDays("2018-01"));
        System.out.println(getLastDayOfMonth2("2018-01"));
        System.out.println();

        System.err.println(getLastMonthSameDay("2019-03-29"));
	}

    // 1998-12-01

    /**
     * Gets the date for noc.
     *
     * @return the date for noc
     */
    public static Date getDateForNOC() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, 1998);
        calendar.set(Calendar.MONTH, 11);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    /**
     * Gets the current date of last year.
     *
     * @return the current date of last year
     */
    public static Date getCurrentDateOfLastYear() {
        Calendar calendar = Calendar.getInstance();
        // calendar.setTime(new Date());
        calendar.add(Calendar.YEAR, -1);
        return calendar.getTime();
    }

    /**
     * Gets the biggest date.
     *
     * @return the biggest date
     */
    public static Date getBiggestDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(9999, 11, 31);
        return calendar.getTime();
    }

    /**
     * Parses the date.
     *
     * @param date the date
     *
     * @return the date
     *
     * @throws ParseException the parse exception
     */
//    public static Date parseDate(String date) throws ParseException {
//        return parseDate(date, false);
//    }

    /**
     * Before today.
     *
     * @param date the date
     * @return true, if successful
     */
    public static boolean beforeToday(Date date) {
        Date currentDate = null;
        try {
            currentDate = DateUtils.parseDate(formatDate(new Date()));
        } catch (ParseException e) {
            LOG.error(e.getMessage());
        }
        return date.before(currentDate);
    }

    /**
     * After today.
     *
     * @param date the date
     * @return true, if successful
     */
    public static boolean afterToday(Date date) {
        Date currentDate = null;
        try {
            currentDate = DateUtils.parseDate(formatDate(new Date()));
        } catch (ParseException e) {
            LOG.error(e.getMessage());
        }
        return date.after(currentDate);
    }

    /**
     * Parses the date.
     *
     * @param dateString the date string
     * @param pattern    the pattern
     * @param isLenient  the is lenient
     * @return the date
     * @throws ParseException the parse exception
     */
    public static Date parseDate(String dateString, String pattern, boolean isLenient) throws ParseException {
        if (StringUtils.isEmpty(dateString)) {
            return null;
        }
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, enLocale);
        formatter.setLenient(false);
        Date resultDate = null;
        resultDate = formatter.parse(dateString);
        return resultDate;

    }

    /**
     * Gets the current time stamp.
     *
     * @return the current time stamp
     */
    public static Timestamp getCurrentTimeStamp() {
        return new Timestamp((new Date()).getTime());
    }

    /**
     * Gets the day.
     *
     * @param date the date
     * @return the day
     */
    public static Date getTheDay(Date date) {
        if (date == null) {
            return null;
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
//        calendar.set(Calendar.HOUR_OF_DAY, 0);
//        calendar.set(Calendar.MINUTE, 0);
//        calendar.set(Calendar.SECOND, 0);
//        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    public static String getCurYear() {
        return String.valueOf(Calendar.getInstance().get(Calendar.YEAR)).substring(2);
    }

    /**
     * 获取当前年度 2019
     * @return
     */
    public static String getCurFullYear() {
        return String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
    }

    /**
     * 获取当前时间：格式:2019-05-28
     * @return
     */
    public static String getCurYearMonthDay() {
        Calendar calendar = Calendar.getInstance();
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        return getCurYearMonth()+ "-" + day;
    }

    /**
     * 获取当前时间：格式:2019-05
     *
     * @return
     */
    public static String getCurYearMonth() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        if (month < 10) {
            return year + "-0" + month ;
        }
        return year + "-" + month ;
    }

    /**
     * 获取当年最后一天时间：格式:2019-12-31
     * @return
     */
    public static String getCurYearLastDay() {
        return getCurFullYear() + "-12-31";
    }

    /**
     * 获取当年第一天时间：格式:2019-01-01
     * @return
     */
    public static String getCurYearFirstDay() {
        return getCurFullYear() + "-01-01";
    }
/**
     * 获取当年第一天时间：格式:2019-01-01
     * @return
     */
    public static String getFirstOfCurYear_Str() {
        return  sdfDay.format(getFirstDayOfCurrentYear());
    }

    /**
     * @Author lianhuinan
     * @Description //TODO(获取过去24小时的yyyy-MM-dd HH的日期时间集合)
     * @Date 2019/10/18 0018 9:21
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> get24h() {
		return DateUtil_BK.get24Hours(new Date());
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取过去30天的yyyy-MM-dd的日期集合)
     * @Date 2019/10/18 0018 9:16
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> get30d() {
		return DateUtil_BK.get30Days(new Date());
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取过去一个月的yyyy-MM-dd日期集合)
     * @Date 2019/10/18 0018 9:11
     * @param date
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getDayLastMonth(Date date) {
		return DateUtil_BK.getDaysOfLastMonth(date);
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取过去day天数的yyyy-MM-dd的日期集合)
     * @Date 2019/10/18 0018 10:05
     * @param day
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getSomeDay(Integer day) {
        Date date = DateUtil_BK.add(new Date(), Calendar.DATE, -day);
		return DateUtil_BK.getDaysBetweenDate(date, new Date(),20,null);
	}
	
	/**
     * @Author lianhuinan
     * @Description //TODO(获取某年天的MM-dd的日期集合)
     * @Date 2019/10/18 0018 9:23
     * @param year1
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getYearDay(int year1) throws ParseException {
        Calendar date = Calendar.getInstance();
        date.set(Calendar.YEAR, year1);
        Map<String, Object> map = DateUtil_BK.getDaysOfYear(date.getTime());
        map.put("startTime", year1 + "-" + map.get("startTime"));
        map.put("endTime", year1 + "-" + map.get("endTime"));
        map.put("year1", year1);
        map.put("year2", getCurFullYear());
		return map;

	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取过去12个月的yyyy-MM的日期集合)
     * @Date 2019/10/18 0018 9:55
     * @param
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> get12m() {
		return DateUtil_BK.get12Months(new Date());
	}

	@SuppressWarnings("deprecation")
	public static Map<String, Object> getSomeHours(Integer hours,Integer period) {
		Map<String, Object> map = new HashMap<>();
		Map<String, Integer> indexmap = new HashMap<>();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");
		Date end = new Date();
		Date start = DateUtil.addHour(end, -hours);
		String startTime = df.format(start);
		String endTime = df.format(end);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(start.compareTo(end)<=0) {
			Integer temp = start.getHours();
			if(temp%period==0) {
				xList.add(df.format(start));
				indexmap.put(df.format(start), i++);
			}
			start = addHour(start,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		return map;
	}

	/**
	 * 获取时间段内的小时数据
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("deprecation")
	public static Map<String, Object> getBetweenHour(String start, String end,Integer period) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> indexmap = new HashMap<>();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");
		map.put("startTime", start);
		map.put("endTime", end);
		Date endDate = df.parse(end);
		Date startDate = df.parse(start);
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(startDate.compareTo(endDate)<=0) {
			Integer temp = startDate.getHours();
			if(temp%period==0) {
				xList.add(df.format(startDate));
				indexmap.put(df.format(startDate), i++);
			}
			startDate = addHour(startDate,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		return map;
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取时间段内的yyyy-MM-dd的日期集合)
     * @Date 2019/10/18 0018 10:17
     * @param start
     * @param end
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getBetweenDay(String start, String end) throws ParseException {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return DateUtil_BK.getDaysBetweenDate(df.parse(start), df.parse(end),null,null);
	}
	
	/**
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	/**
     * @Author lianhuinan
     * @Description //TODO(获取yyyy-MM月的天的MM-dd的日期集合)
     * @Date 2019/10/18 0018 10:25
     * @param yearMonth ：格式为 yyyy-MM
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getMonthDays(String yearMonth) throws ParseException {
		Date start = new SimpleDateFormat("yyyy-MM").parse(yearMonth);
		Date end = DateUtil_BK.getLastDateOfMonthYear(start);
		return DateUtil_BK.getDaysBetweenDate(start, end,null, new SimpleDateFormat("MM-dd"));
	}
	
	/**
     * @Author lianhuinan
     * @Description //TODO(获取某年yyyy的yyyy-MM的日期集合)
     * @Date 2019/10/18 0018 10:41
     * @param year
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getYearMonths(String year) throws ParseException {
        Date startDate = DateUtil_BK.yyyy_MM_dd.parse(year + "-01-01");
        Date endDate = DateUtil_BK.yyyy_MM_dd.parse(year + "-12-31");
        Map map = DateUtil_BK.getMonthsBetweenDate(startDate, endDate,null, null);
        map.put("startTime", map.get("startTime") + "-01");
        map.put("endTime",  map.get("endTime") + "-31");
		return map;
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取某年yyyy的MM的日期集合)
     * @Date 2019/10/18 0018 10:41
     * @param year
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getYearMonth42(String year) throws ParseException {
        Date startDate = DateUtil_BK.yyyy_MM_dd.parse(year + "-01-01");
        Date endDate = DateUtil_BK.yyyy_MM_dd.parse(year + "-12-31");
        Map map = DateUtil_BK.getMonthsBetweenDate(startDate, endDate,null, DateUtil_BK.MM);
        map.put("startTime", year + "-01");
        map.put("endTime", year + "-12");
		return map;
	}

    /**
     * @Author lianhuinan
     * @Description //TODO(获取某年yyyy的M的日期集合)
     * @Date 2019/10/18 0018 10:41
     * @param year1
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getYearMonth(int year1) throws ParseException {
        Date startDate = DateUtil_BK.yyyy_MM_dd.parse(year1 + "-01-01");
        Date endDate = DateUtil_BK.yyyy_MM_dd.parse(year1 + "-12-31");
        Map map = DateUtil_BK.getMonthsBetweenDate(startDate, endDate,null, DateUtil_BK.M);
		map.put("year1", year1);
		map.put("year2", year1);
		return map;
	}

	/**
     * @Author lianhuinan
     * @Description //TODO(获取两个月份yyyy-MM内的天数最多的dd日期集合)
     * @Date 2019/10/18 0018 11:32
     * @param time1
     * @param time2
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getMonthDays(String time1, String time2) throws ParseException {
	    Date startDate = DateUtil_BK.getLastDateOfMonthYear(DateUtil_BK.yyyy_MM.parse(time1));
        Calendar calendar1 = DateUtil_BK.date2Calendar(startDate);
        int maxDate1 = calendar1.getActualMaximum(Calendar.DAY_OF_MONTH);
        Date endDate = DateUtil_BK.getLastDateOfMonthYear(DateUtil_BK.yyyy_MM.parse(time2));
        Calendar calendar2 = DateUtil_BK.date2Calendar(endDate);
        int maxDate2 = calendar2.getActualMaximum(Calendar.DAY_OF_MONTH);
        Map map = maxDate1 > maxDate2 ?
                DateUtil_BK.getDaysBetweenDate(DateUtil_BK.getFirstDateOfMonthYear(startDate), DateUtil_BK.getLastDateOfMonthYear(startDate), null, DateUtil_BK.dd) :
                DateUtil_BK.getDaysBetweenDate(DateUtil_BK.getFirstDateOfMonthYear(endDate), DateUtil_BK.getLastDateOfMonthYear(endDate), null, DateUtil_BK.dd);

        map.put("startTime1", time1 + "-01");
        map.put("endTime1", time1 + "-" + (maxDate1 < 10 ? "0" + maxDate1 : maxDate1));
        map.put("startTime2", time2 + "-01");
        map.put("endTime2", time2 + "-" + (maxDate2 < 10 ? "0" + maxDate2 : maxDate2));
        map.remove("startTime");
        map.remove("endTime");
		return map;
	}

    /**
     * @Author lianhuinan
     * @Description //TODO(获取两个月份yyyy-MM内的天数最多的间隔4小时dd HH日期集合)
     * @Date 2019/10/18 0018 11:32
     * @param time1
     * @param time2
     * @return java.util.Map<java.lang.String, java.lang.Object>
     * @version 1.0
     **/
	public static Map<String, Object> getMonthDaysHour(String time1, String time2) throws ParseException {
        Date startDate = DateUtil_BK.getLastDateOfMonthYear(DateUtil_BK.yyyy_MM.parse(time1));
        Calendar calendar1 = DateUtil_BK.date2Calendar(startDate);
        int maxDate1 = calendar1.getActualMaximum(Calendar.DAY_OF_MONTH);
        Date endDate = DateUtil_BK.getLastDateOfMonthYear(DateUtil_BK.yyyy_MM.parse(time2));
        Calendar calendar2 = DateUtil_BK.date2Calendar(endDate);
        int maxDate2 = calendar2.getActualMaximum(Calendar.DAY_OF_MONTH);
        Map map = maxDate1 > maxDate2 ?
                DateUtil_BK.getHoursBetweenDate(DateUtil_BK.getMinHour(DateUtil_BK.getFirstDateOfMonthYear(startDate)),
                        DateUtil_BK.getMaxHour(DateUtil_BK.getLastDateOfMonthYear(startDate)), 4, DateUtil_BK.dd_HH) :
                DateUtil_BK.getHoursBetweenDate(DateUtil_BK.getMinHour(DateUtil_BK.getFirstDateOfMonthYear(endDate)),
                        DateUtil_BK.getMaxHour(DateUtil_BK.getLastDateOfMonthYear(endDate)), 4, DateUtil_BK.dd_HH);

        map.put("startTime1", time1 + "-01 00");
        map.put("endTime1", time1 + "-" + (maxDate1 < 10 ? "0" + maxDate1 : maxDate1) + " 23");
        map.put("startTime2", time2 + "-01 00");
        map.put("endTime2", time2 + "-" + (maxDate2 < 10 ? "0" + maxDate2 : maxDate2) + " 23");
        map.remove("startTime");
        map.remove("endTime");
		return map;
	}
	
	/**
	 * 获取天的小时数据
	 * @param time
	 * @param period
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("deprecation")
	public static Map<String, Object> getDayHours(String time,Integer period) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> indexmap = new HashMap<>();
		SimpleDateFormat df = new SimpleDateFormat("HH");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH");
		String date=getDay();
		
		Date start = df2.parse(time+" 00");
		Date end = df2.parse(time+" 23");
		map.put("startTime1", df2.format(start));
		map.put("endTime1", df2.format(end));
		map.put("startTime2", date+" 00");
		map.put("endTime2", date+" 23");
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(start.compareTo(end)<=0) {
			Integer temp = start.getHours();
			if(temp%period==0) {
				xList.add(df.format(start));
				indexmap.put(df.format(start), i++);
				
			}
			start = addHour(start,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		return map;
	}
	
	/**
	 * 获取时间段内每4小时数据
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("deprecation")
	public static Map<String, Object> getBetweenFourHour(String start, String end) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> indexmap = new HashMap<>();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");
		map.put("startTime", start);
		map.put("endTime", end);
		Date endDate = df.parse(end);
		Date startDate = df.parse(start);
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(startDate.compareTo(endDate)<=0) {
			Integer temp = startDate.getHours();
			if(temp%4==0) {
				xList.add(df.format(startDate));
				indexmap.put(df.format(startDate), i++);
			}
			startDate = addHour(startDate,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		return map;
	}
	
	/**
	 * 获取时间段内月数据
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	public static Map<String, Object> getBetweenMonth(String start, String end) throws ParseException {
		Map map = DateUtil_BK.getMonthsBetweenDate(DateUtil_BK.yyyy_MM_dd.parse(start),
                DateUtil_BK.yyyy_MM_dd.parse(end),4, null);
        map.put("startTime", start);
        map.put("endTime", end);
        return map;
	}
	
	/**
	 * 获取时间段内年数据
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	public static Map<String, Object> getBetweenYear(String start, String end) throws ParseException {
	    Map map = DateUtil_BK.getYearsBetweenDate(DateUtil_BK.yyyy_MM_dd.parse(start),
                DateUtil_BK.yyyy_MM_dd.parse(end),null, null);
	    map.put("startTime", start);
	    map.put("endTime", end);
	    return map;
	}
	
	/**
	 * 获取时间段内周数据
	 * @param start
	 * @param end
	 * @return
	 * @throws ParseException
	 */
	public static Map<String, Object> getBetweenWeek(String start, String end) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> indexmap = new HashMap<>();
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		map.put("startTime", start);
		map.put("endTime", end);
		Date endWeek = df.parse(getFirstDayOfWeek(end));
		Date startWeek = df.parse(getFirstDayOfWeek(start));
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(startWeek.compareTo(endWeek)<=0) {
			xList.add(getSeqWeek(startWeek,""));
			indexmap.put(getSeqWeek(startWeek,""), i++);
			startWeek = addWeek(startWeek,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		return map;
	}
	
	/**
	 * 得到某年某周第一天的日期
	 * @param year
	 * @param week
	 * @return
	 */
	public static String getFirstDayOfWeek(String yearWeek) { 
		String year = yearWeek.substring(0, 4);
		String week = yearWeek.substring(5, yearWeek.length()-1);
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, Integer.valueOf(year)); 
		c.set (Calendar.MONTH, Calendar.JANUARY); 
		c.set(Calendar.DATE, 1); 
		Calendar cal = (GregorianCalendar) c.clone(); 
		cal.add(Calendar.DATE, (Integer.valueOf(week)-1) * 7); 
		return getFirstDayOfWeek(cal.getTime()); 
	}

	/**
	 * 
	 * @param date
	 * @return
	 */
	private static String getFirstDayOfWeek(Date date) {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		 Calendar c = new GregorianCalendar(); 
		 c.setFirstDayOfWeek(Calendar.MONDAY); 
		 c.setTime(date); 
		 c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday 
		 return sdf.format(c.getTime());
	}
	
	/**
	 * 日期转周
	 * @return
	 */
	public static String getSeqWeek(Date date,String type) {  
	    Calendar c = Calendar.getInstance();  
	    c.setTime(date);
	    int week = c.get(Calendar.WEEK_OF_YEAR);  
	    int year = c.get(Calendar.YEAR);  
	    if(week==1) {
	    	year = year+1;
	    }
	    if(type.equals("w")) {
	    	return String.valueOf(week);
	    }else {
	    	return year +"年"+ week +"周";  
	    }
	}  
	
	/**
	 * 获取年的周数据
	 * @param year1
	 * @return
	 * @throws ParseException
	 */
	public static Map<String, Object> getYearWeek(int year1) throws ParseException {
		Calendar date = Calendar.getInstance();
		int year2 = Integer.parseInt(String.valueOf(date.get(Calendar.YEAR)));
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> indexmap = new HashMap<>();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String startTime = year1+"-01-01";
		Date start = df.parse(startTime);
		List<String> xList = new ArrayList<String>();
		int i = 0;
		while(getYear(start).equals(String.valueOf(year1))) {
			String week = getSeqWeek(start, "w");
			if(indexmap.containsKey(week)) {
				break;
			}
			xList.add(week);
			indexmap.put(week, i++);
			start = addWeek(start,1);
		}
		map.put("xList", xList);
		map.put("indexmap", indexmap);
		map.put("year1", year1);
		map.put("year2", year2);
		return map;
	}
	
	/**
	 * 
	 * @Title:  getLastYearSameDay
	 * @Description:    TODO(获取传入时间的去年同期)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年7月2日 下午4:39:51
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年7月2日 下午4:39:51    
	 * @param day format("2001-01-01")
	 * @return  String 
	 * @throws
	 */
	public static String getLastYearSameDay(String day) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
        try {
        	Date date = format.parse(day);
        	c.setTime(date);
        	
        	c.add(Calendar.YEAR, -1);
		} catch (Exception e) {
			e.printStackTrace();
		}
        Date start = c.getTime();
        return format.format(start);
	}
	
	/**
	 * 
	 * @Title:  getLastMonthSameDay
	 * @Description:    TODO(获取传入时间的上个月同期)    
	 * @CreateBy: lianhuinan 
	 * @CreateTime: 2019年7月2日 下午4:39:51
	 * @UpdateBy: lianhuinan 
	 * @UpdateTime:  2019年7月2日 下午4:39:51    
	 * @param day format("2001-01-01")
	 * @return  String 
	 * @throws
	 */
	public static String getLastMonthSameDay(String day) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
        try {
        	Date date = format.parse(day);
        	c.setTime(date);
        	
        	c.add(Calendar.MONTH, -1);
		} catch (Exception e) {
			e.printStackTrace();
		}
        Date start = c.getTime();
        return format.format(start);
	}

}
