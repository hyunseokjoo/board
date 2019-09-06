package com.java.board;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.board.HttpUtill;

import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;


@Controller
public class HomeController {
	
	@Autowired
	SqlSession session;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletResponse response) {
		return "home";
	}	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String url ="https://kauth.kakao.com/oauth/authorize?client_id=7ba614e8738f533e4814d6f87cdf2c6c&redirect_uri=";
			url += URLEncoder.encode("http://gdj16.gudi.kr:20018/KakaoBack", "utf-8");
			url += "&response_type=code";
			response.sendRedirect(url);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/KakaoBack", method = RequestMethod.GET)
	public  String KakaoBack(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("KakaoBack");
			String code = request.getParameter("code");
			String url = "https://kauth.kakao.com/oauth/token";
			url += "?client_id=7ba614e8738f533e4814d6f87cdf2c6c&redirect_uri=";
			url += URLEncoder.encode("http://gdj16.gudi.kr:20018/KakaoBack", "UTF-8"); //주소값이 코딩이 되어야 기계에서 읽어서 보내줄수 있다 꼭해줘야함.
			url += "&code=" + code;
			url += "&grant_type=authorization_code";
			System.out.println("code : " +code);
			URL u = new URL(url);
			HttpUtill utill = new HttpUtill();
			HashMap<String, Object> result = utill.getUrl(url);
			System.out.println(result);
			
			String userUrl = "https://kapi.kakao.com/v2/user/me";
			userUrl += "?access_token=" + result.get("access_token");
			System.out.println("userUrl : " + userUrl);
			result = utill.getUrl(userUrl);
			System.out.println("result : " +result);	
			System.out.println("id : " + result.get("id"));
			JSONObject jObject = JSONObject.fromObject(result.get("properties"));
			System.out.println("nickname : " +jObject.get("nickname"));
			String nickname = (String) jObject.get("nickname");
		
			request.setAttribute("nickname", nickname);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "home";
	}

//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(HttpServletRequest request, HttpServletResponse response, UserInfo user) {
//		session.insert("test.signIn",user);
//		return "login";
//	}
//	
//	
//	@RequestMapping(value = "/login/check", method = RequestMethod.POST
//			,consumes = MediaType.APPLICATION_JSON_VALUE
//			,headers = {"Accept=application/json"})
//	@ResponseBody
//	public String login_check(HttpServletRequest request,UserInfo user) {
//		System.out.println(request.getParameterNames());
//		System.out.println(request.getParameter("data"));
//		System.out.println(request.getParameter("json"));
//		System.out.println(request.getParameter("jsonData"));
//		return "redirect:/login";
//	}
	
}