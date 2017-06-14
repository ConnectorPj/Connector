package com.test.web.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.PagingBean;
import com.test.web.common.bean.TeacherBean;

public interface TeacherDAO {

	public TeacherBean selectTeacher(TeacherBean bean);

	public List<TeacherBean> selectTeacherList(@Param("teacherBean") TeacherBean bean,
			@Param("pagingBean") PagingBean pBean);
	
	public List<TeacherBean> selectTeacherListCheck(@Param("teacherBean") TeacherBean bean,
			@Param("pagingBean") PagingBean pBean);
	
	public List<TeacherBean> selectTeacherList(TeacherBean bean);

	public int insertTeacher(TeacherBean bean);

	public int updateTeacher(TeacherBean bean);

	public int deleteTeacher(TeacherBean bean) throws Exception;

	public int teacherCheckId(TeacherBean bean);

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectTeacherListTotalCount();

	public int selectTeacherListTotalCountCheck();
}
