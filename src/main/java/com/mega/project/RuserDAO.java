package com.mega.project;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository //DB or 파일 같은 외부 I/O작업 처리
@Component //BbsDAO dao = new MemberDAO(); 한개만 객체 생성!
public class RuserDAO {
	
	//myBatis싱글톤 주소를 주입!!
	@Autowired
	SqlSessionTemplate my;

	
	public void insert(RuserVO bag) throws Exception {
		//myBatis가 대신 해줌
		my.insert("ruser.insert", bag);
	}
	
	public int idCheck(String id) {
		return my.selectOne("ruser.idcheck", id);
	}
	
	public RuserVO login(RuserVO vo) {
		return my.selectOne("ruser.login", vo);	
	}
	
	public void logout(HttpServletResponse response) {
		my.selectOne("ruser.logout", response);
	}

	public void update(RuserVO bag) throws Exception{
		my.update("ruser.update", bag);
//		System.out.println(bag.getUserpw());
	}
	
	public int delete(RuserVO bag) throws Exception{
		System.out.println("dao에서 삭제" + bag.getUserid() + bag.getUserpw());
		return my.delete("ruser.delete", bag);
	}
	
	public RuserVO select(RuserVO bag) {
		return my.selectOne("ruser.select", bag);
	}

	public RuserVO checkBasket(String id) {
		return my.selectOne("ruser.checkBasket" , id);
	}
	
	public RuserVO findpwpw(RuserVO bag) {
		return my.selectOne("ruser.findpw", bag);
	}
	
}
