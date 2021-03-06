<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/order.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;500;900&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<title>Admin</title>
</head>
<body>
	<div class="main__container">

		<!-- header 영역 -->
		<%@include file="/include/header.jsp"%>

		<section class="order__con1">
			<div class="order__con1__img">
				<h2>관리자 페이지</h2>
			</div>


			<div class="mypage-inner">
				<div class="lnb-area">
					<ul>
						<li class="lnb-depth1"><a href="http://localhost:8000/monami/admin?cmd=product&page=0">상품관리</a></li>
						<li class="lnb-depth1"><a href="http://localhost:8000/monami/admin?cmd=users">회원관리</a></li>
						<li class="lnb-depth1"><a href="http://localhost:8000/monami/users?cmd=order">주문관리</a></li>
					</ul>
				</div>
				<div class="cont-area">
					<section class="lately">
						<div style="display: flex; justify-content: space-between; align-items:center;">
							<h4 class="tit">회원관리</h4>
							<div>
								<input id="inputUsername" type="text" placeholder="아이디를 입력하세요" style="width:200px; height:33px; vertical-align:middle;">
								<button type="button" class="btn btn-primary" onclick="searchByUsername()">회원검색</button>
							</div>
							</div>
						<div class="step-wrap">
							<table class="table">
								<thead>
									<tr>
										<th>유저명</th>
										<th>전화번호</th>
										<th>이메일</th>
										<th>권한</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="userTbody">
<!-- 									<tr> -->
<%-- 										<td>${result.username }</td> --%>
<%-- 										<td>${result.phonenumber }</td> --%>
<%-- 										<td>${result.email }</td> --%>
<!-- 										<td><select id="userRole"> -->

<!-- 												<option value="" selected="selected">카테고리</option> -->
<!-- 												<option value="USER">유저</option> -->
<!-- 												<option value="ADMIN">관리자</option> -->

<!-- 										</select></td> -->
<!-- 										<td> -->
<!-- 											<button type="button" class="btn btn-danger" onclick="deleteUser()">권한변경</button> -->
<!-- 										</td> -->
<!-- 									</tr> -->
								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
		</section>
		<ul class="pagination justify-content-center">

			<%-- 		<c:choose> --%>
			<%-- 			<c:when test="${listSize < 20}"> --%>
			<%-- 				<li class="page-item"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page-1}">Previous</a></li> --%>
			<%-- 				<li class="page-item disabled"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page+1}">Next</a></li> --%>
			<%-- 			</c:when> --%>

			<%-- 			<c:when test="${param.page == 0}"> --%>
			<%-- 				<li class="page-item disabled"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page-1}">Previous</a></li> --%>
			<%-- 				<li class="page-item"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page+1}">Next</a></li> --%>
			<%-- 			</c:when> --%>

			<%-- 			<c:otherwise> --%>
			<%-- 				<li class="page-item"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page-1}">Previous</a></li> --%>
			<%-- 				<li class="page-item"><a class="page-link" href="http://localhost:8000/monami/admin?cmd=product&page=${page+1}">Next</a></li> --%>
			<%-- 			</c:otherwise> --%>

			<%-- 		</c:choose> --%>
		</ul>
		<br /> <br /> <br />

		<!-- footer 영역 -->
		<%@include file="../include/footer.jsp"%>

	</div>
	<script type="text/javascript">
	
		function changeRole(id) {
			
			var userRole = $("#"+id+"_userRole option:selected").val();
			var username = $("#inputUsername").val();
			
// 			location.href = "/monami/admin?cmd=usersChangeRoleProc&id="+id+"&userRole="+userRole;
			
			$.ajax({

				type : "get",
				url : "/monami/admin?cmd=usersChangeRoleProc&id="+id+"&userRole="+userRole+"&username="+username,
				dataType: "json"

			}).done(function(resultList) {
				
				if(resultList != null && resultList.length > 0){
					
					$("#userTbody").empty();
					
					for (let result of resultList) {
						
						var roleOption = "";
						var roleOption1 = "";
						
						if(result.userRole == "ADMIN"){
							roleOption = "<option value=\"ADMIN\" selected=\"selected\">관리자</option>\r\n";
							roleOption1 = "<option value=\"USER\">유저</option>\r\n";
						} else {
							roleOption = "<option value=\"USER\" selected=\"selected\">유저</option>\r\n";
							roleOption1 = "<option value=\"\ADMIN\">관리자</option>\r\n";
						}
		
						
						var string = 
							"<tr>\r\n" + 
							"	<td>"+result.username+"</td>\r\n" + 
							"	<td>"+result.phonenumber+"</td>\r\n" + 
							"	<td>"+result.email+"</td>\r\n" + 
							"	<td><select id=\""+result.id+"_userRole\">\r\n" + 
							roleOption+
							roleOption1+
							"	</select></td>\r\n" + 
							"	<td>\r\n" + 
							"		<button type=\"button\" class=\"btn btn-danger\" onclick=\"changeRole("+result.id+")\">권한변경</button>\r\n" + 
							"	</td>\r\n" + 
							"</tr>";
							
						$("#userTbody").append(string);
					}
					alert("해당 유저의 권한이 변경되었습니다.");
				} else {
					alert("오류가 발생하였습니다.");
				}
				

			}).fail(function(error) {
				alert("권한 변경에 실패하였습니다.");
			});
			
		}
	
		function searchByUsername() {

			var username = $("#inputUsername").val();

			$.ajax({

				type : "get",
				url : "/monami/admin?cmd=usersSearchProc&username=" + username,
				dataType: "json"

			}).done(function(resultList) {
				
				if(resultList != null){
					
					$("#userTbody").empty();
					
					for (let result of resultList) {
						
						var roleOption = "";
						var roleOption1 = "";
						
						if(result.userRole == "ADMIN"){
							roleOption = "<option value=\"ADMIN\" selected=\"selected\">관리자</option>\r\n";
							roleOption1 = "<option value=\"USER\">유저</option>\r\n";
						} else {
							roleOption = "<option value=\"USER\" selected=\"selected\">유저</option>\r\n";
							roleOption1 = "<option value=\"\ADMIN\">관리자</option>\r\n";
						}
		
						
						var string = 
							"<tr>\r\n" + 
							"	<td>"+result.username+"</td>\r\n" + 
							"	<td>"+result.phonenumber+"</td>\r\n" + 
							"	<td>"+result.email+"</td>\r\n" + 
							"	<td><select id=\""+result.id+"_userRole\">\r\n" + 
							roleOption+
							roleOption1+
							"	</select></td>\r\n" + 
							"	<td>\r\n" + 
							"		<button type=\"button\" class=\"btn btn-danger\" onclick=\"changeRole("+result.id+")\">권한변경</button>\r\n" + 
							"	</td>\r\n" + 
							"</tr>";
							
						$("#userTbody").append(string);
					}
				} else {
					alert("해당아이디가 없습니다.");
				}
				

			}).fail(function(error) {
				alert("검색 실패");
			});

		}
	</script>
	<script src="js/index.js"></script>

</body>
</html>