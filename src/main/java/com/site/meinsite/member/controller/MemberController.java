package com.site.meinsite.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.site.meinsite.member.model.service.MemberService;
import com.site.meinsite.member.model.vo.Member;

@Controller //컨트롤러 등록
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired //자동 의존성 주입
	private MemberService memberService;
	
	@Autowired
	private MailSendService mailService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 페이지 이동처리 ----------------------------------------------
	@RequestMapping("loginPage.do")
	public String moveLoginPage() {
		return "member/loginPage";
	}
	
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	@RequestMapping("moveIdRecovery.do")
	public String moveIdRecoveryPage() {
		return "member/idRecovery";
	}
	
	@RequestMapping("movePwdRecovery.do")
	public String movePwdRecoveryPage() {
		return "member/pwdRecovery";
	}
	
	@RequestMapping("moveup.do")
	public String moveUpdatePage(@RequestParam String userid, Model model) {
		Member member = memberService.selectMember(userid);
		if(member != null) {
			model.addAttribute("member", member);
			return "member/updatePage";
		} else {
			model.addAttribute("message", userid + " : 회원 조회 실패!");
			return "common/error";
		}
		
	}
	
	@RequestMapping("namecardPage.do")
	public String moveNameCardPage() {
		return "member/nameCardPage";
	}
	
	@RequestMapping("pickEnroll.do")
	public String movePickEnroll() {
		return "member/chooseSignUp";
	}
	
	@RequestMapping("uploadImage.do")
	public String moveUploadImg() {
		return "member/uploadCardImg";
	}
	
	@RequestMapping("camCamera.do")
	public String moveCamCard() {
		return "member/camCard";
	}
	
	// -----------------------------------------------------------
	
	//로그인
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String loginMethod(Member member, HttpSession loginSession, SessionStatus status, Model model) {
		logger.info("login.do" + member);
		
		//암호화 처리된 패스워드 일치 조회는 select 해 온 값으로 비교
		//전달온 회원 아이디로 먼저 회원정보 조회
		Member loginMember = memberService.selectMember(member.getUserid());
		
		String viewName = null;
		if(loginMember != null && this.bcryptPasswordEncoder.matches(member.getUserpwd(), loginMember.getUserpwd()) 
				&& loginMember.getLoginOK().equals("Y")) {
			//로그인 상태 관리 방법 : 기본 세션 사용
			logger.info("sessionID : " + loginSession.getId());
			
			//필요한 경우 생성된 세션 객체 안에 정보 저장 가능
			//맵 구조로 저장함 : 키(String), 값(Object)
			loginSession.setAttribute("loginMember", loginMember);
			status.setComplete(); //로그인 요청 성공, 200 전송
			//로그인 성공시 내보낼 뷰파일명 지정
			viewName = "common/main";
		} else {
			model.addAttribute("message", "로그인 실패 : 로그인 제한 회원인지 관리자한테 문의하거나, <br> 아이디와 암호가 잘못되었는지 확인하세요.");
			viewName = "common/error";
		}
			
		
		return viewName;
		
	}
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		//로그인 시 생성된 세션객체를 찾아 없앰
		HttpSession session = request.getSession(false);
		//request가 가진 세션 id에 대한 세션객체 있으면 리턴
		//없으면 null 리턴
		
		if(session != null) {
			session.invalidate();
			return "common/main";		
		} else {
			model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}
	}
	
	//이메일 인증
	@ResponseBody
	@GetMapping("mailCheck.do")
	public String mailCheck(String email) {
		int mailCount = memberService.selectMailCheck(email);
		
		if(mailCount == 0 ) {
			return mailService.mailMessage(email);
		} else {
			String failureMessage = "failure";
			return failureMessage;
		}
	}
	
	//아이디 중복확인
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	public void dupIdCheck(@RequestParam("userid") String userid, HttpServletResponse response) throws IOException{
		
		int idCount = memberService.selectDupcheckId(userid);
		
		String returnValue = null;
		if(idCount == 0) {
			returnValue = "ok";
		} else {
			returnValue = "dup";
		}
		
		//response 이용해 클라이언트로 출력 스트림 만들고, 값 보내기
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
	}
	
	//회원가입
	@PostMapping("enroll.do")
	public String memberInsert(Member member, Model model, @RequestParam(name="validnum", required=false) String vnum){
		//패스워드 암호화 처리
		member.setUserpwd(this.bcryptPasswordEncoder.encode(member.getUserpwd()));
		
		if(memberService.insertMember(member) > 0) {
			//회원 가입 성공
			return "common/main";
		}else {
			model.addAttribute("message", "회원 가입 실패!");
			return "common/error";
		}
	}
	
	//명함 회원가입
	//이미지로 업로드해서 이메일 데이터 추출
	@PostMapping("extractImgtoTxt.do")
	public String extractImgtoTxt(@RequestParam("nameCardFile") MultipartFile mfile, Model model, 
			HttpServletRequest request) throws Exception {
		String savePath = request.getSession().getServletContext().getRealPath("resources/namecard_img_files");
		String ocrPath = request.getSession().getServletContext().getRealPath("resources/ocr_python");
		//첨부파일이 있을때만 업로드된 파일을 폴더로 옮김
		if(!mfile.isEmpty()) {
			String filename = mfile.getOriginalFilename();
			if(filename != null && filename.length() > 0) {
				//변경할 파일 이름
				String renameFileName = "namecard";
				renameFileName += "." + filename.substring(filename.lastIndexOf(".") + 1);
				
				//파일 객체 생성
				File originFile = new File(savePath + "\\" + filename);
				File renameFile = new File(savePath + "\\" + renameFileName);
				
				mfile.transferTo(renameFile);
				
				String detectorFile = ocrPath + "\\" + "namecard_detector.py";
				ProcessBuilder builder = new ProcessBuilder("python", detectorFile, 
						ocrPath + "/ocrstudent-45a0a578de07.json", savePath + "/namecard.jpg");
				builder.redirectErrorStream(true);
				System.out.println(builder.command());
				Process p = builder.start();
				
				BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream(), "utf-8"));
				StringBuilder buffer = new StringBuilder();
				String line = null;
				while((line = br.readLine()) != null) {
					buffer.append(line);
				}
				String email = buffer.toString();
				System.out.println("추출된 이메일 : " + email);
				
				model.addAttribute("extractedTxt", email);
				
				int exitVal = p.waitFor();
				if(exitVal != 0)  {
				   System.out.println("비정상 종료");
				}
				br.close();
				return "member/uploadCardImg";
				
			} else {
				model.addAttribute("message", "데이터 추출 실패!");
				return "common/error";
			}
			
		} else {
			model.addAttribute("message", "데이터 추출 실패!");
			return "common/error";
		}
		
	}
	
	//명함 데이터를 명함 회원가입 폼으로 보냄
	@GetMapping("sendEnrollForm.do")
	public String sendCardData(@RequestParam("extractedTxt") String email, Model model) {
		model.addAttribute("usermail", email);
		return "member/cardEnrollPage";
	}
	
													
	//아이디 찾기
	@RequestMapping("idRecovery.do")
	public ModelAndView idRecovery(@RequestParam("email") String email, ModelAndView mv) {
		Member loginMember = memberService.selectByMail(email);
		
		if(loginMember != null) {
			mv.addObject("find_id", loginMember.getUserid());
			mv.setViewName("member/showUid");
		}else {
			mv.addObject("message", "아이디 찾기 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
		
	}
	
	//비밀번호 찾기 : 임시비밀번호 발급
	@PostMapping("findPwd.do")
	public void passRecovery(Member loginMember, 
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String userid = loginMember.getUserid();
		String email = loginMember.getEmail();
		//아이디 조회에 실패하면, 오류메세지 출력
		if(memberService.chkSelectForPwd(loginMember) == 0) {
			out.print("등록된 아이디 또는 이메일이 없습니다.");
			out.close();
		}else {
			String tempKey = mailService.sendTempPwd(userid, email);
			loginMember.setUserpwd(bcryptPasswordEncoder.encode(tempKey));
			memberService.findPwd(loginMember);
			out.print("인증번호가 발송되었습니다. <br>");
			out.print("<a href=\"main.do\">홈으로 이동</a>");
			out.close();
		}
		
	}
		
	//회원 정보 보기
	//리턴 타입으로 String, ModelAndView를 사용할 수 있음
	@RequestMapping("myinfo.do")
	//public String myinfoMethod() { return "폴더명/뷰파일명"; }
	public ModelAndView myPageMethod(@RequestParam("userid") String userid, ModelAndView mv) {
		//서비스로 전송온 값 전달해서, 실행 결과 받기
		Member member = memberService.selectMember(userid);
		
		if(member != null) {
			mv.addObject("member", member);
			mv.setViewName("member/myinfoPage");
		}else {
			mv.addObject("message", userid + " : 회원 정보 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}

	//회원 정보 수정
	@PostMapping("mupdate.do")
	public String memberUpdate(Member member, Model model, @RequestParam("origin_userpwd") String originUserpwd) {		
		//새로운 암호 전송 시, 패스워드 암호화 처리
		String userpwd = member.getUserpwd().trim();
		if(userpwd != null && userpwd.length() > 0) {
			//기존 암호화 다른 값인지 확인
			if(!this.bcryptPasswordEncoder.matches(userpwd, originUserpwd)){
				//member에 새로운 패스워드를 암호화해 기록
				member.setUserpwd(this.bcryptPasswordEncoder.encode(userpwd));
			}
		} else {
			member.setUserpwd(originUserpwd);
		}
		
		logger.info("after : " + member);
		
		if(memberService.updateMember(member) > 0) {
			//수정이 성공했다면, 컨트롤러의 메소드를 직접 호출할 수도 있음.
			//즉, 컨트롤러 안에서 다른 컨트롤러를 실행할 수도 있음
			//내 정보보기 페이지에 수정된 회원정보를 다시 조회해서 내보냄
			//쿼리스트링 : ?이름=값&이름=값
			return "redirect:myinfo.do?userid=" + member.getUserid();
		}else {
			model.addAttribute("message", member.getUserid() + " : 회원 정보 수정 실패!");
			return "common/error";
		}
		
	}
	
	//회원 탈퇴
	// 삭제되면 자동 로그아웃함
	@RequestMapping("mdel.do")
	public String memberDeleteMethod(@RequestParam("userid") String userid, Model model) {
		if(memberService.deleteMember(userid) > 0) {
			return "redirect:logout.do";
		} else {
			model.addAttribute("message", userid + " : 회원 삭제 요청 실패!");
			return "common/error";
		}
	}
	
}
