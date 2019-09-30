package com.java.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;

@Controller
public class BoardController {

	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public  String board(HttpServletRequest request, BoardBean bb, HttpSession httpSession) {
		//세션 확인 예외처리
		if(httpSession.getAttribute("logIn") == null) {
			return "redirect:/";
		}else {
			UserInfo user = (UserInfo) httpSession.getAttribute("logIn"); //세션 가져오기 userinfo 로 넣어 줬기때문에 변환함
			List<BoardBean> list = session.selectList("test.select", bb); 
			request.setAttribute("id", user.getId()); //user의 id를 객체로 전환해서 넣어줌
			request.setAttribute("list", list); //게시글 내용 가져 오기
			return "/board";
		}
	}
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public  void boardPOST(HttpServletRequest request, BoardBean bb, HttpSession httpSession) {
		board( request,  bb,  httpSession);
	}
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insert(HttpServletRequest request,BoardBean bb,HttpServletResponse response) { 
		session.selectOne("test.insert", bb);
		JSONObject jsonObject = new JSONObject();
		boolean result = true;
		jsonObject.put("result", result);
		try {
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/board_Detail", method = RequestMethod.POST)
	public void detail(HttpServletRequest request,  BoardBean bb, HttpServletResponse response) {
		System.out.println(request.getParameter("no"));
		BoardBean info = session.selectOne("test.select", bb);
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject.put("info", info);
			response.setHeader("Content-Type", "application/xml");
			response.setContentType("text/xml;charset=UTF-8");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(HttpServletRequest request, BoardBean bb, HttpServletResponse response) {
		session.update("test.update", bb);
		JSONObject jsonObject = new JSONObject();
		boolean result = true;
		jsonObject.put("result", result);
		try {
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest request, BoardBean bb,  HttpServletResponse response) {
		session.update("test.delete", bb);
		JSONObject jsonObject = new JSONObject();
		boolean result = true;
		jsonObject.put("result", result);
		try {
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//logout
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public  String logout(HttpSession httpSession) {
		httpSession.removeAttribute("logIn");
		System.out.println("세션이 제거되었습니다 : " + httpSession.getAttribute(" logIn"));
		return "redirect:/";
	}

	
}
