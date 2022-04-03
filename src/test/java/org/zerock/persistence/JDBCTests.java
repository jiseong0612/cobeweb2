package org.zerock.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class JDBCTests {
	@Autowired
	DataSource ds;

	@Autowired
	private SqlSessionFactory factory;

	@Test
	public void testConnection() throws Exception {
		/*
		 * Class clz = Class.forName("oracle.jdbc.driver.OracleDriver"); Connection conn
		 * = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",
		 * "book_ex", "book_ex");
		 * 
		 * log.info("conn = {}", conn);
		 */

		SqlSession session = factory.openSession();
		Connection con = session.getConnection();
		log.info("factory = {}", factory);
	}
	
	
}
