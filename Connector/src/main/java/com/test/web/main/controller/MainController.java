﻿package com.test.web.main.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.web.common.Constants;
import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.ClassDAO;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.TeacherDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;

	@Autowired
	private TeacherDAO teacherDao;

	@Autowired
	private PhotoDAO photoDao;

	@Autowired
	private ClassDAO classDao;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/main")
	public String main(Model model) {
		List<ClassBean> classList = classDao.selectClassList();
		List<ClassBean> photoList = new ArrayList<>();

		ClassBean cBean = new ClassBean();

		Iterator<ClassBean> itor = classList.iterator();

		while (itor.hasNext()) {
			cBean = itor.next();
			try {
				cBean = classDao.selectTeacherPhotoList(cBean);
				photoList.add(cBean);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("mainPhoto", photoList);

		return "main";
	}

	@RequestMapping("/payorder")
	public String payorder(Locale locale, Model model) {
		return "payorder";
	}

	@RequestMapping("/classlist")
	public String classlist(Locale locale, Model model) {
		return "classlist";
	}

	@RequestMapping("/application")
	public String application(ClassBean cBean, PhotoBean photoBean, Model model) {

		ClassBean classBean = classDao.selectClass(cBean);
		model.addAttribute("classBean", classBean);

		photoBean = new PhotoBean();
		photoBean.setMemberId(cBean.getStudyId());

		PhotoBean poBean = photoDao.selectPhoto(photoBean);

		if (poBean == null) {
			poBean = new PhotoBean();
			poBean.setPhotoFileName("/resources/images/noImage.png");
		}

		model.addAttribute("photoBean", poBean);

		return "application";
	}

	@RequestMapping("/payment")
	public String payment(Model model, ClassBean cBean) {
		ClassBean classBean = classDao.selectClass(cBean);
		model.addAttribute("classBean", classBean);

		return "payment";
	}

	@RequestMapping("/bucketList")
	public String busketList(Locale locale, Model model) {
		return "bucketList";
	}

	@RequestMapping("/selectTeacher")
	public String selectMember(TeacherBean teacherBean, Model model) {
		// DB로부터 데이터를 가져온다.
		TeacherBean mBean = teacherDao.selectTeacher(teacherBean);
		// JSP로 보내기 위해서 데이터를 적재한다.
		model.addAttribute("teacherBean", mBean);

		return "/main";
	}

	/** 회원 수정화면 **/
	@RequestMapping("/personalInfoTeacher")
	public String personalInfoTeacher(TeacherBean teacherBean, PhotoBean photoBean, Model model) {

		TeacherBean resBean = teacherDao.selectTeacher(teacherBean);
		model.addAttribute("teacherBean", resBean);

		PhotoBean poBean = photoDao.selectPhoto(photoBean);

		if (poBean == null) {
			poBean = new PhotoBean();
			poBean.setPhotoFileName("/resources/images/noImage.png");
		}
		model.addAttribute("photoBean", poBean);

		return "/personalInfoTeacher";
	}

	/** 회원정보 수정 처리를 한다. **/
	@RequestMapping("/updateTeacherProc")
	public String updateTeacherProc(TeacherBean teacherBean, Model model) {

		model.addAttribute(Constants.RESULT, Constants.RESULT_FAIL);
		model.addAttribute("teacherBean", teacherBean);

		// DB update
		int res = teacherDao.updateTeacher(teacherBean);

		if (res > 0) {
			model.addAttribute(Constants.RESULT, Constants.RESULT_OK);
		}

		return "/personalInfoTeacher";
	}

	@RequestMapping("/deleteTeacher")
	public String deleteTeacher(TeacherBean teacherBean, Model model) {

		model.addAttribute(Constants.RESULT, Constants.RESULT_FAIL);
		model.addAttribute("teacherBean", teacherBean);

		// DB delete
		int res = 0;

		PhotoBean inBean = new PhotoBean();
		inBean.setMemberId(teacherBean.getTeacherId());

		try {
			photoDao.deletePhoto(inBean);
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			res = teacherDao.deleteTeacher(teacherBean);

			if (res > 0) {
				model.addAttribute(Constants.RESULT, Constants.RESULT_OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/adminTeacherList.do";
	}

	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404(HttpServletResponse res, Model model) {

		res.setStatus(HttpServletResponse.SC_OK);

		model.addAttribute("contents", "error/error404");
		return "/errorpage";

	}
	@RequestMapping(value = "/error500", method = RequestMethod.GET)
	public String error500(HttpServletResponse res, Model model) {
		
		res.setStatus(HttpServletResponse.SC_OK);
		
		model.addAttribute("contents", "error/error500");
		return "/errorpage2";
		
	}

	@RequestMapping("/adminRegTeacher")
	public String adminRegTeacher() {
		return "adminRegTeacher";
	}

	@RequestMapping("/adminPage")
	public String adminPage() {
		return "adminPage";
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

	@RequestMapping("/adminRegClass")
	public String adminRegClass(Model model, ClassBean cBean) {

		cBean = classDao.selectClass(cBean);

		String location[] = cBean.getStudyLocation().split(",");
		model.addAttribute("Alt", location[0]);
		model.addAttribute("Att", location[1]);

		int diff = dayCal(cBean.getStudyStartDate(), cBean.getStudyEndDate());
		model.addAttribute("diff", diff);


		// photoBean 생성
		PhotoBean photoBean = new PhotoBean();
		photoBean.setMemberId(cBean.getStudyId());
		photoBean.setPhotoSort("2");
		photoBean = photoDao.selectPhoto(photoBean);
		model.addAttribute("photoBean", photoBean);

		// teacher photo 생성
		PhotoBean tPhotoBean = new PhotoBean();
		tPhotoBean.setMemberId(cBean.getTeacherId());
		tPhotoBean.setPhotoSort("1");
		tPhotoBean = photoDao.selectPhoto(tPhotoBean);
		model.addAttribute("tPhotoBean", tPhotoBean);

		model.addAttribute("ClassBean", cBean);

		return "adminRegClass";
	}

	@RequestMapping("/adminStudentList")
	public String adminStudentList() {
		return "adminStudentList";
	}

	@RequestMapping("/adminStudyList")
	public String adminStudyList() {
		return "adminStudyList";
	}

}
