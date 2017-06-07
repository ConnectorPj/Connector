package com.test.web.main.service;

import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;

public interface BoardService {

	// 게시글과 파일의 정보를 한꺼번에 insert 처리
	public int insertBoardAttach(TeacherBean tBean, PhotoBean pBean, String upPath);

}
