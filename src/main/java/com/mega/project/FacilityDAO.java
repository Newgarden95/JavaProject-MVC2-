package com.mega.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
@Component
public class FacilityDAO {
	@Autowired
	SqlSessionTemplate my; //마이바티스 싱글톤객체 생성
	
	//name에는 편의점/CCTV가 들어가서 각 위치정보를 리스트로 뽑아줌
	public List<FacilityVO> selectF() {
		return my.selectList("facility.select");
	}
}
