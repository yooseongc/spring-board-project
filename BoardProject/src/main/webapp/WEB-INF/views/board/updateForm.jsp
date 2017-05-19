<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정 화면</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		var img = $("<img>");
		$("#imgView").hover(function() {
			img.attr({
				src: "/uploadStorage/${updateData.b_file}",
				width: "450px",
				height: "200px"
			});
			img.addClass("imgViewData");
			$("#imgArea").append(img);
		}, function() {
			img.remove();
		});
		
		$("#boardUpdateBtn").click(function() {
			if (!chkSubmit($("#b_title"), "제목을")) return;
			else if (!chkSubmit($("#b_content"), "작성할 내용을")) return;
			else {
				if ($("#file").val().indexOf(".") > -1) {
					var ext = $("#file").val().split(".").pop().toLowerCase();
					if (jQuery.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
						alert('gif, png, jpg, jpeg 파일만 업로드할 수 있습니다.');
						return;
					}
				}
				$("#f_writeForm").attr("method", "POST");
				$("#f_writeForm").attr("action", "/board/boardUpdate.do");
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
	
	<div class="contentContainer">
		<div class="contentTit">
			<h3>게시판 글 수정</h3>
		</div>
		<div class="contentTB">
			<form id="f_writeForm" name="f_writeForm" enctype="multipart/form-data">
				<input type="hidden" id="b_num" name="b_num" value="${updateData.b_num}">
				<input type="hidden" name="page" id="page" value="${param.page}">
				<input type="hidden" name="pageSize" id="pageSize" value="${param.pageSize}">
				<input type="hidden" name="b_file" id="b_file" value="${updateData.b_file}">
				<table>
					<colgroup>
						<col width="17%">
						<col width="33%">
						<col width="17%">
						<col width="33%">
					</colgroup>
					<tbody>
						<tr>
							<td class="ac">글번호</td>
							<td>${updateData.b_num}</td>
							<td class="ac">작성일</td>
							<td>${updateData.b_date}</td>
						</tr>
						<tr>
							<td class="ac">작성자</td>
							<td colspan="3">${updateData.b_name}</td>
						</tr>
						<tr>
							<td class="ac">글제목</td>
							<td colspan="3">
								<input type="text" name="b_title" id="b_title" value="${updateData.b_title}">
							</td>
						</tr>
						<tr>
							<td class="ac vm">내용</td>
							<td colspan="3">
								<textarea name="b_content" id="b_content">${updateData.b_content}</textarea>
							</td>
						</tr>
						<tr>
							<td class="ac">첨부파일</td>
							<td colspan="3">
								<input type="file" name="file" id="file">
								<label id="imgView">기존 이미지 파일명: ${updateData.b_file}<span id="imgArea"></span></label>
							</td>
						</tr>
						<tr>
							<td class="ac">비밀번호</td>
							<td colspan="3">
								<input type="password" name="b_pwd" id="b_pwd">
								<label>수정할 비밀번호를 입력해 주세요.</label>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
		<div class="contentBtn">
			<input type="button" value="수정" id="boardUpdateBtn">
			<input type="button" value="목록" id="boardListBtn">
		</div>
	</div>
	
	<%-- <div id="boardTit">
		<h3>글수정</h3>
	</div>
	
	<form id="f_writeForm" name="f_writeForm" method="post">
		<input type="hidden" id="b_num" name="b_num" value="${updateData.b_num}">
		<table cellspacing="0" cellpadding="0" id="boardWrite">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="b_name" id="b_name" value="${updateData.b_name}"></td>
			</tr>
			<tr>
				<td>글제목</td>
				<td><input type="text" name="b_title" id="b_title" value="${updateData.b_title}"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="b_content" id="b_content"
						rows="10" cols="70">${updateData.b_content}</textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="b_pwd" id="b_pwd"><label>수정할 비밀번호를 입력해 주세요.</label></td>
			</tr>
		</table>
	</form>
	
	<div id="boardBut">
		<input type="button" value="수정" class="but" id="boardUpdate">
		<input type="button" value="목록" class="but" id="boardList">
	</div> --%>

</body>
</html>