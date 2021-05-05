package com.mega.project;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SelectController {
	
	@Autowired
	ProductDAO dao;
	
	@RequestMapping("getProduct")
	//JSP(브라우저)에서 AJAX를 통해 보낸 배열을 컨트롤러에서 받는 방법
	//파라미터로 @RequestParam(value = "보낸 데이터 키값(아이디값)[]") String[] arr)
	//										AJAX로 보낸 데이터(배열)	 받는 데이터가 배열(List)
	@ResponseBody
	public List<ProductVO> category(@RequestParam(value = "arr[]") String[] arr) {
		//AJAX를 통해 받아온 배열형태의 데이터를 각 타입의 문자열 변수에 대입
		String roomType = arr[0];
		String saleType = arr[1];
		String sectionType = arr[2];
		
		//받아온 배열의 내용을 풀어서 VO에 담아주기
		ProductVO bag = new ProductVO();
		bag.ptype = roomType;
		bag.ctype = saleType;
		bag.placetype = sectionType;
		
		// 상품을 담을 리스트 초기화 => List는 인터페이스라 new키워드 못씀 -> ArrayList()대체
		//상품테이블로 보내줌
		List<ProductVO> list = new ArrayList<ProductVO>();
		
		// 전체상품 정보를 출력
		if(roomType.equals("none") & saleType.equals("none") & sectionType.equals("none")) {
			list = dao.productList();
			return list;
		}
		// 선택된 방종류에 해당하는 정보를 출력
		if(saleType.equals("none") & sectionType.equals("none")) {
			list = dao.selectPlist1(bag);
			return list;
		}
		// 선택된 거래유형에 해당하는 정보를 출력
		if(roomType.equals("none") & sectionType.equals("none")) {
			list = dao.selectPlist2(bag);
			return list;
		}
		// 선택된 세권유형에 해당하는 정보를 출력
		if(saleType.equals("none") & roomType.equals("none")) {
			list = dao.selectPlist3(bag);
			return list;
		}
		// 선택된 방종류와 거래유형에 해당하는 정보를 출력
		if(sectionType.equals("none")) {
			list = dao.selectPlist4(bag);
			return list;
		}
		// 선택된 방종류와 세권유형에 해당하는 정보를 출력
		if(saleType.equals("none")) {
			list = dao.selectPlist5(bag);
			return list;
		}
		// 선택된 거래유형과 세권유형에 해당하는 정보를 출력
		if(roomType.equals("none")) {
			list = dao.selectPlist6(bag);
			return list;
		}
		// 선택된 방종류와 거래유형 그리고 세권유형에 해당하는 정보를 출력
		if(!roomType.equals("none") & !saleType.equals("none") & !sectionType.equals("none")) {
			list = dao.selectPlist7(bag);
			return list;
		}
		return list; 
	}
}
