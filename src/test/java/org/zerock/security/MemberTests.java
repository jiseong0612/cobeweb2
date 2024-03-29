package org.zerock.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	
	@Autowired
	private PasswordEncoder pwencoder;
	
	@Autowired
	private MemberMapper mmeberMapper;
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void getMember() {
		String userid ="admin99";
		
		MemberVO member = mmeberMapper.read(userid);
		
		log.info("member = " + member);
	}
	
	@Test
	public void testInsertMember() {
		String sql = "insert into tbl_member(userid, userpw, username) values(?,?,?)";
		
		for(int i = 0; i< 100; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(2, pwencoder.encode("pw"+i));
				if(i< 80) {
					pstmt.setString(1, "user"+i);
					pstmt.setString(3, "일반사용자"+i);
				}else if(i<90) {
					pstmt.setString(1, "manager"+i);
					pstmt.setString(3, "운영자"+i);
				}else {
					pstmt.setString(1, "admin"+i);
					pstmt.setString(3, "관리자"+i);
				}
				pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {try {pstmt.close();}catch (Exception e) {}}
				if(con != null) {try {con.close();}catch (Exception e) {}}
			}
		}	//end for
	}
//	@Test
//	public void testInsertAuth() {
//		String sql = "insert into tbl_member_auth(userid, auth) values(?,?)";
//		
//		for(int i = 0; i< 100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(sql);
//				
//				if(i< 80) {
//					pstmt.setString(1, "user"+i);
//					pstmt.setString(2, "ROLE_USER");
//				}else if(i<90) {
//					pstmt.setString(1, "manager"+i);
//					pstmt.setString(2, "ROLE_MEMBER");
//				}else {
//					pstmt.setString(1, "admin"+i);
//					pstmt.setString(2, "ROLE_ADMIN, ROLE_MEMBER");
//				}
//				pstmt.executeUpdate();
//			}catch (Exception e) {
//				e.printStackTrace();
//			}finally {
//				if(pstmt != null) {try {pstmt.close();}catch (Exception e) {}}
//				if(con != null) {try {con.close();}catch (Exception e) {}}
//			}
//		}	//end for
//	}
	
	
	@Test
    public void testInsertAuth2() {


        String sql = "insert into tbl_member_auth (userid, auth) values (?,?)";

        for(int i = 0; i < 100; i++) {

            Connection con = null;
            PreparedStatement pstmt = null;

            if(i <80){
                addUser("user", sql, i, con, pstmt);
            }else if(i < 90){
                addUser("manager", sql, i, con, pstmt);
                addManager( "manager", sql, i, con, pstmt);
            }else{
                addUser("admin", sql, i, con, pstmt);
                addManager( "admin", sql, i, con, pstmt);
                addAdmin( "admin", sql, i, con, pstmt);
            }
        }//end for
    }

    private void addUser(String type, String sql, int i, Connection con, PreparedStatement pstmt){
        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);


            pstmt.setString(1, type+ i);
            pstmt.setString(2,"ROLE_USER");

            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
            if(con != null) { try { con.close();  } catch(Exception e) {} }

        }
    }

    private void addManager(String type, String sql, int i, Connection con, PreparedStatement pstmt){
        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);


            pstmt.setString(1, type+ i);
            pstmt.setString(2,"ROLE_MEMBER");

            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
            if(con != null) { try { con.close();  } catch(Exception e) {} }

        }
    }

    private void addAdmin(String type, String sql, int i, Connection con, PreparedStatement pstmt){
        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);


            pstmt.setString(1, type+ i);
            pstmt.setString(2,"ROLE_ADMIN");

            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
            if(con != null) { try { con.close();  } catch(Exception e) {} }

        }
    }
}
