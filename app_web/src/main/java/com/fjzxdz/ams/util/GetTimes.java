package com.fjzxdz.ams.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class GetTimes {
	//上个月的现在
    public static String getNowOfLastMonth(String time) {
        // Date Format will be display
        SimpleDateFormat aSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        GregorianCalendar aGregorianCalendar = new GregorianCalendar();
        Date date;
		try {
			date = aSimpleDateFormat.parse(time);
			date = new Date(date.getTime());
			aGregorianCalendar.setTime(date);
		} catch (ParseException e) {
		}	    
        aGregorianCalendar.set(Calendar.MONTH, aGregorianCalendar
                .get(Calendar.MONTH) - 1);
        String nowOfLastMonth = aSimpleDateFormat
                .format(aGregorianCalendar.getTime());
        return nowOfLastMonth;
    }
    
    //去年的现在
    public static String getNowOfLastYear(String time) {
        // Date Format will be display
        SimpleDateFormat aSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        GregorianCalendar aGregorianCalendar = new GregorianCalendar();
        Date date;
		try {
			date = aSimpleDateFormat.parse(time);
			date = new Date(date.getTime());
			aGregorianCalendar.setTime(date);
		} catch (ParseException e) {
		}	
        aGregorianCalendar.set(Calendar.YEAR, aGregorianCalendar
                .get(Calendar.YEAR) - 1);
        String currentYearAndMonth = aSimpleDateFormat
                .format(aGregorianCalendar.getTime());
        return currentYearAndMonth;
    }

//    public static void main(String[] args) {
//        System.out.println(GetTimes.getNowOfLastMonth("2019-06-22"));
//        System.out.println(GetTimes.getNowOfLastYear("2019-06-22"));
//    }
}
