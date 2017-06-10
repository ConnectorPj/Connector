package com.test.web.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.service.CustomerService;
import com.test.web.common.service.TeacherService;

@Controller
public class CustomerController {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private CustomerDAO customerDao;

	@Autowired
	private PhotoDAO photoDao;

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

		// DB insert
		try {
			int res = customerService.insertCustomer(customerBean);

			if (res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** 회원가입 처리를 한다. **/
	@RequestMapping("/insertTeacherProc")
	@ResponseBody
	public Map<String, Object> insertTeacherProc(TeacherBean teacherBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원가입에 실패 하였습니다.");

		// DB insert
		try {

			teacherBean.setTeacherCheck("0");
			int res = teacherService.insertTeacher(teacherBean);

			if (res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	/** 회원로그인 처리 */
	@RequestMapping("/CustomerloginProc")
	@ResponseBody
	public Map<String, Object> CustomerloginProcAjax(CustomerBean bean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		// 로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		System.out.println(bean.getCustomerId());
		System.out.println(bean.getCustomerPw());

		try {
			CustomerBean customerBean = customerService.selectCustomer(bean);
			if (customerBean != null && customerBean.getCustomerId().equals(bean.getCustomerId())) {
				// 로그인 성공 - 세션에 저장
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, customerBean);
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				req.getSession().setAttribute(Constants.RESULT_CODE, "C");
				return resMap;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** 강사로그인 처리 */
	@RequestMapping("/TeacherloginProc")
	@ResponseBody
	public Map<String, Object> TeacherloginProcAjax(TeacherBean bean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		// 로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		System.out.println(bean.getTeacherId());
		System.out.println(bean.getTeacherPw());

		try {
			TeacherBean teacherBean = teacherService.selectTeacher(bean);
			if (teacherBean != null && teacherBean.getTeacherId().equals(bean.getTeacherId())) {
				// 로그인 성공 - 세션에 저장
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, teacherBean);
				req.getSession().setAttribute(Constants.RESULT_CODE, "T");
				resMap.put(Constants.RESULT, Constants.RESULT_OK);

				return resMap;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** ID 중복체크 **/
	@RequestMapping("/TeacherCheckId")
	@ResponseBody
	public Map<String, Object> teacherCheckId(TeacherBean teacherBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT_MSG, "이미 사용중인 ID 입니다.");
		resMap.put(Constants.RESULT, "success");

		try {
			int res = teacherService.teacherCheckId(teacherBean);
			if (res == 0) {
				resMap.put(Constants.RESULT_MSG, "사용할 수 있는 ID 입니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

	/** 로그아웃 **/

	@RequestMapping("/logout")
	public String logout(HttpServletRequest req) {

		req.getSession().invalidate();

		return "main";
	}

	/** ID 중복체크 **/
	@RequestMapping("/customerCheckId")
	@ResponseBody
	public Map<String, Object> customerCheckId(CustomerBean customerBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT_MSG, "이미 사용중인 ID 입니다.");
		resMap.put(Constants.RESULT, "success");

		try {
			int res = customerService.customerCheckId(customerBean);
			if (res == 0) {
				resMap.put(Constants.RESULT_MSG, "사용할 수 있는 ID 입니다.");
			}
		} catch (Exception e) {
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
	
	@RequestMapping("deleteCustomerAjax")
	@ResponseBody
	public Map<String, Object> deleteCustomerAjax(CustomerBean bean, PhotoBean photoBean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 실패 하였습니다.");
		try {
			// 세션값 취득
			// MemberBean sesBean =
			// (MemberBean)req.getSession().getAttribute(Constants.MEMBER_LOGIN_BEAN);

			// if( StringUtils.equals(sesBean.getMemberId(), bean.getMemberId())
			// ){
			int resVal = customerDao.deleteCustomer(bean);
			photoBean.setMemberId(bean.getCustomerId());
			photoDao.deletePhoto(photoBean);
			if (resVal > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 성공 하였습니다.");
			}
			// }

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
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
	public String personalInfoCustomer(CustomerBean customerBean, PhotoBean photoBean, Model model) {

		CustomerBean resBean = customerDao.selectCustomer(customerBean);
		model.addAttribute("customerBean", resBean);

		PhotoBean poBean = photoDao.selectPhoto(photoBean);

		if (poBean == null) {
			poBean = new PhotoBean();
			poBean.setPhotoFileName("/resources/images/noImage.png");
		}
		model.addAttribute("photoBean", poBean);

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
			int totRecord = teacherService.selectCustomerListTotalCount(bean, pagingBean);
			// 페이징 계산
			pagingBean.calcPage(totRecord);

			List<CustomerBean> list = customerService.selectCustomerList(bean, pagingBean);

			resMap.put("customerBean", bean);
			resMap.put("CustomerList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	@RequestMapping("customerInsertProcAjax")
	@ResponseBody
	public Map<String, Object> customerInsertProcAjax(CustomerBean cBean, PhotoBean pBean, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			int res = customerService.insertCustomerAttach(cBean, pBean, FILE_UPLOAD_PATH + "/upFile");
			CustomerBean cusBean = customerService.selectCustomer(cBean);
			req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, cusBean);

			if (res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

	@RequestMapping("photoSendAjax")
	@ResponseBody
	public Map<String, Object> photoSendAjax(PhotoBean bean, CustomerBean cbean, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			PhotoBean pBean = photoDao.selectPhoto(bean);
			CustomerBean CusBean = customerService.selectCustomer(cbean);
						
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			
			resMap.put("pBean", pBean);
			resMap.put("CusBean", CusBean);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

}