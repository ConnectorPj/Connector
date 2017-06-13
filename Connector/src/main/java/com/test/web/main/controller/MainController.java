package com.test.web.main.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

		model.addAttribute("classList", classList);

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
	public String application(Locale locale, Model model) {
		return "application";
	}

	@RequestMapping("/payment")
	public String payment(Model model, ClassBean cBean) {
		ClassBean classBean = classDao.selectClass(cBean);
		model.addAttribute("classBean",classBean);
		
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

	@RequestMapping("/errorpage")
	public String error404() {
		return "errorpage";
	}

	@RequestMapping("/adminRegTeacher")
	public String adminRegTeacher() {
		return "adminRegTeacher";
	}

	@RequestMapping("/adminPage")
	public String adminPage() {
		return "adminPage";
	}

	@RequestMapping("/adminRegClass")
	public String adminRegClass(Model model, ClassBean cBean) {

		cBean = classDao.selectClass(cBean);

		String location[] = cBean.getStudyLocation().split(",");
		model.addAttribute("Alt", location[0]);
		model.addAttribute("Att", location[1]);

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
