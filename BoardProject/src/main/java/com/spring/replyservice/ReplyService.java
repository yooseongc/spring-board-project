package com.spring.replyservice;

import java.util.List;

import com.spring.replyvo.ReplyVO;

public interface ReplyService {

	List<ReplyVO> replyList(Integer b_num);

	int replyInsert(ReplyVO rvo);

	int replyUpdate(ReplyVO rvo);

	int replyDelete(Integer r_num);

}
