package com.sw.service;

import java.util.List;
import com.sw.dto.PatchBoardDto;

// DAO�� ��Ʈ�ѷ� ���̿��� �߰� ó�� ����
public interface PatchBoardService {
    List<PatchBoardDto> getAllPosts();
    PatchBoardDto getPostById(int bno);
    void insertPost(PatchBoardDto dto); //�Խñ� �߰�
    void updatePost(PatchBoardDto dto);
    void deletePost(int bno);
    void increaseViewCount(int p_bno);  //��ȸ��
    PatchBoardDto getDetail(int bno);
    void increaseLike(int p_bno);// ��õ �� ���� ���� �޼���
    void increaseUnLike(int p_bno);  // ����õ �� ����
    List<PatchBoardDto> searchPosts(String category, String keyword);  // �Խñ� �˻� ��� �������̽�
}
