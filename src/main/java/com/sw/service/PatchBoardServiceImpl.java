package com.sw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sw.dao.PatchBoardDao;
import com.sw.dto.PatchBoardDto;

// ���� ������ DAO�� ����
@Service
public class PatchBoardServiceImpl implements PatchBoardService {

    @Autowired
    private PatchBoardDao dao; // XML ���� ���� �ڵ� ����
    
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
    public void insertPost(PatchBoardDto dto) {   //�Խñ� �߰�
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
        return dao.getDetail(bno);  // �� �κп��� ������ ����� ����
    }
    @Override
    public void increaseLike(int p_bno) {
        dao.increaseLike(p_bno); // DAO �޼��� ȣ��
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
