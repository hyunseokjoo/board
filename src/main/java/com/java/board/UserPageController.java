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

import net.sf.json.JSONObject;

@Controller
public class UserPageController {
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/userPage", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, HttpSession httpSession) {
		
		if(httpSession.getAttribute("logIn") == null) {
			return "redirect:/";
		}else {
			return "/userPage";
		}
	}
	
	@RequestMapping(value = "/userPage", method = RequestMethod.POST)
	public void userPageImage(HttpServletRequest request,  HttpServletResponse response) {	
			List<FilesBean> fileList = session.selectList("test.file");
			List<BoardBean> list = session.selectList("test.selectPaging"); 
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("fileList", fileList);
			jsonObject.put("list", list);
			try {
				response.setHeader("Content-Type", "application/xml");
				response.setContentType("text/xml;charset=UTF-8");
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(jsonObject);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setAttribute("list", list); //게시글 내용 가져 오기
	}
}
