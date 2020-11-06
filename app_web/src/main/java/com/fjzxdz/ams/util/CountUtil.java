package com.fjzxdz.ams.util;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CountUtil { 
	
	public static String getDivide(Object obj_a, Object Obj_b,String format) {
		double a = Double.parseDouble(obj_a.toString());
		double b = Double.parseDouble(Obj_b.toString());
		DecimalFormat df = new DecimalFormat(format);
		return df.format(a/b);
	}

	public static String getDoubleFormat(double a,String format) {
		DecimalFormat df = new DecimalFormat(format);
		return df.format(a);
	}

	public static double getTotal(Object obj_a, Object Obj_b,Object obj_c, Object Obj_d,Object obj_e, Object Obj_f) {
		double a = Double.parseDouble(obj_a.toString());
		double b = Double.parseDouble(Obj_b.toString());
		double c = Double.parseDouble(obj_c.toString());
		double d = Double.parseDouble(Obj_d.toString());
		double e = Double.parseDouble(obj_e.toString());
		double f = Double.parseDouble(Obj_f.toString());
		return a+b+c+d+e+f;
	}

	public static String getTB(Object obj_a, Object Obj_b,String format) {
		double a = Double.parseDouble(obj_a.toString());
		double b = Double.parseDouble(Obj_b.toString());
		DecimalFormat df = new DecimalFormat(format);
		if(a>=b) {
			double temp = (a-b)/b*100;
			return df.format(temp)+"%";
		}else {
			double temp = (b-a)/b*100;
			return "-"+df.format(temp)+"%";
		}
	}


	public static String getZB(Object obj_a, Object Obj_b,String format) {
		double a = Double.parseDouble(obj_a.toString());
		double b = Double.parseDouble(Obj_b.toString());
		DecimalFormat df = new DecimalFormat(format);
		double temp = a/b*100;
		return df.format(temp)+"%";
	}

	public static double getValue(Object obj_a, Object Obj_b) {
		double a = Double.parseDouble(obj_a.toString());
		double b = Double.parseDouble(Obj_b.toString());
		return a/b*100;
	}

	public static String getStartDate(String start,int minuend) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		String monthFormat;
		String tbDate="";
		try {
			date = sdf.parse(start + "-" + "01");
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.add(Calendar.YEAR, -minuend);
			int month = c.get(Calendar.MONTH) + 1;
			if(month<=9) {
				monthFormat="0"+month;
			}else {
				monthFormat=String.valueOf(month);
			}
			tbDate = c.get(Calendar.YEAR) + "-"
					+ monthFormat+"-01";
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return tbDate;
	}

	public static String getEndDate(String end, int minuend) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = null;
		try {
			date = sdf.parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Calendar c = Calendar.getInstance();
		int today = c.get(Calendar.DATE);
		c.setTime(date);
		c.add(Calendar.YEAR, -minuend);
		//获取某月最大天数
		int lastDay = c.getActualMaximum(Calendar.DATE);
		if(today > lastDay) {
			c.set(Calendar.DAY_OF_MONTH, lastDay);
		} else {
			c.set(Calendar.DAY_OF_MONTH, today);
		}
		//格式化日期
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(c.getTime());
	}
	
	public static double getAverage(List<Double> list) {
		double total = 0;
		for(int i=0;i<list.size();i++){
			total += list.get(i);
		}
		double avg = total/list.size();
		return avg;
	}
	
	public static double[] list2double(List<Double> list) {
		double[] result = new double[list.size()];
		for(int i=0;i<list.size();i++){
			result[i] = list.get(i);
		}
		return result;
	}

	public static void main(String[] args) {
	}
}
