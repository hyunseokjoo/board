package com.java.board;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;

import net.sf.json.JSONObject;

public class HttpUtill {

	public static HashMap<String, Object> getUrl(String apiUrl){
		 HashMap<String, Object> resultMap = new  HashMap<String, Object>();
		try {
			 URL u = new URL(apiUrl);
				HttpURLConnection con = (HttpURLConnection) u.openConnection();
				con.setRequestMethod("POST");
				int resCode = con.getResponseCode();
				if(resCode == 200) {
					//받아온 (파일)??정보 읽어 드리기 
					InputStream input = con.getInputStream();
					InputStreamReader inputReader = new InputStreamReader(input, "utf-8");
					BufferedReader br = new BufferedReader(inputReader);
					String line="";
					String result = "";
					while((line = br.readLine()) != null) {
						result += line;
					}
					JSONObject jObject = JSONObject.fromObject(result);
					Iterator<?> iterator = jObject.keys();// keys를 컬렉션으로 바꾼다. List형식으로 
					//컬렉션을 보는 법을 표준화 해놓은것
					//hasNext boolean
					//next object
					//remove();
					System.out.println();
					System.out.println(iterator);
					System.out.println();
					while(iterator.hasNext()) {//다음값이 있으면 실행
						String key = iterator.next().toString();// object를 String 으로 전환해옴.
						String value = jObject.getString(key);//
						resultMap.put(key, value);
					}
					input.close();
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return resultMap;
	}
}
