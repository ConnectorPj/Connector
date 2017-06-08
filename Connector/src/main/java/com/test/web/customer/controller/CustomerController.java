package com.test.web.customer.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.service.CustomerService;

@Controller
public class CustomerController {
	
	
	@Autowired
	private CustomerService customerService;

	@Autowired
	private CustomerDAO customerDao;

	@RequestMapping("/join")
	public String join() {
		return "join";
	}

	/** 회원가입 처리를 한다. **/
	@RequestMapping("/insertCustomerProc")
	@ResponseBody
	public Map<String, Object> insertCustomerProc(CustomerBean customerBean) {
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원가입에 실패 하였습니다.");
		
		//DB insert
		try {
			int res = customerService.insertCustomer(customerBean);
			
			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	
	/** 로그인 처리 */
	@RequestMapping("/loginProc")
	@ResponseBody
	public Map<String, Object> loginProcAjax(CustomerBean bean, 
			HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		//로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		System.out.println(bean.getCustomerId() );
		System.out.println(bean.getCustomerPw() );
		
		try {
			CustomerBean customerBean = customerService.selectCustomer(bean);
			if( customerBean != null 
					&& customerBean.getCustomerId().equals(bean.getCustomerId()) ) {
				System.out.println("11111111");
				//로그인 성공 - 세션에 저장
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, customerBean);
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				return resMap;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	/** 회원정보 수정 처리를 한다. **/
	@RequestMapping("/updateCustomerProc")
	public String updateCustomerProc(CustomerBean customerBean, Model model) {

		model.addAttribute(Constants.RESULT, Constants.RESULT_FAIL);
		model.addAttribute("customerBean", customerBean);

		// DB update
		int res = customerDao.updateCustomer(customerBean);

		if (res > 0) {
			model.addAttribute(Constants.RESULT, Constants.RESULT_OK);
		}

		return "personalInfoCustomer";
	}

	@RequestMapping("/deleteCustomer")
	public String deleteCustomer(CustomerBean customerBean) {

		// DB insert
		int res = 0;

		try {
			res = customerDao.deleteCustomer(customerBean);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(res);

		return "/main";

	}
	
	@RequestMapping("/selectCustomer")
	public String selectCustomer(CustomerBean customerBean, Model model) {
		// DB로부터 데이터를 가져온다.
		CustomerBean mBean = customerDao.selectCustomer(customerBean);
		// JSP로 보내기 위해서 데이터를 적재한다.
		model.addAttribute("customerBean", mBean);

		return "/main";
	}

	

	@RequestMapping("/registerstudy")
	public String registerstudy() {
		return "registerStudy";
	}

	@RequestMapping("/applicationsuccess")
	
	public String applicationSuccess() {
		return "applicationSuccess";
	}

	@RequestMapping("/registersuccess")
	public String registersuccess() {
		return "registerSuccess";
	}
	
	@RequestMapping("/personalInfoCustomer")
	public String personalInfoCustomer(CustomerBean customerBean, Model model) {

		CustomerBean resBean = customerDao.selectCustomer(customerBean);

		model.addAttribute("customerBean", resBean);

		return "/personalInfoCustomer";
	}

	@RequestMapping("/leaderIntro")
	public String leaderIntro() {
		return "leaderIntro";
	}

	@RequestMapping("/studyIntro")
	public String studyIntro() {
		return "studyIntro";
	}

/** 회원정보 리스트 AJAX **/
	@RequestMapping("/selectCustomerListAjax")
	@ResponseBody
	public Map<String, Object> selectCustomerListAjax(CustomerBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			// int totRecord = memberService.selectMemberListTotalCount();
			// 페이징 계산
			// pagingBean.calcPage(totRecord);

			List<CustomerBean> list = customerService.selectCustomerList(bean, pagingBean);

			resMap.put("customerBean", bean);
			resMap.put("CustomerList", list);
			resMap.put("pagingBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

}