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

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PurchaseBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.PurchaseDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.dao.reviewDAO;

@Controller
public class DetailController {

	@Autowired
	ClassDAO classDao;

	@Autowired
	TeacherDAO teacherDao;

	@Autowired
	reviewDAO reviewDao;

	@RequestMapping("/detail")
	public String detail(Model model, ClassBean cBean) {
		ClassBean selBean = classDao.selectClass(cBean);
		model.addAttribute("ClassBean", selBean);

		String location[] = selBean.getStudyLocation().split(",");
		model.addAttribute("Alt", location[0]);
		model.addAttribute("Att", location[1]);

		// ��¥ ���
		int diff = dayCal(selBean.getStudyStartDate(), selBean.getStudyEndDate());
		model.addAttribute("diff", diff);

		/*
		 * // ���� ���� TeacherBean bean = new TeacherBean();
		 * bean.setTeacherId(selBean.getTeacherId());
		 * 
		 * bean = teacherDao.selectTeacher(bean);
		 * model.addAttribute("teacher",bean);
		 * 
		 * // �ı� ����Ʈ ��ȯ reviewBean rBean = new reviewBean();
		 * rBean.setStudyId(selBean.getStudyId());
		 * 
		 * model.addAttribute("reviewList",reviewDao.selectReviewList(rBean));
		 */

		return "classDetail";
	}

	int dayCal(String str, String str1) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date beginDate = formatter.parse(str);
			Date endDate = formatter.parse(str1);

			// �ð����̸� �ð�,��,�ʸ� ���� ������ ������ �Ϸ� ������ ����
			long diff = endDate.getTime() - beginDate.getTime();
			long diffDays = diff / (24 * 60 * 60 * 1000);

			return (int) diffDays / 7;

		} catch (ParseException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/** 클래스 리스트 AJAX **/
	@RequestMapping("/selectClassListAjax")
	@ResponseBody
	public Map<String, Object> selectClassListAjax(ClassBean bean, PagingBean pagingBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			// int totRecord = memberService.selectMemberListTotalCount();
			// 페이징 계산
			// pagingBean.calcPage(totRecord);

			List<ClassBean> list = classDao.selectClassListAll(bean, pagingBean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);
			resMap.put("pagingBean", pagingBean);

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
		// 로그인 실패
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
	public Map<String, Object> selectTeacherClassList(ClassBean bean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			// int totRecord = memberService.selectMemberListTotalCount();
			// 페이징 계산
			// pagingBean.calcPage(totRecord);
			System.out.println(bean.getTeacherId());
			List<ClassBean> list = classDao.selectTeacherClassList(bean);

			resMap.put("classBean", bean);
			resMap.put("ClassList", list);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;

	}
}
