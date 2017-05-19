package com.spring.replydao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.replyvo.ReplyVO;

@Repository
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<ReplyVO> replyList(Integer b_num) {
		return session.selectList("replyList", b_num);
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		return session.insert("replyInsert", rvo);
	}

	@Override
	public int replyUpdate(ReplyVO rvo) {
		return session.update("replyUpdate", rvo);
	}

	@Override
	public int replyDelete(int r_num) {
		return session.delete("replyDelete", r_num);
	}

}
