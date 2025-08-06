package com.sw.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sw.dto.PatchBoardDto;

// MyBatis가 이 인터페이스를 자동으로 구현함
public interface PatchBoardDao {

    // 게시글 전체 목록 가져오기
    List<PatchBoardDto> getAllPosts();

    // 게시글 번호로 특정 게시글 가져오기
    PatchBoardDto getPostById(int bno);

    // 게시글 추가
    void insertPost(PatchBoardDto dto);

    // 게시글 수정
    void updatePost(PatchBoardDto dto);

    // 게시글 삭제
    void deletePost(int bno);

    // 조회수 증가
    void increaseViewCount(int p_bno);
    
    PatchBoardDto getDetail(int bno);
    
    // 게시글 추천 수 증가
    void increaseLike(int p_bno);
    
    // 비추천 수 증가
    void increaseUnLike(int p_bno);
    
    // 게시글 검색 기능 인터페이스
    List<PatchBoardDto> searchPosts(@Param("category") String category, @Param("keyword") String keyword);

    

    
}
