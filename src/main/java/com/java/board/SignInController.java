package com.java.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SignInController {
	
	@Autowired
	SqlSession session;

	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String signIn() {
		return "/signIn";
	}	
	
	@RequestMapping(value = "/signIn", method = RequestMethod.POST)
	public String signIn(HttpServletRequest request, UserInfo UI) {
		boolean result = false;
		System.out.println(session.selectOne("test.sign_check", UI));
		if(session.selectOne("test.sign_check", UI) == null) {
			result = false;
		}else if(session.selectOne("test.sign_check", UI)) {
			result = true;
		}
		request.setAttribute("id", request.getAttribute("id"));
		request.setAttribute("result", result);
		return "/signIn";
	}
	
	@RequestMapping(value = "/signIn/check", method = RequestMethod.POST)
	public String signIn_check(HttpServletRequest request, UserInfo UI) {
		System.out.println("signIn");
		session.insert("test.userInsert", UI);
		return "redirect:/";
	}
}
