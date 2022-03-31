package org.zerock.controller;

public class JavaTest {

	public static void main(String[] args) {
		String data = "2671025021101210008000001|1|2671025021|부산광역시|기장군|기장읍|동부리|0|121|8|1";
		String[]arr = data.split("|");
		for(String arr2  : arr) {
			System.out.println(arr2);
		}
	}

}
