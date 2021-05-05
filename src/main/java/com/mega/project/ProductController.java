package com.mega.project;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mega.project.ProductDAO;
import com.mega.project.ProductVO;

@Controller // 컨트롤러 선언
public class ProductController {// 입력값을 받아서 처리해주는 컨트롤러
	
	@Autowired
	ProductDAO dao;
	// 받아주는 기능 설정, 싱글톤으로 생성 후 하나의 주소값을 호출하여 계속 사용가능
	// ProductDAO의 객체를 dao로 생성
	@RequestMapping("insert")
	// 브라우저에서 입력된 값을 가상주소 insert로 보내주면 아래를 실행
	public void insert(ProductVO productVO) throws Exception {
		// 입력받은 값은 ProductVO타입이고 productVO이라는 변수를 사용해서 찍어 줄 수 있다.
		System.out.println(productVO);
		// 각각의 입력받은 값 확인 productVO를 toString으로 오버라이딩(재정의)해서 입력값을 찍을 수 있다.
		dao.insert(productVO); // ProductDAO class의 insert 메서드 실행
		// 입력받은 productVO 변수를 dao의 insert로 보내준다.
	}
	
	@RequestMapping("select")
	// 브라우저에서 입력된 값을 가상주소 select로 보내주면 아래를 실행
	public void select(ProductVO productVO, HttpSession session) {
		// 입력받은 값은 ProductVO 타입이고 productVO라는 변수명을 사용한다.
		// 세션을 사용하기 위해서 HttpSession을 임포트 시킨다.
		System.out.println("입력받은 번호는 : " + productVO.contact);
		// 입력받은 값 중 contact를 조건으로 사용하기 때문에 잘 받아왔는지 출력값 확인.
		List<ProductVO> list = dao.read(productVO);
		System.out.println(list);
		// db에 있는 여러개의 row를 가져와야해서 list 타입을 사용한다.
		// 싱글톤인 ProductDAO의 read 메서드를 사용
		// 리스트와 전화번호를 세션처리해준다.
		System.out.println("해당 전화번호 확인");
		session.setAttribute("userCon", list);
		session.setAttribute("contact", productVO.contact);
	}
	
	@RequestMapping("pdetail")
	// 브라우저에서 입력된 값을 가상주소 pdetail로 보내주면 아래를 실행
	public void pdetail(ProductVO productVO, Model model) {
		System.out.println("입력받은 매물 번호는 " + productVO.pnum);
		// pnum으로 삭제 처리를 하기 때문에 넘어온 매물 번호 확인하는 출력
		ProductVO productVO2 = dao.pdetail(productVO);
		// dao의 pdetail 메서드를 사용해서 productVO2에 넣어주기.
		// 다시 넣어주는 이유 : 방 사진 1개만 등록하면 변경되서 2개가 나올 수 있도록 하기 위해.
		String pic = productVO2.getRoomimg();
		// productVO02의 roomimg 컬럼을 pic 변수에 넣어준다.
		System.out.println(pic);
		String pic2 = pic.replace("1", "2");
		// pic2변수에는 pic변수에 들어있는 값 중 1을 2로 교체해서 pic2로 넣어준다.
		productVO2.setRoomimg2(pic2);
		// 1 -> 2로 변경한 pic2를 productVO2에 set메서드 사용해서 넣어준다.
		System.out.println(pic2);
		String pic3 = pic2.replace("2", "3");
		productVO2.setRoomimg3(pic3);
		model.addAttribute("productVO2", productVO2);
		// 최종적으로 모델을 통해서 views에는 productVO2를 넘겨준다.
		// model은 views까지만 값을 넘겨주는 역할
	}
	
	@RequestMapping("update")
	// 브라우저에서 입력된 값을 가상주소 update로 보내주면 아래를 실행
	public void update(ProductVO bag) {
		System.out.println("수정할 data는 : " + bag);
		// 입력받은 값을 bag에 넣고 toString(재정의를)통해서 찍어주면 입력받은값 전체 확인 가능
		dao.update(bag);
		// DAO 싱글톤의 update 메서드 사용
	}
	
	@RequestMapping("update2")
	// 브라우저에서 입력된 값을 가상주소 update2로 보내주면 아래를 실행	
	public void update2(ProductVO bag) {
		System.out.println("수정할 data는 : " + bag);
		dao.update(bag);
	}
	
	@RequestMapping("delete")
	// 브라우저에서 입력된 값을 가상주소 delete로 보내주면 아래를 실행	
	public void delete(ProductVO bag) {
		System.out.println("삭제하려는 상품 번호는 : " + bag.pnum); // 입력받은 상품번호
		dao.delete(bag); // DAO에 있는 delete 실행 DAO는 맵퍼파일에서 delete 실행
	}
	
	@RequestMapping("delete2")
	// 브라우저에서 입력된 값을 가상주소 delete2로 보내주면 아래를 실행	
	public void delete2(ProductVO bag) {
		System.out.println("삭제하려는 상품 번호는 : " + bag.pnum); // 입력받은 상품번호
		dao.delete(bag); // DAO에 있는 delete 실행 DAO는 맵퍼파일에서 delete 실행
	}
	
	//신화원 ==> 상품상세페이지에서 상품 목록 가져오기(productDetail.jsp페이지에서 넘겨진 pnum(상품번호)를 통해 해당하는 상품의 정보를 출력)
	@RequestMapping("productInfo")
	@ResponseBody
	public ProductVO productInfo(@RequestParam(value = "pnum") String pnum) { //AJAX에서 data를 보낼 때 String타입으로 보낸 경우 받아줄떄
		ProductVO list = dao.productDetailList(pnum);
		System.out.println(list);
		return list;
	}

}
	