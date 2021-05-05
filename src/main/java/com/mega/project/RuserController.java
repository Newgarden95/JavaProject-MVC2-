package com.mega.project;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


//클라이언트의 요청에 대한 데이터를 받아 전달하기 쉽게 데이터를 가공하는 역할
@Controller //어노테이션, 표시 
public class RuserController {
   // 1) 스프링 프레임워크에 해당 클래스를 Controller역할을 하도록 등록
   // 2) 싱글톤 객체로 생성

   @Autowired 
   RuserDAO dao; 
   //@Autowired 사용하여 RuserDAO객체 사용하기 위해 의존성 주입
   //객체 생성이(new) 필요없이 객체 자동으로 생성

   @Autowired 
   ProductDAO dao2; 
   
   
   @RequestMapping("ruser_login")
   public void insert(RuserVO bag) throws Exception {
      dao.insert(bag);
   }
   
   //get은 Select기능에 사용, 캐시가 남음, 보안측면이 떨어지나
   //전송속도가 우수하고 파라미터가 url에 노출됨
   
   //post 방식의 경우 패킷안에 숨겨져서 전송됨
   //CUD에 사용되며, 캐시가 남지않아 보안적인 면에서 우수
   //Request body에 데이터가 들어가기 때문에 
   //파라미터가 노출되지 않음.
   
   @RequestMapping(value="idcheck", method = RequestMethod.POST) //http 전달 방식은 post, 전달되는 값은 idcheck
   @ResponseBody    //메서드의 return값을 HTTP reponse의 body에 담는 역할
   public String idcheck(String id) throws Exception {
      
      //int타입으로 캐스팅하여 id가 존재하면 1, 존재하지 않으면 0
      int result = dao.idCheck(id);
      
      if (result != 0) { //0 = 아이디 중복 x, 1 = 아이디 중복 yes
         return "fail"; //중복아이디 존재   
      } else {
         return "success"; //중복아이디 없음
      }
      
   }

   @RequestMapping("main")
   public String login(RuserVO bag, HttpSession session, Model model) {
      // 넘어갈 페이지가 다르다는 점을 Spring에 알려줘야 함 : 반환값 String 타입
      // RuserVO bag을 파라메터로 받고, session으로 로그인 연결, Model로 view page로 이동 
      // model = request.setAttribute와 같은 역할
      
      RuserVO vo = dao.login(bag);
      //dao, login메서드 사용 vo 변수로 정의 
      
      if (vo != null) {

         session.setAttribute("userid", vo.getUserid()); //로그인 성공할 경우 session으로 연결
         
//         로그인 후, 메인페이지에 회원가입 정보(거래형태, 방개수, 희망세권)와 매칭된 매물 추천을 위한 알고리즘
//         회원가입 flow를 거친후 다음 flow에 해당.
         
//          매칭된 결과는 Product 디비에 있는 roomimg(추천매물)이고, 
//         dao2 recommend 메서드(ProductDAO)에 vo를 담아 mapper로 전송
//         productMapper에서 추천 매물(회원가입 정보 = 상품 정보) sql문 dao로 보냄
//         ProductDAO recommend 함수에서 매칭되는 상품 정보를 가져옴

         List<ProductVO> list = dao2.recommend(vo);
         
         model.addAttribute("list", list);
         System.out.println("hds: "+list);
//         view 페이지에 매칭된 상품 정보 결과를 전송
         
         return "main";
//         로그인 성공할 경우 main 페이지로 이동
                  
         } else {
            return "signup";
//         로그인 실패할 경우 회원가입 페이지로 이동
         }
      }

   
   @RequestMapping("checkBasket")
   @ResponseBody  //메서드의 return값을 HTTP reponse의 body에 담는 역할
   public List<ProductVO> checkBasket(@RequestParam(value="userid1") String userid) {
      //   RequestParam
      //   String id = request.getParameter("id"); out.print(id); 동일   
      //   main 페이지 userid1 값을 가져옴   
      System.out.println("유저아이디: "+userid);
      RuserVO bag = dao.checkBasket(userid);
      //   Ruser checkbasket 메서드의 userid에 해당하는 방타입, 개수, 땡세권 값을 bag변수에 담음
      
      List<ProductVO> list = dao2.recommend(bag);
      //   ProductVO recommend 메서드 bag값을 list타입의 list 변수에 담아
      //   RuserVO, ProductVO의 타입, 개수, 세권이 상품 정보에 매칭되는 방 이미지를 가져옴
      System.out.println(list);
      return list;
      // 방 이미지가 담긴 리스트를 반환값으로 넘겨줌
   }
   
   @RequestMapping("ruser_update")
   public void update(RuserVO bag) throws Exception {
      dao.update(bag);
//      System.out.println(bag.getUserpw());
      
   }
   
   @RequestMapping("ruser_select")
   public void select(RuserVO ruservo, Model model) {
      RuserVO vo = dao.select(ruservo);
      
      model.addAttribute("vo2", vo);   
      // 검색결과를 담기위해 views까지 데이터를 넘김.
   }
   
   @RequestMapping("ruser_delete")
   public String delete(RuserVO bag, HttpSession session) throws Exception {
      
      int result = dao.delete(bag);
//      아이디 삭제시 결과값이 1일경우 아이디 삭제, 0일 경우 삭제 x
      
      if(result == 1) {
         session.invalidate();
//         아이디 탈퇴가 성공할 경우 세션끊음
         
         return "redirect:main.jsp";
//         탈퇴될 경우 컨트롤러 -> 메인페이지 메인페이지로 재 요청
         
      }else {
         return "redirect:ruser_delete.jsp";
//         탈퇴가 실패할 경우 삭제 브라우저 페이지로 이동
      }
   }
   
}