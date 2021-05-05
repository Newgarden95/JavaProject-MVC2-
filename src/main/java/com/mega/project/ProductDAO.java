package com.mega.project;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mega.project.ProductVO;

@Component
// 어노테이션의 기능 해당 클래스가 특정한 역할을 하게 등록한다, 싱글톤으로 만들어준다. 2가지
// 한개만 객체생성, 한개만 만드는게 싱글톤
// 같은 주소값을 계속 가져다가 사용한다.

public class ProductDAO {

	@Autowired
	SqlSessionTemplate my; // mybatis 사용하는 싱글톤

	// 상품 등록 관련 crud 생성

	// 상품 등록(create)
	public void insert(ProductVO bag) { // 컨트롤러에서 dao.insert 기능을 사용하면 아래를 실행
		my.insert("product.insert", bag); // mybatis의 기능중 insert를 실행
		// mybatis를 활용해서 mapper에 있는 namespace가 product 중 에서 insert라는 id를 가진 기능을 수행
		System.out.println("맵퍼 보내기 성공");
		// my.insert가 실행됫는지 확인 하는 출력값
	}

	// 상품 조회(read)
	public List<ProductVO> read(ProductVO bag) {
		// 리턴타입이 List 형태이기 때문에 리턴 타입으로 받아줘야한다.
		if (bag.getContact().equals("01011111111")) {
			// 입력값의 ProductVO중 contact가 01011111111일때는 아래를 실행
			List<ProductVO> list = my.selectList("product.all", bag);
			// list 변수에 mybatist에 selectList 메서드 사용
			// mapper의 namespace가 product이고 id가 all인 sql문 사용
			System.out.println("맵퍼 보내기 성공");
			// 보냈는지 확인하는 출력
			return list;
		} else { // 입력된 contact값이 01011111111이 아닐때는 아래를 실행
			List<ProductVO> list = my.selectList("product.select", bag);
			// list 변수에 mybatist에 selectList 메서드 사용
			// mapper의 namespace가 product이고 id가 select인 sql문 사용
			System.out.println("맵퍼 보내기 성공");
			// 보냈는지 확인하는 출력
			return list;
		}
	}

	// 상품 상세 조회(read)
	public ProductVO pdetail(ProductVO bag) {
		// 리턴되는 타입이 db있는 row이기 때문에 ProductVO 타입으로 리턴이 된다.
		System.out.println("맵퍼 보내기 성공");
		return my.selectOne("product.detail", bag);
		// 리턴은 항상 맨 마지막에 위치!
		// 리턴을 mybatis의 selectOne 메서드를 사용해서 sql문을 통해서 db의 row값을 가져온다.
	}

	// 상품 수정(update)
	public void update(ProductVO bag) {
		my.update("product.update", bag);
		// 수정할 data는 ProductVO 타입으로 입력을 받는다.
		// mybatis의 update 메서드를 통해서 mapper의 sql문 사용
		System.out.println("맵퍼 보내기 성공");
	}

	// 상품 삭제(delete)
	public void delete(ProductVO bag) {
		// 입력받은 번호값을 mybatis를 통해서 mapper로 전송
		my.delete("product.delete", bag);
		// mapper의 spl문을 통해서 delete 처리
		System.out.println("맵퍼 보내기 성공");
	}
	
	// 상품 추천(선종님)
   public List<ProductVO> recommend(RuserVO bag) {
      return my.selectList("product.recommend", bag);
   }

	
	// 최근본 상품(지수님)
	public List<ProductVO> recentSelect(MypageVO bag) {
		return my.selectList("product.recentselect", bag);
	}
	public ProductVO recentSelect2(String pnum) {
		return my.selectOne("product.recentselect2", pnum);
	}
	//아이디로 상
	public List<ProductVO> recentSelect3(String userid){
		return my.selectList("product.recentselect3", userid);
	}
	public List<ProductVO> recentSelect4(String pnum){
		return my.selectList("product.recentselect2", pnum);
	}


	
	/*
	 * 신화원 
	 * 상품정보를 가져올 경우의 수에 해당하는 쿼리문을 수행할 메서드들
	 * 총 8가지 경우
	 * */
	// 전체 상품 목록 가져오기
	public List<ProductVO> productList() {
		return my.selectList("product.productList");
	}
	// 원룸, 아파트, 오피스텔 타입(방종류)만 선택된 경우
	public List<ProductVO> selectPlist1(ProductVO bag) {
		return my.selectList("product.productList1",bag);
	}
	// 월세, 전세, 매매 타입(거래유형)만 선택된 경우
	public List<ProductVO> selectPlist2(ProductVO bag) {
		return my.selectList("product.productList2",bag);
	}
	// 세권 타입만 선택된 경우
	public List<ProductVO> selectPlist3(ProductVO bag) {
		return my.selectList("product.productList3",bag);
	}
	// 방종류&거래유형 두개가 선택된 경우
	public List<ProductVO> selectPlist4(ProductVO bag) {
		return my.selectList("product.productList4",bag);
	}
	// 방종류&세권유형 두개가 선택된 경우
	public List<ProductVO> selectPlist5(ProductVO bag) {
		return my.selectList("product.productList5",bag);
	}
	// 거래유형&세권유형 두개가 선택된 경우
	public List<ProductVO> selectPlist6(ProductVO bag) {
		return my.selectList("product.productList6",bag);
	}
	// 방종류&거래유형&세권유형 모두 선택된 경우
	public List<ProductVO> selectPlist7(ProductVO bag) {
		return my.selectList("product.productList7",bag);
	}
	//상품상세페이지에 사용될 상품정보 출력
	public ProductVO productDetailList(String pnum) {
		return my.selectOne("product.productDetailList", pnum);
	}
}
