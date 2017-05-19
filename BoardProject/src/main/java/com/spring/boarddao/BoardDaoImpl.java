package com.spring.boarddao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.boardvo.BoardVO;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<BoardVO> boardList(BoardVO pvo) {
		return sqlSession.selectList("boardList", pvo);
	}

	@Override
	public int boardInsert(BoardVO pvo) {
		return sqlSession.insert("boardInsert", pvo);
	}

	@Override
	public BoardVO boardDetail(BoardVO pvo) {
		return (BoardVO) sqlSession.selectOne("boardDetail", pvo);
	}

	@Override
	public int pwdConfirm(BoardVO pvo) {
		return (Integer) sqlSession.selectOne("pwdConfirm", pvo);
	}

	@Override
	public int boardUpdate(BoardVO pvo) {
		return sqlSession.update("boardUpdate", pvo);
	}

	@Override
	public int boardDelete(int b_num) {
		return sqlSession.delete("boardDelete", b_num);
	}

	@Override
	public int boardListCnt(BoardVO pvo) {
		return (Integer) sqlSession.selectOne("boardListCnt", pvo);
	}

}
