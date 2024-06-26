package com.todoc.view.admin.hosapproval;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.admin.hosapproval.HosApprovalService;
import com.todoc.admin.hosapproval.HosApprovalVO;
import com.todoc.common.Paging;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.membership.HosMembershipService;
import com.todoc.membership.HosMembershipVO;

@RequestMapping("/admin")
@Controller
public class HosApprovalController {
	@Autowired
	HosApprovalService hosApprovalService;
	@Autowired
	HospitalService hospitalService;
//	@Autowired
//	HosMembershipService hosmembershipService;
	
	//병원 전체 조회 + 페이징
	@RequestMapping("/getHosApprovalList.do")
	public String approvalMain(HosApprovalVO vo, HttpServletRequest request, Model model
					, @RequestParam(value = "beginDate", required = false) String beginDate
					, @RequestParam(value = "endDate", required = false) String endDate
					, @RequestParam(value = "searchCondition", required = false) String searchCondition
					) {
		System.out.println(">> HosHosApprovalController approvalMain() 실행");

		System.out.println("beginDate : " + beginDate);
		System.out.println("endDate : " + endDate);
		System.out.println("searchCondition : " + searchCondition);
		
		//병원 조건별 검색(승인전,승인완료,결제완료)
		if (searchCondition != null && !searchCondition.isEmpty()) {
			vo.setCondition(searchCondition);
		}
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		System.out.println("전체 게시물 수량 전 vo : " + vo);
		p.setTotalRecord(hosApprovalService.getAjaxTotCnt(vo));
		p.setTotalPage();
		System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
		System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재 페이지 번호 구하기
		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}
		System.out.println("> cPage : " + cPage);
		System.out.println("> Paging nowPage : " + p.getNowPage());
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		System.out.println(">> 시작번호(begin) : " + p.getBegin());
		System.out.println(">> 끝번호(end) : " + p.getEnd());
		int begin = p.getBegin();
		int end = p.getEnd();
		
		//4. 블록(block) 계산하기
		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		System.out.println(">> nowBlock : " + p.getNowBlock());
		System.out.println(">> beginPage : " + p.getBeginPage());
		System.out.println(">> endPage : " + p.getEndPage());
		
		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
			System.out.println(">> 정정 후 endPage : " + p.getEndPage());
		}
		
		//병원승인 관리[getHosApprovalList.jsp] onload시, 병원 전체목록 조회
		List<HosApprovalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, searchCondition, begin, end);
		System.out.println(">> 병원 목록 조회 hosList : " + hosList);
		
		model.addAttribute("hosList", hosList);
		model.addAttribute("pagingVO", p);
		
		return "admin/getHosApprovalList";
	}
	
	//병원 동적 조회 + 페이징
	@RequestMapping(value = "/getHosApprovalSearch.do")
	public String getAjaxApprovalList(HosApprovalVO vo, HttpServletRequest request, Model model
					, @RequestParam(value = "beginDate", required = false) String beginDate
					, @RequestParam(value = "endDate", required = false) String endDate
					, @RequestParam(value = "searchCondition", required = false) String searchCondition
					) {
		System.out.println(">> HosApprovalController getAjaxApprovalList() 실행");
		System.out.println(">> HosApprovalVO vo : " + vo);
		System.out.println("beginDate : " + beginDate);
		System.out.println("endDate : " + endDate);
		
		//회원가입 조건별
		if (beginDate != null && beginDate != null) {
			vo.setSearchCondition("date");
			vo.setBeginDate(beginDate);
			vo.setEndDate(endDate);
		} 
		//병원 조건별 검색(승인전,승인완료,결제완료)
		if (searchCondition != null) {
			switch (searchCondition) {
            case "before":
                vo.setSearchCondition("before");
                break;
            case "after":
                vo.setSearchCondition("after");
                break;
            case "payment":
                vo.setSearchCondition("payment");
                break;
            case "all":
                vo.setSearchCondition("all");
                break;
			}
		}
		System.out.println("searchCondition getSearchCondition() : " + vo.getSearchCondition());
		
		//vo 데이터의 getOpenTime() null 값으로  cnt 검색 조건으로 사용X
		System.out.println(">> 페이징 전 vo.getOpenTime() : " + vo.getOpenTime());
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		//날짜 검색 시, totalRecord가 0 추출되면 안됨.
		int totalRecord = hosApprovalService.getAjaxTotCnt(vo);
		System.out.println("::: totalRecord 전체 수 : " + totalRecord);
		p.setTotalRecord(totalRecord);
		p.setTotalPage();
		System.out.println("> Ajax 전체 게시글 수 : " + p.getTotalRecord());
		System.out.println("> Ajax 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재 페이지 번호 구하기
		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			if (cPage.equals("0")) {
				cPage = "1";
			}
			p.setNowPage(Integer.parseInt(cPage));
			if (p.getTotalPage() < Integer.parseInt(cPage)) {
				System.out.println("p.getTotalPage() < cPage 경우");
				p.setNowPage(p.getTotalPage());
				System.out.println("> Ajax totalPage보다 cPage가 큰 경우 : " + p.getNowPage());
			}
		}
		System.out.println("> Ajax 최종 cPage : " + cPage);
		System.out.println("> Ajax Paging nowPage : " + p.getNowPage());
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		System.out.println(">> Ajax 시작번호(begin) : " + p.getBegin());
		System.out.println(">> Ajax 끝번호(end) : " + p.getEnd());
		int begin = p.getBegin();
		int end = p.getEnd();
		
		//4. 블록(block) 계산하기
		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		System.out.println(">> Ajax nowBlock : " + p.getNowBlock());
		System.out.println(">> Ajax beginPage : " + p.getBeginPage());
		System.out.println(">> Ajax endPage : " + p.getEndPage());
		
		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
			System.out.println(">> Ajax 정정 후 endPage : " + p.getEndPage());
		}
		
		//병원승인 동적 검색 전체 목록 + 페이징
		List<HosApprovalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, searchCondition, begin, end);
		System.out.println(">> getAjaxApprovalList - 병원목록조회 hosList : " + hosList);
		System.out.println("p : " + p);
		
		model.addAttribute("hosList", hosList);
		model.addAttribute("pagingVO", p);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		
		return "admin/getHosApprovalList";
	}
	
	//병원 승인 클릭
	@RequestMapping("/approvalPro.do")
	public String aprrovalClick(HosApprovalVO hosptial, Model model
//								, HttpSession session, HospitalVO hvo
								) {
		System.out.println(">> approvalClick() 메소드 실행~~");
		System.out.println("hosptial : " + hosptial);
		
		int clickCnt;
		try {
			clickCnt = hosApprovalService.updateApproval(hosptial.getHosIdx());
			System.out.println("hosptial.getHosIdx() : " + hosptial.getHosIdx()
			+ ", clickCnt : " + clickCnt);
			if (clickCnt == 1) {
//				hvo.setCondition("결제완료");
//				hosmembershipService.updateHosCondition(hvo); 
//				session.setAttribute("hoUser", hvo);

				System.out.println("승인 완료!!");
			} 
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("승인 처리 오류 발생!");
		}
		return "redirect:../admin/getHosApprovalList.do";
	}

	//병원 승인취소 클릭
	@RequestMapping("/approvalBeforePro.do")
	public String aprrovalClickCancel(HosApprovalVO hosptial, Model model) {
		System.out.println(">> aprrovalClickCancel() 메소드 실행~~");
		System.out.println("hosptial : " + hosptial);
		
		int clickCnt;
		try {
			clickCnt = hosApprovalService.updateBeforeApproval(hosptial.getHosIdx());
			System.out.println("hosptial.getHosIdx() : " + hosptial.getHosIdx()
			+ ", clickCnt : " + clickCnt);
			if (clickCnt == 1) {
				System.out.println("승인취소 완료!!");
			} 
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("승인취소 처리 오류 발생!");
		}
		return "redirect:../admin/getHosApprovalList.do";
	}
}
