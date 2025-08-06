package com.wg.dao;

import org.apache.ibatis.annotations.Param;

import com.wg.dto.Member.MemberDto;

public interface MemberDao {
	void insert(MemberDto dto);  // ȸ������

	MemberDto findById(String id); // ID������ �˻�
	
	MemberDto login(@Param("id") String id, @Param("pw") String pw); //�α���
	
	void updatePassword(@Param("user_id") String userId, @Param("user_pw") String userPw);
	
	void updateUserName(MemberDto dto);   //�г���
	
	int getGradeById(String userId);   //����� ���

}
