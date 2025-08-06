package com.sw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sw.dao.PatchBoardDao;
import com.sw.dto.PatchBoardDto;

// 실제 로직을 DAO에 위임
@Service
public class PatchBoardServiceImpl implements PatchBoardService {

    @Autowired
    private PatchBoardDao dao; // XML 매퍼 통해 자동 주입
    
    @Autowired
    private PatchBoardDao patchBoardDao;

    @Override
    public List<PatchBoardDto> getAllPosts() {
        return dao.getAllPosts();
    }

    @Override
    public PatchBoardDto getPostById(int bno) {
        return dao.getPostById(bno);
    }

    @Override
    public void insertPost(PatchBoardDto dto) {   //게시글 추가
        dao.insertPost(dto);
    }

    @Override
    public void updatePost(PatchBoardDto dto) {
        dao.updatePost(dto);
    }

    @Override
    public void deletePost(int bno) {
        dao.deletePost(bno);
    }

    @Override
    public void increaseViewCount(int p_bno) {
        patchBoardDao.increaseViewCount(p_bno);
    }
    @Override
    public PatchBoardDto getDetail(int bno) {
        return dao.getDetail(bno);  // 이 부분에서 오류가 없어야 정상
    }
    @Override
    public void increaseLike(int p_bno) {
        dao.increaseLike(p_bno); // DAO 메서드 호출
    }
    @Override
    public void increaseUnLike(int p_bno) {
        dao.increaseUnLike(p_bno);
    }
    @Override
    public List<PatchBoardDto> searchPosts(String category, String keyword) {
        return dao.searchPosts(category, keyword);
    }


}
