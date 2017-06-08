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
import com.test.web.main.service.BoardService;

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
	private BoardService boardService;

	@RequestMapping("/adminRegTeacherAjax")
	public String adminRegTeacher(TeacherBean teacherBean, PhotoBean photoBean, Model model) {

		TeacherBean resBean = teacherDao.selectTeacher(teacherBean);
		model.addAttribute("teacherBean", resBean);

		PhotoBean poBean = photoDao.selectPhoto(photoBean);
		model.addAttribute("photoBean", poBean);

		model.addAttribute("filepath", FILE_UPLOAD_PATH);
		return "adminRegTeacherAjax";
	}

	@RequestMapping("adminInsertProcAjax")
	@ResponseBody
	public Map<String, Object> adminInsertProcAjax(TeacherBean tBean, PhotoBean pBean, HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			int res = boardService.insertBoardAttach(tBean, pBean, FILE_UPLOAD_PATH + "/upFile");

			if (res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
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
			 int totRecord = boardService.selectTeacherListTotalCount(pagingBean);
			 
			 //페이징 계산
			 pagingBean.calcPage(totRecord);

			List<TeacherBean> list = boardService.selectTeacherList(bean, pagingBean);

			resMap.put("teacherBean", bean);
			resMap.put("TeacherList", list);
			resMap.put("pagingBean", pagingBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}

}
