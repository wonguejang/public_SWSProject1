package com.sw.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sw.dto.PatchBoardDto;

// MyBatis�� �� �������̽��� �ڵ����� ������
public interface PatchBoardDao {

    // �Խñ� ��ü ��� ��������
    List<PatchBoardDto> getAllPosts();

    // �Խñ� ��ȣ�� Ư�� �Խñ� ��������
    PatchBoardDto getPostById(int bno);

    // �Խñ� �߰�
    void insertPost(PatchBoardDto dto);

    // �Խñ� ����
    void updatePost(PatchBoardDto dto);

    // �Խñ� ����
    void deletePost(int bno);

    // ��ȸ�� ����
    void increaseViewCount(int p_bno);
    
    PatchBoardDto getDetail(int bno);
    
    // �Խñ� ��õ �� ����
    void increaseLike(int p_bno);
    
    // ����õ �� ����
    void increaseUnLike(int p_bno);
    
    // �Խñ� �˻� ��� �������̽�
    List<PatchBoardDto> searchPosts(@Param("category") String category, @Param("keyword") String keyword);

    

    
}
