package com.test.web.main.controller;

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
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.common.dao.PhotoDAO;
import com.test.web.common.dao.TeacherDAO;
import com.test.web.common.service.TeacherService;

@Controller
public class MainControllerAjax {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;

	@Autowired
	private TeacherDAO teacherDao;

	@Autowired
	private PhotoDAO photoDao;

	@Autowired
	private TeacherService teacherService;

	@RequestMapping("/adminRegTeacherAjax")
	public String adminRegTeacher(TeacherBean teacherBean, PhotoBean photoBean, Model model) {

		TeacherBean resBean = teacherDao.selectTeacher(teacherBean);
		model.addAttribute("teacherBean", resBean);

		PhotoBean poBean = photoDao.selectPhoto(photoBean);

		if (poBean == null) {
			poBean = new PhotoBean();
			poBean.setPhotoFileName("/resources/images/noImage.png");
		}
		model.addAttribute("photoBean", poBean);
		return "adminRegTeacherAjax";
	}

	@RequestMapping("teacherInsertProcAjax")
	@ResponseBody
	public Map<String, Object> teacherInsertProcAjax(TeacherBean tBean, PhotoBean pBean, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			int res = teacherService.insertTeacherAttach(tBean, pBean, FILE_UPLOAD_PATH + "/upFile");
			TeacherBean teaBean = teacherService.selectTeacher(tBean);
			req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, teaBean);

			if (res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

	@RequestMapping("/adminTeacherList")
	public String adminTeacherList() {
		return "adminTeacherList";
	}

	/** 회원정보 리스트 AJAX **/
	@RequestMapping("/selectTeacherListAjax")
	@ResponseBody
	public Map<String, Object> selectTeacherListAjax(TeacherBean bean, PagingBean pagingBean, Model model) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");

		try {
			// 전체 회원 리스트 갯수 조회
			int totRecord = teacherService.selectTeacherListTotalCount(bean, pagingBean);

			// 페이징 계산
			pagingBean.calcPage(totRecord);

			List<TeacherBean> list = teacherService.selectTeacherList(bean, pagingBean);

			resMap.put("teacherBean", bean);
			resMap.put("TeacherList", list);
			resMap.put("pBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

	@RequestMapping("/updateTeacherAjax")
	public String updateTeacherAjax(TeacherBean tBean) {

		// DB insert
		int res = 0;

		try {
			res = teacherDao.updateTeacher(tBean);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(res);

		return "/adminPage";

	}

	@RequestMapping("deleteTeacherAjax")
	@ResponseBody
	public Map<String, Object> deleteTeacherAjax(TeacherBean bean, PhotoBean photoBean, HttpServletRequest req) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 실패 하였습니다.");
		try {

			int resVal = teacherDao.deleteTeacher(bean);
			photoBean.setMemberId(bean.getTeacherId());
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

	@RequestMapping("photoTeacherRecAjax")
	@ResponseBody
	public Map<String, Object> photoTeacherRecAjax(PhotoBean bean, TeacherBean tBean, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			PhotoBean pBean = photoDao.selectPhoto(bean);
			TeacherBean teaBean = teacherService.selectTeacher(tBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");

			resMap.put("pBean", pBean);
			resMap.put("teaBean", teaBean);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

}
