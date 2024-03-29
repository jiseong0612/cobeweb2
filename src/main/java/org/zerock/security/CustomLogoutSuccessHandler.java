package org.zerock.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler{

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		log.warn("로그아웃 완료 핸들러");
		log.warn("로그아웃 완료 핸들러");
		log.warn("로그아웃 완료 핸들러");
		log.warn("로그아웃 완료 핸들러");
		log.warn("로그아웃 완료 핸들러");
		log.warn("로그아웃 완료 핸들러");
		
		response.sendRedirect("/customLogin");
	}

}
