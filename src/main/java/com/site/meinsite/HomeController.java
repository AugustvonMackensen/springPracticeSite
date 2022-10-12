package com.site.meinsite;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping("main.do")
	public String forwardMainView(HttpServletRequest request) throws IOException{
		String camPath = request.getSession().getServletContext().getRealPath("/resources/python/main.exe");
		ProcessBuilder builder = new ProcessBuilder(camPath);
		builder.start();
		return "common/main";	//내보낼 뷰파일명
		
	}
}
