package com.wg.dto.Member;

public class MemberDto {
	private String userId;
	private String userPw;
	private String userName;
	private String pwHint;
	private int grade;
	
	public MemberDto() { }

	public MemberDto(String userId, String userPw, String userName, String pwHint, int grade) {
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.pwHint = pwHint;
		this.grade = grade;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwHint() {
		return pwHint;
	}

	public void setPwHint(String pwHint) {
		this.pwHint = pwHint;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	
	
}
