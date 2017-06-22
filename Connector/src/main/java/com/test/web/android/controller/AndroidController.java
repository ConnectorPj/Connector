package com.test.web.android.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.PurchaseDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.service.CustomerService;
import com.test.web.common.service.TeacherService;


   /**
    * Handles requests for the application home page.
    */
   @Controller
   public class AndroidController {

   	// 파일 업로드 저장경로
   	@Value("#{config['file.upload.path']}")
   	private String FILE_UPLOAD_PATH;

   	@Autowired
   	private CustomerDAO customerDAO;

   	@Autowired
   	private PurchaseDAO purchaseDAO;

   	@Autowired
   	private TeacherDAO teacherDAO;

   	@Autowired
   	private PhotoDAO photoDAO;

   	@Autowired
   	private ClassDAO classDAO;

   	@Autowired
   	private CustomerService customerService;

   	@Autowired
   	private TeacherService teacherService;

   	@RequestMapping("/androidLogin")
   	@ResponseBody
   	public Map<String, Object> androidLogin(HttpServletRequest request) {

   		System.out.println(request.getParameter("user"));
   		CustomerBean customerBean = new CustomerBean();
   		PhotoBean photoBean = new PhotoBean();
   		customerBean.setCustomerId(request.getParameter("userId"));
   		customerBean.setCustomerPw(request.getParameter("userPw"));
   		photoBean.setMemberId(request.getParameter("userId"));
   		System.out.println(request.getParameter("userId"));

   		photoBean = photoDAO.selectPhoto(photoBean);
   		customerBean = customerDAO.selectCustomer(customerBean);
   		Map<String, Object> result = new HashMap<>();
   		if (customerBean == null) {
   			TeacherBean teacherBean = new TeacherBean();
   			teacherBean.setTeacherId(request.getParameter("userId"));
   			teacherBean = teacherDAO.selectTeacher(teacherBean);

   			result.put("userId", teacherBean.getTeacherId());
   			result.put("userName", teacherBean.getTeacherName());
   			result.put("userCellphone", teacherBean.getTeacherCellphone());
   			result.put("userProfile", teacherBean.getTeacherInfo());
   			result.put("userGender", teacherBean.getTeacherGender());

   		} else {
   			result.put("userId", customerBean.getCustomerId());
   			result.put("userName", customerBean.getCustomerName());
   			result.put("userCellphone", customerBean.getCustomerCellphone());
   			result.put("userProfile", customerBean.getCustomerProfile());
   			result.put("userGender", customerBean.getCustomerGender());
   		}
   		if (photoBean != null)
   			result.put("photoFileName", photoBean.getPhotoFileName());

   		return result;
   	}

   	/** 학생 회원 가입 */
   	@RequestMapping("/androidInsertStudent")
   	@ResponseBody
   	public Map<String, Object> androidInsertStudent(HttpServletRequest request) {
   		Map<String, Object> result = new HashMap<>();
   		result.put(Constants.RESULT, Constants.RESULT_FAIL);
   		result.put(Constants.RESULT_MSG, "회원가입에 실패하였습니다.");

   		System.out.println(request.getParameter("userName"));
   		// DB insert
   		try {
   			TeacherBean tBean = new TeacherBean();

   			tBean.setTeacherId(request.getParameter("userId"));
   			tBean = teacherService.selectTeacher(tBean);
   			if (tBean == null) {
   				CustomerBean customerBean = new CustomerBean();
   				customerBean.setCustomerId(request.getParameter("userId"));
   				customerBean.setCustomerPw(request.getParameter("userPw"));
   				customerBean.setCustomerName(request.getParameter("userName"));
   				System.out.println(request.getParameter("userId"));

   				int res = customerDAO.insertCustomer(customerBean);
   				if(res > 0){
   					result.put(Constants.RESULT, Constants.RESULT_OK);
   					result.put(Constants.RESULT_MSG, "회원가입에 성공하였습니다.");
   					result.put("userId", customerBean.getCustomerId());
   					result.put("userName", customerBean.getCustomerName());
   					result.put("userCellphone", customerBean.getCustomerCellphone());
   					result.put("userProfile", customerBean.getCustomerProfile());
   					result.put("userGender", customerBean.getCustomerGender());
   				}
   			}else{
   				result.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
   			}
   		} catch (Exception e) {
   			e.printStackTrace();
   			result.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
   		}
   		return result;
   	}

   	/** 강사 회원 가입 */
   	@RequestMapping("/androidInsertTeacher")
   	@ResponseBody
   	public Map<String, Object> androidInsertTeacher(HttpServletRequest request) {
   		Map<String, Object> result = new HashMap<>();
   		result.put(Constants.RESULT, Constants.RESULT_FAIL);
   		result.put(Constants.RESULT_MSG, "회원가입에 실패하였습니다.");

   		System.out.println(request.getParameter("userName"));
   		// DB insert
   		try {
   			CustomerBean cusBean = new CustomerBean();

   			cusBean.setCustomerId(request.getParameter("userId"));
   			cusBean = customerService.selectCustomer(cusBean);
   			if (cusBean == null) {
   				TeacherBean teacherBean = new TeacherBean();
   				teacherBean.setTeacherId(request.getParameter("userId"));
   				teacherBean.setTeacherPw(request.getParameter("userPw"));
   				teacherBean.setTeacherName(request.getParameter("userName"));
   				System.out.println(request.getParameter("userId"));

   				int res = teacherDAO.insertTeacher(teacherBean);
   				if(res > 0){
   					result.put(Constants.RESULT, Constants.RESULT_OK);
   					result.put(Constants.RESULT_MSG, "회원가입에 성공하였습니다.");
   					result.put("userId", teacherBean.getTeacherId());
   					result.put("userName", teacherBean.getTeacherName());
   					result.put("userCellphone", teacherBean.getTeacherCellphone());
   					result.put("userProfile", teacherBean.getTeacherCareer());
   					result.put("userGender", teacherBean.getTeacherGender());
   				}
   			}else{
   				result.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
   			}
   		} catch (Exception e) {
   			e.printStackTrace();
   			result.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
   		}

   		return result;
   	}

   	@RequestMapping("/androidProfile")
   	@ResponseBody
   	public Map<String, Object> androidProfile(HttpServletRequest request) {

   		System.out.println(request.getParameter("user"));
   		CustomerBean customerBean = new CustomerBean();
   		PhotoBean photoBean = new PhotoBean();
   		customerBean.setCustomerId(request.getParameter("userId"));
   		photoBean.setMemberId(request.getParameter("userId"));
   		System.out.println(request.getParameter("userId"));

   		photoBean = photoDAO.selectPhoto(photoBean);
   		customerBean = customerDAO.selectCustomer(customerBean);
   		Map<String, Object> result = new HashMap<>();
   		if (customerBean == null) {
   			TeacherBean teacherBean = new TeacherBean();
   			teacherBean.setTeacherId(request.getParameter("userId"));
   			teacherBean = teacherDAO.selectTeacher(teacherBean);

   			result.put("userId", teacherBean.getTeacherId());
   			result.put("userName", teacherBean.getTeacherName());
   			result.put("userCellphone", teacherBean.getTeacherCellphone());
   			result.put("userProfile", teacherBean.getTeacherInfo());
   			result.put("userGender", teacherBean.getTeacherGender());

   		} else {
   			result.put("userId", customerBean.getCustomerId());
   			result.put("userName", customerBean.getCustomerName());
   			result.put("userCellphone", customerBean.getCustomerCellphone());
   			result.put("userProfile", customerBean.getCustomerProfile());
   			result.put("userGender", customerBean.getCustomerGender());
   		}
   		if (photoBean != null)
   			result.put("photoFileName", photoBean.getPhotoFileName());

   		return result;
   	}

}