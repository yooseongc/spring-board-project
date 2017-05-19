package com.spring.replydao;

import java.util.List;
import com.spring.replyvo.ReplyVO;

public interface ReplyDao {

	public List<ReplyVO> replyList(Integer b_num);
	
	public int replyInsert(ReplyVO rvo);
	
	public int replyUpdate(ReplyVO rvo);
	
	public int replyDelete(int r_num);
	
}
