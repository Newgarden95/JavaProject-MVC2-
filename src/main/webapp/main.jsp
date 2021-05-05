<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<!-- 로그인 되면, 회원정보 가지고 오고, 상품정보 가지고와서 출력하고, if문으로 조건 건다. -->

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

	//세션처리된 아이디에 해당하는 추천상품
	$(function() {
		userid = "${userid}" //세션처리된 id를 userid변수에 담는다.
		//AJAX를 통해 checkBasket이라는 가상주소로 넘어간다.
		if(userid != null & userid !=""){
		console.log(userid)
		$.ajax({
			async:false,
			url : "checkBasket",
			data : {
				userid1 : userid,
			},
			success : function(result) {
				if(result.length == 1){
					$('#room1').html("<a href = 'productdetail.jsp?pnum="+result[0].pnum+"'><img src ='resources/rimg/"+result[0].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room1').append('<h4>'+result[0].ptype+" / "+result[0].price+"</h4>")
					$('#room1').append('<h5>'+result[0].ctype+" / "+result[0].rsize+" / "+result[0].placetype+"</h5>")
					$('#room1').append('<h5>'+result[0].pinfo+"</h5><br>")
					$('#room2').html('')
					$('#room3').html('')
				}
				if(result.length == 2){
					$('#room1').html("<a href = 'productdetail.jsp?pnum="+result[0].pnum+"'><img src ='resources/rimg/"+result[0].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room1').append('<h4>'+result[0].ptype+" / "+result[0].price+"</h4>")
					$('#room1').append('<h5>'+result[0].ctype+" / "+result[0].rsize+" / "+result[0].placetype+"</h5>")
					$('#room1').append('<h5>'+result[0].pinfo+"</h5><br>")
					
					$('#room2').html("<a href = 'productdetail.jsp?pnum="+result[1].pnum+"'><img src ='resources/rimg/"+result[1].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room2').append('<h4>'+result[1].ptype+" / "+result[1].price+"</h4>")
					$('#room2').append('<h5>'+result[1].ctype+" / "+result[1].rsize+" / "+result[1].placetype+"</h5>")
					$('#room2').append('<h5>'+result[1].pinfo+"</h5><br>")
					
					$('#room3').html('')
				}
				if(result.length >= 3){
					$('#room1').html("<a href = 'productdetail.jsp?pnum="+result[0].pnum+"'><img src ='resources/rimg/"+result[0].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room1').append('<h4>'+result[0].ptype+" / "+result[0].price+"</h4>")
					$('#room1').append('<h5>'+result[0].ctype+" / "+result[0].rsize+" / "+result[0].placetype+"</h5>")
					$('#room1').append('<h5>'+result[0].pinfo+"</h5><br>")
					
					$('#room2').html("<a href = 'productdetail.jsp?pnum="+result[1].pnum+"'><img src ='resources/rimg/"+result[1].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room2').append('<h4>'+result[1].ptype+" / "+result[1].price+"</h4>")
					$('#room2').append('<h5>'+result[1].ctype+" / "+result[1].rsize+" / "+result[1].placetype+"</h5>")
					$('#room2').append('<h5>'+result[1].pinfo+"</h5><br>")
					
					$('#room3').html("<a href = 'productdetail.jsp?pnum="+result[2].pnum+"'><img src ='resources/rimg/"+result[2].roomimg+"' style = 'width: 300px; height: 300px;'></a><br>")
					$('#room3').append('<h4>'+result[2].ptype+" / "+result[2].price+"</h4>")
					$('#room3').append('<h5>'+result[2].ctype+" / "+result[2].rsize+" / "+result[2].placetype+"</h5>")
					$('#room3').append('<h5>'+result[2].pinfo+"</h5><br>")
				}
			}
		})
		}
	})
</script>
<title>내 집은 신촌에 있나방</title>

  <!-- Bootstrap core CSS -->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">

  <!-- Custom fonts for this template -->
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
  <link href="resources/vendor/fontawesome-free/css/all.min.css/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template -->
  <link href="resources/css/landing-page.min.css" rel="stylesheet" type="text/css">
  <link href="resources/css/landing-page.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
  </script>
</head>

<body>
  <!-- Navigation : 맨 위 메뉴바 부분/ 모든 페이지에 공통적으로 들어갈 부분(메뉴바)-->
  <nav class="navbar navbar-light bg-light static-top">
     <div class="logo">
     <a class="navbar-brand" href="#">내 집은 신촌에 있나방</a>
     </div>
    <div id="menu">
		 <!-- 세션처리 -->
		 <!-- 로그인이 안 된 경우 -->
		<% if(session.getAttribute("userid") == null){ %>
		 <a class="btn btn-primary btn-lg" href="productSummary.jsp">방찾기</a>
		 <a class="btn btn-primary btn-lg" href="ruser_login.jsp">마이페이지</a> 
		 <a class="btn btn-primary btn-lg" href="qnamain.jsp">고객센터</a>
		 <a class="btn btn-primary btn-lg" href="ruser_update.jsp">회원정보수정</a>
		 <a class="btn btn-primary btn-lg" href="ruser_select.jsp">회원정보검색</a>
		<a class="btn btn-primary btn-lg" href="ruser_login.jsp">로그인</a>
		<a class="btn btn-primary btn-lg" href="signup.jsp">회원가입</a>
		<!-- 로그인 된 경우 -->
		<% }else{ %>
		 <a class="btn btn-primary btn-lg" href="productSummary.jsp">방찾기</a>
		 <a class="btn btn-primary btn-lg" href="mypage_main.jsp">마이페이지</a> 
		 <a class="btn btn-primary btn-lg" href="PMain.jsp">방내놓기</a>
		 <a class="btn btn-primary btn-lg" href="qnamain.jsp">고객센터</a>
		 <a class="btn btn-primary btn-lg" href="ruser_update.jsp">회원정보수정</a>
		 <a class="btn btn-primary btn-lg" href="ruser_select.jsp">회원정보검색</a>
		 <a class="btn btn-primary btn-lg" href="ruser_delete.jsp">회원탈퇴</a>
		<a class="btn btn-primary btn-lg" href="ruser_logout.jsp">로그아웃</a>
		<div class="btn btn-primary btn-lg">${userid}님 환영합니다.</div>
		<%} %>
    </div>
  </nav><!-- navigation 종료 -->

  <!-- Masthead: 헤더부분 -->
  <header class="masthead text-white text-center">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-xl-9 mx-auto">
          <h1 class="mb-5">어떤 방을 찾으세요?</h1>
        </div>
        <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
          <form>
            <div class="form-row">
              <div class="col-12 col-md-9 mb-2 mb-md-0">
                <input type="text" class="form-control form-control-lg" placeholder="지역 또는 단지명을 입력하세요.">
              </div>
              <div class="col-12 col-md-3">
                <button id = "findroom" type="submit" class="btn btn-block btn-lg btn-primary">방찾기</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </header>

  <!-- Icons Grid : 섹션 영역-->
  <section class="features-icons bg-light text-center">
    <div class="container">
      <div class="row">
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
            <div class="features-icons-icon d-flex">
              <i class="icon-screen-desktop m-auto text-primary"></i>
            </div>
            <div class="lead mb-0" id = "room1"></div>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
            <div class="features-icons-icon d-flex">
              <i class="icon-layers m-auto text-primary"></i>
            </div>
               <div class="lead mb-0" id = "room2"></div>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="features-icons-item mx-auto mb-0 mb-lg-3">
            <div class="features-icons-icon d-flex">
              <i class="icon-check m-auto text-primary"></i>
            </div>
            <div class="lead mb-0" id = "room3"></div>
          </div>
        </div>
      </div>
    </div>
  </section>
   <!-- Footer -->
   <footer class="footer bg-light">
      <div class="container">
         <div class="row">
            <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
               <ul class="list-inline mb-2">
                  <li class="list-inline-item"><a href="#">About</a></li>
                  <li class="list-inline-item">&sdot;</li>
                  <li class="list-inline-item"><a href="#">Contact</a></li>
                  <li class="list-inline-item">&sdot;</li>
                  <li class="list-inline-item"><a href="#">Terms of Use</a></li>
                  <li class="list-inline-item">&sdot;</li>
                  <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
               </ul>
               <p class="text-muted small mb-4 mb-lg-0">&copy; Your Website
                  2020. All Rights Reserved.</p>
            </div>
            <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
               <ul class="list-inline mb-0">
                  <li class="list-inline-item mr-3"><a href="#"> <i
                        class="fab fa-facebook fa-2x fa-fw"></i>
                  </a></li>
                  <li class="list-inline-item mr-3"><a href="#"> <i
                        class="fab fa-twitter-square fa-2x fa-fw"></i>
                  </a></li>
                  <li class="list-inline-item"><a href="#"> <i
                        class="fab fa-instagram fa-2x fa-fw"></i>
                  </a></li>
               </ul>
            </div>
         </div>
      </div>
   </footer>

   <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
    