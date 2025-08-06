package com.sw.service;

import java.util.List;
import com.sw.dto.PatchBoardDto;

// DAO와 컨트롤러 사이에서 중간 처리 역할
public interface PatchBoardService {
    List<PatchBoardDto> getAllPosts();
    PatchBoardDto getPostById(int bno);
    void insertPost(PatchBoardDto dto); //게시글 추가
    void updatePost(PatchBoardDto dto);
    void deletePost(int bno);
    void increaseViewCount(int p_bno);  //조회수
    PatchBoardDto getDetail(int bno);
    void increaseLike(int p_bno);// 추천 수 증가 서비스 메서드
    void increaseUnLike(int p_bno);  // 비추천 수 증가
    List<PatchBoardDto> searchPosts(String category, String keyword);  // 게시글 검색 기능 인터페이스
}
