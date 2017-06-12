package com.test.web.main.controller;

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
	public String teacherInsertProcAjax(TeacherBean tBean, PhotoBean pBean, @RequestParam("file1") MultipartFile file1,
			HttpServletRequest req) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		System.out.println("filename: " + file1.getOriginalFilename());

		// 파일 이미지 처리
		if (!file1.getOriginalFilename().equals("")) {
			try {
				int resVal1 = teacherDao.updateTeacher(tBean);

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
				String fileName = tBean.getTeacherId() + file1.getOriginalFilename() + "";
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
				inBean.setMemberId(tBean.getTeacherId());
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

				TeacherBean teaBean = teacherService.selectTeacher(tBean);
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, teaBean);

				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end if
		else {
			int resVal1 = teacherDao.updateTeacher(tBean);

			if (resVal1 <= 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");
			}

			try {
				TeacherBean teaBean = teacherService.selectTeacher(tBean);
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, teaBean);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:/main.do";
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

			pBean.setPhotoSort("1");

			resMap.put("pBean", pBean);
			resMap.put("teaBean", teaBean);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

}
