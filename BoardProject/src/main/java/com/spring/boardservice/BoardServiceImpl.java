package com.spring.boardservice;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.boarddao.BoardDao;
import com.spring.boardvo.BoardVO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService {
	
	Logger logger = Logger.getLogger(BoardServiceImpl.class);
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<BoardVO> boardList(BoardVO pvo) {
		List<BoardVO> myList = null;
		myList = boardDao.boardList(pvo);
		return myList;
	}

	@Override
	public int boardInsert(BoardVO pvo) {
		int result = 0;
		result = boardDao.boardInsert(pvo);
		return result;
	}

	@Override
	public BoardVO boardDetail(BoardVO pvo) {
		BoardVO detail = null;
		detail = boardDao.boardDetail(pvo);
		return detail;
	}

	@Override
	public int pwdConfirm(BoardVO pvo) {
		int result = 0;
		result = boardDao.pwdConfirm(pvo);
		return result;
	}

	@Override
	public int boardUpdate(BoardVO pvo) {
		int result = 0;
		result = boardDao.boardUpdate(pvo);
		return result;
	}

	@Override
	public int boardDelete(int b_num) {
		int result = 0;
		result = boardDao.boardDelete(b_num);
		return result;
	}

	@Override
	public int boardListCnt(BoardVO pvo) {
		return boardDao.boardListCnt(pvo);
	}

}
