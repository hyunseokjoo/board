package com.java.board;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.helpers.SubstituteLoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileController {
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/file", method = RequestMethod.GET)
	public String file() {
		return "file";
	}
	
//	@RequestMapping(value = "/file", method = RequestMethod.POST)
//	public String file(@RequestParam("file") MultipartFile[] files, HttpServletRequest request) {
//		int[] statusList = new int[files.length];
//		try {
//			String[] content;
//			String path="";
//			for (int i = 0; i < files.length; i++) {
//				MultipartFile file = files[i];
//				String originalfileName = file.getOriginalFilename();
//				String ext = originalfileName.substring(originalfileName.lastIndexOf("."), originalfileName.length());
//				String fileName = UUID.randomUUID().toString();
//				String realPath=request.getSession().getServletContext().getRealPath("/");
//				System.out.println(realPath);
//				byte[] data = file.getBytes();
//				path = realPath + "resources\\upload\\";
//				File f = new File(path);
//				if(!f.isDirectory()) {
//					System.out.println("없다");
//					f.mkdirs();
//				}
//				//no,path,originalFileName, uuidFileName;
//				//output
//				OutputStream os = new FileOutputStream(new File(path + fileName + ext));
//				os.write(data);
//				os.close();
//				
//				FilesBean fb = new FilesBean();
//				fb.setDelYn("N");
//				fb.setFileName(originalfileName);
//				fb.setFileURL(fileName + ext);
//				
//				int status = session.insert("test.insert", fb);
//				statusList[i] = status;
//				System.out.println(i +"번째의 결과" + status);
//				System.out.println(files);
//				
//			}
//		
//			content = text(path);
//			System.out.println(content);
//			request.setAttribute("content", content );
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		
//		return "file";
//	}
	
	public String[] text(String path) {
		File folder = new File(path);
		String[] name = new String[(int) folder.length()];
		int i =0;
		for (File filePath : folder.listFiles()) {
			name[i] = filePath.getName();
			System.out.println(name[i]);
			i++;
		}
		
		
//		File fileread = new File(path+"text.txt");
//		String content = "";
//		try {
//			if(check(fileread)) {
//				BufferedReader br = new BufferedReader(new FileReader(fileread));
//
//				
//				 String str = br.readLine();
//
//			while(str != null) {
//				System.out.println(str);
//				str = br.readLine();
//			content = content + str;
//				}
//			br.close();
//			System.out.println(content);
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
		return name;
	}
	
	
	public boolean check(File file) {
		
		if(file.exists()) {
			if(file.isFile() && file.canRead()) {
				return true;
			}
		}
		return false;
	}
	
	
	@RequestMapping("/download/{originalFileName}/{ext}")
	public void download(HttpServletRequest request, HttpServletResponse response, 
			@PathVariable("originalFileName") String originalFileName
			, @PathVariable("ext") String ext) {
		String path = "D:\\IDE\\workspace\\resources\\";
		String fileName = "db4678ac-1f9a-4680-84f1-3e38945af6db.txt";
		//String originalFileName = "spring.txt"; 확장명을 따로 관리하고 데이터베이스에 넣어서 관리 하면된다 위에 변수에 내용을 따로 관리하면 편하다.
		try {
			InputStream input = new FileInputStream(path + fileName);
			OutputStream output = response.getOutputStream();
			IOUtils.copy(input, output);
			
/*	Header 정의
 * Content-Type : 전송되는 content가 어떤 유형인지 알려주는 목적을 가지고 있습니다.
 * Content-Disposition : content가 어떻게 처리되어야 하는지 나타냅니다.
 * 	/ attachment : 브라우저는 해당 content를 처리하지 않고, 다운로드하게 된다.
 *  / inline : 브라우저가  Content를 즉시 출력해야 함을 나타냅니다.
 * */			
			response.setHeader("Content-Disposition", "attachment; filename=\"" + (originalFileName +"."+ ext) +"\"");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	

}
