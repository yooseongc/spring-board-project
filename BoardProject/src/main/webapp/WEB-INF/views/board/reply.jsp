<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>comment</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/reply.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		var b_num = "<c:out value='${detail.b_num}'/>";
		listAll(b_num);
		
		$("#replyInsert").click(function() {
			if (!chkSubmit($("#r_name"), "이름을")) return;
			else if (!chkSubmit($("#r_content"), "내용을")) return;
			else {
				var insertUrl = "/replies/replyInsert.do";
				$.ajax({
					url: insertUrl,
					type: "POST",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					dataType: "text",
					data: JSON.stringify({
						b_num: b_num,
						r_name: $("#r_name").val(),
						r_pwd: $("#r_pwd").val(),
						r_content: $("#r_content").val()
					}),
					error: function() {
						alert("시스템 오류입니다. 관리자에게 문의하세요.");
					},
					success: function(resultData) {
						if (resultData == "SUCCESS") {
							alert("댓글 등록이 완료되었습니다.");
							dataReset();
							listAll(b_num);
						}
					}
				});
			}
		});
		
		$(document).on("click", ".update_form", function() {
			$(".reset_btn").click();
			var conText = $(this).parents("li").children().eq(1).html();
			console.log("conText: " + conText);
			$(this).parents("li").find("input[type='button']").hide();
			$(this).parents("li").children().eq(0).html();
			var conArea = $(this).parents("li").children().eq(1);
			
			conArea.html("");
			var data = "<textarea name='content' id='content'>" + conText + "</textarea>";
			data += "<input type='button' class='update_btn' value='수정완료'>";
			data += "<input type='button' class='reset_btn' value='수정취소'>";
			conArea.html(data);
		});
		
		$(document).on("click", ".reset_btn", function() {
			var conText = $(this).parents("li").find("textarea").html();
			$(this).parents("li").find("input[type='button']").show();
			var conArea = $(this).parents("li").children().eq(1);
			conArea.html(conText);
		});
		
		$(document).on("click", ".update_btn", function() {
			var r_num = $(this).parents("li").attr("data-num");
			var r_content = $("#content").val();
			if (!chkSubmit($("#content"), "댓글 내용을")) return;
			else {
				$.ajax({
					url: '/replies/' + r_num + '.do',
					type: 'PUT',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "PUT"
					},
					dataType: 'text',
					data: JSON.stringify({ r_content: r_content }),
					success: function(result) {
						console.log("result: " + result);
						if (result == 'SUCCESS') {
							alert('수정되었습니다.');
							listAll(b_num);
						}
					}
				});
			}
		});
		
		$(document).on("click", ".delete_btn", function() {
			var r_num = $(this).parents("li").attr("data-num");
			console.log("r_num: " + r_num);
			
			if (confirm("선택하신 댓글을 삭제하시겠습니까?")) {
				$.ajax({
					type: 'DELETE',
					url: '/replies/' + r_num + ".do",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "DELETE"
					},
					dataType: "text",
					success: function(result) {
						console.log("result: " + result);
						if (result == 'SUCCESS') {
							alert("삭제되었습니다.");
							listAll(b_num);
						}
					}
				});
			}
		});
		
	});
	
	function listAll(b_num) {
		$("#comment_list").html("");
		var url = "/replies/all/" + b_num + ".do";
		$.getJSON(url, function(data) {
			console.log(data.length);
			$(data).each(function() {
				var r_num = this.r_num;
				var r_name = this.r_name;
				var r_content = this.r_content;
				var r_date = this.r_date;
				addNewItem(r_num, r_name, r_content, r_date);
			});
		}).fail(function() {
			alert("댓글 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.");
		});
	}
	
	function addNewItem(r_num, r_name, r_content, r_date) {
		var new_li = $("<li>");
		new_li.attr("data-num", r_num);
		new_li.addClass("comment_item");
		
		var writer_p = $("<p>");
		writer_p.addClass("writer");
		
		var name_span = $("<span>");
		name_span.addClass("name");
		name_span.html(r_name + "님");
		
		var date_span = $("<span>");
		date_span.html(" / " + r_date + " ");
		
		var up_input = $("<input>");
		up_input.attr({
			"type": "button", "value": "수정하기"
		});
		up_input.addClass("update_form");
		
		var del_input = $("<input>");
		del_input.attr({
			"type": "button", "value": "삭제하기"
		});
		del_input.addClass("delete_btn");
		
		var content_p = $("<p>");
		content_p.addClass("con");
		content_p.html(r_content);
		
		writer_p.append(name_span).append(date_span).append(up_input).append(del_input);
		new_li.append(writer_p).append(content_p);
		$("#comment_list").append(new_li);
	}
	
	function dataReset() {
		$("#r_name").val("");
		$("#r_pwd").val("");
		$("#r_content").val("");
	}
	
</script>
</head>
<body>
	
	<div id="replyContainer">
		<h1></h1>
		<div id="comment_write">
			<form id="comment_form">
				<div>
					<label for="r_name">작성자</label>
					<input type="text" name="r_name" id="r_name">
					<label for="r_pwd">비밀번호</label>
					<input type="password" name="r_pwd" id="r_pwd">
					<input type="button" id="replyInsert" value="저장하기">
				</div>
				<div>
					<label for="r_content">댓글 내용</label>
					<textarea name="r_content" id="r_content"></textarea>
				</div>
			</form>
		</div>
		<ul id="comment_list">
			<!-- 여기에 동적 생성 요소가 들어가게 된다. -->
		</ul>
	</div>
	
</body>
</html>