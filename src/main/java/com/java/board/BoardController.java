package com.java.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	public  String board(HttpServletRequest request, BoardBean bb) {
		List<BoardBean> list = session.selectList("test.select", bb);
		request.setAttribute("list", list);
		return "/board";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public  String insert(HttpServletRequest request,BoardBean bb) { 
		session.selectOne("test.insert", bb);
		return "redirect:/board";
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public  String detail(HttpServletRequest request,  BoardBean bb) {
		System.out.println(request.getParameter("no"));
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
