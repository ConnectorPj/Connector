package com.test.web.main.service;

import java.util.List;

import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;

public interface BoardService {

	// 게시글과 파일의 정보를 한꺼번에 insert 처리
	public int insertBoardAttach(TeacherBean tBean, PhotoBean pBean, String upPath);

	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<TeacherBean> selectTeacherList(TeacherBean bean, PagingBean pBean) throws Exception;

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectTeacherListTotalCount(PagingBean bean) ;
}
