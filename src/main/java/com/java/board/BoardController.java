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

@Controller
public class BoardController {

	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public  String board(HttpServletRequest request, BoardBean bb, HttpSession httpSession) {
		UserInfo user = (UserInfo) httpSession.getAttribute("logIn"); //세션 가져오기 userinfo 로 넣어 줬기때문에 변환함
		List<BoardBean> list = session.selectList("test.select", bb); 
		request.setAttribute("id", user.getId()); //user의 id를 객체로 전환해서 넣어줌
		request.setAttribute("list", list); //게시글 내용 가져 오기
		return "/board";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public  String insert(HttpServletRequest request,BoardBean bb) { 
		session.selectOne("test.insert", bb);
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/board_Detail", method = RequestMethod.GET)
	public  String detail(HttpServletRequest request,  BoardBean bb, HttpSession httpSession) {
		UserInfo user = (UserInfo) httpSession.getAttribute("logIn");
		request.setAttribute("id", user.getId());
		//
		if(request.getParameter("no") != null) {
			request.setAttribute("info", session.selectOne("test.select", bb));
		}else {
			request.setAttribute("info", bb);
		}
		return "/board_Detail";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public  String update(HttpServletRequest request, BoardBean bb) {
		session.update("test.update", bb);
		return "redirect:/board";
	}
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public  String delete(HttpServletRequest request, BoardBean bb) {
		session.update("test.delete", bb);
		return "redirect:/board";
	}

}
