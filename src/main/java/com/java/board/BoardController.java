package com.java.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
	public void insert(@RequestParam("files") MultipartFile[] files, HttpServletRequest request,BoardBean bb, HttpServletResponse response) {
		session.selectOne("test.insert", bb);
		System.out.println(bb.getNo());
		bb = session.selectOne("test.fileSelect", bb);
		System.out.println(bb.getNo());
		int checkPoint = 1;
		fileInsert(files, bb, checkPoint);
		
		JSONObject jsonObject = new JSONObject();
		boolean result = true;
		jsonObject.put("result", result);
		try {
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void fileInsert(MultipartFile[] files,BoardBean bb, int checkPoint) {
		int[] statusList = new int[files.length];
		try {
			String[] content;
			String path="";
			for (int i = 0; i < files.length; i++) {
				MultipartFile file = files[i];
				String originalfileName = file.getOriginalFilename();
				String ext = originalfileName.substring(originalfileName.lastIndexOf("."), originalfileName.length());
				String fileName = UUID.randomUUID().toString();
				//get realpath 는  동적으로 관리하기 위한 방안 이다. 절대적으로 관리하기위하면 사용하지 않아도 된다.
				//String realPath=request.getSession().getServletContext().getRealPath("/");
				//System.out.println(realPath);
				byte[] data = file.getBytes();
				path = "D:\\file\\img\\";
				File f = new File(path);
				if(!f.isDirectory()) {
					System.out.println("없다");
					f.mkdirs();
				}
				//output
				OutputStream os = new FileOutputStream(new File(path + fileName + ext));
				os.write(data);
				os.close();
				
				FilesBean fb = new FilesBean();
				fb.setBoardNum(bb.getNo());
				fb.setFileOriginalName(originalfileName);
				fb.setFileUUIDName(fileName + ext);
				int status = 0;
				if(checkPoint == 1) {
					status = session.insert("test.fileInsert", fb);
				}else if(checkPoint == 2) {
					status = session.insert("test.fileUpdate", fb);
				}
				statusList[i] = status;
				System.out.println(i +"번째의 결과" + status);
				System.out.println(files);
				
			}
		
			content = text(path);
			System.out.println(content);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	//상태 체크
	public String[] text(String path) {
		File folder = new File(path);
		String[] name = new String[(int) folder.length()];
		int i =0;
		for (File filePath : folder.listFiles()) {
			name[i] = filePath.getName();
			System.out.println(name[i]);
			i++;
		}
		return name;
	}
	@RequestMapping(value = "/board_Detail", method = RequestMethod.POST)
	public void detail(HttpServletRequest request,  BoardBean bb, HttpServletResponse response) {
		System.out.println(request.getParameter("no") + "번 내용 출력");
		FilesBean fb = new FilesBean();
		fb.setBoardNum(request.getParameter("no"));
		BoardBean info = session.selectOne("test.select", bb);
		List<FilesBean> list = session.selectList("test.fileSearch", bb);
		JSONObject jsonObject = new JSONObject();
		try {
			//ajax 통신 성공을 하기 위해 utf-8을 세팅 해주어야 함.
			jsonObject.put("info", info);
			jsonObject.put("fileList", list);
			response.setHeader("Content-Type", "application/xml");
			response.setContentType("text/xml;charset=UTF-8");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(@RequestParam("files") MultipartFile[] files, HttpServletRequest request, BoardBean bb, HttpServletResponse response) {
		session.update("test.update", bb);
		bb = session.selectOne("test.fileSelect", bb);
		int checkPoint = 2;
		fileInsert(files, bb,checkPoint);
		
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
	//fileDelete
	@RequestMapping(value = "/fileDelete", method = RequestMethod.POST)
	public void delete(HttpServletRequest request,  HttpServletResponse response) {
		String path = "D:\\file\\img\\";
		String fileUUIDName = request.getParameter("fileName");
		String filePath = path + fileUUIDName;
		JSONObject jsonObject = new JSONObject();
		boolean result = fileDelete(filePath, fileUUIDName);
		System.out.println(result);
		jsonObject.put("result", result);
		try {
			response.getWriter().print(jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public boolean fileDelete(String filePath, String fileUUIDName) {
		System.out.println(fileUUIDName);
		FilesBean fb = new FilesBean();
		fb.setFileUUIDName(fileUUIDName);
		session.update("test.fileDelete", fb);
	 	File f = new File(filePath);
	 	return f.delete();
	}
	//logout
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public  String logout(HttpSession httpSession) {
		httpSession.removeAttribute("logIn");
		System.out.println("세션이 제거되었습니다 : " + httpSession.getAttribute(" logIn"));
		return "redirect:/";
	}

	
}
