package com.java.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONObject;

@Controller
public class UserPage {
	
	@RequestMapping(value = "/userPage", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, BoardBean bb,  HttpServletResponse response) {
		return "userPage";
	}
}
