<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 화면</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		$("#boardInsertBtn").click(function() {
			if (!chkSubmit($("#b_name"), "이름을")) return;
			else if (!chkSubmit($("#b_title"), "제목을")) return;
			else if (!chkSubmit($("#b_content"), "작성할 내용을")) return;
			else if (!chkSubmit($("#b_pwd"), "비밀번호를")) return;
			else {
				var ext = $("#file").val().split('.').pop().toLowerCase();
				if (jQuery.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
					alert('gif, png, jpg, jpeg 파일만 업로드할 수 있습니다.');
					return;
				}
				$("#f_writeForm").attr("method", "POST");
				$("#f_writeForm").attr("action", "/board/boardInsert.do");
				$("#f_writeForm").submit();
			}
		});
		
		$("#boardListBtn").click(function() {
			location.href = "/board/boardList.do";
		});
	});
	
</script>
</head>
<body>
	
	<!-- <div id="boardTit">
		<h3>글쓰기</h3>
	</div> -->
	
	<div class="contentContainer">
		<div class="contentTit"><h3>게시판 글작성</h3></div>
		
		<div class="contentTB">
			<form id="f_writeForm" name="f_writeForm" enctype="multipart/form-data">
				<input type="hidden" name="csrf" value="${CSRF_TOKEN}">
				<table id="boardWrite">
					<colgroup>
						<col width="17%">
						<col width="83%">
					</colgroup>
					<tr>
						<td class="ac">작성자</td>
						<td><input type="text" name="b_name" id="b_name"></td>
					</tr>
					<tr>
						<td class="ac">글제목</td>
						<td><input type="text" name="b_title" id="b_title"></td>
					</tr>
					<tr>
						<td class="ac vm">내용</td>
						<td><textarea name="b_content" id="b_content"
								rows="10" cols="70"></textarea></td>
					</tr>
					<tr>
						<td class="ac">첨부파일</td>
						<td><input type="file" name="file" id="file"></td>
					</tr>
					<tr>
						<td class="ac">비밀번호</td>
						<td><input type="password" name="b_pwd" id="b_pwd"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="contentBtn">
			<input type="button" value="저장" class="but" id="boardInsertBtn">
			<input type="button" value="목록" class="but" id="boardListBtn">
		</div>
	</div>
	
	<!-- <form id="f_writeForm" name="f_writeForm">
		<table cellspacing="0" cellpadding="0" id="boardWrite">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="b_name" id="b_name"></td>
			</tr>
			<tr>
				<td>글제목</td>
				<td><input type="text" name="b_title" id="b_title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="b_content" id="b_content"
						rows="10" cols="70"></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="b_pwd" id="b_pwd"></td>
			</tr>
		</table>
	</form> -->
	
	<!-- <div id="boardBut">
		<input type="button" value="저장" class="but" id="boardInsertBtn">
		<input type="button" value="목록" class="but" id="boardListBtn">
	</div> -->
	
</body>
</html>