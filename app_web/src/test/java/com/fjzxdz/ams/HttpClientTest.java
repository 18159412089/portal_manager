package com.fjzxdz.ams;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class HttpClientTest {

	private CloseableHttpClient httpClient;

	public HttpClientTest() {
		super();

		this.init();
	}

	private void init() {
		this.httpClient = HttpClients.createDefault();
	}

	/** 
     * post方式提交表单（模拟用户登录请求） 
     */
	public String postForm(String url, JSONObject obj) throws JSONException {
		// 创建httppost 
		HttpPost httpPost = new HttpPost(url);
		// 创建参数队列
		List<BasicNameValuePair> list = new ArrayList<BasicNameValuePair>();
		list.add(new BasicNameValuePair("uuid", obj.toString()));
		String responseData ="";
		UrlEncodedFormEntity uefEntity;
		try {
			uefEntity = new UrlEncodedFormEntity(list, "UTF-8");
			httpPost.addHeader("X-Requested-With","XMLHttpRequest");
			httpPost.addHeader("Cookie","JSESSIONID="+"72EB5CCE37E34E6D33B1372873488CF4");
			httpPost.setEntity(uefEntity);
			System.out.println("executing request " + httpPost.getURI());
			CloseableHttpResponse response = this.httpClient.execute(httpPost);
			try {
				System.out.println("Status:"+response.getStatusLine().getStatusCode());
				HttpEntity entity = response.getEntity();
				if (entity != null) {
					System.out.println("============================");
					responseData = EntityUtils.toString(entity, "UTF-8");
                    System.out.println(responseData);
                    System.out.println("============================");
				}
			} finally {
				response.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return responseData;
	}

	/** 
     * 发送 post请求访问本地应用并根据传递参数不同返回不同结果 
     */ 
	public void post() {
		 // 创建默认的httpClient实例. 
		CloseableHttpClient httpclient = HttpClients.createDefault();
		// 创建httppost    
		HttpPost httppost = new HttpPost(
				"http://localhost:8080/fjzxLocalTax/LocalTaxUserMobile?login");
		// 创建参数队列  
		List<BasicNameValuePair> formparams = new ArrayList<BasicNameValuePair>();
		formparams.add(new BasicNameValuePair("type", "house"));
		
		UrlEncodedFormEntity uefEntity;
		try {
			uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8");
			httppost.setEntity(uefEntity);
			System.out.println("executing request " + httppost.getURI());
			CloseableHttpResponse response = httpclient.execute(httppost);
			try {
				HttpEntity entity = response.getEntity();
				if (entity != null) {
					System.out
							.println("--------------------------------------");
					System.out.println("Response content: "
							+ EntityUtils.toString(entity, "UTF-8"));
					System.out
							.println("--------------------------------------");
				}
			} finally {
				response.close();
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// 关闭连接,释放资源   
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) throws InterruptedException {
		HttpClientTest test = new HttpClientTest();
		try {			
			//派车单审核不通过
			String url = "http://192.169.8.236:8088/sys/user/getUser";
			JSONObject jsonData = new JSONObject();
		
			jsonData.put("uuid", "0DpG0sUFN5KqwTquKwR_J7");
			
			test.postForm(url, jsonData);
//			
//			Thread.sleep(70000);
//			test.postForm(url, jsonData);
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

}
