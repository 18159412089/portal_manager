package com.fjzxdz.ams.util;

import java.util.Arrays;

public class PercentileUtil { 
	
	public static double getPercentile(double[] A, double p) {
		if (A == null) {
			return 0;
		}
		if(A.length == 1) {
			return A[0];
		}
		double res = 0;
		Arrays.sort(A); // 从小到大排序
		double x = (A.length - 0.99) * p;
		int i = (int) x; // 取出整数部分
		double j = x - i; // 还没找到最精确的取double数的小数部分的方法，有可能会有误差
		res = (1 - j) * A[i] + j * A[i + 1];
		return res;
	}
	
	public static void main(String[] args) {
		double[] data= {0.6,
				0.6,
				0.9,
				1.2,
				1,
				1.1,
				1.1,
				1.2,
				0.8,
				0.9,
				0.9,
				1,
				1.1,
				1,
				1.2,
				0.9,
				1,
				0.9,
				1,
				1.1,
				1.3,
				1.2,
				0.8,
				0.6,
				0.7,
				0.6,
				0.5,
				0.6,
				0.6,
				0.9,
				0.8};
		System.out.println(getPercentile(data, 0.9));
	}
}
