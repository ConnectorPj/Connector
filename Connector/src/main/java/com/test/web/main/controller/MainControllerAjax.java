package com.test.web.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;
import com.test.web.main.service.BoardService;

@Controller
public class MainControllerAjax {

	// 파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping("/adminRegTeacherAjax")
	public String adminRegTeacher() {
		return "adminRegTeacherAjax";
	}

	@RequestMapping("adminInsertProcAjax")
	@ResponseBody
	public Map<String, Object> adminInsertProcAjax(
			TeacherBean tBean, PhotoBean pBean, HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			int res = boardService.insertBoardAttach(tBean, 
					pBean, FILE_UPLOAD_PATH + "/upFile");
			
			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}

}
