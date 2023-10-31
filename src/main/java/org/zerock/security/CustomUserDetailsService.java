package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {

		log.warn("load user by username :  " + userid);
		
		MemberVO vo = memberMapper.read(userid);
		
		log.warn("queried by member mapper :  " + vo);
		
		return vo == null? null : new CustomUser(vo);
	}

	public UserDetails loadUserByUsername(String userid, String username) throws UsernameNotFoundException {

		log.warn("load user by username :  " + userid);
		
		MemberVO vo = memberMapper.read(username);	// 아이디로 회원을 조회 한 다음
		if(!vo.getUserName().equals(username)) {	// 회원이름 '관리자90'이 아니라면 null;
			return null;
		}

		log.warn("queried by member mapper :  " + vo);

		return vo == null ? null : new CustomUser(vo);
	}

}
