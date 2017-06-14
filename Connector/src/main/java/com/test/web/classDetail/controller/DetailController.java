/**
 * 
 */
/**
 * @author park deok hwan
 *
 */
package com.test.web.classDetail.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.BucketBean;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.PurchaseBean;
import com.test.web.common.dao.BucketDAO;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.CustomerDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.ReviewDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.service.TeacherService;

@Controller
public class DetailController {

	@Autowired
	ClassDAO classDao;

	@Autowired
	TeacherDAO teacherDao;

	@Autowired
	ReviewDAO reviewDao;

	@Autowired
	PhotoDAO photoDao;

	@Autowired
	BucketDAO busketDao;
	@Autowired
	CustomerDAO customerDao;

	@Autowired
	private TeacherService teacherService;

	@RequestMapping("/detail")
	public String detail(Model model, ClassBean cBean) {
		ClassBean selBean = classDao.selectClass(cBean);
		model.addAttribute("ClassBean", selBean);

		String location[] = selBean.getStudyLocation().split(",");
		model.addAttribute("Alt", location[0]);
		model.addAttribute("Att", location[1]);

		int diff = dayCal(selBean.getStudyStartDate(), selBean.getStudyEndDate());
		model.addAttribute("diff", diff);

		// photoBean 생성
		PhotoBean photoBean = new PhotoBean();
		photoBean.setMemberId(selBean.getStudyId());
		photoBean.setPhotoSort("2");
		photoBean = photoDao.selectPhoto(photoBean);
		model.addAttribute("photoBean", photoBean);

		// teacher photo 생성
		PhotoBean tPhotoBean = new PhotoBean();
		tPhotoBean.setMemberId(selBean.getTeacherId());
		tPhotoBean.setPhotoSort("1");
		tPhotoBean = photoDao.selectPhoto(tPhotoBean);
		model.addAttribute("tPhotoBean", tPhotoBean);

		return "classDetail";
	}
	
	@RequestMapping("/detailProc")
	public String detailProc(Model model, ClassBean cBean) {
		ClassBean selBean = classDao.selectClass(cBean);
		model.addAttribute("ClassBean", selBean);
		
		return "applicationsuccess";
	}

	int dayCal(String str, String str1) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = formatter.parse(str);
			Date endDate = formatter.parse(str1);

			long diff = endDate.getTime() - beginDate.getTime();
			long diffDays = diff / (24 * 60 * 60 * 1000);

			return (int) diffDays / 7;

		} catch (ParseException e) {
			e.printStackTrace();
		}

		return 0;
	}

	@RequestMapping("/updateBusket")
	@ResponseBody
	public Map<String, Object> updateBusket(BucketBean bBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "데이터 통신 실패");

		System.out.println(bBean.getCustomerId());
		System.out.println(bBean.getStudyId());

		try {
			BucketBean sBean = busketDao.selectBucket(bBean);
			if (sBean == null) {
				busketDao.insertBucket(bBean);
			} else {
				busketDao.deleteBucket(bBean);
			}
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "데이터 통신 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** 클래스 리스트 AJAX **/
	@RequestMapping("/selectAdminClassListAjax")
	@ResponseBody
	public Map<String, Object> selectClassListAjax(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectClassListTotalCount();
			// 페이징 계산
			pagingBean.calcPage(totRecord);
			// bean.setStudyCheck("1");

			List<ClassBean> list = classDao.selectClassListAll(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** 클래스 리스트 AJAX **/
	@RequestMapping("/selectAdminClassListAjax2")
	@ResponseBody
	public Map<String, Object> selectClassListAjax2(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectClassUnCheckedListTotalCount();
			// 페이징 계산
			pagingBean.calcPage(totRecord);
			// bean.setStudyCheck("0");
			List<ClassBean> list = classDao.selectClassListAllunChecked(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}
	
	/** 클래스 가져오깅 */
	@RequestMapping("/selectClass")
	@ResponseBody
	public Map<String, Object> selectClass(ClassBean bean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);

		try {
			ClassBean classBean = classDao.selectClass(bean);
			System.out.println(classBean.getStudyId());
			resMap.put("classBean", classBean);
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			return resMap;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	/** 수업진행 내역 개인별 수업정보 **/
	@RequestMapping("/selectClassAjax")
	@ResponseBody
	public Map<String, Object> selectTeacherClassList(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectClassListTotalCount();
			// 페이징 계산
			pagingBean.calcPage(totRecord);

			// bean.setStudyCheck("1");

			List<ClassBean> list = classDao.selectClassListAll(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}

	/** 수업진행 신청내역 개인별 수업정보 **/
	@RequestMapping("/selectClassAjax2")
	@ResponseBody
	public Map<String, Object> selectTeacherClassList2(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");
		try {

			// bean.setStudyCheck("0");

			// 전체 회원 리스트 갯수 조회
			int totRecord = classDao.selectClassUnCheckedListTotalCount();
			// 페이징 계산
			pagingBean.calcPage(totRecord);

			List<ClassBean> list = classDao.selectClassListAllunChecked(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}

/** 수업에 신청한 학생리스트 뿌려주깅 **/
	@RequestMapping("/selectStudyMember")
	@ResponseBody
	public Map<String, Object> selectStudyMember(PurchaseBean bean,  Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");
		try {
			// 전체 회원 리스트 갯수 조회
			// int totRecord = memberService.selectMemberListTotalCount();
			// 페이징 계산
			// pagingBean.calcPage(totRecord);

			bean.setPurchaseSort("0");
			List<CustomerBean> list = customerDao.selectStudyMember(bean);
			
			resMap.put("customerBean", bean);
			resMap.put("CustomerList", list);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
		
	}
	/** 수업에 듣는 학생리스트 뿌려주깅 **/
	@RequestMapping("/selectStudyMember2")
	@ResponseBody
	public Map<String, Object> selectStudyMember2(PurchaseBean bean,  Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");
		try {
			// 전체 회원 리스트 갯수 조회
			// int totRecord = memberService.selectMemberListTotalCount();
			// 페이징 계산
			// pagingBean.calcPage(totRecord);
			
			bean.setPurchaseSort("1");
			List<CustomerBean> list = customerDao.selectStudyMember(bean);
			
			resMap.put("customerBean", bean);
			resMap.put("CustomerList", list);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
		
	}


	@RequestMapping("/updateClass")
	@ResponseBody
	public Map<String, Object> updateClass(ClassBean bean) {
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "업데이트 실패");

		try {
			
			ClassBean cBean = new ClassBean();
			cBean = classDao.selectClass(bean);
			cBean.setStudyCheck("1");
			
			int res = classDao.updateClass(cBean);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "업데이트 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}
	

	@RequestMapping("/calcelClass")
	@ResponseBody
	public Map<String, Object> calcelClass(ClassBean bean) {
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "업데이트 실패");

		try {
			
			ClassBean cBean = new ClassBean();
			cBean = classDao.selectClass(bean);
			cBean.setStudyCheck("0");
			
			int res = classDao.updateClass(cBean);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "업데이트 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}

}
