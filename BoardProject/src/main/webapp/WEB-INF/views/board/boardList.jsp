<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 목록</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		if ("<c:out value='${data.keyword}'/>" != "") {
			$("#keyword").val("<c:out value='${data.keyword}'/>");
			$("#search").val("<c:out value='${data.search}'/>");
		}
		
		if ("<c:out value='${data.pageSize}'/>" != "") {
			$("#pageSize").val("<c:out value='${data.pageSize}'/>");
		}
		
		$("#search").change(function() {
			if ($("#search").val() == "all") {
				$("#keyword").val("글 목록 전체 조회");
			} else if ($("#search").val() != "all") {
				$("#keyword").val("");
				$("#keyword").focus();
			}
		});
		
		$("#searchData").click(function() {
			if ($("#search").val() == "all") {
				if (!chkSubmit($("#keyword"), "검색어를")) return;
			}
			goPage(1);
		});
		
		$("#pageSize").change(function() {
			goPage(1);
		});
		
		$("#excelDown").click(function() {
			$("#f_search").attr("method", "GET");
			$("#f_search").attr("action", "/board/boardExcel.do");
			$("#f_search").submit();
		});
		
		$(".goDetail").click(function() {
			var b_num = $(this).parents("tr").attr("data-num");
			$("#b_num").val(b_num);
			var page = $("#page").val();
			var pageSize = $("#pageSize").val();
			console.log("글번호 : " + b_num);
			$("#detailForm").attr({
				"method": "get",
				"action": "/board/boardDetail.do"
			});
			$("#detailForm").submit();
		});
		
		$("#InsertFormBtn").click(function() {
			location.href = "/board/writeForm.do";
		});

	});
	
	function setOrder(order_by) {
		$("#order_by").val(order_by);
		if ($("#order_sc").val() == "DESC") {
			$("#order_sc").val("ASC");
		} else {
			$("#order_sc").val("DESC");
		}
		goPage(1);
	}
	
	function goPage(page) {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}
		$("#page").val(page);
		$("#f_search").attr("method", "GET");
		$("#f_search").attr("action", "/board/boardList.do");
		$("#f_search").submit();
	}
	
</script>
</head>
<body>
	
	<c:if test="${csrfError != null}">
		<c:remove var="csrfError"/>
	</c:if>
	
	<div id="boardhome">
		<h2><a href="/">HOME</a></h2>
	</div>
	
	<div class="contentContainer">
		<div class="contentTit"><h3>게시판 리스트</h3></div>
		<form name="detailForm" id="detailForm">
			<input type="hidden" name="b_num" id="b_num">
			<input type="hidden" name="page" value="${data.page}">
			<input type="hidden" name="pageSize" value="${data.pageSize}">
		</form>
	
	</div>
	

	<%--======================= 검색 기능 시작 ====================================--%>
	
	<div id="boardSearch">
		<form id="f_search" name="f_search">
			<input type="hidden" id="page" name="page" value="${data.page}">
			<input type="hidden" id="order_by" name="order_by" value="${data.order_by}">
			<input type="hidden" id="order_sc" name="order_sc" value="${data.order_sc}">
			<table border="0" summary="검색">
				<colgroup>
					<col width="70%">
					<col width="30%">				
				</colgroup>
				<tr>
					<td id="btd1">
						<label>검색조건</label>
						<select id="search" name="search">
							<option value="all">전체</option>
							<option value="b_title">제목</option>
							<option value="b_content">내용</option>
							<option value="b_name">작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요.">
						<input type="button" value="검색" id="searchData">
						<input type="button" value="엑셀 다운로드" id="excelDown">
					</td>
					<td id="btd2">한페이지에
						<select id="pageSize" name="pageSize">
							<option value="10">10줄</option>
							<option value="20">20줄</option>
							<option value="30">30줄</option>
							<option value="50">50줄</option>
							<option value="70">70줄</option>
							<option value="100">100줄</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<%--======================= 검색 기능 종료 ====================================--%>
	
	<%--======================= 리스트 시작 ====================================--%>
	<div id="boardList">
		<table cellspacing="0" cellpadding="0" summary="게시판 리스트">
			<colgroup>
				<col width="10%">
				<col width="62%">
				<col width="15%">
				<col width="13%">
			</colgroup>
			<thead>
				<tr>
					<th>
						<a href="javascript:setOrder('b_num');">글번호
							<c:choose>
								<c:when test="${data.order_by == 'b_num' and data.order_sc == 'ASC'}">▲</c:when>
								<c:when test="${data.order_by == 'b_num' and data.order_sc == 'DESC'}">▼</c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose>
						</a>
					</th>
					<th>글제목</th>
					<th>
						<a href="javascript:setOrder('b_date');">작성일
							<c:choose>
								<c:when test="${data.order_by == 'b_date' and data.order_sc == 'ASC'}">▲</c:when>
								<c:when test="${data.order_by == 'b_date' and data.order_sc == 'DESC'}">▼</c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose>
						</a>
					</th>
					<th class="borcle">작성자</th>
				</tr>
			</thead>
			<tbody>
				<!-- 데이터 출력 -->
				<c:choose>
					<c:when test="${not empty boardList}">
						<c:forEach var="board" items="${boardList}" varStatus="status">
							<tr class="tac" data-num="${board.b_num}">
								<td>${count - (status.count - 1)}</td>
								<td class="tal">
									<span class="goDetail">${board.b_title}</span>
								</td>
								<td>${board.b_date}</td>
								<td>${board.b_name}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr><td colspan="4" class="tac">등록된 게시물이 존재하지 않습니다.</td></tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<%--======================= 리스트 종료 ====================================--%>
	
	<%--======================= 글 쓰기 버튼 출력 시작 ====================================--%>
	<div id="contentBtn">
		<input type="button" value="글쓰기" id="InsertFormBtn">
	</div>	
	<%--======================= 글 쓰기 버튼 출력 종료 ====================================--%>
	
	<%--======================= 페이지 네비게이션 시작 ====================================--%>
	<div id="boardPage">
		<tag:paging page="${param.page}" total="${total}" list_size="${data.pageSize}"/>
	</div>	
	<%--======================= 페이지 네비게이션 종료 ====================================--%>
</body>
</html>