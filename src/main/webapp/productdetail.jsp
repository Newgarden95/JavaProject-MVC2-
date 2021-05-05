<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 상품넘버 받아오기 -->
    <%
    	int pnum1 = Integer.parseInt(request.getParameter("pnum")); //상품목록에서 상품을 클릭하면 해당하는 상품페이지를 넘겨주고 여기서 받는다
    												//자바스크립트에서 사용될 pnum은 request받은 값을 Body로 넘겨준 후 input hidden을 통해 다시 스크립트로 
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
<!-- 제이쿼리 -->
<script type="text/javascript" src = "resources/js/jquery-3.6.0.js"></script>

<!-- Include the plugin's CSS and JS: -->
<script type="text/javascript" src="resources/js/bootstrap-multiselect.js"></script>
<link rel="stylesheet" href="resources/css/bootstrap-multiselect.css" type="text/css"/>
<!-- Initialize the plugin: -->

<!-- 카카오맵API 라이브러리 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a928be6ed8a88c1ba98215dcf28ec6f0&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">

	//넘어온 상품번호로 상품테이블에 접근해서 주소를 가져옴 => 주소를 위도/경도로 바꾸고 그걸 지도의 중심으로 표시 + 편의시설 데이터를 지도에 찍어주기
	$(function() {
		
		//편의시설 & cctv에 대한 위치정보를 담을 배열을 전역변수 선언
		csLatitude = []
		csLongtitude = []
		
		cctvLatitude = []
		cctvLongtitude = []
		
		index = 0 //cs위치정보를 담을 배열 인덱스 카운트를 위한 변수 선언
		index1 = 0//cctv위치정보를 담을 배열 인덱스 카운트를 위한 변수 선언
		$.ajax({
			url: "getFlocation",
			success: function(result) {
				console.log(result)
				//result에 편의시설에 대한 위치정보가 다 들어있음(편의점, cctv) ~> 따라서 분류(편의점, cctv)를 통해 나눠준 후 
				for (let i = 0; i < result.length; i++) {
					if(result[i].name == "cs"){
						csLatitude[index] = result[i].latitude
						csLongtitude[index] = result[i].longtitude
						index++
						
					}else if(result[i].name == "cctv"){
						cctvLatitude[index1] = result[i].latitude
						cctvLongtitude[index1] = result[i].longtitude
						index1++
					}
				}
			}
		}) //편의시설 & cctv에 대한 위치정보를 가져올 AJAX 종료부분
		
		var pnum = ${param.pnum} // 
		var pnum1 = <%=pnum1%> //위에서 jsp 표현식으로 request를 통해 얻어온 pnum값을 출력						
		
		var pname;	//전역변수 선언
		var address; //전역변수 선언(주소)
		
		$.ajax({
			//매물정보 받아올 AJAX
			/*
			수정할 부분
			상품컨트롤러로 상품번호를 보내 상품 받아오기
			*/
			url: "productInfo", //매물번호를 통해서 상품정보를 가져온다
			data : {
				pnum : pnum,
			},
			async:false, //async: false 속성을 추가하면 success에 해당하는 결과값에 선언된 변수를 전역변수에 담아서 사용가능!!! 
									//맨 처음에는 지도에 찍어주는 부분을 success 밖에서 따로 설정함 -> 그러다 보니 결과에서 얻어온 address를 사용할 수 x
									//따라서 결과를 전역변수로 사용할 수 없을까 생각해서 사용
			success: function(result) {
				console.log("결과 확인: ", result)
				pname = result.pname //매물명 : 리모델링된 원룸
				ptype = result.ptype //매물타입 : 아파트
				ctype = result.ctype	//거래형태 : 매매
				price = result.price	//가격 : 500/42만원
				address = result.address	//매물주소 : 서울특별시 서대문구 연세로 2길 17
				address1 = result.address1	//상세주소 : 1동 102호
				contact = result.contact	//판매자 전화번호 : 010-5412-1315
				floor = result.floor	//매물층,건물층 : 4층/5층
				rsize = result.rsize //전용 면적 : 16.5㎡
				room = result.room	//방개수/화장실수 : 3개/2개
				total = result.total //총세대수 : 30세대
				placetype = result.placetype	//세권 : 역세권
				roomimg = result.roomimg	//방사진 : 001.jpg
				roomimg2 = result.roomimg2	//방사진 : 001.jpg
				roomimg3 = result.roomimg3	//방사진 : 001.jpg
				pinfo = result.pinfo		//방상세설명 : 신촌역 2호선 지하철역과 도보로 3분 거리에 위치한 원룸입니다
				dstatue = result.dstatue	//거래상태 : 협의중
				
				//html body태그안에 있는 div태그에 출력된 정보들을 찍어주는 과정
				$(".pname").html(pname)
				$(".ctype").html(ctype)
				$(".price").html(price)
				$(".rsize").html(rsize)
				$(".contact").html(contact)
				$(".dstatue").html(dstatue)
				$(".floor").html(floor)
				$(".room").html(room)
				$(".placetype").html(placetype)
				$("#roomimg").html("<img src = 'resources/rimg/"+roomimg+"'style = 'width:900px; height:599px;'>")
				$("#roomimg2").html("<img src = 'resources/rimg/"+roomimg2+"'style = 'width:500px; height:290px;'>")
				$("#roomimg3").html("<img src = 'resources/rimg/"+roomimg3+"'style = 'width:500px; height:305px'>")
				
				
				/*
				AJAX를 통해 받아온 상품주소 & 편의시설 위치정보를 KAKAO맵에 띄어주기
				1. 상품주소(도로명/지번)를 geocoder를 사용하여 위도/경도로 변경
				2. addressSearch메서드를 활용하여 변경된 위도/경도로 지도에 찍어주기
				*/
				var geocoder = new kakao.maps.services.Geocoder(); //geocoder : 주소를 입력하면 위도와 경도로 바꿔주는 객체
				geocoder.addressSearch(address, function(result, status) {//전역변수로 선언된 address의 주소를 위도/경도로 변경
					if(status === kakao.maps.services.Status.OK){
						console.log(result);
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x); //변경된 위도경도를 담은 변수
						console.log(coords)
					
						var mapContainer = $('#map')[0], // 지도를 표시할 div 
						mapOption = {
							center : new kakao.maps.LatLng(result[0].y, result[0].x), // 지도의 중심좌표(  =>  해당 상품 위도/경도로 바꾸기)
							level : 3
						// 지도의 확대 레벨3
						};
						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						//편의시설 버튼을 누른경우 
						if ($("#b2").click(function() {
						 	//마커에 이미지 입히기
							var imageSrc = 'https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/02/web-20180209042218641969.png', // 마커이미지의 주소입니다    
							imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
							imageOption = {
								offset : new kakao.maps.Point(27, 69)
							}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니
							var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

							for (let i = 0; i < csLatitude.length; i++) { //편의시설 배열 길이
								// 마커가 표시될 위치입니다 
								markerPosition = new kakao.maps.LatLng(csLatitude[i], csLongtitude[i]); //편의시설 위도/경도 정보
								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
									position : markerPosition,
									image : markerImage
								// 마커이미지 설정 
								});
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
							}
						}))
						
						//안전시설 버튼을 누른 경우
						if ($("#b3").click(function() {
							//마커에 이미지 입히기
							var imageSrc = 'https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/02/web-20180221070608779012.png', // 마커이미지의 주소입니다    
							imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
							imageOption = {
								offset : new kakao.maps.Point(27, 69)
							}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니
							var markerImage = new kakao.maps.MarkerImage(
									imageSrc, imageSize, imageOption)

							for (let i = 0; i < cctvLatitude.length; i++) {//안전시설 배열 길이
								// 마커가 표시될 위치입니다 
								markerPosition = new kakao.maps.LatLng(
										cctvLatitude[i], cctvLongtitude[i]); //안전시설 위도/경도 정보
								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
									position : markerPosition,
									image : markerImage
								// 마커이미지 설정 
								});
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
							}
						}))
						
						// 지도에 표시할 원을 생성합니다
						var circle = new kakao.maps.Circle({
							center : new kakao.maps.LatLng(result[0].y, result[0].x), // 원의 중심좌표 입니다 
							radius : 50, // 미터 단위의 원의 반지름입니다 
							strokeWeight : 5, // 선의 두께입니다 
							strokeColor : '#75B8FA', // 선의 색깔입니다
							strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
							strokeStyle : 'dashed', // 선의 스타일 입니다
							fillColor : '#CFE7FF', // 채우기 색깔입니다
							fillOpacity : 0.7
						// 채우기 불투명도 입니다   
						});
						// 지도에 원을 표시합니다 
						circle.setMap(map);
					}
				});
			}
		})//상품정보를 가져온 AJAX 종료
		
		/*
		<장바구니 버튼>
		장바구니 버튼을 누른 경우 
		1. (기본적으로)상품페이지로 넘어오면 pnum과 세션처리된 아이디, like에 0을 마이페이지 컨트롤러로 보내준다 
		2. (상품담기버튼 누른경우)pnum , 세션처리된 아이디, like에 1을 담아 보내준다
		*/
		
		var userid = '${userid}' //${userid}라고 하면 안넘어감.....   ~> userid는 문자열인데 param.userid로 안하는 이유? ~> getAttribute이기 때문에
		var liked = 0
		
		//상품상세페이지로 넘어오면 자동적으로 최근방문페이지 카운트를 위해 AJAX를 이용하여 마이페이지 컨트롤러로 정보들을 넘겨준다
		$.ajax({
			url: "my_insert",
			data: {
				pnum : pnum,
				userid : userid,
				liked : liked,	
			},
			success: function() {
				console.log("최근방문페이지")
			}
		})
		
		//장바구니 버튼을 누른 경우
		//AJAX를 통해 해당 아이디와 상품넘버, like=1 보내줌 ~> 마이페이지 컨트롤러로 ~> insert SQL수행
		$("#b1").click(function() {
			alert("장바구니에 담겼습니다")
			liked = 1

			$.ajax({
				url: "basket",
				data : {
					pnum : pnum,
					userid : userid,
					liked : liked,
				},
				success: function() {
					console.log("찜하기")
				}
			})
		})
		
	// 비로그인 상태에서 장바구니 버튼을 눌렀을 때 로그인 페이지로 전환 
	$("#b4").click(function(){
		alert("로그인이 필요한 서비스입니다.")
		console.log("hid")
		location.href = "ruser_login.jsp"
	});
		
	//상품정보를 클릭하면 정보를 alert를 통해 보여주도록 설정
	$("#b5").click(function(){
		alert(pinfo)
	});
})
</script>

<style type="text/css">
.a{
	display: inline-block; /* div 수평정렬 */
	width: 300px;
	height: 50px;
}
.b{
	display: inline-block; /* div 수평정렬 */
}

.pic{
	display: inline-block;
}
</style>

</head>
<body>
<!-- Navigation : 위에 부분-->
	<nav class="navbar navbar-light bg-light static-top">
		<div class="logo">
			<a class="navbar-brand" href="main.jsp">내 집은 신촌에 있나방 </a>
		</div>
		<div id="menu">
		 <!-- 세션처리 -->
		 <!-- 세션처리된 아이디가 있는경우 -> 로그인된 상태 -->
		<% if(session.getAttribute("userid") == null){ %>
		 <a class="btn btn-primary btn-lg" href="productSummary.jsp">방찾기</a>
		 <a class="btn btn-primary btn-lg" href="ruser_login.jsp">마이페이지</a> <!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="qnamain.jsp">고객센터</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="ruser_select.jsp">회원정보검색</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		<a class="btn btn-primary btn-lg" href="ruser_login.jsp">로그인</a>
		<a class="btn btn-primary btn-lg" href="signup.jsp">회원가입</a>
		<!-- 세션처리된 아이디가 없는경우 -> 로그인 x -->
		<% }else{ %>
		 <a class="btn btn-primary btn-lg" href="productSummary.jsp">방찾기</a>
		 <a class="btn btn-primary btn-lg" href="mypage_main.jsp">마이페이지</a> <!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="PMain.jsp">방내놓기</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="qnamain.jsp">고객센터</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="ruser_update.jsp">회원정보수정</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		 <a class="btn btn-primary btn-lg" href="ruser_delete.jsp">회원탈퇴</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		<a class="btn btn-primary btn-lg" href="ruser_logout.jsp">로그아웃</a><!-- href에 각자 만든 페이지 주소 넣어주기 -->
		<div class="btn btn-primary btn-lg">${userid}님 환영합니다.</div>
		<%} %>
		</div>
	</nav>
	<div class = "content" style="padding-left: 250px; padding-right: 200px">
		<div class = "contentTop" style="width: 1405px; height: 150px; margin-top: 50px"> <!-- 크기고정 width고정시켜버림 -->
			<div class = "a">
				<span class = "pname" style="font-size: 30px; font-weight: bold"></span> <br>
				<span class = "ctype" style="font-weight: bold"></span>&nbsp&nbsp<span class = "price" style="font-weight: bold"></span>
			</div>
				<div class = "a">
					<span style="font-size: 30px; font-weight: bold">전용면적</span><br>
					<span class = "rsize" style="font-weight: bold"></span><span style="font-size: 15px; font-weight: bold">㎡</span>
				</div>
			<div class = "a">
				<span class ="placetype" style="font-size: 30px; font-weight: bold;margin-top: 100px"></span><br>
				<span> </span><br>
			</div>
			<div class = "a" style="float: right; width: 300px; height: 50px;">
				<span style="font-size: 20px; font-weight: bold">주)래미안복덕방부동산중개법인</span><br>
				<span style="font-weight: bold">김미희</span>(<span class = "contact" style="font-weight: bold"></span>)<br>
				<span style="font-weight: bold">거래현황: </span><span class = "dstatue" style="font-weight: bold"></span>
			</div>
			<div id = "a"><!-- 장바구니 테이블 -->
			<%if(session.getAttribute("userid")!=null){ %> <!-- 세션처리된 아이디가 있는경우 -> 로그인된 상태 -->
				<button id = "b1" style="background-color:#007bff; color: white">
					상품담기
				</button>
			<%}else{ %>
				<button id = "b4" style="background-color:#007bff; color: white">
					상품담기
				</button>
			<%} %>
			<button id ="b5" style="background-color:#007bff; color: white">상품상세설명</button>
			</div>
			<hr color="#007bff" size = "5" style="padding-bottom: 5px">
		</div>
		<div id = "contentMid" style="width: 700px">
			<div class = "b">
				해당층/건물층&nbsp&nbsp&nbsp&nbsp<span class = "floor" style="font-weight: bold"></span><span style="font-size: 15px; font-weight: bold">층</span>
			</div>
			<div class = "b" style="margin-left: 50px">
				전용/공급면적&nbsp&nbsp&nbsp&nbsp<span class = "rsize" style="font-weight: bold"></span><span style="font-size: 15px; font-weight: bold">㎡</span>
			</div>
			<div class = "b" style="margin-left: 50px">
				방수/욕실수&nbsp&nbsp&nbsp&nbsp<span class = "room" style="font-weight: bold"></span><span style="font-size: 15px; font-weight: bold">개</span>
			</div>
			<hr>
			<div class = "b">
				난방종류&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<span style="font-weight: bold">개별난방</span>
			</div>
			<div class = "b" style="margin-left: 42px">
				주차대수&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<span style="font-weight: bold">총 1대</span>
			</div>
			<div class = "b" style="margin-left: 60px">
				입주가능일&nbsp&nbsp&nbsp&nbsp
				<span style="font-weight: bold">즉시입주</span>
			</div>
			<hr>
		</div>
		<div id = "contentBot">
			<table>
				<tr>
					<td rowspan="2" id = "roomimg"></td>
					<td id = "roomimg2" style="margin-top: 10px"></td>
				</tr>
				<tr>
					<td id = "roomimg3"></td>
				</tr>
			</table>
		</div>
			<hr>
			<!-- 편의시설/ cctv 정보확인을 위한 버튼 ~> 클릭 시 맵에 찍어줌 -->
			<div id = "pdMap">
				<div id="map" style="width:700px;height:500px;margin-left: 400px"></div>
				<div style="margin-left: 650px">
					<br>
					<button id = "b2" style="background-color:#007bff; color: white"><span style="font-size: 20px"> 편의시설 </span></button>
					<button id = "b3" style="background-color:#007bff; color: white"><span style="font-size: 20px"> 안전시설 </span></button>
				</div>
				<hr style="width: 48.5%; margin-right: 350px" color="#007bff">
			</div>
		</div>
	</div>
	
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
</body>
</html>