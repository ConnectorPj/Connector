package com.test.web.common.service;

import java.util.List;

import com.test.web.common.bean.ClassBean;
import com.test.web.common.bean.CustomerBean;
import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.PhotoBean;
import com.test.web.common.bean.TeacherBean;

public interface TeacherService {

	/** 회원정보를 조회해서 가져온다. **/
	public TeacherBean selectTeacher(TeacherBean bean) throws Exception;

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectTeacherListTotalCount(PagingBean pBean);

	/** 회원정보를 삽입한다. **/
	public int insertTeacher(TeacherBean bean) throws Exception;

	/** 회원정보를 수정한다. **/
	public int updateTeacher(TeacherBean bean) throws Exception;

	public int deleteTeacher(TeacherBean bean) throws Exception;

	/** 회원 아이디 중복 체크 */
	public int teacherCheckId(TeacherBean bean) throws Exception;

	/** 게시글과 파일의 정보를 한꺼번에 insert 처리 **/
	public int insertTeacherAttach(TeacherBean tBean, PhotoBean pBean, String upPath);

	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<TeacherBean> selectTeacherList(TeacherBean bean, PagingBean pBean) throws Exception;
	public List<TeacherBean> selectTeacherList(TeacherBean bean) throws Exception;

	/** 전체 Teacher 데이터 갯수를 가져온다. **/
	public int selectTeacherListTotalCount(TeacherBean bean, PagingBean pBean);

	/** 전체 Class 데이터 갯수를 가져온다. **/
	public int selectClassListTotalCount(ClassBean bean, PagingBean pBean);

	/** 전체 Class 데이터 갯수를 가져온다. **/
	public int selectCustomerListTotalCount(CustomerBean bean, PagingBean pBean);

}
