package com.spring.replyservice;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.replyvo.ReplyVO;
import com.spring.replydao.ReplyDao;

@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {
	
	private Logger logger = LoggerFactory.getLogger(ReplyServiceImpl.class);
	
	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public List<ReplyVO> replyList(Integer b_num) {
		List<ReplyVO> myList = null;
		myList = replyDao.replyList(b_num);
		return myList;
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		int result = 0;
		result = replyDao.replyInsert(rvo);
		return result;
	}

	@Override
	public int replyUpdate(ReplyVO rvo) {
		int result = 0;
		result = replyDao.replyUpdate(rvo);
		return result;
	}

	@Override
	public int replyDelete(Integer r_num) {
		int result = 0;
		result = replyDao.replyDelete(r_num);
		return result;
	}

}
