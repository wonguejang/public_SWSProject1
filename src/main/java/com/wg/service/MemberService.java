package com.wg.service;

import com.wg.dto.Member.MemberDto;

public interface MemberService {
    void insert(MemberDto dto);  // ȸ������
  
    MemberDto findById(String id);  // ID�� ����� �˻�
    
    MemberDto login(String id, String pw);  // �α���
    
    void updatePassword(String userId, String userPw);  // ��й�ȣ ����
    
    void updateUserName(MemberDto dto);  // �г��� ����
    
    int getGradeById(String userId);  //��� ��ȸ�� �޼���

}
