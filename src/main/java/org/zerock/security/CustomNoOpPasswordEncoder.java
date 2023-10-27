package org.zerock.security;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPasswordEncoder implements PasswordEncoder{

	//암호화를 피하기 위해 커스텀한것,
	//security-context.xml 을 보면 , 시큐리티가 제공하는 bcryptPasswordEncoder 클래스를 사용하여 자동 암호화
	@Override
	public String encode(CharSequence rawPassword) {
		// TODO Auto-generated method stub
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		// TODO Auto-generated method stub
		return rawPassword.toString().equals(encodedPassword);
	}

}
