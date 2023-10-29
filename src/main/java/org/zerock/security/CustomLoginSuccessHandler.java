package org.zerock.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.zerock.domain.MemberVO;
import org.zerock.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.warn("login success...");
		
		List<String> roleNames = new ArrayList<String>();
		CustomUser customUser =  (CustomUser)authentication.getPrincipal();
		User user =  (User)authentication.getPrincipal();
		
		MemberVO member = customUser.getMember();
		
		//추가 작업으로 로그인 성공시 세션에 로그인된 객체 정보를 담을 수 있다.
		log.info("logined member : " + member);
		
		
		authentication.getAuthorities().forEach(autht ->{
			roleNames.add(autht.getAuthority());
		});
		
		log.warn("role names..."  + roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		}
		if(roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/sample/member");
			return;
		}
		
		response.sendRedirect("/board/list");
		
		
	}
}
