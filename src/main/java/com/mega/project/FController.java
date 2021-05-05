package com.mega.project;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonSubTypes.Type;

//편의 시설 테이블에 대한 컨트롤 해주는 컨트롤러
@Controller
public class FController {
	@Autowired
	FacilityDAO dao; //dao싱글톤 객체 생성
	
	@RequestMapping("getFlocation")
	@ResponseBody //뷰페이지로 넘어가지 않고 바로 실행된 AJAX로 결과값을 리턴
	public List<FacilityVO> select() {
		List<FacilityVO> fList = dao.selectF();
		return fList;
	}
}
