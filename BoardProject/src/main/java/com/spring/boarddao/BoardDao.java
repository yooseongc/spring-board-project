package com.spring.boarddao;

import java.util.List;
import com.spring.boardvo.BoardVO;

public interface BoardDao {

	public List<BoardVO> boardList(BoardVO pvo);
	
	public int boardInsert(BoardVO pvo);
	
	public BoardVO boardDetail(BoardVO pvo);
	
	public int pwdConfirm(BoardVO pvo);
	
	public int boardUpdate(BoardVO pvo);
	
	public int boardDelete(int b_num);

	public int boardListCnt(BoardVO pvo);
	
}
