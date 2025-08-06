package com.hc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "user0416";
		String pw = "pass0416";
		
		Class.forName(driver);  // ojdbc6.jar를 메모리로.
		Connection conn = DriverManager.getConnection(url, id, pw);		

		return conn;
	}
	public boolean loginCheck(String id, String pw) throws Exception {
		String sql = "SELECT COUNT(*) FROM member1 WHERE id=? AND pw=?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		if(cnt==0) return false;
		return true;
	}
	
	public String getNameFromId(String id) throws Exception {
		String name = null;
		String sql = "SELECT name FROM member1 WHERE id=?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			name = rs.getString("name");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return name;	
	} 
	public static void main(String[] args) throws Exception {
		MemberDao dao = new MemberDao();
		String name = dao.getNameFromId("YG");
		System.out.println(name);
	}
}







