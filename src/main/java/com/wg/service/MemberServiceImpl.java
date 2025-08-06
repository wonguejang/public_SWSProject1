package com.wg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wg.dao.MemberDao;
import com.wg.dto.Member.MemberDto;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDao memberDao;

    @Override
    public void insert(MemberDto dto) {
        memberDao.insert(dto);
    }

    @Override
    public MemberDto findById(String id) {
        return memberDao.findById(id);
    }

    @Override 
    public MemberDto login(String id, String pw) {
        return memberDao.login(id, pw);
    }

    @Override
    public void updatePassword(String userId, String userPw) {
        memberDao.updatePassword(userId, userPw);
    }

    @Override
    public void updateUserName(MemberDto dto) {
        memberDao.updateUserName(dto);
    }

    @Override
    public int getGradeById(String userId) {
        return memberDao.getGradeById(userId);  
    }


}
