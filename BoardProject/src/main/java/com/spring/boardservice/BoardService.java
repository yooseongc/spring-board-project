package com.spring.boardservice;

import java.util.List;

import com.spring.boardvo.BoardVO;

public interface BoardService {

	List<BoardVO> boardList(BoardVO bvo);

	int boardInsert(BoardVO bvo);

	BoardVO boardDetail(BoardVO pvo);

	int pwdConfirm(BoardVO bvo);

	int boardUpdate(BoardVO bvo);

	int boardDelete(int b_num);

	int boardListCnt(BoardVO bvo);

}
