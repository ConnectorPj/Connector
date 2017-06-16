package com.test.web.customer.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.Constants;
import com.test.web.common.bean.BucketBean;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.PurchaseBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.BucketDAO;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.PurchaseDAO;
import com.test.web.common.service.CustomerService;
import com.test.web.common.service.TeacherService;

@Controller
public class CustomerController {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;
	
	@Value("#{config['admin.id']}")
	private String adminId;
	
	@Value("#{config['admin.pw']}")
	private String adminPw;

	@Autowired
	private PhotoDAO photoDao;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private CustomerDAO customerDao;

	@Autowired
	private BucketDAO bucketDao;

	@Autowired
	private ClassDAO classDao;
	
	@Autowired
	PurchaseDAO purchaseDao;

	@RequestMapping("/join")
	public String join(ClassBean bean, Model model) {
		
		
		ClassBean cbean = classDao.selectClass(bean);
		model.addAttribute(cbean);
		return "join";
	}
	
	
	
	/** 학생 회원가입 처리를 한다. **/
	@RequestMapping("/insertCustomerProc")
	@ResponseBody
	public Map<String, Object> insertCustomerProc(CustomerBean customerBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원가입에 실패 하였습니다.");
		
		
		// DB insert
		try {
			TeacherBean tBean = new TeacherBean();
			tBean.setTeacherId(customerBean.getCustomerId());
			
			tBean = teacherService.selectTeacher(tBean);
			if(tBean == null){
				int res = customerService.insertCustomer(customerBean);

				if (res > 0) {
					resMap.put(Constants.RESULT, Constants.RESULT_OK);
					resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
				}
			}else{
				resMap.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resMap.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
		}

		return resMap;
	}

	/** 강사 회원가입 처리를 한다. **/
	@RequestMapping("/insertTeacherProc")
	@ResponseBody
	public Map<String, Object> insertTeacherProc(TeacherBean teacherBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();

		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원가입에 실패 하였습니다.");

		// DB insert
		try {
			CustomerBean cusBean = new CustomerBean();
			cusBean.setCustomerId(teacherBean.getTeacherId());
			
			cusBean = customerService.selectCustomer(cusBean);
			
			if(cusBean == null){
				teacherBean.setTeacherCheck("0");
				int res = teacherService.insertTeacher(teacherBean);

				if (res > 0) {
					resMap.put(Constants.RESULT, Constants.RESULT_OK);
					resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
				}
			}else{
				resMap.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resMap.put(Constants.RESULT_MSG, "이미 가입되어 있는 아이디 입니다.");
		}

		return resMap;
	}


	@RequestMapping("/login")
	public String login(ClassBean bean, Model model) {
		
		
		ClassBean cbean = classDao.selectClass(bean);
		model.addAttribute(cbean);
		return "login";
	}

	/** 회원로그인 처리 */
	@RequestMapping("/loginByGoogle")
	@ResponseBody
	public Map<String, Object> loginByGoogle(CustomerBean bean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		// 로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		
		try{
			customerService.insertCustomer(bean);
		}catch(Exception e){
			System.out.println("이미 회원가입이 되어 있음 !");
		}

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

	/** 회원로그인 처리 */
	@RequestMapping("/CustomerloginProc")
	@ResponseBody
	public Map<String, Object> CustomerloginProcAjax(CustomerBean bean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		// 로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		
		// 운영자 로그인
		if(bean.getCustomerId().equals(adminId) && bean.getCustomerPw().equals(adminPw)){
			
			req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, bean);
			req.getSession().setAttribute(Constants.RESULT_CODE, "A");
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put("admin",bean);
			return resMap;
		}

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

		 return "redirect:/main.do";
	}
	
	@RequestMapping("/applicationProc")
	public String applicationProc(PurchaseBean pBean) {
		
		System.out.println(pBean.getCustomerCellPhone());
		System.out.println(pBean.getCustomerId());
		System.out.println(pBean.getStudyId());
		System.out.println(pBean.getCustomerContent());
		
		
		// 기본값 0 
		pBean.setPurchaseSort("0");
		
		purchaseDao.insertPurchase(pBean);
		
		return "applicationSuccess";
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
			int resVal = customerDao.deleteCustomer(bean);
			photoBean.setMemberId(bean.getCustomerId());
			photoDao.deletePhoto(photoBean);
			if (resVal > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 성공 하였습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

	@RequestMapping("/registerstudy")
	public String registerstudy() {
		return "registerStudy";
	}

	@RequestMapping("/registerstudyProc")
	public String registerstudyProc(ClassBean ClassBean, @RequestParam("file1") MultipartFile file1) {
		// DB insert
		ClassBean.setStudyCheck("0");
		ClassBean.setStudyId(ClassBean.getTeacherId() + "-" + System.nanoTime());
		classDao.insertClass(ClassBean);

		// 파일 이미지 처리
		if (!file1.getOriginalFilename().equals("")) {
			try {
				// 파일을 저장하는 처리를 시작한다.
				File saveDir = new File(FILE_UPLOAD_PATH + "/upFile");

				if (!saveDir.exists()) {
					saveDir.mkdirs();
				}

				// 파일이름 생성
				String fileName = ClassBean.getStudyId() + "";
				String fileExt = file1.getOriginalFilename().substring(file1.getOriginalFilename().lastIndexOf("."));
				System.out.println(fileName + fileExt);

				String fullFilePath = saveDir.getPath() + File.separator + fileName + fileExt;

				// 파일저장
				byte[] bytes = file1.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(new FileOutputStream(fullFilePath));
				buffStream.write(bytes);
				buffStream.close();

				// 파일 db에 넣기

				PhotoBean classPhoto = new PhotoBean();
				classPhoto.setMemberId(ClassBean.getStudyId());
				classPhoto.setPhotoSort("2");
				
				try {
					photoDao.deletePhoto(classPhoto);
				} catch (Exception e) {
					e.printStackTrace();
				}

				classPhoto.setPhotoFileName("/upFile/" + fileName + fileExt);
				photoDao.insertPhoto(classPhoto);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end if
			// db 처리

		return "applicationSuccess";
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
	public String customerInsertProcAjax(CustomerBean cBean, PhotoBean pBean,
			@RequestParam("file1") MultipartFile file1, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		System.out.println("filename: " + file1.getOriginalFilename());

		// 파일 이미지 처리
		if (!file1.getOriginalFilename().equals("")) {
			try {
				int resVal1 = customerDao.updateCustomer(cBean);

				if (resVal1 <= 0) {
					resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
					resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");
				}

				// 파일을 저장하는 처리를 시작한다.
				File saveDir = new File(FILE_UPLOAD_PATH + "/upFile");

				if (!saveDir.exists()) {
					saveDir.mkdirs();
				}

				// 파일이름 생성
				String fileName = cBean.getCustomerId() + file1.getOriginalFilename() + "";
				String fileExt = file1.getOriginalFilename().substring(file1.getOriginalFilename().lastIndexOf("."));
				System.out.println(fileName + fileExt);

				String fullFilePath = saveDir.getPath() + File.separator + fileName + fileExt;

				// 파일저장
				byte[] bytes = file1.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(new FileOutputStream(fullFilePath));
				buffStream.write(bytes);
				buffStream.close();

				// 파일 db에 넣기

				PhotoBean inBean = new PhotoBean();
				inBean.setMemberId(cBean.getCustomerId());
				inBean.setPhotoSort(Constants.FILE_TYPE_BOARD);

				try {
					photoDao.deletePhoto(inBean);
				} catch (Exception e) {
					e.printStackTrace();
				}

				// insert

				inBean.setPhotoFileName("/upFile/" + fileName + fileExt);

				// DB
				photoDao.insertPhoto(inBean);

				CustomerBean cusBean = customerService.selectCustomer(cBean);
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, cusBean);

				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end if
		else {
			int resVal1 = customerDao.updateCustomer(cBean);

			if (resVal1 <= 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");
			}

			try {
				CustomerBean cusBean = customerService.selectCustomer(cBean);
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, cusBean);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		  return "redirect:/main.do";
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

	
	/** 수업결제 내역 개인별 수업정보 **/
	@RequestMapping("/selectCustomerPurchaseList")
	@ResponseBody
	public Map<String, Object> selectCustomerPurchaseList(ClassBean bean, PurchaseBean pBean, PagingBean paBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 실패 하였습니다.");
		
		try {
			
			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectCustomerPurchaseListTotal(pBean);
			// 페이징 계산
			paBean.calcPage(totRecord);

			List<ClassBean> list = classDao.selectCustomerPurchaseList(pBean,paBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", paBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}
	/** 수업신청 내역 개인별 수업정보 **/
	@RequestMapping("/selectCustomerPurchaseList2")
	@ResponseBody
	public Map<String, Object> selectCustomerPurchaseList2(ClassBean bean, Model model, PurchaseBean pBean, PagingBean paBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 실패 하였습니다.");
		
		try {
			
			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectCustomerPurchaseUncheckListTotal(pBean);
			// 페이징 계산
			paBean.calcPage(totRecord);
			
			List<ClassBean> list = classDao.selectCustomerPurchaseUncheckList(pBean, paBean);
			
			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", paBean);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
		
	}


	/** 수업결제 내역 개인별 찜목록 **/
	@RequestMapping("/selectBucketClassAjax")
	@ResponseBody
	public Map<String, Object> selectBucketClassAjax(ClassBean bean, Model model, BucketBean bBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 실패 하였습니다.");

		try {

			List<ClassBean> list = classDao.selectBucketClassList(bBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "결제 내역 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}

	/* 찜목록 삭제 */
	@RequestMapping("/deleteBucket")
	@ResponseBody
	public Map<String, Object> deleteBucket(BucketBean bBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "찜목록 삭제에 실패했습니다.");
		// DB insert

		try {
			int res = bucketDao.deleteBucket(bBean);
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "찜목록 삭제에 성공했습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}


/**수업 신청 수락하기 */
@RequestMapping("/updateStudyMember")
	@ResponseBody
	public Map<String, Object> updateStudyMember(PurchaseBean bean){
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "업데이트 실패");
		
		try {
//			
//			PurchaseBean pBean = new PurchaseBean();
//			pBean = purchaseDao.selectPurchase(bean);
			bean.setPurchaseSort("1");
			
			int res = purchaseDao.updateStudyMember(bean);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "업데이트 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
		
	}
}