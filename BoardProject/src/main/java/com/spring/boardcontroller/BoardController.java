package com.spring.boardcontroller;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.boardcommon.Paging;
import com.spring.boardcommon.Util;
import com.spring.boardexcel.ListExcelView;
import com.spring.boardfileupload.FileUploadUtil;
import com.spring.boardservice.BoardService;
import com.spring.boardvo.BoardVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	// 글 목록 구현
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public String boardList(@ModelAttribute BoardVO bvo, Model model) {
		logger.info("boardList 호출 성공");
		
		if (bvo.getOrder_by() == null) bvo.setOrder_by("b_num");
		if (bvo.getOrder_sc() == null) bvo.setOrder_sc("DESC");
		
		logger.info("order_by = " + bvo.getOrder_by());
		logger.info("order_sc = " + bvo.getOrder_sc());
		
		logger.info("search = " + bvo.getSearch());
		logger.info("keyword = " + bvo.getKeyword());
		
		Paging.setPage(bvo);
		
		int total = boardService.boardListCnt(bvo);
		logger.info("total = " + total);
		
		int count = total - (Util.nvl(bvo.getPage()) - 1) * Util.nvl(bvo.getPageSize());
		logger.info("count = " + count);
		
		List<BoardVO> boardList = boardService.boardList(bvo);
		model.addAttribute("count", count);
		model.addAttribute("total", total);
		model.addAttribute("boardList", boardList);
		model.addAttribute("data", bvo);
		return "board/boardList";
	}
	
	// 글 쓰기 폼 출력
	@RequestMapping(value="/writeForm")
	public String writeForm(HttpSession session) {
		logger.info("writeForm 호출 성공");
		
		session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
		logger.info("CSRF_TOKEN : " + session.getAttribute("CSRF_TOKEN"));
		return "board/writeForm";
	}
	
	// 글 쓰기 구현
	/*@RequestMapping(value="/boardInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute BoardVO bvo) {
		logger.info("boardInsert 호출 성공");
		
		int result = 0;
		String url = "";
		result = boardService.boardInsert(bvo);
		if (result == 1) {
			url = "/board/boardList.do";
		}
		
		return "redirect:" + url;
	}*/
	
	@RequestMapping(value="/boardInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute BoardVO bvo, HttpServletRequest request) 
			throws IllegalStateException, IOException {
		logger.info("boardInsert 호출 성공");
		logger.info("fileName : " + bvo.getFile().getOriginalFilename());
		logger.info("b_title : " + bvo.getB_title());
		
		int result = 0;
		String url = "";
		
		String b_file = FileUploadUtil.fileUpload(bvo.getFile(), request);
		bvo.setB_file(b_file);
		
		result = boardService.boardInsert(bvo);
		if (result == 1) {
			url = "/board/boardList.do";
		}
		
		return "redirect:" + url;
	}
	
	// 글 상세보기 구현
	@RequestMapping(value="/boardDetail", method=RequestMethod.GET)
	public String boardDetail(@ModelAttribute BoardVO pvo, Model model) {
		logger.info("boardDetail 호출 성공");
		logger.info("b_num = " + pvo.getB_num());
		logger.info("page = " + pvo.getPage());
		logger.info("pageSize = " + pvo.getPageSize());
		
		BoardVO detail = boardService.boardDetail(pvo);
		if (detail != null) {
			detail.setB_content(detail.getB_content().toString().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("detail", detail);
		return "board/boardDetail";
	}
	
	// 비밀번호 확인
	@ResponseBody
	@RequestMapping(value="/pwdConfirm", method=RequestMethod.POST)
	public String pwdConfirm(@ModelAttribute BoardVO bvo) {
		logger.info("pwdConfirm 호출 성공");
		
		int result = 0;
		result = boardService.pwdConfirm(bvo);
		logger.info("result = " + result);
		
		return result+"";
	}
	
	// 글 수정 폼 출력
	@RequestMapping(value="/updateForm", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute BoardVO pvo, Model model) {
		logger.info("updateForm 호출 성공");
		logger.info("b_num = " + pvo.getB_num());
		
		BoardVO updateData = boardService.boardDetail(pvo);
		
		model.addAttribute("updateData", updateData);
		return "board/updateForm";
	}
	
	// 글 수정 구현
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String boardUpdate(@ModelAttribute BoardVO bvo, HttpServletRequest request)
			throws IllegalStateException, IOException {
		logger.info("boardUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		String b_file = "";
		
		if (!bvo.getFile().isEmpty()) {
			logger.info("========  b_file = " + bvo.getB_file());
			FileUploadUtil.fileDelete(bvo.getB_file(), request);
			b_file = FileUploadUtil.fileUpload(bvo.getFile(), request);
			bvo.setB_file(b_file);
		} else {
			logger.info("첨부파일 없음");
			bvo.setB_file("");
		}
		logger.info("========= b_file = " + bvo.getB_file());
		result = boardService.boardUpdate(bvo);
		if (result == 1) {
			//url = "/board/boardList.do";
			url = "/board/boardDetail.do?b_num=" + bvo.getB_num();
		}
		return "redirect:" + url;
	}
	
	// 글 삭제 구현
	@RequestMapping(value="/boardDelete")
	public String boardDelete(@ModelAttribute BoardVO bvo, HttpServletRequest request) throws IOException {
		logger.info("boardDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		FileUploadUtil.fileDelete(bvo.getB_file(), request);
		result = boardService.boardDelete(bvo.getB_num());
		if (result == 1) {
			url = "/board/boardList.do";
		}
		return "redirect:" + url;
	}
	
	// POI 엑셀 다운로드 구현
	@RequestMapping(value="/boardExcel", method=RequestMethod.GET)
	public ModelAndView boardExcel(@ModelAttribute BoardVO bvo) {
		logger.info("boardExcel 호출 성공");
		
		if (bvo.getOrder_by() == null) bvo.setOrder_by("b_num");
		if (bvo.getOrder_sc() == null) bvo.setOrder_sc("DESC");
		
		Paging.setPage(bvo);
		List<BoardVO> boardList = boardService.boardList(bvo);
		ModelAndView mv = new ModelAndView(new ListExcelView());
		mv.addObject("list", boardList);
		mv.addObject("template", "board.xlsx");
		mv.addObject("file_name", "board");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/board", method=RequestMethod.GET)
	public String board(@ModelAttribute BoardVO bvo, Model model, ObjectMapper om) {
		logger.info("boardList 호출 성공");
		String listData = "";
		List<BoardVO> boardList = boardService.boardList(bvo);
		
		try {
			listData = om.writeValueAsString(boardList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return listData;
	}
	
}
