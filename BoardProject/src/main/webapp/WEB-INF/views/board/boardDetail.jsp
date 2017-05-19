<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세 보기</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
	var butChk = 0;
	$(document).ready(function() {
		$("#pwdChk").hide();
		
		var file = "<c:out value='${detail.b_file}'/>";
		if (file != "") {
			$("#fileImage").attr({
				src: "/uploadStorage/${detail.b_file}",
				width: "450px",
				height: "200px"
			});
		}
		
		$("#updateForm").click(function() {
			$("#pwdChk").show();
			$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
			butChk = 1;
		});
		
		$("#boardDelete").click(function() {
			$("#pwdChk").show();
			$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
			butChk = 2;
		});
		
		$("#pwdBut").click(function() {
			pwdConfirm();
		});
		
		$("#boardList").click(function() {
			location.href = "/board/boardList.do?page=${param.page}&pageSize=${param.pageSize}";
		});
	});
	
	function pwdConfirm() {
		if (!chkSubmit($("#b_pwd"), "비밀번호를")) return;
		else {
			$.ajax({
				url: "/board/pwdConfirm.do",
				type: "POST",
				data: $("#f_pwd").serialize(),
				error: function() {
					alert("시스템 오류입니다. 관리자에게 문의하세요.");
				},
				success: function(resultData) {
					var goUrl = "";
					if (resultData == 0) {
						$("#msg").text("작성시 입력한 비밀번호가 일치하지 않습니다.").css("color", "red");
						$("#b_pwd").select();
					} else if (resultData == 1) {
						$("#msg").text("");
						if (butChk == 1) {
							goUrl = "/board/updateForm.do";
						} else if (butChk == 2) {
							goUrl = "/board/boardDelete.do";
						}
						$("#f_data").attr("action", goUrl);
						$("#f_data").submit();
					}
				}
			});
		}
	}
</script>
</head>
<body>
	
	<div id="boardTit"><h3>글상세</h3></div>
	
	<form name="f_data" id="f_data" method="POST">
		<input type="hidden" name="b_num" id="b_num" value="${detail.b_num}">
	</form>
	
	<table id="boardPwdBut">
		<tr>
			<td id="btd1">
				<div id="pwdChk">
					<form name="f_pwd" id="f_pwd">
						<input type="hidden" name="b_num" id="b_num" value="${detail.b_num}">
						<label for="b_pwd" id="l_pwd">비밀번호 : </label>
						<input type="password" name="b_pwd" id="b_pwd">
						<input type="button" id="pwdBut" value="확인">
						<span id="msg"></span>
					</form>
				</div>
			</td>
			<td id="btd2">
				<input type="button" value="수정" id="updateForm">
				<input type="button" value="삭제" id="boardDelete">
				<input type="button" value="목록" id="boardList">
			</td>
		</tr>
	</table>
	
	<div class="contentTB">
		<table>
			<colgroup>
				<col width="17%">
				<col width="33%">
				<col width="17%">
				<col width="33%">
			</colgroup>
			<tbody>
				<tr>
					<td class="ac">작성자</td>
					<td>${detail.b_name}</td>
					<td class="ac">작성일</td>
					<td>${detail.b_date}</td>
				</tr>
				<tr>
					<td class="ac">제목</td>
					<td colspan="3">${detail.b_title}</td>
				</tr>
				<tr>
					<td class="ac vm">내용</td>
					<td colspan="3">${detail.b_content}</td>
				</tr>
				<tr>
					<td class="ac vm">첨부파일 이미지</td>
					<td colspan="3"><img id="fileImage"></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<jsp:include page="reply.jsp"/>
	
	<%-- <div id="boardDetail">
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<tbody>
				<tr>
					<td class="ac">작성자</td>
					<td>${detail.b_name}</td>
					<td class="ac">작성일</td>
					<td>${detail.b_date}</td>
				</tr>
				<tr>
					<td class="ac">제목</td>
					<td colspan="3">${detail.b_title}</td>
				</tr>
				<tr class="ctr">
					<td class="ac">내용</td>
					<td colspan="3">${detail.b_content}</td>
				</tr>
			</tbody>
		</table>
	</div> --%>
	
</body>
</html>